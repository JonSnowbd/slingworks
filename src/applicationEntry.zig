const sling = @import("main.zig");
const std = @import("std");
const Sokol = sling.package.sokol;
const sg    = Sokol.gfx;
const sapp  = Sokol.app;
const sgapp = Sokol.app_gfx_glue;
const stm = Sokol.time;
const reroute = sling.package.reroute;
const known_folders = @import("deps/known_folders.zig");

const imguiImpl = @import("reroute/imguiPrivate.zig");

var update: fn() callconv(.C) void = undefined;
var userInit: ?fn() callconv(.C) void = null;
pub var dt: f32 = 0;

pub fn begin(initMethod: ?fn() callconv(.C) void, updateMethod: fn() callconv(.C) void) void {
    // Always from the executable:
    var cwd = known_folders.getPath(sling.mem.Allocator, known_folders.KnownFolder.executable_dir) catch unreachable;
    std.os.chdir(cwd.?) catch unreachable;

    // And now boot everything up:
    userInit = initMethod;
    update = updateMethod;
    sapp.run(.{
        .init_cb = qs_init,
        .frame_cb = qs_frame,
        .event_cb = qs_event,
        .cleanup_cb = qs_cleanup,
        .fail_cb = qs_err,
        .width = 1280,
        .height = 720,
        .window_title = "Sling"
    });
}

var last: u64 = 0;
export fn qs_init() void {
    stm.setup();
    sg.setup(.{
        .context = sgapp.context()
    });
    imguiImpl.init();

    // After init, you're free to initialize your fonts.
    // Hint: Use multiple adds with ranges specified to cover your bases
    // for multiple language character sets, or icon fonts!
    var fnt = reroute.imgui.config.startFontCreation();
    _ = fnt.addDefaultFont();
    fnt.build();

    last = stm.now();

    if(userInit) |ini| {
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
}

export fn qs_cleanup() void {
    sg.shutdown();
}

export fn qs_event(evt: [*c]const sapp.Event) void {
    _ = imguiImpl.feed(evt);
}

export fn qs_err(msg:[*c]const u8) void {
    std.debug.panic("ERR: {s}\n",.{msg});
}