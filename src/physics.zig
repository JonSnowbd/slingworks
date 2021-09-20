const zt = @import("deps/ZT/src/zt.zig");
const std = @import("std");
const sling = @import("sling.zig");

pub usingnamespace zt.game.Physics;

pub const SweepResult = struct {
    hit: bool = false,
    /// The normal of the collision, if there was no collision then this is 0,0.
    normal: sling.math.Vec2 = .{},
    /// How far into the velocity the mover gets before it hits static.
    time: f32 = 1.0,
};

pub fn sweepRect(mover: sling.math.Rect, static: sling.math.Rect, velocity: sling.math.Vec2) f32 {
    return sweepRectEx(mover, static, velocity).time;
}

/// WARNING: For now, this is not accurate at EXTREMELY high velocities.
/// Given a rectangle that moves, a static rectangle, and the mover's velocity, returns
/// an f32 that represents how far into the velocity that a collision happens. Useful
/// for proper collision that is far more accurate than an intersection. If 1.0 is returned,
/// no collision occured.
///
/// Quite a bit more expensive than simple methods of collision detection, but accurate and
/// avoids popping through thin geometry if used properly.
pub fn sweepRectEx(mover: sling.math.Rect, static: sling.math.Rect, velocity: sling.math.Vec2) SweepResult {
    var result: SweepResult = .{};
    // Calculate sweep through distances:
    var xInvEntry: f32 = undefined;
    var yInvEntry: f32 = undefined;
    var xInvExit: f32 = undefined;
    var yInvExit: f32 = undefined;

    if (velocity.x > 0.0) {
        xInvEntry = static.position.x - (mover.position.x + mover.size.x);
        xInvExit = (static.position.x + static.size.x) - mover.position.x;
    } else {
        xInvEntry = (static.position.x + static.size.x) - mover.position.x;
        xInvExit = static.position.x - (mover.position.x + mover.size.x);
    }

    if (velocity.y > 0.0) {
        yInvEntry = static.position.y - (mover.position.y + mover.size.y);
        yInvExit = (static.position.y + static.size.y) - mover.position.y;
    } else {
        yInvEntry = (static.position.y + static.size.y) - mover.position.y;
        yInvExit = static.position.y - (mover.position.y + mover.size.y);
    }

    var xEntry: f32 = undefined;
    var yEntry: f32 = undefined;
    var xExit: f32 = undefined;
    var yExit: f32 = undefined;

    if (velocity.x == 0.0) {
        xEntry = -std.math.inf(f32);
        xExit = std.math.inf(f32);
    } else {
        xEntry = xInvEntry / velocity.x;
        xExit = xInvExit / velocity.x;
    }

    if (velocity.y == 0.0) {
        yEntry = -std.math.inf(f32);
        yExit = std.math.inf(f32);
    } else {
        yEntry = yInvEntry / velocity.y;
        yExit = yInvExit / velocity.y;
    }

    var entryTime: f32 = std.math.max(xEntry, yEntry);
    var exitTime = std.math.min(xExit, yExit);

    if (entryTime > exitTime or (xEntry < 0.0 and yEntry < 0.0) or xEntry > 1.0 or yEntry > 1.0) {
        result.hit = false;
        result.time = 1.0;
    } else {
        result.hit = true;
        result.time = entryTime;
        if (xEntry > yEntry) {
            if (xInvEntry < 0.0) {
                result.normal.x = 1.0;
                result.normal.y = 0.0;
            } else {
                result.normal.x = -1.0;
                result.normal.y = 0.0;
            }
        } else {
            if (yInvEntry < 0.0) {
                result.normal.x = 0.0;
                result.normal.y = 1.0;
            } else {
                result.normal.x = 0.0;
                result.normal.y = -1.0;
            }
        }
    }

    return result;
}