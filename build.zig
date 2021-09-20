const std = @import("std");
const ztBuild = @import("src/deps/ZT/build.zig");

// ZLS kinda freaks out about not having a build file to parse, so this is
// a dummy build.
pub fn build(b: *std.build.Builder) void {
    const target = b.standardTargetOptions(.{});
    const mode = b.standardReleaseOptions();

    const exe = b.addExecutable("fake", "./fakeMain.zig");
    exe.linkLibC();
    exe.setTarget(target);
    exe.setBuildMode(mode);
    link(exe);
    exe.install();
}

fn getRelativePath() []const u8 {
    comptime var src: std.builtin.SourceLocation = @src();
    return std.fs.path.dirname(src.file).? ++ std.fs.path.sep_str;
}

pub fn link(exe: *std.build.LibExeObjStep) void {
    comptime var path = getRelativePath();

    ztBuild.link(exe.builder, exe, exe.target);
    const slingPkg = std.build.Pkg{ .name = "sling", .path = .{
        .path = path ++ "src/sling.zig",
    }, .dependencies = &[_]std.build.Pkg{
        ztBuild.ztPkg,
        ztBuild.glfwPkg,
        ztBuild.glPkg,
        ztBuild.imguiPkg,
        ztBuild.stbPkg,
    } };
    exe.addPackage(slingPkg);

    // TODO: Linux
    if (exe.target.isWindows()) {
        exe.target.cpu_arch = .x86_64;
        if (exe.builder.is_release) { // Release builds wont want to include the commandline.
            exe.subsystem = .Windows;
        }
        // Core
        exe.addIncludeDir("C:/Program Files (x86)/FMOD SoundSystem/FMOD Studio API Windows/api/core/inc");
        exe.addObjectFile("C:/Program Files (x86)/FMOD SoundSystem/FMOD Studio API Windows/api/core/lib/x64/fmod_vc.lib");

        // Studio
        exe.addIncludeDir("C:/Program Files (x86)/FMOD SoundSystem/FMOD Studio API Windows/api/studio/inc");
        exe.addObjectFile("C:/Program Files (x86)/FMOD SoundSystem/FMOD Studio API Windows/api/studio/lib/x64/fmodstudio_vc.lib");

        var core = exe.builder.addInstallFile(.{ .path = "C:/Program Files (x86)/FMOD SoundSystem/FMOD Studio API Windows/api/studio/lib/x64/fmodstudio.dll" }, "bin/fmodstudio.dll");
        var studio = exe.builder.addInstallFile(.{ .path = "C:/Program Files (x86)/FMOD SoundSystem/FMOD Studio API Windows/api/core/lib/x64/fmod.dll" }, "bin/fmod.dll");
        exe.step.dependOn(&core.step);
        exe.step.dependOn(&studio.step);
    }
}

pub const addBinaryContent = ztBuild.addBinaryContent;
