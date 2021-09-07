const std = @import("std");
const ig = @import("imgui");
const glfw = @import("glfw");

pub const zt = @import("zt");
pub const input = @import("input.zig");
pub const math = zt.math;
pub const serializer = @import("serializer.zig");
pub const asset = @import("asset.zig");
pub const util = @import("util.zig");
pub const register = @import("register.zig");
pub const fmod = @import("fmod.zig");
pub const audio = @import("audio.zig");
const editor = @import("editor.zig");

const Renderer = @import("renderer.zig");
pub const Camera = @import("camera.zig");
pub const Depth = Renderer.Depth;
pub const Object = @import("object.zig");
pub const Scene = @import("scene.zig");
pub const Shader = zt.gl.Shader;
pub const Vertex = zt.game.Renderer.Vertex;

pub const alloc = std.heap.c_allocator;

const SlingSettings = struct {
    initialScene: ?[]const u8 = null,
    rememberWindowSettings: bool = true,
    wasMaximizedLast: bool = false,
    windowPos: math.Vec2 = .{ .x=200, .y=200 },
    windowSize: math.Vec2 = .{ .x = 1280, .y = 720 },
    debugView: bool = false,
};

pub var time: f32 = 0.0;
pub var dt: f32 = 0.0;

pub var settings: SlingSettings = .{};
pub var inEditor: bool = false;

pub var render: Renderer = undefined;
pub var scene: ?*Scene = null;
pub var room: ?usize = null;

pub var preferredSerializationConfig: serializer.Configuration = serializer.Configuration.init(alloc);
pub var preferredLexicon: serializer.Lexicon = serializer.json.JsonLexicon;

var ctx: *zt.App(void).Context = undefined;

var staticInits = std.ArrayList(fn() void).init(alloc);

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
    if(zt.known_folders.getPath(alloc, .executable_dir) catch unreachable) |exePath| {
        defer alloc.free(exePath);
        std.process.changeCurDir(exePath) catch {
            std.debug.print("Failed to chdir to local executable folder.\n",.{});
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
    for(staticInits.items) |ifn| {
        ifn();
    }

    if(!inEditor and settings.initialScene != null) {
        var bytes = std.fs.cwd().readFileAlloc(alloc, settings.initialScene.?, 80_000_000) catch unreachable;
        defer alloc.free(bytes);
        scene = Scene.initFromBytes(bytes);
    }

    // Add fontawesome
    // var copied: []u8 = alloc.dupeZ(u8, @embedFile("deps/fontawesome.otf")) catch unreachable;
    // defer alloc.free(copied);

    // var cfg = ig.ImFontConfig_ImFontConfig();
    // cfg.*.SizePixels = size;
    // cfg.*.OversampleH = 1;
    // cfg.*.OversampleV = 1;
    // cfg.*.MergeMode = true;
    // cfg.*.
    // var range = ig.ImFontAtlas_GetGlyphRangesDefault(io.*.Fonts);
    // var font = ig.ImFontAtlas_AddFontFromMemoryTTF(io.*.Fonts, copied.ptr, @intCast(c_int,bytes.len), size, cfg, range);
    // ctx.rebuildFont();
}
fn loop() void {
    while (ctx.open) {
        time += ctx.time.dt;
        dt = ctx.time.dt;

        ctx.beginFrame();
        input.pump();

        if (inEditor) {
            _ = zt.custom_components.ztViewPort();
            editor.editorUI();
        }

        if(room) |roomIdx| {
            register.RegisteredRooms.items[roomIdx].method();
        } else if(scene) |currentScene| {
            currentScene.update();
        }

        render.flush();
        ctx.endFrame();
        audio.update();
    }
}
fn serializeSling() void {
    // Serialize settings.
    if(settings.rememberWindowSettings) {
        var w: c_int = 0;
        var h: c_int = 0;
        var x: c_int = 0;
        var y: c_int = 0;
        glfw.glfwGetWindowSize(ctx.window, &w, &h);
        glfw.glfwGetWindowPos(ctx.window, &x, &y);

        if(glfw.glfwGetWindowAttrib(ctx.window, glfw.GLFW_MAXIMIZED) == 1) {
            settings.wasMaximizedLast = true;
        } else {
            settings.wasMaximizedLast = false;
            settings.windowPos = .{.x=@intToFloat(f32, x),.y=@intToFloat(f32, y)};
            settings.windowSize = .{.x=@intToFloat(f32, w),.y=@intToFloat(f32, h)};
        }
    }

    var tree = serializer.Tree.initArena(alloc);
    tree.root = tree.toNode(settings);
    defer tree.deinit();
    var settingsBytes = preferredLexicon.convert(alloc, tree);
    defer alloc.free(settingsBytes);


    std.fs.cwd().writeFile("settings", settingsBytes) catch {
        std.debug.panic("Failed to write sling settings to disk.", .{});
    };
}
fn deserializeSling() void {
    // 5mb max
    var settingsFile = std.fs.cwd().readFileAlloc(alloc, "settings", 5_000_000) catch {
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
pub fn integrate(comptime T:type) void {
    if(@hasDecl(T, "slingIntegration")) {
        switch(@typeInfo(@TypeOf(@field(T, "slingIntegration")))) {
            .Fn => |fnInfo| {
                if(fnInfo.args.len == 0 and (fnInfo.return_type == null or fnInfo.return_type.? == void)) {
                    T.slingIntegration();
                } else {
                    std.debug.panic("'slingIntegration' on type {s} failed, it should be a function with no args and no return type.", .{@typeName(T)});
                }
            },
            else => { 
                std.debug.panic("'slingIntegration' on type {s} failed, it should be a function with no args and no return type.", .{@typeName(T)});
            }
        }
    }
}
pub fn addStaticInit(func: fn() void) void {
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
    gl.glClearColor(color.x,color.y,color.z,color.w);
}
pub fn igFontPath(path: []const u8, size: f32) *ig.ImFont {
    return ctx.addFont(path, size);
}
pub fn igFontBytes(bytes: []const u8, size: f32) *ig.ImFont {
    var copied: []u8 = alloc.dupeZ(u8, bytes) catch unreachable;
    defer alloc.free(copied);
    var io = ig.igGetIO();
    var cfg = ig.ImFontConfig_ImFontConfig();
    cfg.*.SizePixels = size;
    cfg.*.OversampleH = 1;
    cfg.*.OversampleV = 1;
    var range = ig.ImFontAtlas_GetGlyphRangesDefault(io.*.Fonts);
    var font = ig.ImFontAtlas_AddFontFromMemoryTTF(io.*.Fonts, copied.ptr, @intCast(c_int,bytes.len), size, cfg, range);
    ctx.rebuildFont();

    return font;
}
pub fn igSetFontFilter(nearest:bool) void {
    var io = ig.igGetIO();
    var fontTex = zt.gl.Texture.from(@intCast(c_uint,@ptrToInt(io.*.Fonts.*.TexID)), true);
    if(nearest) {
        fontTex.setNearestFilter();
    } else {
        fontTex.setLinearFilter();
    }
}