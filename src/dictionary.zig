pub const icon = @import("icon.zig");

pub var addNew: []const u8 = "+";
pub var duplicate: []const u8 = "~";

pub var fileMenuTag: []const u8 = "File";
pub var fileMenuNew: []const u8 = "New";
pub var fileMenuSave: []const u8 = "Save";
pub var fileMenuSaveAs: []const u8 = "Save As";
pub var fileMenuLoad: []const u8 = "Load";
pub var fileMenuQuit: []const u8 = "Quit";
pub var fileMenuLeave: []const u8 = "Exit Scene";

pub var exitRoom: []const u8 = "Exit";

pub var roomMenuTag: []const u8 = "Room";
/// Due to this being a room that is registered, changing this after init wont work.
pub var roomMenuPlay: []const u8 = "Play current scene";

pub var miscMenuTag: []const u8 = "Other";
pub var miscMenuImGui: []const u8 = "ImGui Demo";

pub var fileSelectorFolder: []const u8 = "-> ";
pub var fileSelectorFile: []const u8 = "- ";

pub var windowTitleSceneEditor: []const u8 = "Scene Edit##SLING_SCENE_EDITOR_WINDOW";
pub var windowTitleObjectEditor: []const u8 = "Object Edit##SLING_OBJECT_EDITOR_WINDOW";
pub var windowTitleConsole: []const u8 = "Console##SLING_OBJECT_CONSOLE";
pub var windowTitlePalette: []const u8 = "Palette##SLING_OBJECT_PALETTE";

pub fn iconify() void {
    fileMenuNew = icon.newFile ++ " New";
    fileMenuSave = icon.save ++ " Save";
    fileMenuSaveAs = icon.newFileCode ++ " Save As";
    fileMenuLoad = icon.folderOpen ++ " Load";
    fileMenuLeave = icon.stop ++ " Exit Scene";
    exitRoom = icon.circleLeft ++ " Exit";
    addNew = icon.boxPlus;
    roomMenuPlay = icon.keyboard ++ " Play current scene";

    addNew = icon.boxPlus;
    duplicate = icon.clone;
    fileSelectorFile = icon.newFile ++ " ";
    fileSelectorFolder = icon.folderOpen ++ " ";
}
