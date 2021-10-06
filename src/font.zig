const std = @import("std");
const sling = @import("sling.zig");
const Font = @This();

// I'm sorry about the code youre about to read
// please take solace in the fact that is only run once
// on load. I will rewrite more zig-like later, and support more
// formats.

pub const Information = struct {
    name: []const u8,
    fontSize: f32,
    lineHeight: f32,
    bold: bool,
    italic: bool,
    atlasSize: sling.math.Vec2,
};
pub const Page = struct {
    texture: usize = undefined,
};
pub const Character = struct {
    atlas: usize,
    atlasSourceRect: sling.math.Rect,
    offset: sling.math.Vec2,
    advance: f32,
};

information: Information = undefined,
pages: std.ArrayList(usize) = std.ArrayList(usize).init(sling.alloc),
characters: std.AutoHashMap(u8, Character) = std.AutoHashMap(u8, Character).init(sling.alloc),

/// Provide root as the base folder, for loading the accompanying pngs.
pub fn loadBmFontAscii(bytes: []const u8, root: []const u8) Font {
    var self: Font = .{};
    var tokens = std.mem.tokenize(u8, bytes, "\n\r ");
    var consumingChars: ?usize = null;
    var dictionary = std.StringHashMap([]const u8).init(sling.alloc);
    var chars = std.ArrayList(std.StringHashMap([]const u8)).init(sling.alloc);
    while (tokens.next()) |token| {
        if (std.mem.eql(u8, token, "char")) {
            if (consumingChars == null) {
                consumingChars = 0;
            } else {
                consumingChars.? += 1;
            }
            chars.append(std.StringHashMap([]const u8).init(sling.alloc)) catch unreachable;
            continue;
        }
        if (std.mem.containsAtLeast(u8, token, 1, "=")) {
            var tag: []const u8 = undefined;
            var value: []const u8 = undefined;
            for (token) |char, i| {
                if (char == '=') {
                    tag = token[0..i];
                    value = token[i + 1 ..];
                    break;
                }
            }
            if (std.mem.eql(u8, tag, "file")) {
                var texturePath = std.fs.path.joinZ(sling.alloc, &[_][]const u8{ root, std.mem.trim(u8, value, "\"") }) catch unreachable;
                self.pages.append(sling.asset.ensure(sling.asset.Texture, texturePath)) catch unreachable;
                continue;
            }
            if (consumingChars) |charInd| {
                chars.items[charInd].put(tag, value) catch unreachable;
            } else {
                dictionary.put(tag, value) catch unreachable;
            }
        }
    }
    self.rawParseToFont(&dictionary, &chars);

    return self;
}

fn rawParseToFont(self: *Font, meta: *std.StringHashMap([]const u8), chars: *std.ArrayList(std.StringHashMap([]const u8))) void {
    defer meta.deinit();
    defer chars.deinit();

    if (meta.get("face")) |face| {
        self.information.name = sling.alloc.dupeZ(u8, std.mem.trim(u8, face, "\"")) catch unreachable;
    }
    if (meta.get("size")) |size| {
        self.information.fontSize = parseToFloat(size);
    }
    if (meta.get("scaleW")) |size| {
        self.information.atlasSize.x = parseToFloat(size);
    }
    if (meta.get("scaleH")) |size| {
        self.information.atlasSize.y = parseToFloat(size);
    }
    if (meta.get("bold")) |val| {
        self.information.bold = parseToBool(val);
    }
    if (meta.get("italic")) |val| {
        self.information.italic = parseToBool(val);
    }
    if (meta.get("lineHeight")) |val| {
        self.information.lineHeight = parseToFloat(val);
    }

    for (chars.items) |dict| {
        var char: Character = undefined;
        var id = std.fmt.parseUnsigned(u32, dict.get("id").?, 10) catch unreachable;
        // todo, advanced unicode points:
        if (id >= std.math.maxInt(u8)) {
            continue;
        }
        if (dict.get("page")) |val| {
            char.atlas = std.fmt.parseInt(usize, val, 10) catch unreachable;
        }
        if (dict.get("x")) |val| {
            char.atlasSourceRect.position.x = parseToFloat(val);
        }
        if (dict.get("y")) |val| {
            char.atlasSourceRect.position.y = parseToFloat(val);
        }
        if (dict.get("width")) |val| {
            char.atlasSourceRect.size.x = parseToFloat(val);
        }
        if (dict.get("height")) |val| {
            char.atlasSourceRect.size.y = parseToFloat(val);
        }
        if (dict.get("xoffset")) |val| {
            char.offset.x = parseToFloat(val);
        }
        if (dict.get("yoffset")) |val| {
            char.offset.y = parseToFloat(val);
        }
        if (dict.get("xadvance")) |val| {
            char.advance = parseToFloat(val);
        }
        self.characters.put(@intCast(u8, id), char) catch unreachable;
    }
}

fn parseToFloat(value: []const u8) f32 {
    if (std.mem.containsAtLeast(u8, value, 1, ".")) {
        return std.fmt.parseFloat(f32, value) catch unreachable;
    } else {
        return @intToFloat(f32, std.fmt.parseInt(i32, value, 10) catch {
            std.debug.panic("Failed to parse {s}", .{value});
        });
    }
}
fn parseToBool(value: []const u8) bool {
    if (std.mem.eql(u8, value, "1") or std.mem.eql(u8, value, "true")) {
        return true;
    }
    return false;
}

pub fn loadBmFontAsciiPath(path: []const u8) Font {
    var bytes = std.fs.cwd().readFileAlloc(sling.alloc, path, 10_000_000) catch unreachable;
    defer sling.alloc.free(bytes);
    var root = std.fs.path.dirname(path).?;
    return loadBmFontAscii(bytes, root);
}
