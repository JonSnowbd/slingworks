const std = @import("std");
const ig = @import("../cimgui/imgui.zig");
const math = @import("math.zig");
const mem = @import("mem.zig");

const sokol = @import("../sokol/sokol.zig");
const sg = sokol.gfx;
const sapp = sokol.app;

/// If you need direct access to imgui, you can do so here.
pub const raw = ig;

pub const WindowParams = struct {
    /// If this pointer exists, it will enable window minimizing, and modify
    /// the target bool to suit the current state.
    openPtr:?*bool = null,
    /// If true, the window cant move or resize by user input.
    static:bool = false,
    /// Enables or disables the titlebar decoration
    titlebarEnabled:bool = true,
    background:bool = true,



    pub fn constructFlags(self:WindowParams) ig.ImGuiWindowFlags {
        var flags = ig.ImGuiWindowFlags_None;

        if(self.static) {
            flags |= ig.ImGuiWindowFlags_NoResize;
            flags |= ig.ImGuiWindowFlags_NoMove;
        }
        if(!self.titlebarEnabled) {
            flags |= ig.ImGuiWindowFlags_NoTitleBar;
        }
        if(!self.background) {
            flags |= ig.ImGuiWindowFlags_NoBackground;
        }

        return flags;
    }
};

pub const InputParams = struct {
    preferDragInput:bool = true,
    step:f32 = 1.0,
    multiline:bool = false,
    updateOnEnter:bool = false,
    uppercase: bool = false,
    autoSelectAll: bool = false,
    allowTabInput: bool = false,
    noUndoRedo: bool = false,
    ctrlEnterNewline: bool = false,

    pub fn toInputTextFlags(self: InputParams) ig.ImGuiInputTextFlags {
        var flags = ig.ImGuiInputTextFlags_None;

        if(self.uppercase) {
            flags |= ig.ImGuiInputTextFlags_CharsUppercase;
        }
        if(self.multiline) {
            flags |= ig.ImGuiInputTextFlags_Multiline;
        }
        if(self.autoSelectAll) {
            flags |= ig.ImGuiInputTextFlags_AutoSelectAll;
        }
        if(self.updateOnEnter) {
            flags |= ig.ImGuiInputTextFlags_EnterReturnsTrue;
        }
        if(self.ctrlEnterNewline) {
            flags |= ig.ImGuiInputTextFlags_CtrlEnterForNewLine;
        }
        if(self.allowTabInput) {
            flags |= ig.ImGuiInputTextFlags_AllowTabInput;
        }
        if(self.noUndoRedo) {
            flags |= ig.ImGuiInputTextFlags_NoUndoRedo;
        }

        return flags;
    }
};

/// Makes a blank background 'window' in the background, and lets windows dock into it.
/// Returns the imgui you'd need to pre-split every window.
pub fn dockBackground() ig.ImGuiID {
    const dockNodeFlags = ig.ImGuiDockNodeFlags_PassthruCentralNode;
    const windowFlags =
        ig.ImGuiWindowFlags_NoCollapse |
        ig.ImGuiWindowFlags_NoDecoration |
        ig.ImGuiWindowFlags_NoDocking |
        ig.ImGuiWindowFlags_NoMove |
        ig.ImGuiWindowFlags_NoResize |
        ig.ImGuiWindowFlags_NoScrollbar |
        ig.ImGuiWindowFlags_NoTitleBar |
        ig.ImGuiWindowFlags_NoNavFocus |
        ig.ImGuiWindowFlags_NoBackground |
        ig.ImGuiWindowFlags_NoFocusOnAppearing |
        ig.ImGuiWindowFlags_NoMouseInputs |
        ig.ImGuiWindowFlags_NoInputs |
        ig.ImGuiWindowFlags_NoBringToFrontOnFocus;

    var mainView = ig.igGetMainViewport();

    var pos: ig.ImVec2 = mainView.*.WorkPos;
    var size: ig.ImVec2 = mainView.*.WorkSize;

    ig.igSetNextWindowPos(pos, ig.ImGuiCond_Always, .{});
    ig.igSetNextWindowSize(size, ig.ImGuiCond_Always);

    ig.igPushStyleVar_Vec2(ig.ImGuiStyleVar_WindowPadding, .{});
    _ = ig.igBegin("###DockSpace", null, windowFlags);
    var id = ig.igGetID_Str("DefaultDockingViewport");
    _ = ig.igDockSpace(id, .{}, dockNodeFlags, ig.ImGuiWindowClass_ImGuiWindowClass());

    ig.igEnd();
    ig.igPopStyleVar(1);

    return id;
}

/// Give a label and a pointer to any basic type that isnt a pointer
/// and reroute will generate a single entry editor for it. Returns true
/// if the value changed.
pub fn input(label: []const u8, ptr: anytype, params: InputParams) bool {
    const T = @TypeOf(ptr.*);
    const Info = @typeInfo(T);
    // Early outs for specific types
    const fmax = std.math.f32_max;
    switch(T) {
        []const u8 => {

        },
        math.Vec2 => {
            var temp: [2]f32 = .{ ptr.*.x, ptr.*.y };
            var result = ig.igDragFloat2(label.ptr, &temp, params.step, -fmax, fmax, "%.2f", ig.ImGuiSliderFlags_NoRoundToFormat);
            if (result) {
                ptr.* = math.Vec2.new(temp[0], temp[1]);
            }
            return result;
        },
        math.Vec3 => {
            var temp: [3]f32 = .{ ptr.*.x, ptr.*.y, ptr.*.z };
            var result = ig.igDragFloat3(label.ptr, &temp, params.step, -fmax, fmax, "%.2f", ig.ImGuiSliderFlags_NoRoundToFormat);
            if (result) {
                ptr.* = math.Vec3.new(temp[0], temp[1], temp[2]);
            }
            return result;
        },
        math.Vec4 => {
            var temp: [4]f32 = .{ ptr.*.x, ptr.*.y, ptr.*.z, ptr.*.w };
            var result = ig.igColorEdit4(label.ptr, &temp, ig.ImGuiColorEditFlags_Float);
            if (result) {
                ptr.* = math.Vec4.new(temp[0], temp[1], temp[2], temp[3]);
            }
            return result;
        },
        else => {}
    }

    switch(Info) {
        .Int =>  {
            const max = std.math.min(std.math.maxInt(c_int), std.math.maxInt(T));
            const min = if(Info.Int.signedness == .signed) -max else 0;
            var temp = @intCast(c_int, ptr.*);
            var changed:bool = undefined;
            if(params.preferDragInput) {
                changed = ig.igDragInt(label.ptr, &temp, params.step*0.5,min,max,"%i",ig.ImGuiSliderFlags_NoRoundToFormat);
            } else {
                changed = ig.igInputInt(label.ptr, &temp, @floatToInt(c_int, params.step), @floatToInt(c_int, params.step)*5, params.toInputTextFlags());
            }
            if(changed) {
                ptr.* = @intCast(T, temp);
            }
            return changed;
        },
        .Bool => {
            return ig.igCheckbox(label.ptr, ptr);
        },
        .Float => {
            const max = std.math.f32_max;
            const min = -max;
            var temp = @floatCast(f32, ptr.*);
            var changed:bool = undefined;
            if(params.preferDragInput) {
                changed = ig.igDragFloat(label.ptr, &temp, params.step,min,max,"%.2f",ig.ImGuiSliderFlags_NoRoundToFormat);
            } else {
                changed = ig.igInputFloat(label.ptr, &temp, params.step, params.step*5, "%.2f", params.toInputTextFlags());
            }
            if(changed) {
                ptr.* = @floatCast(T, temp);
            }
            return changed;
        },
        .Enum => {
            var changed: bool = false;
            var integer = @enumToInt(ptr.*);
            if (ig.igBeginCombo(label.ptr, @tagName(ptr.*).ptr, ig.ImGuiComboFlags_None)) {
                inline for (Info.Enum.fields) |enumField, i| {
                    //label: [*c]const u8, selected: bool, flags: ImGuiSelectableFlags, size: ImVec2
                    if (ig.igSelectable_Bool(enumField.name.ptr, i == integer, ig.ImGuiSelectableFlags_None, .{})) {
                        ptr.* = @intToEnum(@TypeOf(ptr.*), i);
                        changed = true;
                    }
                }
                ig.igEndCombo();
            }
            return changed;
        },
        .Optional => {
            if (ptr.* == null) {
                textDisabled("{s} (null)", .{label});
                return false;
            } else {
                return input(label, &ptr.*.?, params);
            }
        },
        .Array => {
            if (Info.Array.child == u8 and Info.Array.sentinel != null) {
                return ig.igInputText(label.ptr, ptr, @intCast(usize, Info.Array.len), ig.ImGuiInputTextFlags_None, null, null);
            } else {
                @compileError(@typeName(T) ++ ": This type cannot be edited as a string due to the lack of a sentinel.");
            }
        },
        .Pointer, .Opaque => {
            @compileError(@typeName(T) ++ " cannot be edited automatically by `imgui.components.input`");
        },
        else => {
            return false;
        }
    }
}
/// Things you allocate with this do not need to be freed.
pub fn format(comptime fmt: []const u8, params: anytype) []const u8 {
    return std.fmt.allocPrint(mem.RingBuffer, fmt, params) catch unreachable;
}
/// Shows the imgui demo window
pub fn demo() void {
    ig.igShowDemoWindow(null);
}
/// Outputs an `igText` via zig formatting.
pub fn text(comptime fmt: []const u8, params: anytype) void {
    var igt = std.fmt.allocPrint(mem.RingBuffer, fmt, params) catch unreachable;
    ig.igText(igt.ptr);
}
pub fn button(comptime fmt: []const u8, params: anytype) bool {
    var igt = std.fmt.allocPrint(mem.RingBuffer, fmt, params) catch unreachable;
    return ig.igButton(igt.ptr, .{});
}
/// Outputs an `igTextDisabled` via zig formatting.
pub fn textDisabled(comptime fmt: []const u8, params: anytype) void {
    var igt = std.fmt.allocPrint(mem.RingBuffer, fmt, params) catch unreachable;
    ig.igTextDisabled(igt.ptr);
}
/// Outputs an `igTextWrapped` via zig formatting.
pub fn textWrapped(comptime fmt: []const u8, params: anytype) void {
    var igt = std.fmt.allocPrint(mem.RingBuffer, fmt, params) catch unreachable;
    ig.igTextWrapped(igt.ptr);
}
/// Outputs an `igTextColored` via zig formatting.
pub fn textColored(comptime fmt: []const u8, params: anytype, color:math.Vec4) void {
    var igt = std.fmt.allocPrint(mem.RingBuffer, fmt, params) catch unreachable;
    ig.igTextColored(color, igt.ptr);
}
pub fn beginWindow(name: []const u8, params: WindowParams) bool {
    return ig.igBegin(name.ptr, params.openPtr, params.constructFlags());
}
pub fn endWindow() void {
    ig.igEnd();
}
/// Call this directly after an imgui component, and this will return true if you can
/// follow this up with some more imgui components to place inside the tooltip.
/// Make sure to end with `endTooltip()` inside of the if block.
pub fn beginTooltip() bool {
    if(ig.igIsItemHovered(ig.ImGuiHoveredFlags_None)) {
        ig.igBeginTooltip();
        return true;
    }
    return false;
}
pub fn endTooltip() void {
    ig.igEndTooltip();
}

/// Outputs a "?" on the same line, and adds the formatted string to a tooltip
/// for hovering over it
pub fn help(comptime fmt: []const u8, params: anytype) void {
    ig.igSameLine(0, 3);
    ig.igTextDisabled("?");
    if(beginTooltip()) {
        text(fmt, params);
        endTooltip();
    }
}