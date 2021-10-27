const std = @import("std");
const sling = @import("../main.zig");

pub const RoomRegister = struct {
    method: fn () void,
    initMethod: ?fn () void = null,
    deinitMethod: ?fn () void = null,
    name: []const u8,
};

pub var RegisteredRooms = std.ArrayList(RoomRegister).init(sling.alloc);

/// children is a tuple struct of each child type that will be in this scene.
/// for example if FpsGame has Pawn, Player, and WeaponPickup, you'd do
/// `sling.register.Scene(FpsGame, .{Pawn,Player,WeaponPickup});`
pub fn scene(comptime T: type, comptime children: anytype) void {
    const childrenType = @typeInfo(@TypeOf(children));
    std.debug.assert(childrenType == .Struct and childrenType.Struct.is_tuple);
    std.debug.assert(@TypeOf(children[0]) == type);

    var entry = sling.Scene.RegisteredScenes.getOrPut(@typeName(T)) catch unreachable;
    if (!entry.found_existing) {
        entry.key_ptr.* = @typeName(T);
        entry.value_ptr.* = undefined;
        entry.value_ptr.*.base = sling.Object.Information.indexOf(T);
        entry.value_ptr.*.dependants = std.ArrayList(usize).init(sling.alloc);
    }

    inline for (children) |childType| {
        entry.value_ptr.*.dependants.append(sling.Object.Information.indexOf(childType)) catch unreachable;
    }
}

pub fn room(roomMethod: fn () void, name: []const u8, initFn: ?fn () void, deinitFn: ?fn () void) void {
    RegisteredRooms.append(.{ .method = roomMethod, .name = name, .initMethod = initFn, .deinitMethod = deinitFn }) catch unreachable;
}
