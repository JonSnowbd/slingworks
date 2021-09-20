const std = @import("std");
const zt = @import("zt");
const sling = @import("../sling.zig");
const ig = @import("imgui");

var demoOpen: bool = false;

var filePath: [512:0]u8 = std.mem.zeroes([512:0]u8);
var pathCallback: ?fn ([]const u8) void = null;

pub fn update() void {
    if (ig.igBeginMainMenuBar()) {
        if (sling.room) |_| {
            if (ig.igBeginMenu("<- Back", true)) {
                sling.leaveRoom();
                ig.igEndMenu();
            }
        }
        // Creation tab
        if (ig.igBeginMenu("File", sling.room == null)) {
            fileMenu();
            ig.igEndMenu();
        }
        if (ig.igBeginMenu("Room", sling.room == null)) {
            for (sling.register.RegisteredRooms.items) |room, i| {
                if (ig.igMenuItem_Bool(room.name.ptr, null, false, true)) {
                    sling.enterRoom(i);
                }
            }
            ig.igEndMenu();
        }
        if (ig.igBeginMenu("Misc", true)) {
            if (ig.igMenuItem_Bool("ImGui Demo", null, demoOpen, true)) {
                demoOpen = !demoOpen;
            }
            ig.igEndMenu();
        }
        ig.igEndMainMenuBar();
    }
    if (demoOpen) {
        ig.igShowDemoWindow(&demoOpen);
    }
    if (pathCallback) |callback| {
        var io = ig.igGetIO();
        ig.igSetNextWindowSize(.{ .x = 300, .y = 100 }, ig.ImGuiCond_Appearing);
        ig.igSetNextWindowPos(io.*.DisplaySize.scale(0.5), ig.ImGuiCond_Appearing, .{ .x = 0.5, .y = 0.5 });
        if (ig.igBegin("Enter Path##SLING_PATH_UTILITY", null, ig.ImGuiWindowFlags_None)) {
            ig.igText("Path");
            _ = sling.util.igEdit("##SLING_PATH_ENTRY", &filePath);
            ig.igSameLine(0, 4);
            if (ig.igButton("Done", .{})) {
                var path = std.mem.spanZ(&filePath);
                callback(path);
                pathCallback = null;
            }
        }
        ig.igEnd();
    }
}

fn fileMenu() void {
    // New menu dropdown
    if (ig.igBeginMenu("New", true)) {
        var registers = sling.register.RegisteredScenes.valueIterator();
        while (registers.next()) |sceneRegister| {
            var cast: *sling.register.SceneRegister = sceneRegister;
            var baseInfo = sling.Object.Information.get(cast.base);
            if (ig.igMenuItem_Bool(baseInfo.name.ptr, null, false, true)) {
                sling.scene = sling.Scene.initFromInfo(cast.*);
            }
        }
        ig.igEndMenu();
    }
    ig.igSeparator();

    // Current scene items
    var enabled = sling.scene != null and sling.scene.?.editorData.filePath != null;
    if (ig.igMenuItem_Bool("Save", "CTRL+S", false, enabled)) {
        var path = sling.scene.?.editorData.filePath.?;
        var data = sling.scene.?.toBytes(sling.alloc);
        defer sling.alloc.free(data);
        std.fs.cwd().writeFile(path, data) catch {
            std.debug.print("Failed to write scene data to disk.\n", .{});
        };
    }
    if (ig.igMenuItem_Bool("Save As", "CTRL+SHIFT+S", false, true)) {
        pathCallback = cb_save;
    }
    if (ig.igMenuItem_Bool("Load", "CTRL+O", false, true)) {
        pathCallback = cb_load;
    }
    // Shortcut stuff
}

fn cb_save(path: []const u8) void {
    var data = sling.scene.?.toBytes(sling.alloc);
    var ownedPath = sling.alloc.dupeZ(u8, path) catch unreachable;
    sling.scene.?.editorData.filePath = ownedPath;
    defer sling.alloc.free(data);
    std.fs.cwd().writeFile(path, data) catch {
        std.debug.print("Failed to write scene data to disk.\n", .{});
    };
    filePath = std.mem.zeroes([512:0]u8);
}

fn cb_load(path: []const u8) void {
    var newScene = sling.Scene.initFromFilepath(path);
    if (sling.scene) |oldScene| {
        oldScene.deinit();
    }
    sling.scene = newScene;
    filePath = std.mem.zeroes([512:0]u8);
}
