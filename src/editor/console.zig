const std = @import("std");
const zt = @import("zt");
const sling = @import("../sling.zig");
const ig = @import("imgui");

const LogType = struct{
    style: sling.debug.DebugType,
    icon: ?[]const u8,
    ownedText: []const u8,
};

var catchup: bool = false;
var log = std.ArrayList(LogType).init(sling.alloc);

pub fn update() void {
    if(ig.igBegin(sling.dictionary.windowTitleConsole.ptr, null, ig.ImGuiWindowFlags_None)) {
        for(log.items) |message| {
            var txt = zt.custom_components.fmtTextForImgui("{s} - {s}", .{message.icon, message.ownedText});
            ig.igTextColored(message.style.toColor(), txt.ptr);
        }
        if(ig.igGetScrollY() >= 0.9875 or catchup) {
            ig.igSetScrollHereY(1.0);
            catchup = false;
        }
    }
    ig.igEnd();
}

/// message is copied and owned by the console, you're free to do whatever you want with it after.
/// However, as you're expected to pass in a static member from `icon.zig` for icon, it is not copied.
pub fn submit(message: []const u8, style: ?sling.debug.DebugType, icon: ?[]const u8) void {
    log.append(.{
        .style = style orelse sling.debug.DebugType.primary,
        .icon = icon,
        .ownedText = sling.alloc.dupeZ(u8, message) catch unreachable,
    }) catch unreachable;
    catchup = true;
}

pub fn submitFmt(comptime fmt: []const u8, params: anytype, style: ?sling.debug.DebugType, icon: ?[]const u8) void {
    var owned = std.fmt.allocPrint(sling.alloc, fmt, params) catch unreachable;
    log.append(.{
        .style = style orelse sling.debug.DebugType.primary,
        .icon = icon,
        .ownedText = owned,
    }) catch unreachable;
    catchup = true;
}