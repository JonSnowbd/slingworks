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
        switch (self) {
            .success => {
                return sling.Theme.debugSuccess;
            },
            .err => {
                return sling.Theme.debugError;
            },
            .warning => {
                return sling.Theme.debugWarning;
            },
            .primary => {
                return sling.Theme.primary;
            },
            .background => {
                return sling.Theme.highlight;
            },
            // else => {
            //     return sling.Theme.secondary;
            // }
        }
    }
};

//todo: more debug convenience methods

/// Renders an in world dot unaffected by zoom.
pub fn dot(center: sling.math.Vec2, radius: f32, debugMethod: DebugType) void {
    sling.render.circle(.world, sling.render.debugDepth, center, radius / sling.render.camera.zoom, debugMethod.toColor());
}

pub fn rect(rectangle: sling.math.Rect, debugMethod: DebugType) void {
    sling.render.rectangle(.world, sling.render.debugDepth, rectangle, debugMethod.toColor(), null);
}