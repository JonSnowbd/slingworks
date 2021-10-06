const std = @import("std");
const zt = @import("zt");
const sling = @import("../sling.zig");
const ig = @import("imgui");
const selector = @import("fileSelector.zig");

var demoOpen: bool = false;
var saveShortcut: bool = false;
var loadShortcut: bool = false;
var saveAsShortcut: bool = false;

pub fn update() void {
    // Shortcut items
    saveAsShortcut = false;
    saveShortcut = false;
    loadShortcut = false;
    var before = sling.input.config.imguiBlocksInput;
    sling.input.config.imguiBlocksInput = false;
    if (sling.input.Key.lCtrl.down() or sling.input.Key.rCtrl.down()) {
        if (sling.input.Key.lShift.down() or sling.input.Key.rShift.down()) {
            if (sling.input.Key.s.pressed()) {
                saveAsShortcut = true;
            }
        } else {
            if (sling.input.Key.s.pressed()) {
                saveShortcut = true;
            }
        }
        if (sling.input.Key.o.pressed()) {
            loadShortcut = true;
        }
    }
    sling.input.config.imguiBlocksInput = before;

    // Main menu
    if (ig.igBeginMainMenuBar()) {
        if (sling.room) |_| {
            if (ig.igBeginMenu(sling.dictionary.exitRoom.ptr, true)) {
                sling.leaveRoom();
                ig.igEndMenu();
            }
        }
        // Creation tab
        if (ig.igBeginMenu(sling.dictionary.fileMenuTag.ptr, sling.room == null)) {
            fileMenu();
            ig.igEndMenu();
        }
        if (ig.igBeginMenu(sling.dictionary.roomMenuTag.ptr, sling.room == null)) {
            for (sling.register.RegisteredRooms.items) |room, i| {
                if (ig.igMenuItem_Bool(room.name.ptr, null, false, true)) {
                    sling.enterRoom(i);
                }
            }
            ig.igEndMenu();
        }
        if (ig.igBeginMenu(sling.dictionary.miscMenuTag.ptr, true)) {
            if (ig.igMenuItem_Bool(sling.dictionary.miscMenuImGui.ptr, null, demoOpen, true)) {
                demoOpen = !demoOpen;
            }
            ig.igEndMenu();
        }
        ig.igEndMainMenuBar();
    }
    if (demoOpen) {
        ig.igShowDemoWindow(&demoOpen);
    }
    selector.update();
}

fn fileMenu() void {
    // New menu dropdown
    if (ig.igBeginMenu(sling.dictionary.fileMenuNew.ptr, true)) {
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
    if (ig.igMenuItem_Bool(sling.dictionary.fileMenuSave.ptr, "CTRL+S", false, enabled) or saveShortcut) {
        var path = sling.scene.?.editorData.filePath.?;
        var data = sling.scene.?.toBytes(sling.alloc);
        defer sling.alloc.free(data);
        std.fs.cwd().writeFile(path, data) catch {
            std.debug.print("Failed to write scene data to disk.\n", .{});
        };
        sling.logFmt("Quick saving to {s} successful!", .{sling.scene.?.editorData.filePath.?});
    }
    if (ig.igMenuItem_Bool(sling.dictionary.fileMenuSaveAs.ptr, "CTRL+SHIFT+S", false, true) or saveAsShortcut) {
        selector.beginSaving(sling.scene.?.editorData.filePath);
    }
    if (ig.igMenuItem_Bool(sling.dictionary.fileMenuLoad.ptr, "CTRL+O", false, true) or loadShortcut) {
        selector.beginLoading();
    }
    ig.igSeparator();
    if (ig.igMenuItem_Bool(sling.dictionary.fileMenuLeave.ptr, null, false, sling.scene != null and sling.inEditor)) {
        if (sling.scene) |scn| {
            scn.deinit();
            sling.scene = null;
        }
    }
}
