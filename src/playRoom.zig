const std = @import("std");
const ig = @import("imgui");
const sling = @import("sling.zig");

var foundScene: bool = false;
var scene: *sling.Scene = undefined;
var exiting: bool = false;

pub fn init() void {
    sling.inEditor = false;
    if (sling.scene) |internalScene| {
        foundScene = true;
        var bytes = internalScene.toBytes(sling.alloc);
        defer sling.alloc.free(bytes);
        scene = sling.Scene.initFromBytes(bytes);
    } else {
        foundScene = false;
        exiting = true;
    }
    sling.inEditor = true;
}
pub fn deinit() void {
    if (foundScene) {
        scene.deinit();
    }
}

pub fn roomMethod() void {
    if (sling.input.Key.escape.down()) {
        exiting = true;
    }
    if (exiting) {
        sling.leaveRoom();
        exiting = false;
        return;
    }

    sling.inEditor = false;
    scene.update();
    sling.inEditor = true;
}
