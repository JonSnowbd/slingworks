const std = @import("std");
const ig = @import("imgui");
const sling = @import("sling");

const PlayerType = @import("playerEntity.zig").Player;

var initFn = std.once(init);
var scene: *sling.Scene = undefined;

fn init() void {
    scene = sling.Scene.initSpoof(.{PlayerType});
    if(scene.spawn(PlayerType)) |player| {
        player.controller = 0;
    }
}

pub fn roomMethod() void {
    initFn.call();
    if(sling.inEditor) {
        sling.inEditor = false;
        scene.update();
        sling.inEditor = true;
    } else {
        scene.update();
    }
}