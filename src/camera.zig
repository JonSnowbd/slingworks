const Self = @This();
const std = @import("std");
const zt = @import("zt");
const ig = @import("imgui");
const sling = @import("sling.zig");

position: sling.math.Vec2 = .{},
rotation: f32 = 0,
zoom: f32 = 1.0,
origin: sling.math.Vec2 = .{ .x = 0.5, .y = 0.5 },

viewMatrix: sling.math.Mat4 = sling.math.Mat4.identity,
inverseViewMatrix: sling.math.Mat4 = sling.math.Mat4.identity,
projectionMatrix: sling.math.Mat4 = sling.math.Mat4.identity,

dirty: bool = true,

sizeOverride: ?sling.math.Vec2 = null,
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
    var io = ig.igGetIO();
    return io.*.DisplaySize;
}

pub inline fn recalc(self: *Self) void {
    var targetSize = self.getSize();

    // Projection recalc
    if (self.currentSize.x != targetSize.x or self.currentSize.y != targetSize.y) {
        self.projectionMatrix = sling.math.Mat4.createOrthogonal(0, targetSize.x, targetSize.y, 0, -128, 128);
        self.currentSize = targetSize;
        self.dirty = true;
    }
    if (self.dirty) {
        self.viewMatrix = sling.math.Mat4.batchMul(&.{
            sling.math.Mat4.createTranslationXYZ(-self.position.x, -self.position.y, 0), // translate
            sling.math.Mat4.createZRotation(self.rotation), // Rotation
            sling.math.Mat4.createScale(self.zoom, self.zoom, 1.0), // Scale
            sling.math.Mat4.createTranslationXYZ(self.currentSize.x * self.origin.x, self.currentSize.y * self.origin.y, 0), // center
        });
        if (self.viewMatrix.invert()) |inverted| {
            self.inverseViewMatrix = inverted;
        } else {
            std.log.err("Camera failed to inverse view matrix:\n{any}", .{self.viewMatrix});
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

pub fn worldToScreen(self: *Self, point: zt.math.Vec2) zt.math.Vec2 {
    return point.transform4(self.viewMatrix);
}

pub fn screenToWorld(self: *Self, point: zt.math.Vec2) zt.math.Vec2 {
    return point.transform4(self.inverseViewMatrix);
}
