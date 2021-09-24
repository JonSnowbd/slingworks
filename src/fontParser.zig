const std = @import("std");
const sling = @import("sling.zig");

pub const Font = struct {
    pub const Information = struct {
        name: []const u8,
        charset: []const u8,
        fontSize: f32,
        realSize: f32,
        bold: usize,
        italic: usize,
        stretchH: f32,
        padding: sling.math.Vec4,
        spacing: sling.math.Vec2,
        isSmooth: bool,
        isAntialiased: bool,
        isUnicode: bool,
        isPacked: bool,
        atlasSize: sling.math.Vec2,
    };
    pub const Page = struct {
        pub const Character = struct {
            id: usize,
            atlasSourceRect: sling.math.Rect,
            offset: sling.math.Vec2,
            advance: f32,
            letter: u8,
        };
    };

    information: Information,
    page: []Page,
    fontTexId: usize,
};

pub fn loadBmFontAscii(bytes: []const u8) Font {
    // todo
}
