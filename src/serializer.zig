//! TODO: I want to move away from nested text serializer to something
//! more ergonomically appropriate for sling, I'll work on this little by little
//! whenever I get a chance. Not in use yet.
const std = @import("std");

pub const json = @import("serializer_json.zig");

pub const Configuration = struct {
    const HashSet = std.StringHashMap(void);

    allocator: *std.mem.Allocator,
    ignoredFields: std.StringHashMap(HashSet),

    pub fn init(allocator: *std.mem.Allocator) Configuration {
        return .{
            .allocator = allocator,
            .ignoredFields = std.StringHashMap(HashSet).init(allocator),
        };
    }

    pub fn ignore(self: *Configuration, comptime T: type, field: []const u8) void {
        var entry = self.ignoredFields.getOrPut(@typeName(T)) catch |err| {
            std.debug.panic("Failed to ignore field '{s}' from type '{s}' due to:\n{s}", .{field, @typeName(T), @errorName(err)});
        };

        if(!entry.found_existing) {
            entry.key_ptr.* = @typeName(T);
            entry.value_ptr.* = HashSet.init(self.allocator);
        }

        entry.value_ptr.put(field, {}) catch |err| {
            std.debug.panic("Failed to ignore field '{s}' from type '{s}' due to:\n{s}", .{field, @typeName(T), @errorName(err)});
        };
    }

    pub fn ignores(self:*Configuration, comptime T: type, field: []const u8) bool {
        if(self.ignoredFields.contains(@typeName(T))) {
            return self.ignoredFields.get(@typeName(T)).?.contains(field);
        }
        return false;
    }
};
pub const Lexicon = struct {
    convert: fn(*std.mem.Allocator,*Tree) []const u8,
    parse: fn(*std.mem.Allocator,[]const u8) *Tree,
};

pub const TreeAllocator = union(enum) {
    raw: *std.mem.Allocator,
    arena: std.heap.ArenaAllocator,

    pub fn internal(self:*TreeAllocator) *std.mem.Allocator {
        switch(self.*) {
            .raw => {return self.raw; },
            .arena => {return &self.arena.allocator; },
        }
    }
    pub fn create(self:*TreeAllocator, comptime T: type) *T {
        switch(self.*) {
            .raw => {return self.raw.create(T) catch unreachable; },
            .arena => {return self.arena.allocator.create(T) catch unreachable;},
        }
    }
    pub fn alloc(self:*TreeAllocator, comptime T: type, N: usize) *T {
        switch(self.*) {
            .raw => {return self.raw.alloc(T,N) catch unreachable; },
            .arena => {return self.arena.allocator.alloc(T,N) catch unreachable;},
        }
    }
    pub fn free(self:*TreeAllocator, value:anytype) void {
        switch(self.*) {
            .raw => {self.raw.free(value); },
            .arena => {self.arena.allocator.free(value);},
        }
    }
    pub fn destroy(self:*TreeAllocator, value:anytype) void {
        switch(self.*) {
            .raw => {self.raw.destroy(value);},
            .arena => {self.arena.allocator.destroy(value);},
        }
    }
};
pub const Tree = struct {
    config: ?*Configuration = null,
    alloc: TreeAllocator = undefined,
    root: *Node = undefined,

    pub fn initRaw(allocator: *std.mem.Allocator) *Tree {
        var self: *Tree = allocator.create(Tree) catch unreachable;
        self.config = null;
        self.alloc = .{.raw=allocator};
        self.root = undefined;
        return self;
    }
    pub fn initArena(allocator: *std.mem.Allocator) *Tree {
        var arena = std.heap.ArenaAllocator.init(allocator);
        var self: *Tree = arena.allocator.create(Tree) catch unreachable;
        self.config = null;
        self.alloc = .{.arena=arena};
        self.root = undefined;
        return self;
    }
    pub fn deinit(self:*Tree) void {
        switch(self.alloc) {
            .raw => {
                self.root.deinit();
                self.alloc.destroy(self);
            },
            .arena => {
                self.alloc.arena.deinit();
            }
        }
    }
    pub fn newObject(tree:*Tree) *Node {
        var alloc = tree.alloc.internal();
        var self = alloc.create(Node) catch unreachable;
        self.tree = tree;
        self.data = .{.Map=std.StringHashMap(*Node).init(tree.alloc.internal())};
        return self;
    }
    pub fn newArray(tree:*Tree) *Node {
        var alloc = tree.alloc.internal();
        var self = alloc.create(Node) catch unreachable;
        self.tree = tree;
        self.data = .{.Array=std.ArrayList(*Node).init(tree.alloc.internal())};
        return self;
    }
    /// It is assumed that tree.alloc owns the provided string. If not, dupeZ it with
    /// `tree.alloc.internal().dupeZ(yourstring)`
    pub fn newString(tree:*Tree, string: []const u8) *Node {
        var alloc = tree.alloc.internal();
        var self = alloc.create(Node) catch unreachable;
        self.tree = tree;
        self.data = .{.Literal=.{.String=string}};
        return self;
    }
    pub fn newInt(tree:*Tree, int: i32) *Node {
        var alloc = tree.alloc.internal();
        var self = alloc.create(Node) catch unreachable;
        self.tree = tree;
        self.data = .{.Literal=.{.Integer=int}};
        return self;
    }
    pub fn newNull(tree:*Tree) *Node {
        var alloc = tree.alloc.internal();
        var self = alloc.create(Node) catch unreachable;
        self.tree = tree;
        self.data = .{.Literal=.Null};
        return self;
    }
    pub fn newFloat(tree:*Tree, float: f32) *Node {
        var alloc = tree.alloc.internal();
        var self = alloc.create(Node) catch unreachable;
        self.tree = tree;
        self.data = .{.Literal=.{.Float=float}};
        return self;
    }
    pub fn newBool(tree:*Tree, Boolean:bool) *Node {
        var alloc = tree.alloc.internal();
        var self = alloc.create(Node) catch unreachable;
        self.tree = tree;
        self.data = .{.Literal=.{.Bool=Boolean}};
        return self;
    }
    pub fn print(self:*Tree, lexicon: Lexicon) void {
        var bytes = lexicon.convert(std.heap.page_allocator, self);
        defer std.heap.page_allocator.free(bytes);
        std.debug.print("{s}\n", .{bytes});
    }
    pub fn toNode(tree: *Tree, value: anytype) *Node {
        const typeInfo = @typeInfo(@TypeOf(value));
        var allocator = tree.alloc.internal();

        // few early outs
        if(@TypeOf(value) == *Node) {
            return value;
        }

        if(isArrayList(@TypeOf(value))) |_| {
            return tree.toNode(value.items);
        }

        if(isStringHashmap(@TypeOf(value))) |hashVal| {
            var mapObj = tree.newObject();
            var cast: std.StringHashMap(hashVal) = value;
            var iter = cast.iterator();
            while(iter.next()) |pair| {
                mapObj.push(pair.key_ptr.*, pair.value_ptr.*);
            }

            return mapObj;
        }

        switch(typeInfo) {
            .Opaque => {
                return tree.newNull();
            },
            .Null => {
                return tree.newNull();
            },
            .Int => {
                return tree.newInt(@intCast(i32, value));
            },
            .Float => {
                return tree.newFloat(@floatCast(f32, value));
            },
            .Bool => {
                return tree.newBool(value);
            },
            .ComptimeInt => {
                return tree.newInt(@intCast(i32, value));
            },
            .ComptimeFloat => {
                return tree.newFloat(@floatCast(f32, value));
            },
            .Enum => {
                return tree.newInt(@intCast(i32,@enumToInt(value)));
            },
            .Array => {
                if(typeInfo.Array.child == u8) {
                    return tree.toNode(std.mem.spanZ(&value));
                } else {
                    const Slice = []const typeInfo.Array.child;
                    return tree.toNode(@as(Slice, &value));
                }

            },
            .Optional => {
                if(value == null) {
                    var nullValue = tree.newNull();
                    return nullValue;
                } else {
                    return tree.toNode(value.?);
                }
            },
            .Struct => {
                var obj = tree.newObject();
                inline for(typeInfo.Struct.fields) |field| {
                    if(tree.config) |cfg| {
                        if(!cfg.ignores(@TypeOf(value), field.name)) {
                            obj.data.Map.put(field.name, tree.toNode(@field(value, field.name))) catch unreachable;
                        }
                    } else {
                        obj.data.Map.put(field.name, tree.toNode(@field(value, field.name))) catch unreachable;
                    }
                    
                }
                return obj;
            },
            .Pointer => {
                switch(typeInfo.Pointer.size) {
                    .One => {
                        return toNode(tree, value.*);
                    },
                    .Slice => {
                        if(typeInfo.Pointer.child == u8) {
                            var ownedString = std.mem.dupeZ(allocator, u8, value) catch unreachable;
                            var stringNode = tree.newString(ownedString);
                            return stringNode;
                        } else {
                            var arr = tree.newArray();
                            for(value) |item| {
                                arr.push(null, item);
                            }
                            return arr;
                        }
                    },
                    else => {
                        return tree.newNull();
                    }
                }
            },
            .Union => {
                var obj = tree.newObject();
                obj.push("tag", tree.newString(@tagName(value)));

                const tagType = typeInfo.Union.tag_type.?;
                inline for(typeInfo.Union.fields) |unionField| {
                    if(value == @field(tagType, unionField.name)) {
                        obj.push("value", tree.toNode(@field(value, unionField.name)));
                    }
                }
                
                return obj;
            },
            else => {std.debug.panic("Failed to serialize {s}", .{@typeName(@TypeOf(value))});}
        }
    }
};

pub const NodeLiteral = union(enum) {
    String: []const u8,
    Bool: bool,
    Integer: i32,
    Float: f32,
    Null
};
pub const NodeValue = union(enum) {
    Literal: NodeLiteral,
    Map: std.StringHashMap(*Node),
    Array: std.ArrayList(*Node),
};
pub const Node = struct {
    tree: *Tree,
    data: NodeValue = undefined,

    /// Also deinits child nodes.
    pub fn deinit(self:*Node) void {
        switch(self.data) {
            .Map => {
                var iter = self.data.Map.valueIterator();
                while(iter.next()) |innerNode| {
                    innerNode.*.deinit();
                }
                self.data.Map.deinit();
            },
            .Array => {
                for(self.data.Array.items) |innerNode| {
                    innerNode.deinit();
                }
                self.data.Array.deinit();
            },
            else => {
                if(self.data == .Literal and self.data.Literal == .String) {
                    self.tree.alloc.internal().free(self.data.Literal.String);
                }
            }
        }
        if(self.tree.alloc == .raw) {
            var alloc = self.tree.alloc.internal();
            alloc.destroy(self);
        }
    }

    /// You should know what the node is before using this convenience method.
    /// Passing in a category means you know it is a map. Pass in null to push as
    /// if this was an array.
    pub fn push(self:*Node, category:?[]const u8, value: anytype) void {
        var result: *Node = self.tree.toNode(value);

        if(category) |categoryName| {
            std.debug.assert(self.data == .Map);
            self.data.Map.put(categoryName, result) catch {
                std.debug.panic("Failed to push into map", .{});
            };
            return;
        } else {
            std.debug.assert(self.data == .Array);
            self.data.Array.append(result) catch {
                std.debug.panic("Failed to push into array", .{});
            };
            return;
        }

        unreachable;
    }

    /// Pushes a node into a type, if possible. If owner is not null, initialized arraylists
    /// and hashmaps will belong to the owner instead of the internal tree allocator.
    pub fn into(self:*Node, ptr: anytype, owner: ?*std.mem.Allocator) void {
        var alloc: *std.mem.Allocator = if(owner != null) owner.? else self.tree.alloc.internal();
        const T = @TypeOf(ptr.*);
        const typeInfo = @typeInfo(T);

        // Early string out
        if(T == []const u8) {
            std.debug.assert(self.data == .Literal and self.data.Literal == .String);
            if(owner) |ownedAllocator| {
                ptr.* = ownedAllocator.dupeZ(u8, self.data.Literal.String) catch unreachable;
            } else {
                ptr.* = self.data.Literal.String;
            }
            return;
        }

        if(isArrayList(T)) |listType| {
            ptr.* = std.ArrayList(listType).init(alloc);
            for(self.data.Array.items) |item| {
                var castItem:listType = .{};
                item.into(&castItem, owner);
                ptr.append(castItem) catch unreachable;
            }
            return;
        }

        if(isStringHashmap(T)) |hashVal| {
            ptr.* = std.StringHashMap(hashVal).init(alloc);
            var iterator = self.data.Map.iterator();
            while(iterator.next()) |entry| {
                var castItem: hashVal = .{};
                entry.value_ptr.*.into(&castItem, owner);
                ptr.put(entry.key_ptr.*, castItem) catch unreachable;
            }
            return;
        }

        switch(typeInfo) {
            .Opaque => {
                // Dont error, just ignore it I guess. Makes for nicer code.
            },
            .Bool => {
                std.debug.assert(self.data == .Literal and self.data.Literal == .Bool);
                ptr.* = self.data.Literal.Bool;
            },
            .Int => {
                std.debug.assert(self.data == .Literal and self.data.Literal == .Integer);
                ptr.* = @intCast(std.meta.Int(typeInfo.Int.signedness, @intCast(u16,typeInfo.Int.bits)),self.data.Literal.Integer);
            },
            .Float => {
                std.debug.assert(self.data == .Literal and self.data.Literal == .Float);
                ptr.* = self.data.Literal.Float;
            },
            .Optional => {
                if(@typeInfo(typeInfo.Optional.child) == .Opaque) {
                    ptr.* = null;
                    return;
                }
                if(self.data == .Literal and self.data.Literal == .Null) {
                    ptr.* = null;
                } else {
                    var real: typeInfo.Optional.child = undefined;
                    self.into(&real, owner);
                    ptr.* = real;
                }
            },
            .Enum => {
                std.debug.assert(self.data == .Literal and self.data.Literal == .Integer);
                ptr.* = @intToEnum(T, self.data.Literal.Integer);
            },
            .Struct => {
                std.debug.assert(self.data == .Map);
                inline for(typeInfo.Struct.fields) |field| {
                    var fieldNode = self.data.Map.get(field.name);
                    if(fieldNode) |node| {
                        node.into(&@field(ptr.*, field.name), owner);
                    }
                }
            },
            .Array => {
                if(typeInfo.Array.child == u8) {
                    ptr.* = std.mem.zeroes(@TypeOf(ptr.*));
                    for(self.data.Literal.String) |char, i| {
                        ptr.*[i] = char;
                    }
                } else {
                    std.debug.assert(self.data == .Array);
                    for(self.data.Array.items) |item, i| {
                        ptr.*[i] = .{};
                        item.into(&ptr.*[i], owner);
                    }
                }
            },
            .Pointer => {
                switch(typeInfo.Pointer.size) {
                    .Slice => {
                        var slice = alloc.alloc(typeInfo.Pointer.child, self.data.Array.items.len) catch unreachable;
                        for(slice) |*item, i| {
                            item.* = .{};
                            self.data.Array.items[i].into(item, owner);
                        }
                        ptr.* = slice;
                    },
                    else => {
                        std.debug.panic("Failed to deserialize\n", .{});
                    }
                }
            },
            .Union => {
                std.debug.assert(self.data == .Map);
                var tagName = self.data.Map.get("tag").?.data.Literal.String;

                inline for(typeInfo.Union.fields) |field| {
                    if(std.mem.eql(u8, @typeName(field.field_type), tagName)) {
                        var nodeData = self.data.Map.get("value").?;
                        var temporary: field.field_type = undefined;
                        nodeData.into(&temporary, owner);
                        ptr.* = @unionInit(T, field.name, temporary);
                        return;
                    }
                }
            },
            else => {std.debug.panic("Failed to deserialize type {s}\n", .{@typeName(T)});}
        }
    }
};

fn isArrayList(comptime T: type) ?type {
    const ti = @typeInfo(T);
    if(ti != .Struct) {
        return null;
    }
    if(comptime @hasDecl(T, "Slice") and std.meta.trait.isSlice(T.Slice) and T == std.ArrayList(std.meta.Elem(T.Slice))) {
        return std.meta.Elem(T.Slice);
    } else {
        return null;
    }
}

fn isStringHashmap(comptime T: type) ?type {
    const ti = @typeInfo(T);
    if(ti != .Struct) {
        return null;
    }
    if(comptime @hasDecl(T, "Unmanaged") and @hasDecl(T.Unmanaged, "KV")) {
        if(std.meta.fieldInfo(T.Unmanaged.KV, .key).field_type == []const u8) {
            const valueType = std.meta.fieldInfo(T.Unmanaged.KV, .value).field_type;
            if(T == std.StringHashMap(valueType)) {
                return valueType;
            }
        }
    }
    return null;
}

// Basically this is the expected way to manually create objects. It can export
// to several formats soon! But for now just json
test "Basic Raw Serialization" {
    var tree = Tree.initRaw(std.testing.allocator);
    defer tree.deinit();

    tree.root = tree.newObject();

    var player = tree.newObject();
    player.push("health", 10);
    player.push("mana", 20);

    var abilityTree = tree.newArray();
    { // Melee
        var ability = tree.newObject();
        ability.push("name", "Melee Attack");
        ability.push("calculation", "1d4+3");
        ability.push("cost", "2mana");
        abilityTree.push(null, ability);
    }
    { // Charge
        var ability = tree.newObject();
        ability.push("name", "Charge Attack");
        ability.push("calculation", "1d2+1");
        ability.push("cost", "2health");
        ability.push("targets", "enemies");
        abilityTree.push(null, ability);
    }

    player.push("abilities", abilityTree);
    tree.root.push("player", player);
}
test "Basic Arena Serialization" {
    var tree = Tree.initArena(std.testing.allocator);
    defer tree.deinit();

    tree.root = tree.newObject();

    var player = tree.newObject();
    player.push("health", 10);
    player.push("mana", 20);

    var abilityTree = tree.newArray();
    { // Melee
        var ability = tree.newObject();
        ability.push("name", "Melee Attack");
        ability.push("calculation", "1d4+3");
        ability.push("cost", "2mana");
        abilityTree.push(null, ability);
    }
    { // Charge
        var ability = tree.newObject();
        ability.push("name", "Charge Attack");
        ability.push("calculation", "1d2+1");
        ability.push("cost", "2health");
        ability.push("targets", "enemies");
        abilityTree.push(null, ability);
    }

    player.push("abilities", abilityTree);

    tree.root.push("player", player);
}
test "Basic Struct Serialization" {
    // const bad = opaque{};
    const Dummy = struct {
        health:i32 = 30,
        mana:i32 = 50,
        ignored:?bool = null,
        // never:*bad = undefined,
    };
    var tree = Tree.initArena(std.testing.allocator);
    defer tree.deinit();

    tree.root = tree.toNode(Dummy{});

    try std.testing.expect(tree.root.data == .Map);
    try std.testing.expect(tree.root.data.Map.contains("health"));
    try std.testing.expect(tree.root.data.Map.contains("mana"));
    try std.testing.expect(tree.root.data.Map.contains("ignored"));
}
test "Basic Raw Deserialization" {
    var tree = Tree.initRaw(std.testing.allocator);
    defer tree.deinit();
    tree.root = tree.newObject();

    var player = tree.newObject();
    player.push("health", 10);
    player.push("mana", 20);

    tree.root.push("player", player);

    const into = struct {
        health: i32,
        mana: i32,
    };

    // Struct:
    var playerDeserialized = into {
        .health = undefined,
        .mana = undefined
    };
    player.into(&playerDeserialized, null);
    try std.testing.expectEqual(into{.health=10,.mana=20},playerDeserialized);

    // Basic types:
    var health: i32 = 0;
    player.data.Map.get("health").?.into(&health, null);
    try std.testing.expectEqual(@intCast(i32, 10), health);
}

test "Standard library structs to basic structs" {
    var tree = Tree.initRaw(std.testing.allocator);
    defer tree.deinit();
    tree.root = tree.newObject();


    var healthMeters = std.ArrayList(i32).init(std.testing.allocator);
    defer healthMeters.deinit();

    var associations = std.StringHashMap(i32).init(std.testing.allocator);
    defer associations.deinit();

    try associations.put("enemy", 10);
    try associations.put("friendly", 20);

    try healthMeters.append(30);
    try healthMeters.append(60);
    try healthMeters.append(90);

    var player = tree.newObject();
    player.push("health", 10);
    player.push("mana", 20);
    player.push("targets", healthMeters);
    player.push("associations", associations);

    tree.root.push("player", player);
}