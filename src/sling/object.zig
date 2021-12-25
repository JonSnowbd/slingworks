const std = @import("std");
const sling = @import("../main.zig");
const ig = sling.package.imgui;

pub const ObjectType = enum {
    Collection,
    Singleton,
};

pub const Clearance = enum {
    editorOnly,
    gameOnly,
    both,
};

/// Created by looking into an entity interface, or via its GenBuildData(T),
/// this contains the information necessary to instance and deserialize into the various types.
pub const Information = struct {
    var pointerToId = std.StringHashMap(usize).init(sling.mem.Allocator);
    var registeredObjects = std.ArrayList(*const Information).init(sling.mem.Allocator);

    name: []const u8,
    autoCreate: fn (*sling.Scene) *Interface,
    autoCreateFrom: fn (*sling.serializer.Node, *sling.Scene) *Interface,
    create: fn (*sling.Scene) *Interface,
    createSingleton: fn (*sling.Scene) *Interface,
    createFrom: fn (*sling.serializer.Node, *sling.Scene) *Interface,
    createSingletonFrom: fn (*sling.serializer.Node, *sling.Scene) *Interface,
    isShadow: fn () bool,

    pub fn register(info: *const Information) void {
        var id = registeredObjects.items.len;
        registeredObjects.append(info) catch {
            std.debug.panic("Failed to register object information: {any}", .{info});
        };
        pointerToId.put(info.name, id) catch {
            std.debug.panic("Failed to register object information index: {any} at {any}", .{ info, id });
        };
    }
    pub fn get(id: usize) *const Information {
        return registeredObjects.items[id];
    }
    pub fn getType(comptime T: type) *const Information {
        if (pointerToId.get(@typeName(T))) |id| {
            return registeredObjects.items[id];
        } else {
            std.debug.panic("Attempted to get type that is not registered.", .{});
            unreachable;
        }
    }
    pub fn indexOf(comptime T: type) usize {
        if (pointerToId.get(@typeName(T))) |id| {
            return id;
        } else {
            std.debug.panic("Attempted to get type that is not registered.", .{});
            unreachable;
        }
    }
    pub fn slice() []const *const Information {
        return registeredObjects.items;
    }
};
/// The interface that needs to be implemented in order to be considered for use inside
/// of a scene as either a parent or child data type.
pub const Interface = struct {
    /// The sole source of allocation in an object group.
    arena: std.heap.ArenaAllocator = undefined,
    /// Basic information on the object in question, including a method to create
    /// a heap allocated instance of the object.
    information: *const Information,
    data: DataUnion,
    serialize: fn (*Interface, *sling.serializer.Tree) *sling.serializer.Node,
    update: fn (*Interface) void,
    deinitAll: fn (*Interface) void,

    pub const DataUnion = union(ObjectType) {
        Collection: Collection,
        Singleton: Singleton,
    };
    pub const Collection = struct {
        /// Emits imgui calls to edit a specific indexed object.
        editor: fn (*Interface, usize) void,
        /// Queues an entity index for deletion at the end of the current iteration.
        remove: fn (*Interface, usize) void,
        /// Creates a new object inside of the container
        append: fn (*Interface) void,
        /// Gets the amount of objects
        getCount: fn (*Interface) usize,
        /// The objects inside can be represented by non-generic text, this gets those names.
        getName: fn (*Interface, usize) []const u8,
        /// Copies all the data from the first index into the second.
        copyFromTo: fn (*Interface, usize, usize) void,
    };
    pub const Singleton = struct {
        editor: fn (*Interface) void,
        getName: fn (*Interface) []const u8,
    };
};

/// Pass in an entity data type(not the interface container, the raw data type itself) and
/// call register to get the 'build' data for the entities behaviour, such as ignored fields,
/// hidden fields, and the information struct that lets you instanciate a collection/singleton
/// instantly.
///
/// Dynamic Method Parameters: In the provided functions for init/update/editorExtension
/// registration, you can be flexible with what parameters you have on them, and in what order.
///
/// Here are a few auto filled parameters your methods can have:
/// `*T` - The entity object itself
/// `usize` - The Index/ID of an object, for example the third object in a collection will receive `2`
/// `*sling.Scene` - The scene in which the object is currently inside, use this for reaching out to other collections.
pub fn GenBuildData(comptime T: type) type {
    return struct {
        pub const information = Information{
            .name = @typeName(T),
            .autoCreate = GenAutoCreate,
            .autoCreateFrom = GenAutoCreateFrom,
            .create = CollectionType(T).objInformation_create,
            .createSingleton = SingletonType(T).objInformation_create,
            .createFrom = CollectionType(T).objInformation_createFrom,
            .createSingletonFrom = SingletonType(T).objInformation_createFrom,
            .isShadow = @This().isShadow,
        };
        pub var Instance: ?@This() = null;

        const FnWrap = struct {
            func: []const u8,
            clearance: Clearance,

            fn init(func: []const u8, clearance: Clearance) FnWrap {
                return .{ .func = func, .clearance = clearance };
            }

            fn canRun(self: FnWrap) bool {
                if (sling.state.isEditing) {
                    return self.clearance == .editorOnly or self.clearance == .both;
                } else {
                    return self.clearance == .gameOnly or self.clearance == .both;
                }
            }

            fn updateSingular(self: FnWrap, target: *T, scene: *sling.Scene) void {
                if (self.canRun()) {
                    inline for (std.meta.declarations(T)) |declField| {
                        if (declField.is_pub) {
                            const fnTypeInfo = @typeInfo(@TypeOf(@field(T, declField.name)));
                            if (fnTypeInfo == .Fn and fnTypeInfo.Fn.args.len > 0) {
                                var name: []const u8 = declField.name;
                                if (std.mem.eql(u8, name, self.func)) {
                                    const feed = ArgType(fnTypeInfo);
                                    var paramList: feed = undefined;
                                    inline for (fnTypeInfo.Fn.args) |fnArg, i| {
                                        if (fnArg.arg_type) |parameter| {
                                            switch (parameter) {
                                                *sling.Scene => {
                                                    paramList[i] = scene;
                                                },
                                                *T => {
                                                    paramList[i] = target;
                                                },
                                                usize => {
                                                    paramList[i] = 0;
                                                },
                                                else => {},
                                            }
                                        } else {
                                            @compileError("Typeless parameter?");
                                        }
                                    }
                                    const func = @field(T, declField.name);
                                    const site = std.builtin.CallOptions{};
                                    _ = @call(site, func, paramList);
                                    return;
                                }
                            }
                        }
                    }
                }
            }
            fn updateArray(self: FnWrap, target: []T, scene: *sling.Scene) void {
                if (self.canRun()) {
                    inline for (std.meta.declarations(T)) |declField| {
                        if (declField.is_pub) {
                            const fnTypeInfo = @typeInfo(@TypeOf(@field(T, declField.name)));
                            if (fnTypeInfo == .Fn and fnTypeInfo.Fn.args.len > 0) {
                                var name: []const u8 = declField.name;
                                if (std.mem.eql(u8, name, self.func)) {
                                    const feed = ArgType(fnTypeInfo);
                                    var paramList: feed = undefined;
                                    comptime var targetIndex: ?usize = null;
                                    comptime var indexIndex: ?usize = null;
                                    inline for (fnTypeInfo.Fn.args) |fnArg, i| {
                                        if (fnArg.arg_type) |parameter| {
                                            switch (parameter) {
                                                *sling.Scene => {
                                                    paramList[i] = scene;
                                                },
                                                *T => {
                                                    targetIndex = i;
                                                },
                                                usize => {
                                                    indexIndex = i;
                                                },
                                                else => {},
                                            }
                                        } else {
                                            @compileError("Typeless parameter?");
                                        }
                                    }
                                    const func = @field(T, declField.name);
                                    for (target) |*targetValue, j| {
                                        if (targetIndex) |idx| {
                                            paramList[idx] = targetValue;
                                        }
                                        if (indexIndex) |idx| {
                                            paramList[idx] = j;
                                        }
                                        const site = std.builtin.CallOptions{};
                                        _ = @call(site, func, paramList);
                                    }
                                    return;
                                }
                            }
                        }
                    }
                }
            }
        };

        allocator: std.mem.Allocator,
        _hidden: std.StringHashMap(void),
        _init: std.ArrayList(FnWrap),
        _deinitFn: std.ArrayList(FnWrap),
        _update: std.ArrayList(FnWrap),
        _getName: ?fn (*T) []const u8,
        _prefersSingleton: bool,
        _prefersShadow: bool,
        _editorExtension: ?FnWrap,

        fn isShadow() bool {
            if (Instance) |inst| {
                return inst._prefersShadow;
            }
            return false;
        }
        fn initBuildData(allocator: std.mem.Allocator) @This() {
            return .{
                .allocator = allocator,
                ._hidden = std.StringHashMap(void).init(allocator),
                ._init = std.ArrayList(FnWrap).init(allocator),
                ._deinitFn = std.ArrayList(FnWrap).init(allocator),
                ._update = std.ArrayList(FnWrap).init(allocator),
                ._getName = null,
                ._prefersSingleton = false,
                ._prefersShadow = false,
                ._editorExtension = null,
            };
        }
        fn GenAutoCreate(scene: *sling.Scene) *Interface {
            var build = register();
            if (build._prefersSingleton) {
                return information.createSingleton(scene);
            } else {
                return information.create(scene);
            }
        }
        fn GenAutoCreateFrom(node: *sling.serializer.Node, scene: *sling.Scene) *Interface {
            var build = register();
            if (build._prefersSingleton) {
                return information.createSingletonFrom(node, scene);
            } else {
                return information.createFrom(node, scene);
            }
        }
        pub fn deinit(self: *@This()) void {
            self._hidden.deinit();
            self._deinitFn.deinit();
            self._init.deinit();
            self._update.deinit();
        }
        /// This hides the fields from the editor, but does not prevent it from being serialized.
        /// Recommended for fields that will be controlled from your editor manually rather than
        /// automatically handled by sling.
        pub fn hide(self: *@This(), comptime field: std.meta.FieldEnum(T)) void {
            self._hidden.put(@tagName(field), {}) catch |err| {
                std.debug.panic("Failed to ignore field '{s}' from type '{s}' due to:\n{s}", .{ @tagName(field), @typeName(T), @errorName(err) });
            };
        }
        /// Hides and ignores a field, it will not show up in the editor, and will not be saved/restored
        /// by serialization in any scenario.
        pub fn ignore(self: *@This(), comptime field: std.meta.FieldEnum(T)) void {
            _ = self;
            sling.config.serializationConfig.ignore(T, @tagName(field));
        }
        /// Marks a declaration function as an initializer function, this is ran on scene start
        /// for singletons, and on creation/deserialization for each object in a collection type.
        /// Clearance controls when it can be ran, `.editorOnly` for in editor initialization,
        /// `.gameOnly` for in game initialization, or `.both` for both.
        pub fn initMethod(self: *@This(), comptime method: sling.util.DeclEnum(T), comptime clearance: Clearance) void {
            self._init.append(FnWrap.init(@tagName(method), clearance)) catch |err| {
                std.debug.panic("Failed to add init system '{s}' to type '{s}' due to:\n{s}", .{ @tagName(method), @typeName(T), @errorName(err) });
            };
        }
        /// Marks a declaration function as an initializer function, this is ran on scene end
        /// for singletons, and on on scene end and destruction for each object in a collection type.
        /// Clearance controls when it can be ran, `.editorOnly` for in editor initialization,
        /// `.gameOnly` for in game initialization, or `.both` for both.
        pub fn deinitMethod(self: *@This(), comptime method: sling.util.DeclEnum(T), comptime clearance: Clearance) void {
            self._deinitFn.append(FnWrap.init(@tagName(method), clearance)) catch |err| {
                std.debug.panic("Failed to add init system '{s}' to type '{s}' due to:\n{s}", .{ @tagName(method), @typeName(T), @errorName(err) });
            };
        }
        /// Marks a declaration function as a name retrieval method, required to be `fn(*T) []const u8`
        /// and the resulting string is not required to live through the entire frame.
        /// By providing this function names in the editor will be more ergonomic and you will
        /// get full control over how they are presented to the editor.
        ///
        /// Note: This method is fixed and you cannot dynamically request more information via
        /// the function's parameters like the other methods.
        pub fn nameMethod(self: *@This(), comptime method: sling.util.DeclEnum(T)) void {
            self._getName = @field(T, @tagName(method));
        }
        /// Marks a declaration function as an update function, this is ran on every frame update,
        /// and can be used to modify the object or render via `sling.render`, or anything else if you're careful.
        /// Clearance controls when it can be ran, `.editorOnly` for in editor initialization,
        /// `.gameOnly` for in game initialization, or `.both` for both.
        pub fn updateMethod(self: *@This(), comptime method: sling.util.DeclEnum(T), comptime clearance: Clearance) void {
            self._update.append(FnWrap.init(@tagName(method), clearance)) catch |err| {
                std.debug.panic("Failed to add update system '{s}' to type '{s}' due to:\n{s}", .{ @tagName(method), @typeName(T), @errorName(err) });
            };
        }
        /// Marking an entity as preferring singleton means that when it is considered
        /// as a child entity in a scene, it will be a persistent single entry instead of
        /// a collection of entity data.
        pub fn prefersSingleton(self: *@This()) void {
            self._prefersSingleton = true;
        }
        /// Being a shadow type means that if this is a child object, it is completely hidden
        /// from the editor and not serialized. This is useful for things you only want to spawn
        /// via code on the scene, typically shortlived objects like projectiles.
        pub fn prefersShadow(self: *@This()) void {
            self._prefersShadow = true;
        }
        /// You can provide an extension method to allow you to place imgui components
        /// in the 'selected entity' editor. Do not call imgui.beginWindow(ig.begin) in this,
        /// instead just call imgui functions that do not begin new windows(child is okay though).
        pub fn editorExtension(self: *@This(), comptime method: sling.util.DeclEnum(T)) void {
            self._editorExtension = FnWrap.init(@tagName(method), .editorOnly);
        }
        pub fn register() *@This() {
            if (Instance == null) {
                Information.register(&GenBuildData(T).information);
                // Register the type in sling
                Instance = initBuildData(sling.mem.Allocator);
                std.debug.print("Registering new type: {s}\n", .{@typeName(T)});
            }

            return &Instance.?;
        }
    };
}
fn ArgType(comptime Fn: std.builtin.TypeInfo) type {
    if (Fn != .Fn) {
        @compileError(std.fmt.comptimePrint("Type '{any}' doesnt fit the format for a method call.", .{Fn}));
    }
    return comptime blk: {
        var fields: [Fn.Fn.args.len]std.builtin.TypeInfo.StructField = undefined;
        for (fields) |*f, idx| {
            var num_buf: [128]u8 = undefined;
            f.* = .{
                .name = std.fmt.bufPrint(&num_buf, "{}", .{idx}) catch unreachable,
                .field_type = Fn.Fn.args[idx].arg_type.?,
                .default_value = @as(?(Fn.Fn.args[idx].arg_type.?), null),
                .is_comptime = false,
                .alignment = @alignOf(Fn.Fn.args[idx].arg_type.?),
            };
        }
        break :blk @Type(.{
            .Struct = .{
                .layout = .Auto,
                .fields = &fields,
                .decls = &[0]std.builtin.TypeInfo.Declaration{},
                .is_tuple = true,
            },
        });
    };
}

/// Takes a data type and turns it into an interface container for a 'collection' type entity
/// that represents an array of that data in the game world.
pub fn CollectionType(comptime T: type) type {
    return struct {
        const Self = @This();

        parent: *sling.Scene = undefined,
        interface: Interface = undefined,
        value: []T = undefined,

        inline fn getSelf(data: *Interface) *Self {
            return @fieldParentPtr(Self, "interface", data);
        }

        // =====
        // Information interface impl
        // =====
        fn objInformation_create(scene: *sling.Scene) *Interface {
            var build = GenBuildData(T).register();
            var instance: *Self = build.allocator.create(Self) catch unreachable;
            instance.interface = .{ .arena = std.heap.ArenaAllocator.init(build.allocator), .information = &GenBuildData(T).information, .serialize = Self.interface_serialize, .update = Self.interface_update, .deinitAll = Self.interface_deinitAll, .data = .{ .Collection = .{
                .editor = Self.interface_editor,
                .remove = Self.interface_remove,
                .append = Self.interface_append,
                .getCount = Self.interface_getCount,
                .getName = Self.interface_getName,
                .copyFromTo = Self.interface_copyFromTo,
            } } };
            instance.parent = scene;
            instance.value = instance.interface.arena.allocator().alloc(T, 0) catch |err| {
                std.debug.panic("Failed to alloc initial values for {s} due to:\n{s}", .{ GenBuildData(T).information.name, @errorName(err) });
            };
            return &instance.interface;
        }
        fn objInformation_createFrom(node: *sling.serializer.Node, scene: *sling.Scene) *Interface {
            var build = GenBuildData(T).register();
            var instance: *Self = build.allocator.create(Self) catch |err| {
                std.debug.panic("Failed to allocate type {s} with error:\n{s}", .{ @typeName(Self), @errorName(err) });
            };
            instance.interface = .{ 
                .arena = std.heap.ArenaAllocator.init(build.allocator),
                .information = &GenBuildData(T).information,
                .serialize = Self.interface_serialize,
                .update = Self.interface_update,
                .deinitAll = Self.interface_deinitAll,
                .data = .{ 
                    .Collection = .{
                        .editor = Self.interface_editor,
                        .remove = Self.interface_remove,
                        .append = Self.interface_append,
                        .getCount = Self.interface_getCount,
                        .getName = Self.interface_getName,
                        .copyFromTo = Self.interface_copyFromTo,
                    }
                } 
            };
            instance.parent = scene;
            node.into(&instance.value, instance.interface.arena.allocator());
            for (build._init.items) |wrapper| {
                wrapper.updateArray(instance.value, instance.parent);
            }
            return &instance.interface;
        }

        // =====
        // Interface interface impl
        // =====
        fn interface_editor(object: *Interface, index: usize) void {
            var build = GenBuildData(T).register();
            var self: *Self = getSelf(object);
            inline for (std.meta.fields(T)) |fieldInfo| {
                if (!build._hidden.contains(fieldInfo.name) and !sling.config.serializationConfig.ignores(T, fieldInfo.name)) {
                    var fieldRef = &@field(self.value[index], fieldInfo.name);
                    _ = sling.imgui.components.input(fieldInfo.name, fieldRef, .{});
                }
            }
            if (build._editorExtension) |extension| {
                extension.updateSingular(&self.value[index], self.parent);
            }
        }
        fn interface_serialize(object: *Interface, tree: *sling.serializer.Tree) *sling.serializer.Node {
            var self: *Self = getSelf(object);
            return tree.toNode(self.value);
        }
        fn interface_update(object: *Interface) void {
            var build = GenBuildData(T).register();
            var self: *Self = getSelf(object);
            for (build._update.items) |wrapper| {
                wrapper.updateArray(self.value, self.parent);
            }
        }
        fn interface_append(object: *Interface) void {
            var build = GenBuildData(T).register();
            var self: *Self = getSelf(object);
            self.value = self.interface.arena.allocator().realloc(self.value, self.value.len + 1) catch {
                std.debug.panic("Failed to realloc internal object array of size {any}", .{self.value.len});
            };
            self.value[self.value.len - 1] = .{};
            for (build._init.items) |wrapper| {
                wrapper.updateSingular(&self.value[self.value.len - 1], self.parent);
            }
        }
        fn interface_deinitAll(object: *Interface) void {
            var self: *Self = getSelf(object);
            var build = GenBuildData(T).register();

            for (build._deinitFn.items) |wrapper| {
                wrapper.updateArray(self.value, self.parent);
            }
        }
        fn interface_remove(object: *Interface, index: usize) void {
            var self: *Self = getSelf(object);
            var build = GenBuildData(T).register();

            for (build._deinitFn.items) |wrapper| {
                wrapper.updateArray(self.value, self.parent);
            }
            self.value[index] = self.value[self.value.len - 1];
            self.value = self.interface.arena.allocator().realloc(self.value, self.value.len - 1) catch {
                std.debug.panic("Failed to realloc internal object array of size {any}", .{self.value.len});
            };
        }
        fn interface_getCount(object: *Interface) usize {
            var self: *Self = getSelf(object);
            return self.value.len;
        }
        fn interface_getName(object: *Interface, index: usize) []const u8 {
            var self: *Self = getSelf(object);
            var build = GenBuildData(T).register();

            if (build._getName) |gn| {
                return gn(&self.value[index]);
            } else {
                return sling.imgui.components.format("{s}#{any}", .{ GenBuildData(T).information.name, index });
            }
        }
        fn interface_copyFromTo(object: *Interface, index: usize, destination: usize) void {
            var self: *Self = getSelf(object);
            self.value[destination] = self.value[index];
        }
    };
}

/// Takes a data type and turns it into an interface container for a 'singleton' type entity
/// that represents a single constantly active entity.
pub fn SingletonType(comptime T: type) type {
    return struct {
        const Self = @This();

        parent: *sling.Scene = undefined,
        interface: Interface = undefined,
        value: T = undefined,

        inline fn getSelf(data: *Interface) *Self {
            return @fieldParentPtr(Self, "interface", data);
        }

        // =====
        // Information interface impl
        // =====
        fn objInformation_create(scene: *sling.Scene) *Interface {
            var build = GenBuildData(T).register();
            var instance: *Self = build.allocator.create(Self) catch unreachable;
            instance.interface = .{ .arena = std.heap.ArenaAllocator.init(build.allocator), .information = &GenBuildData(T).information, .serialize = Self.interface_serialize, .update = Self.interface_update, .deinitAll = Self.interface_deinitAll, .data = .{ .Singleton = .{ .editor = Self.interface_editor, .getName = Self.interface_getName } } };
            instance.parent = scene;

            instance.value = .{};
            for (build._init.items) |wrapper| {
                wrapper.updateSingular(&instance.value, instance.parent);
            }
            return &instance.interface;
        }
        fn objInformation_createFrom(node: *sling.serializer.Node, scene: *sling.Scene) *Interface {
            var build = GenBuildData(T).register();
            var instance: *Self = build.allocator.create(Self) catch |err| {
                std.debug.panic("Failed to allocate type {s} with error:\n{s}", .{ @typeName(Self), @errorName(err) });
            };
            instance.interface = .{ .arena = std.heap.ArenaAllocator.init(build.allocator), .information = &GenBuildData(T).information, .serialize = Self.interface_serialize, .update = Self.interface_update, .deinitAll = Self.interface_deinitAll, .data = .{ .Singleton = .{ .editor = Self.interface_editor, .getName = Self.interface_getName } } };
            instance.parent = scene;

            node.into(&instance.value, instance.interface.arena.allocator());
            for (build._init.items) |wrapper| {
                wrapper.updateSingular(&instance.value, instance.parent);
            }
            return &instance.interface;
        }

        // =====
        // Interface interface impl
        // =====
        fn interface_editor(object: *Interface) void {
            var build = GenBuildData(T).register();

            var self: *Self = getSelf(object);
            inline for (std.meta.fields(T)) |fieldInfo| {
                if (!build._hidden.contains(fieldInfo.name) and !sling.config.serializationConfig.ignores(T, fieldInfo.name)) {
                    var fieldRef = &@field(self.value, fieldInfo.name);
                    _ = sling.imgui.components.input(fieldInfo.name, fieldRef, .{});
                }
            }
            if (build._editorExtension) |extension| {
                extension.updateSingular(&self.value, self.parent);
            }
        }
        fn interface_serialize(object: *Interface, tree: *sling.serializer.Tree) *sling.serializer.Node {
            var self: *Self = getSelf(object);
            return tree.toNode(self.value);
        }
        fn interface_deinitAll(object: *Interface) void {
            var self: *Self = getSelf(object);
            var build = GenBuildData(T).register();

            for (build._deinitFn.items) |wrapper| {
                wrapper.updateSingular(&self.value, self.parent);
            }
        }
        fn interface_update(object: *Interface) void {
            var build = GenBuildData(T).register();
            var self: *Self = getSelf(object);
            for (build._update.items) |wrapper| {
                wrapper.updateSingular(&self.value, self.parent);
            }
        }
        fn interface_getName(object: *Interface) []const u8 {
            _ = object;
            return @typeName(T);
        }
    };
}
