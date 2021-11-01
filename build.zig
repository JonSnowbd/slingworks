const std = @import("std");
const fs = std.fs;

fn getRelativePath() []const u8 {
    comptime var src: std.builtin.SourceLocation = @src();
    return std.fs.path.dirname(src.file).? ++ std.fs.path.sep_str;
}

pub const addGameContent = @import("build_util.zig").addBinaryContent;
/// TODO: This doesnt quite work as well as I'd like yet
const compileShaders = @import("build_util.zig").shaders;

pub fn build(b: *std.build.Builder) void {
    const target = b.standardTargetOptions(.{});
    const mode = b.standardReleaseOptions();

    const exe = b.addExecutable("example", "./example.zig");
    exe.setTarget(target);
    exe.setBuildMode(mode);
    link(exe);
    exe.install();

    // Run cmd
    const run_cmd = exe.run();
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }
    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);
}

pub fn link(exe: *std.build.LibExeObjStep) void {
    if (exe.target.isWindows()) {
        if (exe.builder.is_release) {
            exe.subsystem = .Windows; // Disable the console if release
            exe.want_lto = false; // Also tls_index gets lost if we lto.
        }
    }

    linkSokol(exe);
    linkImGui(exe);
    // Link stb_image
    exe.linkLibC();
    exe.addCSourceFile(getRelativePath() ++ "src/deps/stb_image.c", &[_][]const u8{});
    exe.addPackagePath("sling", getRelativePath() ++ "src/main.zig");
}

fn linkSokol(exe: *std.build.LibExeObjStep) void {
    comptime var prefix = getRelativePath();
    var b = exe.builder;
    var target = exe.target;
    exe.linkLibC();
    exe.linkLibCpp();
    const sokol_path = prefix ++ "src/sokol/c/";
    const csources = [_][]const u8{
        "sokol_app.c",
        "sokol_gfx.c",
        "sokol_time.c",
    };
    var flagContainer = std.ArrayList([]const u8).init(std.heap.page_allocator);
    flagContainer.append("-DIMPL") catch unreachable;
    flagContainer.append("-O2") catch unreachable;
    if (target.isDarwin()) {
        b.env_map.put("ZIG_SYSTEM_LINKER_HACK", "1") catch unreachable;
        flagContainer.append("-ObjC") catch unreachable;
        exe.linkFramework("MetalKit");
        exe.linkFramework("Metal");
        exe.linkFramework("Cocoa");
        exe.linkFramework("QuartzCore");
    } else {
        if (target.isLinux()) {
            exe.linkSystemLibrary("X11");
            exe.linkSystemLibrary("Xi");
            exe.linkSystemLibrary("Xcursor");
            exe.linkSystemLibrary("GL");
        } else if (target.isWindows()) {
            exe.linkSystemLibrary("kernel32");
            exe.linkSystemLibrary("user32");
            exe.linkSystemLibrary("gdi32");
            exe.linkSystemLibrary("ole32");
            exe.linkSystemLibrary("d3d11");
            exe.linkSystemLibrary("dxgi");
        }
    }
    inline for (csources) |csrc| {
        exe.addCSourceFile(sokol_path ++ csrc, flagContainer.items);
    }
}
fn linkImGui(exe: *std.build.LibExeObjStep) void {
    comptime var path = getRelativePath();
    exe.linkLibC();
    exe.linkLibCpp();

    // Generate flags.
    var flagContainer = std.ArrayList([]const u8).init(std.heap.page_allocator);
    flagContainer.append("-O2") catch unreachable;
    flagContainer.append("-Wno-return-type-c-linkage") catch unreachable;
    flagContainer.append("-fno-sanitize=undefined") catch unreachable;

    // Link libraries.
    if (exe.target.isWindows()) {
        exe.linkSystemLibrary("winmm");
        exe.linkSystemLibrary("user32");
        exe.linkSystemLibrary("imm32");
        exe.linkSystemLibrary("gdi32");
    }

    // Include dirs.
    exe.addIncludeDir(path ++ "src/cimgui/imgui");
    exe.addIncludeDir(path ++ "src/cimgui");

    // Add C
    exe.addCSourceFiles(&.{
        path ++ "src/cimgui/imgui/imgui.cpp",
        path ++ "src/cimgui/imgui/imgui_demo.cpp",
        path ++ "src/cimgui/imgui/imgui_draw.cpp",
        path ++ "src/cimgui/imgui/imgui_tables.cpp",
        path ++ "src/cimgui/imgui/imgui_widgets.cpp",
        path ++ "src/cimgui/cimgui.cpp",
    }, flagContainer.items);
}
