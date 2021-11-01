const std = @import("std");
const sling = @import("../main.zig");

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
var playFoundScene: bool = false;
var playScene: *sling.Scene = undefined;
var playExiting: bool = false;
fn playRoomInit() void {
    sling.state.isEditing = false;
    if (sling.state.scene) |internalScene| {
        playFoundScene = true;
        var bytes = internalScene.toBytes(sling.alloc);
        defer sling.alloc.free(bytes);
        playScene = sling.Scene.initFromBytes(bytes);
    } else {
        sling.logErr("You need to be editing a scene to play.");
        playFoundScene = false;
        playExiting = true;
    }
    sling.state.isEditing = true;
}
fn playRoomDeinit() void {
    if (playFoundScene) {
        sling.log("The following deinit was a play test:");
        playScene.deinit();
    }
}
fn playRoomUpdate() void {
    if (sling.input.Key.escape.down()) {
        playExiting = true;
    }
    if (playExiting) {
        sling.leaveRoom();
        playExiting = false;
        return;
    }

    sling.state.isEditing = false;
    playScene.update();
    sling.state.isEditing = true;
}