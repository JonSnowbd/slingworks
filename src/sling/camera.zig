const Self = @This();
const std = @import("std");
const sling = @import("../main.zig");
const ig = sling.package.imgui;

/// Do not manipulate this directly, instead used the setX methods provided.
position: sling.math.Vec2 = .{},
/// Do not manipulate this directly, instead used the setX methods provided.
rotation: f32 = 0,
/// Do not manipulate this directly, instead used the setX methods provided.
zoom: f32 = 1.0,
/// Do not manipulate this directly, instead used the setX methods provided.
origin: sling.math.Vec2 = .{ .x = 0.5, .y = 0.5 },

/// Do not manipulate this directly, instead used the setX methods provided.
viewMatrix: sling.math.Matrix = sling.math.Matrix.identity,
/// Do not manipulate this directly, instead used the setX methods provided.
inverseViewMatrix: sling.math.Matrix = sling.math.Matrix.identity,
/// Do not manipulate this directly, instead used the setX methods provided.
projectionMatrix: sling.math.Matrix = sling.math.Matrix.identity,

/// If you want this to be re-evaluated you can set this to true, and 
/// viewMatrix, inverseViewMatrix, and projectionMatrix will all
/// be recalculated.
dirty: bool = true,

/// Setting this overrides the projection matrix size, useful if you're rendering into something
/// that isnt the default buffer. Applies after the next recalc (set dirty manually to true).
sizeOverride: ?sling.math.Vec2 = null,
/// Do not manipulate this directly, is for internal state. Prefer to use `ig.igGetIO().*.DisplaySize`
currentSize: sling.math.Vec2 = .{},

pub fn init() Self {
    var value: Self = .{};
    value.position.x = -100;
    value.recalc();
    return value;
}

inline fn getSize(self: Self) sling.math.Vec2 {
    if (self.sizeOverride) |override| {
        return override;
    }
    return sling.math.Vec2.new(sling.package.sokol.app.widthf(), sling.package.sokol.app.heightf());
}

pub inline fn recalc(self: *Self) void {
    var targetSize = self.getSize();

    // Projection recalc
    if (self.currentSize.x != targetSize.x or self.currentSize.y != targetSize.y) {
        self.projectionMatrix = sling.math.Matrix.createOrthogonal(0, targetSize.x, targetSize.y, 0, -128, 128);
        self.currentSize = targetSize;
        self.dirty = true;
    }
    if (self.dirty) {
        self.viewMatrix = sling.math.Matrix.batchMul(&.{
            sling.math.Matrix.createTranslationXYZ(-self.position.x, -self.position.y, 0), // translate
            sling.math.Matrix.createZRotation(self.rotation), // Rotation
            sling.math.Matrix.createScale(self.zoom, self.zoom, 1.0), // Scale
            sling.math.Matrix.createTranslationXYZ(self.currentSize.x * self.origin.x, self.currentSize.y * self.origin.y, 0), // center
        });
        if (self.viewMatrix.invert()) |inverted| {
            self.inverseViewMatrix = inverted;
        } else {
            sling.logErrFmt("Camera failed to inverse view matrix:\n{any}", .{self.viewMatrix});
        }
        self.dirty = false;
    }
}

pub fn setPosition(self: *Self, target: sling.math.Vec2) void {
    if (target.x == self.position.x and target.y == self.position.y) {
        return;
    }

    self.dirty = true;
    self.position = target;
}
pub fn setOrigin(self: *Self, target: sling.math.Vec2) void {
    if (target.x == self.origin.x and target.y == self.origin.y) {
        return;
    }

    self.dirty = true;
    self.origin = target;
}
pub fn setZoom(self: *Self, target: f32) void {
    if (target == self.zoom) {
        return;
    }
    self.dirty = true;
    self.zoom = target;
}
pub fn setRotation(self: *Self, target: sling.math.Vec2) void {
    if (target.x == self.position.x and target.y == self.position.y) {
        return;
    }
    self.dirty = true;
    self.position = target;
}

/// Translates a world coordinate into the corresponding point in screenspace.
/// Useful to align user interface items over top of a world item.
pub fn worldToScreen(self: *Self, point: sling.math.Vec2) sling.math.Vec2 {
    return self.viewMatrix.transformVec2(point);
}

/// Translates a screen coordinate into the corresponding point in worldspace.
/// Useful for casting the mouse/interface position into world coords.
pub fn screenToWorld(self: *Self, point: sling.math.Vec2) sling.math.Vec2 {
    return self.inverseViewMatrix.transformVec2(point);
}