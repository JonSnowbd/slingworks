const std = @import("std");
const sling = @import("sling.zig");
const zt = @import("zt");
const ig = @import("imgui");

/// Produces an enum of declarations found in a type. Useful for parameters
/// aimed at a declaration in a type.
pub fn DeclEnum(comptime T: type) type {
    const declInfos = std.meta.declarations(T);
    var declFields: [declInfos.len]std.builtin.TypeInfo.EnumField = undefined;
    var decls = [_]std.builtin.TypeInfo.Declaration{};
    inline for (declInfos) |field, i| {
        declFields[i] = .{
            .name = field.name,
            .value = i,
        };
    }
    return @Type(.{
        .Enum = .{
            .layout = .Auto,
            .tag_type = std.math.IntFittingRange(0, declInfos.len - 1),
            .fields = &declFields,
            .decls = &decls,
            .is_exhaustive = true,
        },
    });
}

pub fn hexToColor(hex: u32) sling.math.Vec4 {
    const cast: [4]u8 = @bitCast([4]u8, hex);
    return sling.math.vec4(@intToFloat(f32, cast[0]) / 255.0, @intToFloat(f32, cast[1]) / 255.0, @intToFloat(f32, cast[2]) / 255.0, @intToFloat(f32, cast[3]) / 255.0);
}
pub fn hexToColorString(hexCode: []const u8) sling.math.Vec4 {
    var slice: []const u8 = std.mem.trim(u8, hexCode, "#");
    var hex = std.fmt.parseUnsigned(u32, slice, 16) catch unreachable;
    return hexToColor(hex);
}

/// An allocated format print you dont need to free:
pub fn tempFmt(comptime fmt: []const u8, params: anytype) []const u8 {
    return std.fmt.allocPrint(sling.zt.Allocators.ring(), fmt, params) catch unreachable;
}

/// Depends on each state having an `fn(*SelfState,*Context) ?TaggedUnion` named `update`.
/// Pass in an `union(enum)` that contains each state, the update signature above
/// returns the union if it will transition to a new state, or null if it will
/// remain the same.
pub fn StateMachine(comptime TaggedUnion: type, comptime Context: type) type {
    std.debug.assert(@typeInfo(TaggedUnion) == .Union);
    return struct {
        /// If true, the next state is updated on transitions.
        followThroughUpdate: bool = true,
        currentState: TaggedUnion,
        pub fn init(initialState: TaggedUnion) @This() {
            return .{
                .currentState = initialState,
            };
        }
        pub fn update(self: *@This(), context: Context) void {
            var activeTag = std.meta.activeTag(self.currentState);
            const info = @typeInfo(TaggedUnion).Union;
            inline for (info.fields) |field_info| {
                if (std.mem.eql(u8, field_info.name, @tagName(activeTag))) {
                    const T = field_info.field_type;
                    if (@hasDecl(T, "update")) {
                        if (T.update(&@field(self.currentState, field_info.name), context)) |newState| {
                            if (@hasDecl(T, "leave")) {
                                T.leave(&@field(self.currentState, field_info.name), context);
                            }
                            self.goto(newState, context);
                        }
                    } else {
                        @compileError("Each state of a statemachine should have an `fn update(self:*State, target:*Context) ?Union`");
                    }
                }
            }
        }
        fn goto(self: *@This(), newState: TaggedUnion, context: Context) void {
            self.currentState = newState;
            var nextTag = std.meta.activeTag(self.currentState);
            const info = @typeInfo(TaggedUnion).Union;
            inline for (info.fields) |field_info| {
                if (std.mem.eql(u8, field_info.name, @tagName(nextTag))) {
                    const T = field_info.field_type;
                    if (@hasDecl(T, "enter")) {
                        T.enter(&@field(self.currentState, field_info.name), context);
                    }
                }
            }
            if (self.followThroughUpdate) {
                self.update(context);
            }
        }
    };
}

/// A data structure that lets you store a usize lookup id to retrieve a value
/// without changing every other id reference when one is released by storing
/// 'holes' to reuse in the structure.
pub fn HoleQueue(comptime T: type) type {
    return struct {
        const Self = @This();

        allocator: *std.mem.Allocator,
        internalList: std.ArrayList(T),
        holeQueue: std.fifo.LinearFifo(usize, .Dynamic),

        pub fn init(allocator: *std.mem.Allocator) Self {
            return .{
                .allocator = allocator,
                .internalList = std.ArrayList(T).init(allocator),
                .holeQueue = std.fifo.LinearFifo(usize, .Dynamic).init(allocator),
            };
        }

        pub fn deinit(self: *Self) void {
            self.internalList.deinit();
            self.holeQueue.deinit();
        }

        /// Copies a stack value into local memory and returns its index(which is guaranteed
        /// to never change.)
        pub fn take(self: *Self, stackVal: T) !usize {
            if (self.holeQueue.readItem()) |id| {
                self.internalList.items[id] = stackVal;
                return id;
            } else {
                var id = self.internalList.items.len;
                try self.internalList.append(stackVal);
                return id;
            }
        }

        pub fn release(self: *Self, id: usize) !void {
            try self.holeQueue.writeItem(id);
            self.internalList.items[id] = undefined;
        }

        pub fn get(self: *Self, id: usize) *T {
            return &self.internalList.items[id];
        }
        pub fn getCopy(self: *Self, id: usize) T {
            return self.internalList.items[id];
        }
    };
}

/// Takes a value, and a min/max range, and returns a ratio depending on where value
/// lies between the 2. if clamp, it is 0-1
pub fn remapValueToRange(value: f32, range_min: f32, range_max: f32, clamp: bool) f32 {
    if (clamp) {
        return std.math.clamp((value - range_min) / (range_max - range_min), 0.0, 1.0);
    } else {
        return (value - range_min) / (range_max - range_min);
    }
}

/// Creates an ig editor field for most possible types you feed it that isnt(and doesnt contain)
/// an opaque type.
pub fn igEdit(label: []const u8, ptr: anytype) bool {
    const ti: std.builtin.TypeInfo = @typeInfo(@TypeOf(ptr.*));

    if (ti == .Pointer) {
        if (ti.Pointer.size == .Slice or ti.Pointer.size == .Many) {
            ig.igPushID_Str(label.ptr);
            var hit: bool = false;
            var height = std.math.clamp(@intToFloat(f32, ptr.*.len + 1) * 30.0, 0, 200);
            ig.igPushStyleVar_Vec2(ig.ImGuiStyleVar_WindowPadding, .{ .x = 2.0, .y = 2.0 });
            if (ig.igBeginChild_Str(label.ptr, .{ .y = height }, true, ig.ImGuiWindowFlags_None)) {
                zt.custom_components.ztTextDisabled("{s}", .{label});
                ig.igSameLine(0, 4);
                for (ptr.*) |*item, i| {
                    var fmt = zt.custom_components.fmtTextForImgui("SubArray#{any}", .{i});
                    if (igEdit(fmt, item)) {
                        hit = true;
                    }
                }
            }
            ig.igEndChild();
            ig.igPopStyleVar(1);
            ig.igPopID();
            return hit;
        }
    }

    if (ti == .Enum) {
        var returnValue: bool = false;
        var integer = @enumToInt(ptr.*);

        if (ig.igBeginCombo(label.ptr, @tagName(ptr.*).ptr, ig.ImGuiComboFlags_None)) {
            inline for (ti.Enum.fields) |enumField, i| {
                //label: [*c]const u8, selected: bool, flags: ImGuiSelectableFlags, size: ImVec2
                if (ig.igSelectable_Bool(enumField.name.ptr, i == integer, ig.ImGuiSelectableFlags_None, .{})) {
                    ptr.* = @intToEnum(@TypeOf(ptr.*), i);
                    returnValue = true;
                }
            }
            ig.igEndCombo();
        }
        return returnValue;
    }

    if (ti == .Optional) {
        if (ptr.* == null) {
            zt.custom_components.ztTextDisabled("{s} (null)", .{label});
            return false;
        } else {
            return igEdit(label, &ptr.*.?);
        }
    }

    // Handle string inputs.
    if (ti == .Array) {
        if (ti.Array.child == u8 and ti.Array.sentinel != null) {
            return ig.igInputText(label.ptr, ptr, @intCast(usize, ti.Array.len), ig.ImGuiInputTextFlags_None, null, null);
        }
    }
    // if(ti == .Union) {
    //     var comboText = zt.custom_components.fmtTextForImgui("{s} Union", .{label});
    //     if(ig.igBeginCombo("", @tagName(ptr.*).ptr, ig.ImGuiComboFlags_None)) {
    //         ig.igEndCombo();
    //     }
    //     return false;
    // }
    switch (@TypeOf(ptr)) {
        *bool => {
            return ig.igCheckbox(label.ptr, ptr);
        },
        *i32 => {
            return ig.igInputInt(label.ptr, ptr, 1, 3, ig.ImGuiInputTextFlags_None);
        },
        *f32 => {
            return ig.igInputFloat(label.ptr, ptr, 1, 3, "%.2f", ig.ImGuiInputTextFlags_None);
        },
        *usize => {
            var cast = @intCast(c_int, ptr.*);
            var result = ig.igInputInt(label.ptr, &cast, 1, 5, ig.ImGuiInputTextFlags_None);
            if (result) {
                ptr.* = @intCast(usize, std.math.max(0, cast));
            }
            return result;
        },
        *sling.math.Vec2 => {
            var cast: [2]f32 = .{ ptr.*.x, ptr.*.y };
            var result = ig.igInputFloat2(label.ptr, &cast, "%.2f", ig.ImGuiInputTextFlags_None);
            if (result) {
                ptr.* = sling.math.vec2(cast[0], cast[1]);
            }
            return result;
        },
        *sling.math.Vec3 => {
            var cast: [3]f32 = .{ ptr.*.x, ptr.*.y, ptr.*.z };
            var result = ig.igInputFloat3(label.ptr, &cast, "%.2f", ig.ImGuiInputTextFlags_None);
            if (result) {
                ptr.* = sling.math.vec3(cast[0], cast[1], cast[2]);
            }
            return result;
        },
        *sling.math.Vec4 => {
            var cast: [4]f32 = .{ ptr.*.x, ptr.*.y, ptr.*.z, ptr.*.w };
            var result = ig.igColorEdit4(label.ptr, &cast, ig.ImGuiColorEditFlags_Float);
            if (result) {
                ptr.* = sling.math.vec4(cast[0], cast[1], cast[2], cast[3]);
            }
            return result;
        },
        *sling.math.Rect => {
            var cast: [4]f32 = .{ ptr.*.position.x, ptr.*.position.y, ptr.*.size.x, ptr.*.size.y };
            var result = ig.igInputFloat4(label.ptr, &cast, "%.2f", ig.ImGuiInputTextFlags_None);
            if (result) {
                ptr.* = sling.math.rect(cast[0], cast[1], cast[2], cast[3]);
            }
            return result;
        },
        *sling.Depth => {
            var changed: bool = false;
            switch (ptr.*) {
                .Regular => {
                    if (ig.igButton("To YSorted", .{})) {
                        ptr.* = sling.Depth.initY(0.0, ptr.*.Regular);
                        return true;
                    }
                    ig.igSameLine(0, 4.0);
                    if (igEdit(label, &ptr.*.Regular)) {
                        changed = true;
                    }
                },
                .YSorted => {
                    var depthLabel = zt.custom_components.fmtTextForImgui("{s}: Depth", .{label});
                    var yLabel = zt.custom_components.fmtTextForImgui("{s}: Y", .{label});
                    if (igEdit(depthLabel, &ptr.*.YSorted.depth) or igEdit(yLabel, &ptr.*.YSorted.y)) {
                        changed = true;
                    }
                    if (ig.igButton("To Regular", .{})) {
                        ptr.* = sling.Depth.init(ptr.*.YSorted.depth);
                        return true;
                    }
                },
            }
            return changed;
        },
        else => {
            std.debug.warn("No editor found for label'{s}'\n", .{label});
            return false;
        },
    }
}
