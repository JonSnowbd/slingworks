const std = @import("std");
const sling = @import("../main.zig");

pub var ListedRooms = std.ArrayList(*const Register).init(sling.mem.Allocator);

pub const Register = struct {
    /// The name of the room, used for debug purposes, and as a display if register is
    /// placed in the room entry
    name: []const u8,
    updateMethod: ?fn () void = null,
    initMethod: ?fn () void = null,
    deinitMethod: ?fn () void = null,
};

/// Entering this room duplicates the current scene being edited, and then plays it
/// as if the world was not being edited.
pub const PlayEditorScene: Register = .{
    .name = "Play Scene",
    .updateMethod = playRoomUpdate,
    .initMethod = playRoomInit,
    .deinitMethod = playRoomDeinit,
};
var playScene: ?*sling.Scene = null;
var playExiting: bool = false;
fn playRoomInit() void {
    var previous = sling.state.isEditing;
    sling.state.isEditing = false;
    if (sling.state.scene) |internalScene| {
        var bytes = internalScene.toBytes(sling.mem.Allocator);
        defer sling.mem.Allocator.free(bytes);
        playScene = sling.Scene.initFromBytes(bytes);
    } else {
        sling.logErr("You need to be editing a scene to play.");
        playExiting = true;
    }
    sling.state.isEditing = previous;
}
fn playRoomDeinit() void {
    if (playScene != null) {
        sling.log("The following deinit was a play test:");
        playScene.?.deinit();
        playScene = null;
    }
}
fn playRoomUpdate() void {
    if (sling.input.Key.escape.pressed()) {
        playExiting = true;
    }
    if (playExiting or playScene == null) {
        sling.state.leaveRoom();
        playExiting = false;
        return;
    }

    sling.state.isEditing = false;
    if (playScene) |pscn| {
        pscn.update();
    }
    sling.state.isEditing = true;
}
