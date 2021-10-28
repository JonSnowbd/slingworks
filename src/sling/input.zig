const std = @import("std");
const sling = @import("../main.zig");
const ig = sling.package.imgui;
const sapp = sling.package.sokol.app;

pub var worldMouseDelta: sling.math.Vec2 = .{};
pub var worldMouse: sling.math.Vec2 = .{};
pub var mouse: sling.math.Vec2 = .{};
pub var mouseDelta: sling.math.Vec2 = .{};
pub var mwheel: f32 = 0;

var io: [*c]ig.ImGuiIO = undefined;

pub const Key = enum(i32) {
    // Mouse
    lmb = @enumToInt(sapp.Mousebutton.LEFT),
    rmb = @enumToInt(sapp.Mousebutton.RIGHT),
    mmb = @enumToInt(sapp.Mousebutton.MIDDLE),

    // Mods
    lCtrl = @enumToInt(sapp.Keycode.LEFT_CONTROL),
    rCtrl = @enumToInt(sapp.Keycode.RIGHT_CONTROL),
    lAlt = @enumToInt(sapp.Keycode.LEFT_ALT),
    rAlt = @enumToInt(sapp.Keycode.RIGHT_ALT),
    lShift = @enumToInt(sapp.Keycode.LEFT_SHIFT),
    rShift = @enumToInt(sapp.Keycode.RIGHT_SHIFT),

    // Special
    capslock = @enumToInt(sapp.Keycode.CAPS_LOCK),
    tilde = @enumToInt(sapp.Keycode.GRAVE_ACCENT),
    backslash = @enumToInt(sapp.Keycode.BACKSLASH),
    forwardslash = @enumToInt(sapp.Keycode.SLASH),
    backspace = @enumToInt(sapp.Keycode.BACKSPACE),
    tab = @enumToInt(sapp.Keycode.TAB),
    escape = @enumToInt(sapp.Keycode.ESCAPE),
    comma = @enumToInt(sapp.Keycode.COMMA),
    period = @enumToInt(sapp.Keycode.PERIOD),
    semicolon = @enumToInt(sapp.Keycode.SEMICOLON),
    openBracket = @enumToInt(sapp.Keycode.LEFT_BRACKET),
    closeBracket = @enumToInt(sapp.Keycode.RIGHT_BRACKET),
    apostraphe = @enumToInt(sapp.Keycode.APOSTROPHE),
    space = @enumToInt(sapp.Keycode.SPACE),
    enter = @enumToInt(sapp.Keycode.ENTER),

    // Arrows
    arrowUp = @enumToInt(sapp.Keycode.UP),
    arrowDown = @enumToInt(sapp.Keycode.DOWN),
    arrowLeft = @enumToInt(sapp.Keycode.LEFT),
    arrowRight = @enumToInt(sapp.Keycode.RIGHT),

    // F Keys
    F1 = @enumToInt(sapp.Keycode.F1),
    F2 = @enumToInt(sapp.Keycode.F2),
    F3 = @enumToInt(sapp.Keycode.F3),
    F4 = @enumToInt(sapp.Keycode.F4),
    F5 = @enumToInt(sapp.Keycode.F5),
    F6 = @enumToInt(sapp.Keycode.F6),
    F7 = @enumToInt(sapp.Keycode.F7),
    F8 = @enumToInt(sapp.Keycode.F8),
    F9 = @enumToInt(sapp.Keycode.F9),
    F10 = @enumToInt(sapp.Keycode.F10),
    F11 = @enumToInt(sapp.Keycode.F11),
    F12 = @enumToInt(sapp.Keycode.F12),
    F13 = @enumToInt(sapp.Keycode.F13),
    F14 = @enumToInt(sapp.Keycode.F14),
    F15 = @enumToInt(sapp.Keycode.F15),
    F16 = @enumToInt(sapp.Keycode.F16),
    F17 = @enumToInt(sapp.Keycode.F17),
    F18 = @enumToInt(sapp.Keycode.F18),
    F19 = @enumToInt(sapp.Keycode.F19),
    F20 = @enumToInt(sapp.Keycode.F20),
    F21 = @enumToInt(sapp.Keycode.F21),
    F22 = @enumToInt(sapp.Keycode.F22),
    F23 = @enumToInt(sapp.Keycode.F23),
    F24 = @enumToInt(sapp.Keycode.F24),
    F25 = @enumToInt(sapp.Keycode.F25),

    // Numeric
    n1 = @enumToInt(sapp.Keycode._1),
    n2 = @enumToInt(sapp.Keycode._2),
    n3 = @enumToInt(sapp.Keycode._3),
    n4 = @enumToInt(sapp.Keycode._4),
    n5 = @enumToInt(sapp.Keycode._5),
    n6 = @enumToInt(sapp.Keycode._6),
    n7 = @enumToInt(sapp.Keycode._7),
    n8 = @enumToInt(sapp.Keycode._8),
    n9 = @enumToInt(sapp.Keycode._9),
    n0 = @enumToInt(sapp.Keycode._0),
    minus = @enumToInt(sapp.Keycode.MINUS),
    equals = @enumToInt(sapp.Keycode.EQUAL),

    // Alpha
    q = @enumToInt(sapp.Keycode.Q),
    w = @enumToInt(sapp.Keycode.W),
    e = @enumToInt(sapp.Keycode.E),
    r = @enumToInt(sapp.Keycode.R),
    t = @enumToInt(sapp.Keycode.T),
    y = @enumToInt(sapp.Keycode.Y),
    u = @enumToInt(sapp.Keycode.U),
    i = @enumToInt(sapp.Keycode.I),
    o = @enumToInt(sapp.Keycode.O),
    p = @enumToInt(sapp.Keycode.P),
    a = @enumToInt(sapp.Keycode.A),
    s = @enumToInt(sapp.Keycode.S),
    d = @enumToInt(sapp.Keycode.D),
    f = @enumToInt(sapp.Keycode.F),
    g = @enumToInt(sapp.Keycode.G),
    h = @enumToInt(sapp.Keycode.H),
    j = @enumToInt(sapp.Keycode.J),
    k = @enumToInt(sapp.Keycode.K),
    l = @enumToInt(sapp.Keycode.L),
    z = @enumToInt(sapp.Keycode.Z),
    x = @enumToInt(sapp.Keycode.X),
    c = @enumToInt(sapp.Keycode.C),
    v = @enumToInt(sapp.Keycode.V),
    b = @enumToInt(sapp.Keycode.B),
    n = @enumToInt(sapp.Keycode.N),
    m = @enumToInt(sapp.Keycode.M),

    inline fn keyCheck(key: Key) bool {
        if (key.isMouse()) {
            return io.*.MouseDown[@intCast(usize, @enumToInt(key))];
        } else {
            return io.*.KeysDown[@intCast(usize, @enumToInt(key))];
        }
    }
    inline fn keyDur(key: Key) f32 {
        if (key.isMouse()) {
            return io.*.MouseDownDuration[@intCast(usize, @enumToInt(key))];
        } else {
            return io.*.KeysDownDuration[@intCast(usize, @enumToInt(key))];
        }
    }
    inline fn keyPrevDur(key: Key) f32 {
        if (key.isMouse()) {
            return io.*.MouseDownDurationPrev[@intCast(usize, @enumToInt(key))];
        } else {
            return io.*.KeysDownDurationPrev[@intCast(usize, @enumToInt(key))];
        }
    }

    /// True only for the frame it is pressed down.
    pub fn pressed(key: Key) bool {
        return keyDur(key) == 0;
    }
    /// True only for the frame it is released.
    pub fn released(key: Key) bool {
        return keyPrevDur(key) >= 0 and !keyCheck(key);
    }
    /// True when down, including when pressed.
    pub fn down(key: Key) bool {
        return keyCheck(key);
    }
    /// True when up, including when released
    pub fn up(key: Key) bool {
        return !down(key);
    }
    /// Inspects the key, if its a mouse button returns true.
    /// Does not inspect the state of the button, just what the button is.
    pub fn isMouse(key: Key) bool {
        return @enumToInt(key) >= 0 and @enumToInt(key) <= 2;
    }
    /// Inspects the key, if its a character key returns true.
    /// Does not inspect the state of the key, just what the key is.
    pub fn isAlpha(key: Key) bool {
        return @enumToInt(key) >= 65 and @enumToInt(key) <= 90;
    }
    /// Inspects the key, if its a character key returns true.
    /// Does not inspect the state of the key, just what the key is.
    pub fn isNumeric(key: Key) bool {
        return @enumToInt(key) >= 48 and @enumToInt(key) <= 57;
    }
};

var prevWorldMouse: sling.math.Vec2 = .{ .x = -1, .y = -1 };
pub fn pump() void {
    io = ig.igGetIO();
    mouse = io.*.MousePos;
    mouseDelta = io.*.MouseDelta;
    worldMouse = sling.render.camera.screenToWorld(mouse);
    if (prevWorldMouse.x == -1.0 and prevWorldMouse.y == -1.0) {
        prevWorldMouse = worldMouse;
    }
    worldMouseDelta = worldMouse.sub(prevWorldMouse);
    mwheel = io.*.MouseWheel;
    prevWorldMouse = worldMouse;
}
