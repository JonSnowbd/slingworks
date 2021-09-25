const std = @import("std");
const ig = @import("imgui");
const glfw = @import("glfw");

// Private items
const PlayRoom = @import("playRoom.zig");
const editor = @import("editor.zig");
const Renderer = @import("renderer.zig");
const SlingSettings = struct {
    initialScene: ?[]const u8 = null,
    rememberWindowSettings: bool = true,
    wasMaximizedLast: bool = false,
    windowPos: math.Vec2 = .{ .x = 200, .y = 200 },
    windowSize: math.Vec2 = .{ .x = 1280, .y = 720 },
    hideConsoleInRooms: bool = false,
    debugView: bool = false,
};

const imFontRanges = [_]c_ushort{ 0xF004, 0xF4AD };

pub const Theme = struct {
    pub var primary = util.hexToColor(0xFDFFFCFF);
    pub var background = util.hexToColor(0x011627FF);
    pub var highlight = util.hexToColor(0x3C91E6FF);
    pub var secondary = util.hexToColor(0xDA627DFF);
    pub var debugInfo = util.hexToColor(0xA663CCFF);
    pub var debugSuccess = util.hexToColor(0x09E85EFF);
    pub var debugError = util.hexToColor(0xE84855FF);
    pub var debugWarning = util.hexToColor(0xF26419FF);
};

// Public namespaces and forwards
pub const zt = @import("zt");
pub const input = @import("input.zig");
pub const math = zt.math;
pub const serializer = @import("serializer.zig");
pub const asset = @import("asset.zig");
pub const util = @import("util.zig");
pub const register = @import("register.zig");
pub const fmod = @import("fmod.zig");
pub const audio = @import("audio.zig");
pub const physics = @import("physics.zig");
pub const handles = @import("handle.zig");
pub const debug = @import("debug.zig");
/// If you are editing the dictionary AND setting a user font for the editor,
/// set the font THEN edit the dictionary.
pub const dictionary = @import("dictionary.zig");
pub const icon = @import("icon.zig");

// Public types and forwards
pub const Camera = @import("camera.zig");
pub const Depth = Renderer.Depth;
pub const Object = @import("object.zig");
pub const Scene = @import("scene.zig");
/// A shader, this is used in slingworks to change how things are drawn.
pub const Shader = zt.gl.Shader;
/// The default vertex that slingworks uses to render everything.
pub const Vertex = zt.game.Renderer.Vertex;
/// A nine patch slice for rendering, store in it the sub rect of the patch,
/// and the amount in pixels from each side, and you can use this to draw
/// nine patch textures.
pub const Patch = Renderer.Patch;

pub const alloc = std.heap.c_allocator;

pub var timeScale: f32 = 1.0;
pub var time: f32 = 0.0;
pub var dt: f32 = 0.0;
pub var unscaledDt: f32 = 0.0;

pub var settings: SlingSettings = .{};
pub var inEditor: bool = false;

pub var render: Renderer = undefined;

/// You can set this directly, null is no scene. Make sure you clean up the current scene if one exists.
pub var scene: ?*Scene = null;
/// You shouldn't set this directly, as rooms have setup/teardown that is managed by sling. Prefer to use
/// enterRoomString("room") and leaveRoom()
pub var room: ?usize = null;

pub var preferredSerializationConfig: serializer.Configuration = serializer.Configuration.init(alloc);
/// You can set this yourself if desired, this changes the serialization format of everything sling uses.
pub var preferredLexicon: serializer.Lexicon = serializer.json.JsonLexicon;

var ctx: *zt.App(void).Context = undefined;

var staticInits = std.ArrayList(fn () void).init(alloc);

pub fn run() void {
    parseArgs();
    deserializeSling();
    initialize();
    loop();
    serializeSling();
    ctx.deinit();
}

fn parseArgs() void {
    // Parse args for editor flag.
    const args = std.process.argsAlloc(alloc) catch unreachable;
    for (args) |argument| {
        if (std.mem.eql(u8, std.mem.spanZ(argument), "editor")) {
            inEditor = true;
        }
    }
    std.process.argsFree(alloc, args);

    // Set the cwd path to the exe folder. If something needs to work based on calling from another directory,
    // I recommend using another way to reach those resources.
    if (zt.known_folders.getPath(alloc, .executable_dir) catch unreachable) |exePath| {
        defer alloc.free(exePath);
        std.process.changeCurDir(exePath) catch {
            std.debug.print("Failed to chdir to local executable folder.\n", .{});
        };
    }
}
fn initialize() void {
    // Audio first so we dont get graphical bugs mid startup.
    audio.init();

    // If we're maximizing, it needs to be through glfw pre-init.
    if (settings.rememberWindowSettings and settings.wasMaximizedLast) {
        zt.App(void).preInit();
        glfw.glfwWindowHint(glfw.GLFW_MAXIMIZED, glfw.GLFW_TRUE);
    }
    // Start the loop from ZT.
    ctx = zt.App(void).begin(std.heap.c_allocator);
    ctx.settings.energySaving = false;

    if (settings.rememberWindowSettings and !settings.wasMaximizedLast) {
        ctx.setWindowSize(@floatToInt(c_int, settings.windowSize.x), @floatToInt(c_int, settings.windowSize.y));
        glfw.glfwSetWindowPos(ctx.window, @floatToInt(c_int, settings.windowPos.x), @floatToInt(c_int, settings.windowPos.y));
    }

    var io = ig.igGetIO();
    io.*.ConfigFlags |= ig.ImGuiConfigFlags_DockingEnable;
    render = Renderer.init();
    for (staticInits.items) |ifn| {
        ifn();
    }

    register.room(PlayRoom.roomMethod, dictionary.roomMenuPlay, PlayRoom.init, PlayRoom.deinit);

    if (!inEditor and settings.initialScene != null) {
        var bytes = std.fs.cwd().readFileAlloc(alloc, settings.initialScene.?, 80_000_000) catch unreachable;
        defer alloc.free(bytes);
        scene = Scene.initFromBytes(bytes);
    }
}
fn loop() void {
    while (ctx.open) {
        dt = ctx.time.dt * timeScale;
        unscaledDt = ctx.time.dt;
        time += ctx.time.dt;

        ctx.beginFrame();
        input.pump();

        if (inEditor) {
            _ = zt.custom_components.ztViewPort();
            editor.editorUI();
        }

        if (room) |roomIdx| {
            register.RegisteredRooms.items[roomIdx].method();
        } else if (scene) |currentScene| {
            currentScene.update();
        }

        render.flush();
        ctx.endFrame();
        audio.update();
    }
}
fn serializeSling() void {
    // Serialize settings.
    if (settings.rememberWindowSettings) {
        var w: c_int = 0;
        var h: c_int = 0;
        var x: c_int = 0;
        var y: c_int = 0;
        glfw.glfwGetWindowSize(ctx.window, &w, &h);
        glfw.glfwGetWindowPos(ctx.window, &x, &y);

        if (glfw.glfwGetWindowAttrib(ctx.window, glfw.GLFW_MAXIMIZED) == 1) {
            settings.wasMaximizedLast = true;
        } else {
            settings.wasMaximizedLast = false;
            settings.windowPos = .{ .x = @intToFloat(f32, x), .y = @intToFloat(f32, y) };
            settings.windowSize = .{ .x = @intToFloat(f32, w), .y = @intToFloat(f32, h) };
        }
    }

    var tree = serializer.Tree.initArena(alloc);
    tree.root = tree.toNode(settings);
    defer tree.deinit();
    var settingsBytes = preferredLexicon.convert(alloc, tree);
    defer alloc.free(settingsBytes);

    std.fs.cwd().writeFile("settings.json", settingsBytes) catch {
        std.debug.panic("Failed to write sling settings to disk.", .{});
    };
}
fn deserializeSling() void {
    // 5mb max
    var settingsFile = std.fs.cwd().readFileAlloc(alloc, "settings.json", 5_000_000) catch {
        std.debug.print("Failed to find sling settings file.\n", .{});
        return;
    };
    defer alloc.free(settingsFile);

    var tree = preferredLexicon.parse(alloc, settingsFile);
    defer tree.deinit();
    tree.root.into(&settings, alloc);
}

/// Use this to get the build data for a type. Calling this implicitly
/// registers a type as an entity.
pub fn configure(comptime T: type) *Object.GenBuildData(T) {
    const base = Object.GenBuildData(T);
    return base.register();
}
/// Use this to automatically register a type into sling if it contains a
/// `slingIntegration` function of type `fn() void`
pub fn integrate(comptime T: type) void {
    if (@hasDecl(T, "slingIntegration")) {
        switch (@typeInfo(@TypeOf(@field(T, "slingIntegration")))) {
            .Fn => |fnInfo| {
                if (fnInfo.args.len == 0 and (fnInfo.return_type == null or fnInfo.return_type.? == void)) {
                    T.slingIntegration();
                } else {
                    @compileError("'slingIntegration' on type " ++ @typeName(T) ++ " failed, it should be a function with no args and no return type.");
                }
            },
            else => {
                @compileError("'slingIntegration' on type " ++ @typeName(T) ++ " failed, it should be a function with no args and no return type.");
            },
        }
    } else {
        @compileError("There is no slingIntegration on type " ++ @typeName(T));
    }
}
pub fn addStaticInit(func: fn () void) void {
    staticInits.append(func) catch {
        std.debug.panic("Failed to append static initializer", .{});
    };
}
pub fn setWindowTitle(title: []const u8) void {
    ctx.setWindowTitle(title);
}
pub fn setWindowIcon(path: []const u8) void {
    ctx.setWindowIcon(path);
}
pub fn setBackgroundColor(color: math.Vec4) void {
    const gl = @import("gl");
    gl.glClearColor(color.x, color.y, color.z, color.w);
}

/// Simply @embedFile your ttf and pass into first param.
/// This should be done once at init. If you are editing the dictionary,
/// do so after this, as this will overwrite iconify the default labels.
pub fn setEditorFontBytes(bytes: []const u8, size: f32) void {
    var io = ig.igGetIO();
    var cfg = ig.ImFontConfig_ImFontConfig();
    cfg.*.OversampleH = 3;
    cfg.*.OversampleV = 2;

    // User font
    var defaultRange = ig.ImFontAtlas_GetGlyphRangesDefault(io.*.Fonts);
    var copied: []u8 = alloc.dupeZ(u8, bytes) catch unreachable;
    defer alloc.free(copied);
    var userFnt = ig.ImFontAtlas_AddFontFromMemoryTTF(io.*.Fonts, copied.ptr, @intCast(c_int, copied.len), size, cfg, defaultRange);

    // Icon font
    var iconCopied: []u8 = alloc.dupeZ(u8, @embedFile("deps/fontawesome.otf")) catch unreachable;
    defer alloc.free(iconCopied);
    cfg.*.MergeMode = true;
    _ = ig.ImFontAtlas_AddFontFromMemoryTTF(io.*.Fonts, iconCopied.ptr, @intCast(c_int, iconCopied.len), size - 2, cfg, &imFontRanges);

    // Finish
    _ = ig.ImFontAtlas_Build(io.*.Fonts);
    io.*.FontDefault = userFnt;
    ctx.rebuildFont();

    dictionary.iconify();
}

pub fn enterRoom(index: usize) void {
    if (room != null) {
        leaveRoom();
    }
    var target = register.RegisteredRooms.items[index];
    if (target.initMethod) |ifn| {
        ifn();
    }
    room = index;
}
pub fn enterRoomString(id: []const u8) void {
    for (register.RegisteredRooms.items) |r, i| {
        if (std.mem.eql(u8, id, r.name)) {
            enterRoom(i);
            return;
        }
    }
}
pub fn leaveRoom() void {
    if (register.RegisteredRooms.items[room.?].deinitMethod) |dfn| {
        dfn();
    }
    room = null;
}

const console = @import("editor/console.zig");
pub fn log(message: []const u8) void {
    console.submit(message, null, icon.bell);
}
pub fn logFmt(comptime fmt: []const u8, params: anytype) void {
    console.submitFmt(fmt, params, null, icon.bell);
}
pub fn logErr(message: []const u8) void {
    console.submit(message, debug.DebugType.err, icon.circledCross);
}
pub fn logErrFmt(comptime fmt: []const u8, params: anytype) void {
    console.submitFmt(fmt, params, debug.DebugType.err, icon.circledCross);
}
pub fn logWarn(message: []const u8) void {
    console.submit(message, debug.DebugType.warning, icon.circledQuestionmark);
}
pub fn logWarnFmt(comptime fmt: []const u8, params: anytype) void {
    console.submitFmt(fmt, params, debug.DebugType.warning, icon.circledQuestionmark);
}