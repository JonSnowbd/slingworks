const zt = @import("zt");
const std = @import("std");
const sling = @import("sling.zig");

const assert = std.debug.assert;

fn AssetWrapper(comptime T: type) type {
    return struct {
        pub var lookup = std.StringHashMap(usize).init(sling.alloc);
        pub var data = std.ArrayList(T).init(sling.alloc);
    };
}

pub const Texture = struct {
    pub var preferNearestFilter: bool = true;
    internal: zt.gl.Texture,
    whitePixel: ?zt.math.Rect = null,
};

/// Don't use this to store a reference to a resource, as the pointer given will be invalidated on data resize.
/// Prefer to use `ensure` to get a pointer to use here instead.
pub fn get(comptime T: type, id: usize) *T {
    const wrapper = AssetWrapper(T);
    return &wrapper.data.items[id];
}

/// Use this to get a stack copy from the asset list, recommended to use normal get if the asset type is not
/// very small. 
pub fn getCopy(comptime T: type, id: usize) T {
    const wrapper = AssetWrapper(T);
    return wrapper.data.items[id];
}

/// A direct version of get, uses ensure to get the id, then returns the type.
pub fn fetch(comptime T: type, path: []const u8) *T {
    var id = ensure(T, path);
    return get(T, id);
}
/// A direct version of getCopy, uses ensure to get the id, then returns the type.
pub fn fetchCopy(comptime T: type, path: []const u8) T {
    var id = ensure(T, path);
    return getCopy(T, id);
}

/// This returns an index that points to the asset that was loaded
/// (or was already loaded). Use this to store runtime information,
/// and do not serialize/deserialize this index as it can change
/// from run to run.
pub fn ensure(comptime T: type, path: []const u8) usize {
    const wrapper = AssetWrapper(T);

    var resource = wrapper.lookup.getOrPut(path) catch |err| {
        std.debug.panic("Unknown error when fetching from asset lookup hashmap:\n{s}", .{@errorName(err)});
    };
    if (!resource.found_existing) {
        resource.key_ptr.* = sling.alloc.dupeZ(u8, path) catch unreachable;
        resource.value_ptr.* = wrapper.data.items.len;
        wrapper.data.append(load(T, path)) catch |err| {
            std.debug.panic("Unknown error when appending to asset list:\n{s}", .{@errorName(err)});
        };
        std.debug.print("SLING: Asset type \"{s}\" loaded from \"{s}\"\n", .{ @typeName(T), path });
    }

    return resource.value_ptr.*;
}

fn load(comptime T: type, path: []const u8) T {
    switch (T) {
        Texture => {
            var tex = Texture{
                .internal = zt.gl.Texture.init(path) catch |err| {
                    std.debug.panic("Failed to load image into asset: {s}:\n{s}", .{ path, @errorName(err) });
                },
                .whitePixel = null,
            };
            if (Texture.preferNearestFilter) {
                tex.internal.setNearestFilter();
            }
            return tex;
        },
        else => {
            @compileError("Unsupported type in Asset request.");
        },
    }
}

pub fn save(comptime T: type, item: T, path: []const u8) !void {
    std.debug.assert(T != Texture);
    _ = item;
    _ = path;
}
