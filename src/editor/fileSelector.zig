const std = @import("std");
const sling = @import("../main.zig");
const ig = sling.package.imgui;

const dict = @import("dictionary.zig");

var pathCallback: ?fn ([]const u8) void = null;

var folders: std.BoundedArray([128:0]u8, 64) = std.BoundedArray([128:0]u8, 64).init(0) catch unreachable;
var files: std.BoundedArray([128:0]u8, 256) = std.BoundedArray([128:0]u8, 256).init(0) catch unreachable;

var currentPath: [512:0]u8 = std.mem.zeroes([512:0]u8);
var currentName: [128:0]u8 = std.mem.zeroes([128:0]u8);

// TODO: make this do a popup on overwrites.
var warnOverwrite: bool = false;

var currentError: ?[]const u8 = null;

fn reset() void {
    currentPath = std.mem.zeroes([512:0]u8);
    currentName = std.mem.zeroes([128:0]u8);
    folders.len = 0;
    files.len = 0;

    reQuery();
}
fn reQuery() void {
    folders.len = 0;
    files.len = 0;
    var currentPathSlice = std.mem.span(&currentPath);
    var target = std.fs.cwd().openDir(currentPathSlice, .{ .iterate = true }) catch {
        currentError = "Path error";
        return;
    };
    defer target.close();
    var iter: std.fs.Dir.Iterator = target.iterate();
    while (iter.next() catch unreachable) |item| {
        switch (item.kind) {
            .Directory => {
                var folderName = std.mem.zeroes([128:0]u8);
                for (item.name) |char, i| {
                    folderName[i] = char;
                }
                // Spilling too many directories can just be ignored, frankly.
                folders.append(folderName) catch {};
            },
            .File => {
                var fileName = std.mem.zeroes([128:0]u8);
                for (item.name) |char, i| {
                    fileName[i] = char;
                }
                // Spilling too many files can just be ignored, frankly.
                files.append(fileName) catch {};
            },
            else => {},
        }
    }

    currentError = null;
}
pub fn beginLoading() void {
    reset();
    warnOverwrite = false;
    pathCallback = cb_load;
}
pub fn beginSaving(initialPath: ?[]const u8) void {
    reset();
    warnOverwrite = true;
    if (initialPath) |ip| {
        if (std.fs.path.dirname(ip)) |dirName| {
            for (dirName) |char, i| {
                currentPath[i] = char;
            }
        }
        for (std.fs.path.basename(ip)) |char, i| {
            currentName[i] = char;
        }
    }
    pathCallback = cb_save;
}

pub fn update() void {
    if (pathCallback) |_| {
        var space: ig.ImVec2 = .{};
        ig.igGetContentRegionAvail(&space);
        var io = ig.igGetIO();
        ig.igSetNextWindowSize(.{ .x = 350, .y = io.*.DisplaySize.y * 0.8 }, ig.ImGuiCond_Appearing);
        ig.igSetNextWindowPos(io.*.DisplaySize.scale(0.5), ig.ImGuiCond_Appearing, .{ .x = 0.5, .y = 0.5 });
        if (ig.igBegin("Enter Path##SLING_PATH_UTILITY", null, ig.ImGuiWindowFlags_None)) {
            if (sling.imgui.components.input("Path##SLING_PATH_ENTRY", &currentPath, .{})) {
                reQuery();
            }
            _ = sling.imgui.components.input("Filename##SLING_FILENAME_ENTRY", &currentName, .{});
            if (ig.igButton("Confirm", .{})) {
                finish();
            }
            ig.igSameLine(0, 4);
            if (ig.igButton("Cancel", .{})) {
                pathCallback = null;
                reset();
            }
            ig.igSeparator();

            if (currentError) |err| {
                sling.imgui.components.textDisabled("Awaiting valid input: {s}", .{err});
            }

            var folderSlice = folders.slice();
            var filesSlice = files.slice();
            for (folderSlice) |folder| {
                var text = sling.imgui.components.format("{s}{s}", .{ dict.fileSelectorFolder, folder });
                if (ig.igSelectable_Bool(text.ptr, false, ig.ImGuiSelectableFlags_None, .{})) {
                    var currentPathSlice = std.mem.span(&currentPath);
                    var pathFragmentSlice = std.mem.span(&folder);
                    var newCombined = std.fs.path.join(sling.mem.Allocator, &[_][]const u8{ currentPathSlice, pathFragmentSlice }) catch unreachable;
                    currentPath = std.mem.zeroes([512:0]u8);
                    for (newCombined) |char, i| {
                        currentPath[i] = char;
                    }
                    reQuery();
                }
            }
            var targetFile = std.mem.span(&currentName);
            for (filesSlice) |file| {
                var text = sling.imgui.components.format("{s}{s}", .{ dict.fileSelectorFile, file });
                var slice = std.mem.span(&file);
                var selected = std.mem.eql(u8, slice, targetFile);
                if (ig.igSelectable_Bool(text.ptr, selected, ig.ImGuiSelectableFlags_None, .{})) {
                    currentName = std.mem.zeroes([128:0]u8);
                    var fileNameSlice = std.mem.span(&file);
                    for (fileNameSlice) |char, i| {
                        currentName[i] = char;
                    }
                }
            }
        }
        ig.igEnd();
    }
}

fn cb_save(path: []const u8) void {
    var data = sling.state.scene.?.toBytes(sling.mem.Allocator);
    var ownedPath = sling.mem.Allocator.dupeZ(u8, path) catch unreachable;
    sling.state.scene.?.editorData.filePath = ownedPath;
    defer sling.mem.Allocator.free(data);
    std.fs.cwd().writeFile(path, data) catch {
        std.debug.print("Failed to write scene data to disk.\n", .{});
    };
    sling.logFmt("Succesfully saved scene to path {s}!", .{path});
}

fn cb_load(path: []const u8) void {
    var newScene = sling.Scene.initFromFilepath(path);
    // TODO: implement a previous scene stack instead of discarding.
    if (sling.state.scene) |oldScene| {
        sling.logWarn("Discarding current scene contents...");
        oldScene.deinit();
    }
    sling.state.scene = newScene;
    sling.logFmt("Succesfully saved scene to path {s}!", .{path});
}

fn finish() void {
    if (pathCallback) |callback| {
        var dir = std.mem.span(&currentPath);
        var name = std.mem.span(&currentName);
        var full = std.fs.path.join(sling.mem.Allocator, &[_][]const u8{ dir, name }) catch unreachable;
        defer sling.mem.Allocator.free(full);
        callback(full[0..]);
    }
    pathCallback = null;
}
