const sling = @import("main.zig");
const std = @import("std");
const Sokol = sling.package.sokol;
const sg = Sokol.gfx;
const sapp = Sokol.app;
const sgapp = Sokol.app_gfx_glue;
const stm = Sokol.time;
const reroute = sling.package.reroute;
const known_folders = @import("deps/known_folders.zig");

const imguiImpl = @import("reroute/imguiPrivate.zig");

var update: *const fn () callconv(.C) void = undefined;
var userInit: ?*const fn () callconv(.C) void = null;
pub var dt: f32 = 0;

pub fn begin(initMethod: ?*const fn () callconv(.C) void, updateMethod: *const fn () callconv(.C) void) void {
    // Always from the executable:
    var cwd = known_folders.getPath(sling.mem.Allocator, known_folders.KnownFolder.executable_dir) catch unreachable;
    std.os.chdir(cwd.?) catch unreachable;

    // And now boot everything up:
    userInit = initMethod;
    update = updateMethod;
    sapp.run(.{ .init_cb = qs_init, .frame_cb = qs_frame, .event_cb = qs_event, .cleanup_cb = qs_cleanup, .fail_cb = qs_err, .width = 1280, .height = 720, .window_title = "Sling" });
}

var last: u64 = 0;
export fn qs_init() void {
    stm.setup();
    sg.setup(.{ .context = sgapp.context() });
    sling.imgui.components.internalBuf = std.heap.FixedBufferAllocator.init(sling.mem.Allocator.alloc(u8, 1024 * 1024 * 6) catch unreachable);
    imguiImpl.init();
    last = stm.now();
    if (userInit) |ini| {
        ini();
    }
}

export fn qs_frame() void {
    dt = @floatCast(f32, stm.stm_sec(stm.roundToCommonRefreshRate(stm.laptime(&last))));
    sg.beginDefaultPass(.{}, sapp.width(), sapp.height());
    imguiImpl.begin(dt);
    update();
    imguiImpl.render();
    sg.endPass();
    sg.commit();

    sling.imgui.components.internalBuf.reset();
}

export fn qs_cleanup() void {
    sg.shutdown();
}

export fn qs_event(evt: [*c]const sapp.Event) void {
    _ = imguiImpl.feed(evt);
}

export fn qs_err(msg: [*c]const u8) void {
    std.debug.panic("ERR: {s}\n", .{msg});
}
