const std = @import("std");
const serializer = @import("serializer.zig");

pub const JsonLexicon: serializer.Lexicon = .{ .convert = _jsonLexConv, .parse = _jsonLexParse };

fn _jsonLexConv(alloc: std.mem.Allocator, tree: *serializer.Tree) []const u8 {
    var bytes = std.ArrayList(u8).init(alloc);
    _jsonLexInner(tree.root, &bytes);
    return bytes.toOwnedSlice() catch unreachable;
}
fn _jsonLexInner(node: *serializer.Node, holder: *std.ArrayList(u8)) void {
    switch (node.data) {
        .Map => {
            holder.append('{') catch unreachable;
            var count = node.data.Map.count();
            var current: u32 = 0;
            var iter = node.data.Map.iterator();
            while (iter.next()) |innerNode| {
                holder.append('\"') catch unreachable;
                holder.appendSlice(innerNode.key_ptr.*) catch unreachable;
                holder.appendSlice("\":") catch unreachable;
                _jsonLexInner(innerNode.value_ptr.*, holder);

                if (current + 1 < count) {
                    holder.append(',') catch unreachable;
                }
                current += 1;
            }
            holder.append('}') catch unreachable;
        },
        .Literal => {
            switch (node.data.Literal) {
                .String => {
                    holder.append('\"') catch unreachable;
                    holder.appendSlice(node.data.Literal.String) catch unreachable;
                    holder.append('\"') catch unreachable;
                },
                .Integer => {
                    var cast = std.fmt.allocPrint(std.heap.page_allocator, "{any}", .{node.data.Literal.Integer}) catch unreachable;
                    defer std.heap.page_allocator.free(cast);
                    holder.appendSlice(cast) catch unreachable;
                },
                .Float => {
                    var cast = std.fmt.allocPrint(std.heap.page_allocator, "{d:.5}", .{node.data.Literal.Float}) catch unreachable;
                    defer node.tree.alloc.free(cast);
                    holder.appendSlice(cast) catch unreachable;
                },
                .Bool => {
                    if (node.data.Literal.Bool == true) {
                        holder.appendSlice("true") catch unreachable;
                    } else {
                        holder.appendSlice("false") catch unreachable;
                    }
                },
                .Null => {
                    holder.appendSlice("null") catch unreachable;
                },
            }
        },
        .Array => {
            holder.append('[') catch unreachable;
            for (node.data.Array.items) |innerNode, i| {
                _jsonLexInner(innerNode, holder);
                if (i + 1 < node.data.Array.items.len) {
                    holder.append(',') catch unreachable;
                }
            }
            holder.append(']') catch unreachable;
        },
    }
}
fn _jsonLexParse(allocator: std.mem.Allocator, bytes: []const u8) *serializer.Tree {
    return _jsonLexParseInner(allocator, bytes) catch |err| {
        std.debug.panic("FAILED TO SERIALIZE JSON:\n{s}\nERROR:{s}", .{ bytes, @errorName(err) });
    };
}
fn _jsonLexParseInner(allocator: std.mem.Allocator, bytes: []const u8) !*serializer.Tree {
    var tree: *serializer.Tree = serializer.Tree.initArena(allocator);

    var nodeStack = std.ArrayList(*serializer.Node).init(allocator);
    defer nodeStack.deinit();

    var tag: ?[]const u8 = null;

    var i: usize = 0;
    while (i < bytes.len) {
        switch (bytes[i]) {
            '{' => {
                var node = tree.newObject();
                if (nodeStack.items.len == 0) {
                    tree.root = node;
                } else {
                    var parent: *serializer.Node = nodeStack.items[nodeStack.items.len - 1];
                    parent.push(tag, node);
                    tag = null;
                }
                try nodeStack.append(node);
                i += 1;
            },
            '}' => {
                _ = nodeStack.pop();
                if (nodeStack.items.len == 0) {
                    break;
                }
                i += 1;
            },
            '[' => {
                var node = tree.newArray();
                if (nodeStack.items.len == 0) {
                    tree.root = node;
                } else {
                    var parent: *serializer.Node = nodeStack.items[nodeStack.items.len - 1];
                    parent.push(tag, node);
                    tag = null;
                }
                try nodeStack.append(node);
                i += 1;
            },
            ']' => {
                _ = nodeStack.pop();
                if (nodeStack.items.len == 0) {
                    break;
                }
                i += 1;
            },
            '"' => {
                var start = i + 1;
                var end = i + 1;
                while (true) {
                    if (bytes[end] == '"' and bytes[end - 1] != '\\') {
                        break;
                    }
                    end += 1;
                }
                var slice = bytes[start..end];

                if (bytes[end + 1] == ':') {
                    tag = slice;
                    i += (end - start) + 2;
                    continue;
                }

                std.debug.assert(nodeStack.items.len > 0);
                var parent = nodeStack.items[nodeStack.items.len - 1];
                var dupe: []const u8 = try tree.alloc.internal().dupeZ(u8, slice);
                var container = tree.newString(dupe);
                parent.push(tag, container);
                tag = null;

                i += (end - start) + 2;
            },
            't' => {
                if (bytes[i + 1] == 'r' and bytes[i + 2] == 'u' and bytes[i + 3] == 'e') {
                    var parent: *serializer.Node = nodeStack.items[nodeStack.items.len - 1];
                    parent.push(tag, true);
                    tag = null;

                    i += 4;
                } else {
                    i += 1;
                }
            },
            'f' => {
                if (bytes[i + 1] == 'a' and bytes[i + 2] == 'l' and bytes[i + 3] == 's' and bytes[i + 4] == 'e') {
                    var parent: *serializer.Node = nodeStack.items[nodeStack.items.len - 1];
                    parent.push(tag, false);
                    tag = null;

                    i += 5;
                } else {
                    i += 1;
                }
            },
            'n' => {
                if (bytes[i + 1] == 'u' and bytes[i + 2] == 'l' and bytes[i + 3] == 'l') {
                    var parent: *serializer.Node = nodeStack.items[nodeStack.items.len - 1];
                    parent.push(tag, null);
                    tag = null;

                    i += 4;
                } else {
                    i += 1;
                }
            },
            '-', 48...57 => {
                var start = i;
                var end = i + 1;
                var period: ?usize = null;
                while (true) {
                    if (bytes[end] == 46) {
                        period = end;
                        end += 1;
                        continue;
                    }
                    if (bytes[end] >= 48 and bytes[end] <= 57) {
                        end += 1;
                        continue;
                    } else {
                        break;
                    }
                }
                if (period) |_| {
                    var slice = bytes[start..end];
                    var parse = try std.fmt.parseFloat(f32, slice);
                    var parent: *serializer.Node = nodeStack.items[nodeStack.items.len - 1];
                    parent.push(tag, parse);
                    tag = null;
                } else {
                    var slice = bytes[start..end];
                    var parse = try std.fmt.parseInt(i32, slice, 0);
                    var parent: *serializer.Node = nodeStack.items[nodeStack.items.len - 1];
                    parent.push(tag, parse);
                    tag = null;
                }
                i += (end - start);
            },
            else => {
                i += 1;
                continue;
            },
        }
    }

    return tree;
}

test "json lex parse" {
    const sample =
        \\{"player":{"health":10.5,"mana":20,"lives":2,"names":["steven","paul"]}}
    ;
    var tree = JsonLexicon.parse(std.testing.allocator, sample);
    defer tree.deinit();

    var playerNode: *serializer.Node = tree.root.data.Map.get("player").?;
    var health = playerNode.data.Map.get("health").?;

    var healthValue: f32 = 0;
    health.into(&healthValue, null);

    var names = playerNode.data.Map.get("names").?.data.Array.items;

    try std.testing.expect(names.len == 2);
    try std.testing.expect(std.mem.eql(u8, names[0].data.Literal.String, "steven"));
    try std.testing.expect(std.mem.eql(u8, names[1].data.Literal.String, "paul"));

    try std.testing.expectEqual(@as(f32, 10.5), healthValue);
}

test "complex structure deserialize" {
    const structure = struct {
        const tagField = std.ArrayList([]const u8);
        const npcField = struct { name: []const u8, strength: i32, children: ?std.ArrayList([]const u8) };
        const townField = struct {
            name: []const u8,
            families: std.StringHashMap(familyField),
        };
        const familyField = struct {
            count: usize,
            notable_history: []const u8,
        };
        npc: []npcField,
        town: townField,
        tags: std.ArrayList(tagField),
    };
    const data = @embedFile("json/test_npc.json");

    var tree = JsonLexicon.parse(std.testing.allocator, std.mem.spanZ(data));
    defer tree.deinit();

    var value: structure = undefined;
    tree.root.into(&value, null);

    tree.print(JsonLexicon);
}
