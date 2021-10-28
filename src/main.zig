const entry = @import("applicationEntry.zig");
const std = @import("std");

/// Direct access to the packages that sling uses. Things are packed away in here by default,
/// but only things directly in the sling namespace are intended for public use. You can still
/// sift through here if you know what you're editing.
pub const package = struct {
    /// Standard renderer for sling, supports most use-cases for 2d.
    pub const Renderer = @import("sling/renderer.zig");
    /// 2D Camear for slingworks renderers.
    pub const Camera = @import("sling/camera.zig");
    /// Handles objects into one group to be managed from one place.
    pub const Scene = @import("sling/scene.zig");
    /// Handles loading and saving to the disk(whatever that may be)
    pub const assets = @import("sling/asset.zig");
    /// Reroute scaffolds a few of the internal apis for im
    pub const reroute = @import("reroute/main.zig");
    /// Raw imgui bindings, its safe to use this anywhere you'd use the zig-bindings.
    pub const imgui = @import("cimgui/imgui.zig");
    /// Direct access to sokol functions, you typically wont need anything here, and I can't
    /// guarantee everything works
    pub const sokol = @import("sokol/sokol.zig");
    /// Contains all the logic to register, instantiate, and interact with generalized groups
    /// of entities.
    pub const object = @import("sling/object.zig");
    /// Custom serializer made for sling.
    pub const serializer = @import("sling/serializer.zig");
    /// Simple default rooms and a register struct to manage them.
    pub const room = @import("sling/room.zig");
    /// Very simple imgui queries to handle input.
    pub const input = @import("sling/input.zig");
    /// Hub for Sling's internal editor interface.
    pub const editor = @import("editor/editor.zig");
};

/// A simple 2d camera, you don't need to instantiate this as Sling Renderers will handle
/// this automatically.
pub const Camera = package.Camera;
/// Simply a union of normal depth(f32) and y-sorted depth(f32,f32), Sling renderers take this
/// to sort between and organize render passes efficiently whilst maintaining proper game
/// rendering that can be called from anywhere with no side effects.
pub const Depth = package.Renderer.Depth;
/// A simple texture, this is a sokol image, try not to create this directly, instead
/// prefer to let `sling.asset.ensure/fetchCopy` do it for you.
pub const Texture = package.sokol.gfx.Image;
/// This groups many objects into one struct to be loaded and saved ergonomically.
pub const Scene = package.Scene;
/// Contains many functions and wrappers to turn any struct into a generalized type for
/// use inside Scenes.
pub const Object = package.object;
/// Use this to access the file system and convert from configuration files to real data.
/// At no point should you need to use `std.fs` and if asset doesn't have you covered,
/// shoot an issue on the repo and I'll sort it.
pub const asset = package.assets;
/// A package full of math types and vectors/rect/matrices, types from this package
/// are compatible with most other package vector types, such as imgui.ImVec2/4
pub const math = package.reroute.math;
/// Zig-oriented bindings for the imgui library, you can call things from here whenever
/// you want inside of sling.
pub const imgui = package.reroute.imgui;
/// Utilities related to memory. I recommend using the provided RingBuffer wherever it makes
/// sense.
pub const mem = package.reroute.mem;
/// Contains Room Registration and editor-provided default rooms to use in your game.
pub const room = package.room;
/// Contains everything you need to query M+KB state for input.
pub const input = package.input;
/// Controls how anything in sling gets turned into bytes and back to data structures.
pub const serializer = package.serializer;
/// This is your default renderer, you can call into this from wherever you want, go wild!
pub var render: package.Renderer = undefined;

pub const InitialRunSettings = struct {
};

var initFunctions: std.ArrayList(fn()void) = std.ArrayList(fn()void).init(mem.Allocator);
var loopFunctions: std.ArrayList(fn()void) = std.ArrayList(fn()void).init(mem.Allocator);

/// These are variables that are set by sling, they should be considered read-only,
/// and only to be mutated by the methods inside, or by modifying the `sling.config` struct
/// instead.
pub const state = struct {
    /// How much time in seconds its been since the last frame. Use this for your game
    /// calculations that need to be the same
    pub var dt: f32 = 0;
    /// Same as dt, but unaffected by `config.timeScale`
    pub var unscaledDt: f32 = 0;
    /// Sling automatically outputs a background dock window; this its ID, updated at the start
    /// of each frame for use in pre-splitting imgui windows.
    pub var dockId: package.imgui.ImGuiID = 0;
    /// The current scene that is running or being edited, setting this directly isnt
    /// recommended, prefer to use switch, load, push, and pop to change scenes.
    pub var scene: ?*Scene = null;
    /// Overrides the current scene with a single method that runs each frame, useful for
    /// test rooms, main menus, settings menu, and dev menus. Basically anything that doesnt
    /// need serialization.
    pub var room: ?package.room.Register = null;
    /// This is true if the game was started with the `editor` command line flag.
    pub var isEditing: bool = true;
};
/// You can modify anything in here directly from anywhere inside your application, and
/// they will be in effect by the next frame start.
pub const config = struct {
    /// Whether or not debug calls are active
    pub var debugView: bool = false;
    /// The alpha of debug shapes
    pub var debugAlpha: f32 = 0.5;
    /// Use this to scale the delta time to simulate slow motion, or speed up the game(gameplay speed, not fps).
    pub var timeScale: f32 = 1.0;
    /// This is the serialization config used for every serialize/deserialize that happens,
    /// editing this directly works fine.
    pub var serializationConfig: serializer.Configuration = serializer.Configuration.init(mem.Allocator);
    /// This is the serialization language that sling will use to store and load data.
    pub var preferredStorageLang: serializer.Lexicon = serializer.json.JsonLexicon;
};

/// Begins the Sling loop, make sure you've configured all your types and game entities.
pub fn run(settings: InitialRunSettings) void {
    _ = settings;
    entry.begin(sling_init, sling_loop);
    state.isEditing = true;
}

export fn sling_init() void {
    render = package.Renderer.init();
    for(initFunctions.items) |ifn| {
        ifn();
    }
}
export fn sling_loop() void {
    // Configure state
    state.dt = entry.dt * config.timeScale;
    state.unscaledDt = entry.dt;
    state.dockId = imgui.components.dockBackground();

    input.pump();
    package.editor.editorUI();

    for(loopFunctions.items) |lfn| {
        lfn();
    }

    if(state.scene) |scn| {
        scn.update();
    }

    render.finish();
}

// Util functions

/// Use this to automatically register a type into sling if it contains a
/// `slingIntegration` function of type `fn() void`. Prefer to use this as it will compile
/// error if something is not meant to be used in sling!
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
/// Use this to get the build data for a type. Calling this implicitly
/// registers a type as an entity for use as or in a scene.
pub fn configure(comptime T: type) *Object.GenBuildData(T) {
    const base = Object.GenBuildData(T);
    return base.register();
}
/// Adds an init function as a function to be ran after everything is initialized, do your
/// global asset loading here, or anything you need to do with imgui.
pub fn configureInit(initFn: fn()void) void {
    initFunctions.append(initFn) catch unreachable;
}
/// Adds an loop function as a function to be ran before each update loop. This is pretty
/// niche and should be used sparingly. Ideas for use include manually
pub fn configureLoop(loopFn: fn()void) void {
    loopFunctions.append(loopFn) catch unreachable;
}
/// Give in a type you've configured as a scene that can be created and edited inside
/// sling's editor, and a list of its pieces as a tuple eg `.{Player,Collision,AmmoPickup}`
pub fn configureAsScene(comptime T: type, comptime children: anytype) void {
    const childrenType = @typeInfo(@TypeOf(children));
    std.debug.assert(childrenType == .Struct and childrenType.Struct.is_tuple);
    std.debug.assert(@TypeOf(children[0]) == type);

    var sceneEntry = Scene.RegisteredScenes.getOrPut(@typeName(T)) catch unreachable;
    if (!sceneEntry.found_existing) {
        sceneEntry.key_ptr.* = @typeName(T);
        sceneEntry.value_ptr.* = undefined;
        sceneEntry.value_ptr.*.base = Object.Information.indexOf(T);
        sceneEntry.value_ptr.*.dependants = std.ArrayList(usize).init(mem.Allocator);
    }

    inline for (children) |childType| {
        sceneEntry.value_ptr.*.dependants.append(Object.Information.indexOf(childType)) catch unreachable;
    }
}

const console = @import("editor/console.zig");
pub fn log(message: []const u8) void {
    console.submit(message, "!");
}
pub fn logFmt(comptime fmt: []const u8, params: anytype) void {
    console.submitFmt(fmt, params, "!");
}
pub fn logErr(message: []const u8) void {
    console.submit(message, "X");
}
pub fn logErrFmt(comptime fmt: []const u8, params: anytype) void {
    console.submitFmt(fmt, params, "X");
}
pub fn logWarn(message: []const u8) void {
    console.submit(message, "?");
}
pub fn logWarnFmt(comptime fmt: []const u8, params: anytype) void {
    console.submitFmt(fmt, params, "?");
}