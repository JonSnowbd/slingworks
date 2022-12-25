const std = @import("std");
const sling = @import("../main.zig");
const ig = sling.package.imgui;

/// Produces an enum of declarations found in a type. Useful for parameters
/// aimed at a declaration in a type.
pub fn DeclEnum(comptime T: type) type {
    const declInfos = std.meta.declarations(T);
    var declFields: [declInfos.len]std.builtin.Type.EnumField = undefined;
    var decls = [_]std.builtin.Type.Declaration{};
    inline for (declInfos) |field, i| {
        declFields[i] = .{
            .name = field.name,
            .value = i,
        };
    }
    return @Type(.{
        .Enum = .{
            .tag_type = std.math.IntFittingRange(0, declInfos.len - 1),
            .fields = &declFields,
            .decls = &decls,
            .is_exhaustive = true,
        },
    });
}

pub fn hexToColor(hex: u32) sling.math.Vec4 {
    const cast: [4]u8 = @bitCast([4]u8, hex);
    return sling.math.Vec4.new(@intToFloat(f32, cast[0]) / 255.0, @intToFloat(f32, cast[1]) / 255.0, @intToFloat(f32, cast[2]) / 255.0, @intToFloat(f32, cast[3]) / 255.0);
}
pub fn hexToColorString(hexCode: []const u8) sling.math.Vec4 {
    var slice: []const u8 = std.mem.trim(u8, hexCode, "#");
    var hex = std.fmt.parseUnsigned(u32, slice, 16) catch unreachable;
    return hexToColor(hex);
}

/// An allocated format print you dont need to free. Note this does not last long so use
/// this for just text that will only be needed that frame.
pub fn tempFmt(comptime fmt: []const u8, params: anytype) []const u8 {
    return std.fmt.allocPrint(sling.mem.RingBuffer, fmt, params) catch unreachable;
}

/// A data structure that lets you store a usize lookup id to retrieve a value
/// without changing every other id reference when one is released by storing
/// 'holes' to reuse in the structure.
pub fn HoleQueue(comptime T: type) type {
    return struct {
        const Self = @This();

        allocator: *std.mem.Allocator,
        internalList: std.ArrayList(T),
        holeQueue: std.fifo.LinearFifo(usize, .Dynamic),

        pub fn init(allocator: *std.mem.Allocator) Self {
            return .{
                .allocator = allocator,
                .internalList = std.ArrayList(T).init(allocator),
                .holeQueue = std.fifo.LinearFifo(usize, .Dynamic).init(allocator),
            };
        }

        pub fn deinit(self: *Self) void {
            self.internalList.deinit();
            self.holeQueue.deinit();
        }

        /// Copies a stack value into local memory and returns its index(which is guaranteed
        /// to never change.)
        pub fn take(self: *Self, stackVal: T) !usize {
            if (self.holeQueue.readItem()) |id| {
                self.internalList.items[id] = stackVal;
                return id;
            } else {
                var id = self.internalList.items.len;
                try self.internalList.append(stackVal);
                return id;
            }
        }

        pub fn release(self: *Self, id: usize) !void {
            try self.holeQueue.writeItem(id);
            self.internalList.items[id] = undefined;
        }

        pub fn get(self: *Self, id: usize) *T {
            return &self.internalList.items[id];
        }
        pub fn getCopy(self: *Self, id: usize) T {
            return self.internalList.items[id];
        }
    };
}

/// Takes a value, and a min/max range, and returns a ratio depending on where value
/// lies between the 2. if clamp, it is 0-1
pub fn remapValueToRange(value: f32, range_min: f32, range_max: f32, clamp: bool) f32 {
    if (clamp) {
        return std.math.clamp((value - range_min) / (range_max - range_min), 0.0, 1.0);
    } else {
        return (value - range_min) / (range_max - range_min);
    }
}
