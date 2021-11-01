const std = @import("std");
const sling = @import("../main.zig");
const sg = sling.package.sokol.gfx;
const assert = std.debug.assert;

// stb_image bindings:
pub extern fn stbi_load(filename: [*c]const u8, x: [*c]c_int, y: [*c]c_int, channels_in_file: [*c]c_int, desired_channels: c_int) [*c]u8;
pub extern fn stbi_set_flip_vertically_on_load(flag_true_if_should_flip: c_int) void;
pub extern fn stbi_image_free(retval_from_stbi_load: ?*c_void) void;

fn AssetWrapper(comptime T: type) type {
    return struct {
        pub var lookup = std.StringHashMap(usize).init(sling.mem.Allocator);
        pub var data = std.ArrayList(T).init(sling.mem.Allocator);
    };
}

// pub const Font = @import("font.zig");

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
        resource.key_ptr.* = sling.mem.Allocator.dupeZ(u8, path) catch unreachable;
        resource.value_ptr.* = wrapper.data.items.len;
        wrapper.data.append(load(T, path)) catch |err| {
            std.debug.panic("Unknown error when appending to asset list:\n{s}", .{@errorName(err)});
        };
        sling.logFmt("Asset type \"{s}\" loaded from \"{s}\"", .{ @typeName(T), path });
    }

    return resource.value_ptr.*;
}

/// Use this to manually input an object into a resource pile. This returns the index
/// of the new resource, for use in resource services that uses indices.
pub fn manualUpload(comptime T: type, object: T) usize {
    const wrapper = AssetWrapper(T);
    var id = wrapper.data.items.len;
    wrapper.data.append(object) catch |err| {
        std.debug.panic("Unknown error when fetching from asset lookup hashmap:\n{s}", .{@errorName(err)});
    };
    sling.logFmt("Asset type \"{s}\" manually uploaded\n", .{@typeName(T)});
    return id;
}

fn load(comptime T: type, path: []const u8) T {
    switch (T) {
        sling.Texture => {
            var w: c_int = 0;
            var h: c_int = 0;
            var c: c_int = 0;
            var raw = stbi_load(@ptrCast([*c]const u8, path), &w, &h, &c, 4);
            defer stbi_image_free(raw);
            var desc = sg.ImageDesc{
                .width = w,
                .height = h,
                .pixel_format = sg.PixelFormat.RGBA8,
                .min_filter = sg.Filter.LINEAR,
                .mag_filter = sg.Filter.LINEAR,
            };
            desc.data.subimage[0][0] = .{ .ptr = raw, .size = @intCast(usize, @sizeOf(u8) * (w * h * c)) };
            var newImage = sg.makeImage(desc);
            sling.logFmt("Uploaded image #{any} to the gpu. ({any}x{any})", .{ newImage.id, desc.width, desc.height });
            return newImage;
        },
        // Font => {
        //     return Font.loadBmFontAsciiPath(path);
        // },
        else => {
            @compileError("Unsupported type in Asset request.");
        },
    }
}
