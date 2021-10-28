const std = @import("std");
const sling = @import("../main.zig");
const Self = @This();

pub var RegisteredScenes = std.StringHashMap(Register).init(sling.mem.Allocator);
pub const Register = struct {
    base: usize = undefined,
    dependants: std.ArrayList(usize) = undefined,
};

pub const EditorData = struct {
    filePath: ?[]const u8 = null,
    selectedObjectGroup: usize = 0,
    selectedEntity: usize = 0,
    objectToIndex: std.StringHashMap(usize) = std.StringHashMap(usize).init(sling.mem.Allocator),
};

baseObject: *sling.Object.Interface = undefined,
childObjects: []*sling.Object.Interface = undefined,
source: Register = undefined,
editorData: EditorData = .{},
isSpoof: bool = false,

/// If you've registered a type as a scene, then you can pass it in here to construct
/// an empty scene.
pub fn init(comptime baseType: type) *Self {
    var fetch = RegisteredScenes.get(@typeName(baseType));
    if (fetch == null) {
        std.debug.panic("Initializing a scene that isnt configured", .{});
    }
    var sceneRegister: Register = fetch.?;
    return initFromInfo(sceneRegister);
}

/// Spoofs a real scene, the base object is not defined, and has the provided children.
/// Children is expected to be a tuple of types that this contains, for example
/// `.{Player,WeaponPickup,Enemy}`
pub fn initSpoof(comptime children: anytype) *Self {
    // sling.logWarn("Creating a spoofed scene");
    var self: *Self = sling.mem.Allocator.create(Self) catch unreachable;
    self.* = .{};
    const childrenType = @typeInfo(@TypeOf(children));
    std.debug.assert(childrenType == .Struct and childrenType.Struct.is_tuple);
    std.debug.assert(@TypeOf(children[0]) == type);

    self.baseObject = undefined;
    self.isSpoof = true;

    self.childObjects = sling.mem.Allocator.alloc(*sling.Object.Interface, children.len) catch unreachable;

    inline for (children) |child, i| {
        var info = sling.Object.GenBuildData(child).information;
        self.editorData.objectToIndex.put(info.name, i) catch unreachable;
        self.childObjects[i] = info.autoCreate(self);
    }

    return self;
}
pub fn deinit(self: *Self) void {
    // sling.logWarn("Deiniting a scene.");
    self.editorData.objectToIndex.deinit();
    self.baseObject.deinitAll(self.baseObject);
    self.baseObject.arena.deinit();
    self.baseObject = undefined;
    for (self.childObjects) |*co| {
        co.*.deinitAll(co.*);
        co.*.arena.deinit();
        co.* = undefined;
    }
    sling.mem.Allocator.free(self.childObjects);
    self.* = undefined;
    sling.mem.Allocator.destroy(self);
}
/// A more manual approach, takes a scene register and constructs an empty scene.
pub fn initFromInfo(sceneRegister: Register) *Self {
    var self: *Self = sling.mem.Allocator.create(Self) catch unreachable;
    self.* = .{};
    self.baseObject = sling.Object.Information.get(sceneRegister.base).createSingleton(self);
    self.childObjects = sling.mem.Allocator.alloc(*sling.Object.Interface, sceneRegister.dependants.items.len) catch unreachable;
    for (self.childObjects) |*obj, i| {
        var info = sling.Object.Information.get(sceneRegister.dependants.items[i]);
        self.editorData.objectToIndex.put(info.name, i) catch unreachable;
        obj.* = info.autoCreate(self);
    }
    // sling.log("Created a scene from scene register information.");
    return self;
}
/// Takes bytes and creates a scene, it correctly picks the scene type for you provided
/// it exists in your game.
pub fn initFromBytes(data: []const u8) *Self {
    var parsed = sling.config.preferredStorageLang.parse(sling.mem.Allocator, data);
    defer parsed.deinit();

    var self: *Self = sling.mem.Allocator.create(Self) catch unreachable;
    self.* = .{};

    if (parsed.root.data.Map.get("scene_type")) |node| {
        std.debug.assert(node.data == .Literal and node.data.Literal == .String);
        var ObjectSlice = sling.Object.Information.slice();
        for (ObjectSlice) |info| {
            if (std.mem.eql(u8, info.name, node.data.Literal.String)) {
                var sceneObject = parsed.root.data.Map.get("scene").?;
                self.baseObject = info.createSingletonFrom(sceneObject, self);
                var sceneRegister = RegisteredScenes.get(info.name).?;
                self.childObjects = sling.mem.Allocator.alloc(*sling.Object.Interface, sceneRegister.dependants.items.len) catch unreachable;
                self.source = sceneRegister;
                break;
            }
        }
    } else {
        std.debug.panic("Failed to find a scene_type definition in the provided bytes:\n{s}", .{data});
    }

    if (parsed.root.data.Map.get("children")) |childrenList| {
        std.debug.assert(childrenList.data == .Map);

        var iter = childrenList.data.Map.iterator();
        var slice = sling.Object.Information.slice();
        var i: usize = 0;
        while (iter.next()) |pair| {
            for (slice) |info| {
                if (std.mem.eql(u8, pair.key_ptr.*, info.name)) {
                    self.editorData.objectToIndex.put(info.name, i) catch unreachable;
                    self.childObjects[i] = info.autoCreateFrom(pair.value_ptr.*, self);
                }
            }
            i += 1;
        }
    } else {
        std.debug.panic("Failed to find a children definition in the provided bytes:\n{s}", .{data});
    }

    // sling.log("Created a scene from raw bytes.");
    return self;
}
/// Takes a filepath and creates a scene, it correctly picks the scene type for you provided
/// it exists in your game still.
pub fn initFromFilepath(path: []const u8) *Self {
    var bytes = std.fs.cwd().readFileAlloc(sling.mem.Allocator, path, 80_000_000) catch unreachable;
    defer sling.mem.Allocator.free(bytes);

    // sling.logFmt("Creating a scene from filepath {s}", .{path});
    var self = initFromBytes(bytes);

    var ownedPath = sling.mem.Allocator.dupeZ(u8, path) catch unreachable;
    self.editorData.filePath = ownedPath;
    return self;
}
/// You don't need to call this, the game does this for you.
pub fn update(self: *Self) void {
    if (!self.isSpoof) {
        self.baseObject.update(self.baseObject);
    }

    for (self.childObjects) |child| {
        child.update(child);
    }
}
/// Spits out an owned string that represents your scene in your preferrec
/// storage format.
pub fn toBytes(self: *Self, allocator: *std.mem.Allocator) []const u8 {
    if (self.isSpoof) {
        std.debug.panic("Improper method call on spoofed scene\n", .{});
    }

    var tree = sling.serializer.Tree.initArena(allocator);
    tree.config = &sling.config.serializationConfig;
    defer tree.deinit();

    // Child objects

    var children = tree.newObject();
    for (self.childObjects) |interface| {
        children.data.Map.put(interface.information.name, interface.serialize(interface, tree)) catch unreachable;
    }

    // Add to root
    tree.root = tree.newObject();
    var ownedName = tree.alloc.internal().dupeZ(u8, self.baseObject.information.name) catch unreachable;
    tree.root.data.Map.put("scene_type", tree.newString(ownedName)) catch unreachable;
    tree.root.data.Map.put("scene", self.baseObject.serialize(self.baseObject, tree)) catch unreachable;
    tree.root.data.Map.put("children", children) catch unreachable;

    // Serialize
    return sling.config.preferredStorageLang.convert(allocator, tree);
}
/// Checks if the scene contains a child type, if it does it is returned. Note
/// that this reference is invalidated if you modify the group by appending
/// or deleting.
pub fn has(self: *Self, comptime target: type) ?[]target {
    for (self.childObjects) |child| {
        if (std.mem.eql(u8, @typeName(target), child.information.name)) {
            const wrapper = sling.Object.CollectionType(target);
            return @fieldParentPtr(wrapper, "interface", child).value;
        }
    }
    return null;
}
/// Checks if the scene's base type is `target`. If it is, then it returns
/// a temporary reference to the value. It's fine to call this constantly
/// if you need to refer to it frequently.
pub fn is(self: *Self, comptime target: type) ?*target {
    if (self.isSpoof) {
        return null;
    }
    if (std.mem.eql(u8, @typeName(target), self.baseObject.information.name)) {
        const wrapper = sling.Object.SingletonType(target);
        return &@fieldParentPtr(wrapper, "interface", self.baseObject).value;
    }
    return null;
}
/// The returned entity reference is only good until the next time an entity is appended.
/// Keep this in mind and don't store this reference.
pub fn spawn(self: *Self, comptime target: type) ?*target {
    for (self.childObjects) |child| {
        if (std.mem.eql(u8, @typeName(target), child.information.name)) {
            const wrapper = sling.Object.CollectionType(target);
            // Precache the id so that if the spawned item's init spawns anything else,
            // the pointer wont be invalidated.
            const id = child.data.Collection.getCount(child);
            child.data.Collection.append(child);
            var array = @fieldParentPtr(wrapper, "interface", child).value;
            return &array[id];
        }
    }
    return null;
}
/// Takes a type and returns the index of the interface that contains the type.
/// Mostly useful for editor related functionality
pub fn objectIndexFor(self: *Self, comptime T: type) usize {
    return self.editorData.objectToIndex.get(@typeName(T)).?;
}
pub fn setFilepath(self: *Self, path: []const u8) void {
    var owned = sling.mem.Allocator.dupeZ(u8, path) catch unreachable;
    self.editorData.filePath = owned;
}
