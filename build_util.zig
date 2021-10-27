const std = @import("std");
const fs = std.fs;
pub const AddContentErrors = error{ PermissionError, WriteError, FileError, FolderError, RecursionError };
fn getRelativePath() []const u8 {
    comptime var src: std.builtin.SourceLocation = @src();
    return std.fs.path.dirname(src.file).? ++ std.fs.path.sep_str;
}
/// Pass in a relative path to a folder, and its content is added to the zig-cache/bin output.
/// TODO: Lookup where zig defines the output folder to make it more bulletproof.
pub fn addBinaryContent(comptime baseContentPath: []const u8) AddContentErrors!void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};

    const zigBin: []const u8 = std.fs.path.join(&gpa.allocator, &[_][]const u8{ "zig-out", "bin" }) catch return error.FolderError;
    defer gpa.allocator.free(zigBin);
    fs.cwd().makePath(zigBin) catch return error.FolderError;

    var sourceFolder: fs.Dir = fs.cwd().openDir(baseContentPath, .{ .iterate = true }) catch return error.FolderError;
    defer sourceFolder.close();
    var iterator: fs.Dir.Iterator = sourceFolder.iterate();
    while (iterator.next() catch return error.FolderError) |target| {
        var x: fs.Dir.Entry = target;
        if (x.kind == .Directory) {
            const source: []const u8 = std.fs.path.join(&gpa.allocator, &[_][]const u8{ baseContentPath, x.name }) catch return error.RecursionError;
            const targetFolder: []const u8 = std.fs.path.join(&gpa.allocator, &[_][]const u8{ zigBin, x.name }) catch return error.RecursionError;
            defer gpa.allocator.free(source);
            defer gpa.allocator.free(targetFolder);
            try innerAddContent(&gpa.allocator, source, targetFolder);
        }
        if (x.kind == .File) {
            try copy(baseContentPath, zigBin, x.name);
        }
    }
}
fn innerAddContent(allocator: *std.mem.Allocator, folder: []const u8, dest: []const u8) AddContentErrors!void {
    var sourceFolder: fs.Dir = fs.cwd().openDir(folder, .{ .iterate = true }) catch return error.FolderError;
    defer sourceFolder.close();

    var iterator: fs.Dir.Iterator = sourceFolder.iterate();
    while (iterator.next() catch return error.FolderError) |target| {
        var x: fs.Dir.Entry = target;
        if (x.kind == .Directory) {
            const source: []const u8 = std.fs.path.join(allocator, &[_][]const u8{ folder, x.name }) catch return error.RecursionError;
            const targetFolder: []const u8 = std.fs.path.join(allocator, &[_][]const u8{ dest, x.name }) catch return error.RecursionError;
            defer allocator.free(source);
            defer allocator.free(targetFolder);
            try innerAddContent(allocator, source, targetFolder);
        }
        if (x.kind == .File) {
            try copy(folder, dest, x.name);
        }
    }
}
fn copy(from: []const u8, to: []const u8, filename: []const u8) AddContentErrors!void {
    fs.cwd().makePath(to) catch return error.FolderError;
    var source = fs.cwd().openDir(from, .{}) catch return error.FileError;
    var dest = fs.cwd().openDir(to, .{}) catch return error.FileError;
    defer source.close();
    defer dest.close();

    var sfile = source.openFile(filename, .{}) catch return error.FileError;
    defer sfile.close();
    var dfile = dest.openFile(filename, .{}) catch {
        source.copyFile(filename, dest, filename, .{}) catch return error.PermissionError;
        std.debug.print("COPY: {s}/{s} to {s}/{s}\n", .{ from, filename, to, filename });
        return;
    };

    var sstat = sfile.stat() catch return error.FileError;
    var dstat = dfile.stat() catch return error.FileError;

    if (sstat.mtime > dstat.mtime) {
        dfile.close();
        dest.deleteFile(filename) catch return error.PermissionError;
        source.copyFile(filename, dest, filename, .{}) catch return error.PermissionError;
        std.debug.print("OVERWRITE: {s}\\{s} to {s}\\{s}\n", .{ from, filename, to, filename });
    } else {
        defer dfile.close();
        std.debug.print("SKIP: {s}\\{s}\n", .{ from, filename });
    }
}

/// Provide path as a path to your folder of shaders.
/// Shaders will be compiled and added to a list of packages, you can add them to your
/// project and import them as if they were packages,
/// for example `@import("yourShader.glsl");`
pub fn shaders(exe: *std.build.LibExeObjStep, comptime path: []const u8) !void {
    // todo linux/mac paths and quirks..
    const shc = getRelativePath() ++ "bin-dev/win32/sokol-shdc.exe";
    var files = try std.fs.cwd().openDir(path, .{.iterate=true});
    defer files.close();
    var iter = files.iterate();
    
    var shaderCacheFolder = try std.fs.path.join(exe.builder.allocator, &[_][]const u8{exe.builder.cache_root, "shaders"});
    if(std.mem.indexOf(u8, shaderCacheFolder, "zig-cache")) |_| {
        try std.fs.cwd().makePath(shaderCacheFolder);
    }

    while(iter.next() catch unreachable) |file| {
        if(std.mem.eql(u8, ".glsl", std.fs.path.extension(file.name))) {
            var name = std.fs.path.basename(file.name);
            var target = try std.fs.path.join(exe.builder.allocator, &[_][]const u8 {path, file.name});
            var destination = try std.fs.path.join(exe.builder.allocator, &[_][]const u8{shaderCacheFolder, try std.mem.concat(exe.builder.allocator, u8, &[_][]const u8 {name, ".zig"})});
            var inputStep = try std.mem.concat(exe.builder.allocator, u8, &[_][]const u8 {"--input=",target});
            var destStep = try std.mem.concat(exe.builder.allocator, u8, &[_][]const u8 {"--output=",destination});
            var step = exe.builder.addSystemCommand(&[_][]const u8{shc, inputStep, destStep, "--slang=glsl330:metal_macos:hlsl4", "--format=sokol_zig"});
            exe.step.dependOn(&step.step);
            // std.build.Pkg{
            //     .name=std.heap.page_allocator.dupeZ(u8,name) catch unreachable,
            //     .path=.{
            //         .path=std.heap.page_allocator.dupeZ(u8,destination) catch unreachable
            //     },
            //     .dependencies=&[_]std.build.Pkg{Pkg}}) catch unreachable;
        }
    }
}