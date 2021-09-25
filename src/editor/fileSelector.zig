const std = @import("std");
const zt = @import("zt");
const sling = @import("../sling.zig");
const ig = @import("imgui");

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
    var currentPathSlice = std.mem.spanZ(&currentPath);
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
            if (sling.util.igEdit("Path##SLING_PATH_ENTRY", &currentPath)) {
                reQuery();
            }
            _ = sling.util.igEdit("Filename##SLING_FILENAME_ENTRY", &currentName);
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
                sling.zt.custom_components.ztTextDisabled("Awaiting valid input: {s}", .{err});
            }

            var folderSlice = folders.slice();
            var filesSlice = files.slice();
            for (folderSlice) |folder| {
                var text = sling.zt.custom_components.fmtTextForImgui("{s}{s}", .{ sling.dictionary.fileSelectorFolder, folder });
                if (ig.igSelectable_Bool(text.ptr, false, ig.ImGuiSelectableFlags_None, .{})) {
                    var currentPathSlice = std.mem.spanZ(&currentPath);
                    var pathFragmentSlice = std.mem.spanZ(&folder);
                    var newCombined = std.fs.path.join(sling.alloc, &[_][]const u8{ currentPathSlice, pathFragmentSlice }) catch unreachable;
                    currentPath = std.mem.zeroes([512:0]u8);
                    for (newCombined) |char, i| {
                        currentPath[i] = char;
                    }
                    reQuery();
                }
            }
            var targetFile = std.mem.spanZ(&currentName);
            for (filesSlice) |file| {
                var text = sling.zt.custom_components.fmtTextForImgui("{s}{s}", .{ sling.dictionary.fileSelectorFile, file });
                var slice = std.mem.spanZ(&file);
                var selected = std.mem.eql(u8, slice, targetFile);
                if (ig.igSelectable_Bool(text.ptr, selected, ig.ImGuiSelectableFlags_None, .{})) {
                    currentName = std.mem.zeroes([128:0]u8);
                    var fileNameSlice = std.mem.spanZ(&file);
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
    var data = sling.scene.?.toBytes(sling.alloc);
    var ownedPath = sling.alloc.dupeZ(u8, path) catch unreachable;
    sling.scene.?.editorData.filePath = ownedPath;
    defer sling.alloc.free(data);
    std.fs.cwd().writeFile(path, data) catch {
        std.debug.print("Failed to write scene data to disk.\n", .{});
    };
    sling.logFmt("Succesfully saved scene to path {s}!", .{path});
}

fn cb_load(path: []const u8) void {
    var newScene = sling.Scene.initFromFilepath(path);
    // TODO: implement a previous scene stack instead of discarding.
    if (sling.scene) |oldScene| {
        sling.logWarn("Discarding current scene contents...");
        oldScene.deinit();
    }
    sling.scene = newScene;
    sling.logFmt("Succesfully saved scene to path {s}!", .{path});
}

fn finish() void {
    if (pathCallback) |callback| {
        var dir = std.mem.spanZ(&currentPath);
        var name = std.mem.spanZ(&currentName);
        var full = std.fs.path.join(sling.alloc, &[_][]const u8{ dir, name }) catch unreachable;
        defer sling.alloc.free(full);
        callback(full[0..]);
    }
    pathCallback = null;
}
