const zt = @import("deps/ZT/src/zt.zig");
const std = @import("std");
const sling = @import("sling.zig");

const ig = @import("imgui");
const glfw = @import("glfw");

pub var worldMouseDelta: sling.math.Vec2 = .{};
pub var worldMouse: sling.math.Vec2 = .{};
pub var mouse: sling.math.Vec2 = .{};
pub var mouseDelta: sling.math.Vec2 = .{};
pub var mwheel: f32 = 0;

var io: [*c]ig.ImGuiIO = undefined;

pub var config: struct {
    /// If true, mouse input is stopped when hovering over an imgui panel,
    /// and key input is halted when entering text.
    imguiBlocksInput: bool = true,
} = .{};

pub const Key = enum(c_int) {
    // Mouse
    lmb = glfw.GLFW_MOUSE_BUTTON_LEFT,
    rmb = glfw.GLFW_MOUSE_BUTTON_RIGHT,
    mmb = glfw.GLFW_MOUSE_BUTTON_MIDDLE,

    // Mods
    lCtrl = glfw.GLFW_KEY_LEFT_CONTROL,
    rCtrl = glfw.GLFW_KEY_RIGHT_CONTROL,
    lAlt = glfw.GLFW_KEY_LEFT_ALT,
    rAlt = glfw.GLFW_KEY_RIGHT_ALT,
    lShift = glfw.GLFW_KEY_LEFT_SHIFT,
    rShift = glfw.GLFW_KEY_RIGHT_SHIFT,

    // Special
    capslock = glfw.GLFW_KEY_CAPS_LOCK,
    tilde = glfw.GLFW_KEY_GRAVE_ACCENT,
    backslash = glfw.GLFW_KEY_BACKSLASH,
    forwardslash = glfw.GLFW_KEY_SLASH,
    backspace = glfw.GLFW_KEY_BACKSPACE,
    tab = glfw.GLFW_KEY_TAB,
    escape = glfw.GLFW_KEY_ESCAPE,
    comma = glfw.GLFW_KEY_COMMA,
    period = glfw.GLFW_KEY_PERIOD,
    semicolon = glfw.GLFW_KEY_SEMICOLON,
    openBracket = glfw.GLFW_KEY_LEFT_BRACKET,
    closeBracket = glfw.GLFW_KEY_RIGHT_BRACKET,
    apostraphe = glfw.GLFW_KEY_APOSTROPHE,
    space = glfw.GLFW_KEY_SPACE,
    enter = glfw.GLFW_KEY_ENTER,

    // Arrows
    arrowUp = glfw.GLFW_KEY_UP,
    arrowDown = glfw.GLFW_KEY_DOWN,
    arrowLeft = glfw.GLFW_KEY_LEFT,
    arrowRight = glfw.GLFW_KEY_RIGHT,

    // F Keys
    f1_ = glfw.GLFW_KEY_F1,
    f2_ = glfw.GLFW_KEY_F2,
    f3_ = glfw.GLFW_KEY_F3,
    f4_ = glfw.GLFW_KEY_F4,
    f5_ = glfw.GLFW_KEY_F5,
    f6_ = glfw.GLFW_KEY_F6,
    f7_ = glfw.GLFW_KEY_F7,
    f8_ = glfw.GLFW_KEY_F8,
    f9_ = glfw.GLFW_KEY_F9,
    f10_ = glfw.GLFW_KEY_F10,
    f11_ = glfw.GLFW_KEY_F11,
    f12_ = glfw.GLFW_KEY_F12,
    f13_ = glfw.GLFW_KEY_F13,
    f14_ = glfw.GLFW_KEY_F14,
    f15_ = glfw.GLFW_KEY_F15,
    f16_ = glfw.GLFW_KEY_F16,
    f17_ = glfw.GLFW_KEY_F17,
    f18_ = glfw.GLFW_KEY_F18,
    f19_ = glfw.GLFW_KEY_F19,
    f20_ = glfw.GLFW_KEY_F20,
    f21_ = glfw.GLFW_KEY_F21,
    f22_ = glfw.GLFW_KEY_F22,
    f23_ = glfw.GLFW_KEY_F23,
    f24_ = glfw.GLFW_KEY_F24,
    f25_ = glfw.GLFW_KEY_F25,

    // Numeric
    n1 = glfw.GLFW_KEY_1,
    n2 = glfw.GLFW_KEY_2,
    n3 = glfw.GLFW_KEY_3,
    n4 = glfw.GLFW_KEY_4,
    n5 = glfw.GLFW_KEY_5,
    n6 = glfw.GLFW_KEY_6,
    n7 = glfw.GLFW_KEY_7,
    n8 = glfw.GLFW_KEY_8,
    n9 = glfw.GLFW_KEY_9,
    n0 = glfw.GLFW_KEY_0,
    minus = glfw.GLFW_KEY_MINUS,
    equals = glfw.GLFW_KEY_EQUAL,

    // Alpha
    q = glfw.GLFW_KEY_Q,
    w = glfw.GLFW_KEY_W,
    e = glfw.GLFW_KEY_E,
    r = glfw.GLFW_KEY_R,
    t = glfw.GLFW_KEY_T,
    y = glfw.GLFW_KEY_Y,
    u = glfw.GLFW_KEY_U,
    i = glfw.GLFW_KEY_I,
    o = glfw.GLFW_KEY_O,
    p = glfw.GLFW_KEY_P,
    a = glfw.GLFW_KEY_A,
    s = glfw.GLFW_KEY_S,
    d = glfw.GLFW_KEY_D,
    f = glfw.GLFW_KEY_F,
    g = glfw.GLFW_KEY_G,
    h = glfw.GLFW_KEY_H,
    j = glfw.GLFW_KEY_J,
    k = glfw.GLFW_KEY_K,
    l = glfw.GLFW_KEY_L,
    z = glfw.GLFW_KEY_Z,
    x = glfw.GLFW_KEY_X,
    c = glfw.GLFW_KEY_C,
    v = glfw.GLFW_KEY_V,
    b = glfw.GLFW_KEY_B,
    n = glfw.GLFW_KEY_N,
    m = glfw.GLFW_KEY_M,

    inline fn keyCheck(key: Key) bool {
        if (key.isMouse()) {
            if (config.imguiBlocksInput and io.*.WantCaptureMouse) {
                return false;
            }
            return io.*.MouseDown[@intCast(usize, @enumToInt(key))];
        } else {
            if (config.imguiBlocksInput and io.*.WantCaptureKeyboard) {
                return false;
            }
            return io.*.KeysDown[@intCast(usize, @enumToInt(key))];
        }
    }
    inline fn keyDur(key: Key) f32 {
        if (key.isMouse()) {
            if (config.imguiBlocksInput and io.*.WantCaptureMouse) {
                return 0.0;
            }
            return io.*.MouseDownDuration[@intCast(usize, @enumToInt(key))];
        } else {
            if (config.imguiBlocksInput and io.*.WantCaptureKeyboard) {
                return 0.0;
            }
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
    if (config.imguiBlocksInput and io.*.WantCaptureMouse) {
        mwheel = 0;
    } else {
        mwheel = io.*.MouseWheel;
    }
    prevWorldMouse = worldMouse;
}
