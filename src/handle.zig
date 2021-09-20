const std = @import("std");
const sling = @import("sling.zig");

/// Configure handle skinning and functionality through here!
pub const config = struct {
    /// If you want to change which key is used to drag handles, this is
    /// your way in.
    pub var lockKey: sling.input.Key = .lmb;
    pub var normalColor: sling.math.Vec4 = sling.math.vec4(0.7, 0.9, 0.4, 0.8);
    pub var hoveredColor: sling.math.Vec4 = sling.math.vec4(0.8, 0.6, 0.3, 0.95);
    pub var heldColor: sling.math.Vec4 = sling.math.vec4(0.9, 0.9, 0.7, 1.0);
    pub var mutedColor: sling.math.Vec4 = sling.math.vec4(0.3, 0.5, 0.1, 0.1);
    pub var blipSize: f32 = 5;
    pub var handleLength: f32 = 15;
    pub var padding: f32 = 4;
};

var locked: ?usize = null;
var mode: ?usize = null;

/// Pass in a reference to a vector to get in-world handles to manipulate a point in space.
/// You can pass in offset to have the handles placed away from the point that you're editing,
/// and a bool to flip the handles in the other direction
pub fn positionHandle(vector: *sling.math.Vec2, flipHandles: bool, offset: ?sling.math.Vec2) void {
    // Modes:
    const centerClick: usize = 0;
    const xClick: usize = 1;
    const yClick: usize = 2;
    const callSite = @ptrToInt(vector);

    const mouse = sling.input.worldMouse;
    const delta = sling.input.worldMouseDelta;

    const length = config.handleLength / sling.render.camera.zoom;
    const size = config.blipSize / sling.render.camera.zoom;
    const padding = config.padding / sling.render.camera.zoom;
    const target: sling.math.Vec2 = if (offset != null) vector.add(offset.?) else vector.*;

    var col = config.normalColor;
    var xAxisHandle = sling.math.rect(
        target.x - length - size - padding,
        target.y - size * 0.5,
        length,
        size,
    );
    var yAxisHandle = sling.math.rect(
        target.x - size * 0.5,
        target.y - length - size - padding,
        size,
        length,
    );
    if (flipHandles) {
        xAxisHandle.position.x += (length + size + padding) + (padding * 2);
        yAxisHandle.position.y += (length + size + padding) + (padding * 2);
    }
    if (locked) |lockId| {
        if (lockId == callSite) {
            col = config.heldColor;
            if (mode) |modeId| {
                switch (modeId) {
                    centerClick => {
                        vector.*.x += delta.x;
                        vector.*.y += delta.y;
                    },
                    xClick => {
                        vector.*.x += delta.x;
                    },
                    yClick => {
                        vector.*.y += delta.y;
                    },
                    else => {},
                }
            }
            if (config.lockKey.released()) {
                locked = null;
                mode = null;
            }
        } else {
            col = config.mutedColor;
        }
    } else {
        const clicked = config.lockKey.pressed();
        if (mouse.distanceTo(target) < size) {
            col = config.hoveredColor;
            if (clicked) {
                mode = centerClick;
                locked = callSite;
            }
        }
        if (xAxisHandle.containsPoint(mouse)) {
            col = config.hoveredColor;
            if (clicked) {
                mode = xClick;
                locked = callSite;
            }
        }
        if (yAxisHandle.containsPoint(mouse)) {
            col = config.hoveredColor;
            if (clicked) {
                mode = yClick;
                locked = callSite;
            }
        }
    }

    sling.render.circle(.world, sling.render.debugDepth, target, size, col);
    sling.render.rectangle(.world, sling.render.debugDepth, xAxisHandle, col, -1);
    sling.render.rectangle(.world, sling.render.debugDepth, yAxisHandle, col, -1);
}

/// Pass in a reference to a rectangle to get in-world handles to manipulate a rectangle.
pub fn rectangleHandle(rect: *sling.math.Rect) void {
    positionHandle(&rect.*.position, false, null);
    positionHandle(&rect.*.size, true, rect.*.position);
}
