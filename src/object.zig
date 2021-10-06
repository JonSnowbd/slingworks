const std = @import("std");
const ig = @import("imgui");
const zt = @import("zt");

const sling = @import("sling.zig");

pub const ObjectType = enum {
    Collection,
    Singleton,
};

pub const Clearance = enum {
    editorOnly,
    gameOnly,
    both,
};

pub const Information = struct {
    var pointerToId = std.StringHashMap(usize).init(sling.alloc);
    var registeredObjects = std.ArrayList(*const Information).init(sling.alloc);

    name: []const u8,
    create: fn (*sling.Scene) *Interface,
    createSingleton: fn (*sling.Scene) *Interface,
    createFrom: fn (*sling.serializer.Node, *sling.Scene) *Interface,
    createSingletonFrom: fn (*sling.serializer.Node, *sling.Scene) *Interface,

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
pub fn GenBuildData(comptime T: type) type {
    return struct {
        pub const information = Information{
            .name = @typeName(T),
            .create = CollectionType(T).objInformation_create,
            .createSingleton = SingletonType(T).objInformation_create,
            .createFrom = CollectionType(T).objInformation_createFrom,
            .createSingletonFrom = SingletonType(T).objInformation_createFrom,
        };
        pub var Instance: ?@This() = null;
        const FnWrap = struct {
            func: []const u8,
            clearance: Clearance,

            fn init(func: []const u8, clearance: Clearance) FnWrap {
                return .{ .func = func, .clearance = clearance };
            }

            fn canRun(self: FnWrap) bool {
                if (sling.inEditor) {
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

        allocator: *std.mem.Allocator,
        _hidden: std.StringHashMap(void),
        _init: std.ArrayList(FnWrap),
        _deinitFn: std.ArrayList(FnWrap),
        _update: std.ArrayList(FnWrap),
        _getName: ?fn (*T) []const u8,
        _editorExtension: ?FnWrap,

        fn initBuildData(allocator: *std.mem.Allocator) @This() {
            return .{
                .allocator = allocator,
                ._hidden = std.StringHashMap(void).init(allocator),
                ._init = std.ArrayList(FnWrap).init(allocator),
                ._deinitFn = std.ArrayList(FnWrap).init(allocator),
                ._update = std.ArrayList(FnWrap).init(allocator),
                ._getName = null,
                ._editorExtension = null,
            };
        }

        pub fn deinit(self: *@This()) void {
            self._hidden.deinit();
            self._deinitFn.deinit();
            self._init.deinit();
            self._update.deinit();
        }

        pub fn hide(self: *@This(), comptime field: std.meta.FieldEnum(T)) void {
            self._hidden.put(@tagName(field), {}) catch |err| {
                std.debug.panic("Failed to ignore field '{s}' from type '{s}' due to:\n{s}", .{ @tagName(field), @typeName(T), @errorName(err) });
            };
        }
        pub fn ignore(self: *@This(), comptime field: std.meta.FieldEnum(T)) void {
            _ = self;
            sling.preferredSerializationConfig.ignore(T, @tagName(field));
        }
        pub fn initMethod(self: *@This(), comptime method: sling.util.DeclEnum(T), comptime clearance: Clearance) void {
            self._init.append(FnWrap.init(@tagName(method), clearance)) catch |err| {
                std.debug.panic("Failed to add init system '{s}' to type '{s}' due to:\n{s}", .{ @tagName(method), @typeName(T), @errorName(err) });
            };
        }
        pub fn deinitMethod(self: *@This(), comptime method: sling.util.DeclEnum(T), comptime clearance: Clearance) void {
            self._deinitFn.append(FnWrap.init(@tagName(method), clearance)) catch |err| {
                std.debug.panic("Failed to add init system '{s}' to type '{s}' due to:\n{s}", .{ @tagName(method), @typeName(T), @errorName(err) });
            };
        }
        pub fn nameMethod(self: *@This(), comptime method: sling.util.DeclEnum(T)) void {
            self._getName = @field(T, @tagName(method));
        }
        pub fn updateMethod(self: *@This(), comptime method: sling.util.DeclEnum(T), comptime clearance: Clearance) void {
            self._update.append(FnWrap.init(@tagName(method), clearance)) catch |err| {
                std.debug.panic("Failed to add update system '{s}' to type '{s}' due to:\n{s}", .{ @tagName(method), @typeName(T), @errorName(err) });
            };
        }
        pub fn editorExtension(self: *@This(), comptime method: sling.util.DeclEnum(T)) void {
            self._editorExtension = FnWrap.init(@tagName(method), .editorOnly);
        }

        pub fn register() *@This() {
            if (Instance == null) {
                Information.register(&GenBuildData(T).information);
                // Register the type in sling
                Instance = initBuildData(sling.alloc);
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
            instance.value = instance.interface.arena.allocator.alloc(T, 0) catch |err| {
                std.debug.panic("Failed to alloc initial values for {s} due to:\n{s}", .{ GenBuildData(T).information.name, @errorName(err) });
            };
            return &instance.interface;
        }
        fn objInformation_createFrom(node: *sling.serializer.Node, scene: *sling.Scene) *Interface {
            var build = GenBuildData(T).register();
            var instance: *Self = build.allocator.create(Self) catch |err| {
                std.debug.panic("Failed to allocate type {s} with error:\n{s}", .{ @typeName(Self), @errorName(err) });
            };
            instance.interface = .{ .arena = std.heap.ArenaAllocator.init(build.allocator), .information = &GenBuildData(T).information, .serialize = Self.interface_serialize, .update = Self.interface_update, .deinitAll = Self.interface_deinitAll, .data = .{ .Collection = .{
                .editor = Self.interface_editor,
                .remove = Self.interface_remove,
                .append = Self.interface_append,
                .getCount = Self.interface_getCount,
                .getName = Self.interface_getName,
                .copyFromTo = Self.interface_copyFromTo,
            } } };
            instance.parent = scene;
            node.into(&instance.value, &instance.interface.arena.allocator);
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
                if (!build._hidden.contains(fieldInfo.name) and !sling.preferredSerializationConfig.ignores(T, fieldInfo.name)) {
                    var fieldRef = &@field(self.value[index], fieldInfo.name);
                    _ = sling.util.igEdit(fieldInfo.name, fieldRef);
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
            self.value = self.interface.arena.allocator.realloc(self.value, self.value.len + 1) catch {
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
            self.value = self.interface.arena.allocator.realloc(self.value, self.value.len - 1) catch {
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
                return zt.custom_components.fmtTextForImgui("{s}#{any}", .{ GenBuildData(T).information.name, index });
            }
        }
        fn interface_copyFromTo(object: *Interface, index: usize, destination: usize) void {
            var self: *Self = getSelf(object);
            self.value[destination] = self.value[index];
        }
    };
}

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

            node.into(&instance.value, &instance.interface.arena.allocator);
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
                if (!build._hidden.contains(fieldInfo.name) and !sling.preferredSerializationConfig.ignores(T, fieldInfo.name)) {
                    var fieldRef = &@field(self.value, fieldInfo.name);
                    _ = sling.util.igEdit(fieldInfo.name, fieldRef);
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
