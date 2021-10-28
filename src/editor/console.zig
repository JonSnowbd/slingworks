const std = @import("std");
const sling = @import("../main.zig");
const ig = sling.package.imgui;
const dict = @import("dictionary.zig");

const LogType = struct {
    icon: ?[]const u8,
    ownedText: []const u8,
};

var catchup: bool = false;
var log = std.ArrayList(LogType).init(sling.mem.Allocator);

pub fn update() void {
    if (ig.igBegin(dict.windowTitleConsole.ptr, null, ig.ImGuiWindowFlags_None)) {
        for (log.items) |message| {
            var txt = sling.imgui.components.format("{s} - {s}", .{ message.icon, message.ownedText });
            ig.igTextColored(sling.math.Vec4.new(1.0,1.0,1.0,1.0), txt.ptr);
        }
        if (ig.igGetScrollY() >= 0.9875 or catchup) {
            ig.igSetScrollHereY(1.0);
            catchup = false;
        }
    }
    ig.igEnd();
}

/// message is copied and owned by the console, you're free to do whatever you want with it after.
/// However, as you're expected to pass in a static member from `icon.zig` for icon, it is not copied.
pub fn submit(message: []const u8, icon: ?[]const u8) void {
    log.append(.{
        .icon = icon,
        .ownedText = sling.mem.Allocator.dupeZ(u8, message) catch unreachable,
    }) catch unreachable;
    catchup = true;
}

pub fn submitFmt(comptime fmt: []const u8, params: anytype, icon: ?[]const u8) void {
    var owned = std.fmt.allocPrint(sling.mem.Allocator, fmt, params) catch unreachable;
    log.append(.{
        .icon = icon,
        .ownedText = owned,
    }) catch unreachable;
    catchup = true;
}
