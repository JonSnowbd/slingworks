const std = @import("std");
const sling = @import("../main.zig");
const ig = sling.package.imgui;
const selector = @import("fileSelector.zig");
pub const dict = @import("dictionary.zig");

var demoOpen: bool = false;
var saveShortcut: bool = false;
var loadShortcut: bool = false;
var saveAsShortcut: bool = false;

pub fn update() void {
    // Shortcut items
    saveAsShortcut = false;
    saveShortcut = false;
    loadShortcut = false;

    // Main menu
    if (ig.igBeginMainMenuBar()) {
        if (sling.state.room) |_| {
            if (ig.igBeginMenu(dict.exitRoom.ptr, true)) {
                ig.igEndMenu();
            }
        }
        // Creation tab
        if (ig.igBeginMenu(dict.fileMenuTag.ptr, sling.state.room == null)) {
            fileMenu();
            ig.igEndMenu();
        }
        if (ig.igBeginMenu(dict.miscMenuTag.ptr, true)) {
            if (ig.igMenuItem_Bool(dict.miscMenuImGui.ptr, null, demoOpen, true)) {
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
    if (ig.igBeginMenu(dict.fileMenuNew.ptr, true)) {
        var registers = sling.Scene.RegisteredScenes.valueIterator();
        while (registers.next()) |sceneRegister| {
            var baseInfo = sling.Object.Information.get(sceneRegister.base);
            if (ig.igMenuItem_Bool(baseInfo.name.ptr, null, false, true)) {
                sling.state.scene = sling.Scene.initFromInfo(sceneRegister.*);
            }
        }
        ig.igEndMenu();
    }
    ig.igSeparator();
    // Current scene items
    var enabled = sling.state.scene != null and sling.state.scene.?.editorData.filePath != null;
    if (ig.igMenuItem_Bool(dict.fileMenuSave.ptr, "CTRL+S", false, enabled) or saveShortcut) {
        var path = sling.state.scene.?.editorData.filePath.?;
        var data = sling.state.scene.?.toBytes(sling.mem.Allocator);
        defer sling.mem.Allocator.free(data);
        std.fs.cwd().writeFile(path, data) catch {
            std.debug.print("Failed to write scene data to disk.\n", .{});
        };
        sling.logFmt("Quick saving to {s} successful!", .{sling.state.scene.?.editorData.filePath.?});
    }
    if (ig.igMenuItem_Bool(dict.fileMenuSaveAs.ptr, "CTRL+SHIFT+S", false, true) or saveAsShortcut) {
        selector.beginSaving(sling.state.scene.?.editorData.filePath);
    }
    if (ig.igMenuItem_Bool(dict.fileMenuLoad.ptr, "CTRL+O", false, true) or loadShortcut) {
        selector.beginLoading();
    }
    ig.igSeparator();
    if (ig.igMenuItem_Bool(dict.fileMenuLeave.ptr, null, false, sling.state.scene != null and sling.state.isEditing)) {
        if (sling.state.scene) |scn| {
            scn.deinit();
            sling.state.scene = null;
        }
    }
}
