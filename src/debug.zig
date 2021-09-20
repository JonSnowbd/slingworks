const std = @import("std");
const zt = @import("zt");
const ig = @import("imgui");

const sling = @import("sling.zig");

pub const DebugType = enum {
    success,
    err,
    warning,
    primary,
    background,

    pub fn toColor(self: DebugType) sling.math.Vec4 {
        switch(self) {
            .success => {return sling.Theme.primary;}
        }
    }
};

/// Renders an in world dot unaffected by zoom.
pub fn dot(center: sling.math.Vec2, radius: f32, debugMethod: DebugType) void {
    sling.render.circle(.world, sling.render.debugDepth, center, radius/sling.render.camera.zoom, sling.Theme.debugInfo);
}
