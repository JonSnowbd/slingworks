const zt = @import("deps/ZT/src/zt.zig");
const std = @import("std");
const sling = @import("sling.zig");

const ig = @import("deps/ZT/src/pkg/imgui.zig");
const gl = @import("deps/ZT/src/pkg/gl.zig");

const Self = @This();
pub const Space = enum { screen, world };
pub const Patch = struct {
    subRect: sling.math.Rect = .{},
    left: f32 = 0,
    top: f32 = 0,
    right: f32 = 0,
    bottom: f32 = 0,
};
const SortingContext = struct {
    // ???
};
pub const Depth = union(enum) {
    YSorted: YSorted,
    Regular: f32,

    pub fn initY(y: f32, depth: f32) Depth {
        return .{ .YSorted = .{
            .depth = depth,
            .y = y,
        } };
    }
    pub fn init(depth: f32) Depth {
        return .{ .Regular = depth };
    }
    pub fn higher(self: Depth, amount: f32) Depth {
        switch (self) {
            .YSorted => {
                return initY(self.YSorted.y, self.YSorted.depth - amount);
            },
            .Regular => {
                return self.Regular - amount;
            },
        }
    }
    pub fn lower(self: Depth, amount: f32) Depth {
        return self.higher(-amount);
    }
    pub fn getDepth(self: Depth) f32 {
        switch (self) {
            .YSorted => return self.YSorted.depth,
            .Regular => return self.Regular,
        }
    }

    pub const YSorted = struct { depth: f32, y: f32 };
};
pub const RenderRequestData = union(enum) {
    Texture: Texture,
    Quad: Quad,
    Line: Line,
    Circle: Circle,
    Rectangle: Rectangle,
    pub const Texture = struct {
        position: sling.math.Vec2,
        targetTexture: usize,
        tint: sling.math.Vec4,
        source: ?sling.math.Rect,
        size: sling.math.Vec2,
    };
    pub const Quad = struct {
        verts: [4]sling.Vertex,
        targetTexture: usize,
        tint: sling.math.Vec4,
    };
    pub const Line = struct {
        from: sling.math.Vec2,
        to: sling.math.Vec2,
        width: f32,
        colorFrom: sling.math.Vec4,
        colorTo: sling.math.Vec4,
    };
    pub const Circle = struct {
        position: sling.math.Vec2,
        radius: f32,
        color: sling.math.Vec4,
    };
    pub const Rectangle = struct {
        value: sling.math.Rect,
        thickness: f32,
        color: sling.math.Vec4,
    };
};
pub const RenderRequest = struct {
    depth: Depth,
    shader: ?sling.Shader = null,
    data: RenderRequestData,
};

fn sort(context: SortingContext, lhs: RenderRequest, rhs: RenderRequest) bool {
    _ = context;
    const ldep = lhs.depth.getDepth();
    const rdep = rhs.depth.getDepth();

    if (ldep != rdep) {
        return ldep > rdep;
    }

    if (lhs.depth == .YSorted and rhs.depth == .YSorted) {
        return lhs.depth.YSorted.y < rhs.depth.YSorted.y;
    }

    if (lhs.data == .Texture and rhs.data == .Texture) {
        return lhs.data.Texture.targetTexture > rhs.data.Texture.targetTexture;
    }

    return ldep > rdep;
}

pub var SortingBehaviour: SortingContext = .{};

worldRequests: std.ArrayList(RenderRequest) = sling.types.alloc,
screenRequests: std.ArrayList(RenderRequest),
renderer: zt.game.Renderer,
whitePixelTex: sling.asset.Texture,
debugDepth: Depth = Depth.init(-300_000),
camera: sling.Camera = .{},
currentShader: ?sling.Shader = null,

pub fn init() Self {
    var pixel: sling.asset.Texture = .{
        .internal = zt.gl.Texture.initBlank(1, 1),
    };
    pixel.whitePixel = zt.math.rect(0, 0, 1, 1);
    pixel.internal.bind();
    var white = [_]u8{ 255, 255, 255 };
    gl.glTexImage2D(gl.GL_TEXTURE_2D, 0, gl.GL_RGB, 1, 1, 0, gl.GL_RGB, gl.GL_UNSIGNED_BYTE, &white);
    pixel.internal.unbind();
    return .{
        .worldRequests = std.ArrayList(RenderRequest).init(std.heap.c_allocator),
        .screenRequests = std.ArrayList(RenderRequest).init(std.heap.c_allocator),
        .renderer = zt.game.Renderer.init(),
        .whitePixelTex = pixel,
    };
}

pub fn flush(self: *Self) void {
    self.camera.recalc();

    // World
    self.renderer.projectionMatrix = self.camera.projectionMatrix;
    self.renderer.viewMatrix = self.camera.viewMatrix;
    self.flushBuffer(&self.worldRequests);

    // Screen
    if (self.screenRequests.items.len > 0) {
        self.renderer.viewMatrix = sling.math.Mat4.identity;
        self.flushBuffer(&self.screenRequests);
    }

    // Clear
    self.worldRequests.clearRetainingCapacity();
    self.screenRequests.clearRetainingCapacity();
}

fn flushBuffer(self: *Self, target: *std.ArrayList(RenderRequest)) void {
    var lastTexture: ?*sling.asset.Texture = &self.whitePixelTex;
    var lastShader: ?sling.Shader = null;

    std.sort.sort(RenderRequest, target.items, SortingBehaviour, sort);
    for (target.items) |*req| {

        // Sort shader before hand.
        if (req.shader) |shd| {
            if (lastShader) |lshd| {
                if (lshd.id != shd.id) {
                    self.renderer.flush();
                    lastShader = req.shader;
                    self.renderer.updateShader(&(req.shader.?));
                }
            } else {
                self.renderer.flush();
                lastShader = req.shader;
                self.renderer.updateShader(&(req.shader.?));
            }
        } else {
            if (lastShader != null) {
                self.renderer.flush();
                lastShader = req.shader;
                self.renderer.updateShader(null);
            }
        }

        switch (req.data) {
            .Texture => {
                var tex: *sling.asset.Texture = sling.asset.get(sling.asset.Texture, req.data.Texture.targetTexture);
                var src: sling.math.Rect = undefined;
                if (req.data.Texture.source) |sourceValue| {
                    src = sourceValue;
                } else {
                    src = sling.math.rect(0, 0, tex.internal.width, tex.internal.height);
                }
                self.renderer.sprite(tex.*.internal, req.data.Texture.position, 0.5, req.data.Texture.size, req.data.Texture.tint, null, src);
                lastTexture = tex;
            },
            .Quad => {
                var tex: *sling.asset.Texture = sling.asset.get(sling.asset.Texture, req.data.Quad.targetTexture);

                var verts = req.data.Quad.verts;
                for (verts) |*vertex| {
                    vertex.tex = vertex.tex.div(.{ .x = tex.internal.width, .y = tex.internal.height });
                }
                self.renderer.spriteManual(tex.*.internal, verts[0], verts[1], verts[2], verts[3]);
                lastTexture = tex;
            },
            .Rectangle => {
                var tex: *sling.asset.Texture = undefined;
                var src: sling.math.Rect = undefined;
                if (lastTexture != null and lastTexture.?.whitePixel != null) {
                    tex = lastTexture.?;
                    src = lastTexture.?.whitePixel.?;
                } else {
                    tex = &self.whitePixelTex;
                    src = sling.math.rect(0, 0, tex.internal.width, tex.internal.height);
                    lastTexture = &self.whitePixelTex;
                }
                if (req.data.Rectangle.thickness > 0) {
                    self.renderer.rectangleHollow(tex.internal, src, req.data.Rectangle.value, 0.5, req.data.Rectangle.thickness, req.data.Rectangle.color);
                } else {
                    self.renderer.sprite(tex.*.internal, req.data.Rectangle.value.position, 0.5, req.data.Rectangle.value.size, req.data.Rectangle.color, null, src);
                }
            },
            .Line => {
                var tex: *sling.asset.Texture = undefined;
                var src: sling.math.Rect = undefined;
                if (lastTexture != null and lastTexture.?.whitePixel != null) {
                    tex = lastTexture.?;
                    src = lastTexture.?.whitePixel.?;
                } else {
                    tex = &self.whitePixelTex;
                    src = sling.math.rect(0, 0, tex.internal.width, tex.internal.height);
                    lastTexture = &self.whitePixelTex;
                }
                self.renderer.line(tex.internal, src, req.data.Line.from, req.data.Line.to, 0.5, req.data.Line.width, req.data.Line.colorFrom, req.data.Line.colorTo);
            },
            .Circle => {
                var tex: *sling.asset.Texture = undefined;
                var src: sling.math.Rect = undefined;
                if (lastTexture != null and lastTexture.?.whitePixel != null) {
                    tex = lastTexture.?;
                    src = lastTexture.?.whitePixel.?;
                } else {
                    tex = &self.whitePixelTex;
                    src = sling.math.rect(0, 0, tex.internal.width, tex.internal.height);
                    lastTexture = &self.whitePixelTex;
                }
                self.renderer.circle(tex.internal, src, req.data.Circle.position, req.data.Circle.radius, 0.5, req.data.Circle.color);
            },
        }
    }
    self.renderer.flush();
}

pub fn createShader(self: *Self, content: [*:0]const u8) sling.Shader {
    _ = self;
    return zt.game.Renderer.createShader(content);
}
/// Sets the shader for the next render requests you submit. Make sure to `popShader`
/// when you're done with the shader.
pub fn pushShader(self: *Self, shader: sling.Shader) void {
    self.currentShader = shader;
}
/// Ends the current shader until you set a new one.
pub fn popShader(self: *Self) void {
    self.currentShader = null;
}

pub fn texture(self: *Self, space: Space, depth: Depth, textureId: usize, position: sling.math.Vec2, size: sling.math.Vec2, color: sling.math.Vec4, sourceRect: ?sling.math.Rect, originNormalized: ?sling.math.Vec2) void {
    var offset: sling.math.Vec2 = .{};
    if (originNormalized) |origin| {
        offset.x = -(size.x * origin.x);
        offset.y = -(size.y * origin.y);
    }
    var targetBuffer = if (space == .world) &self.worldRequests else &self.screenRequests;
    targetBuffer.append(.{ .depth = depth, .shader = self.currentShader, .data = .{ .Texture = .{
        .position = position.add(offset),
        .targetTexture = textureId,
        .tint = color,
        .source = sourceRect,
        .size = size,
    } } }) catch unreachable;
}

pub fn textureRotated(self: *Self, space: Space, depth: Depth, textureId: usize, position: sling.math.Vec2, size: sling.math.Vec2, radians: f32, color: sling.math.Vec4, sourceRect: ?sling.math.Rect, originNormalized: ?sling.math.Vec2) void {
    if (radians == 0) {
        self.texture(space, depth, textureId, position, size, color, sourceRect, originNormalized);
        return;
    }
    var rect = if (sourceRect == null) sling.math.rect(0, 0, 1, 1) else sourceRect.?;
    var offset: sling.math.Vec2 = .{};
    if (originNormalized) |origin| {
        offset.x = -(size.x * origin.x);
        offset.y = -(size.y * origin.y);
    }

    const positions: [4]sling.math.Vec2 = .{
        position.add(offset), // tl
        position.add(offset).add(.{ .x = size.x }), // tr
        position.add(offset).add(.{ .y = size.y }), // bl
        position.add(offset).add(size), // br
    };
    const textures: [4]sling.math.Vec2 = .{
        rect.position, // tl
        rect.position.add(.{ .x = rect.size.x }), // tr
        rect.position.add(.{ .y = rect.size.y }), // bl
        rect.position.add(rect.size), // br
    };
    var vertices: [4]sling.Vertex = undefined;

    for (positions) |target, i| {
        const cache = target.sub(position).rotate(radians).add(position);
        vertices[i] = .{
            .pos = sling.math.vec3(cache.x, cache.y, 0.5),
            .tex = textures[i],
            .col = color,
        };
    }
    self.quad(space, depth, textureId, vertices, color);
}

pub fn quad(self: *Self, space: Space, depth: Depth, textureId: usize, verts: [4]sling.Vertex, color: sling.math.Vec4) void {
    var targetBuffer = if (space == .world) &self.worldRequests else &self.screenRequests;
    targetBuffer.append(.{ .depth = depth, .shader = self.currentShader, .data = .{ .Quad = .{
        .verts = verts,
        .targetTexture = textureId,
        .tint = color,
    } } }) catch unreachable;
}

// todo make it scalable, and make it squish to fit smaller than smallest dimensions.
pub fn patch(self: *Self, space: Space, depth: Depth, patchInfo: Patch, textureId: usize, destination: sling.math.Rect, color: sling.math.Vec4) void {
    const dpos = destination.position;
    const dsiz = destination.size;
    const spos = patchInfo.subRect.position;
    const ssiz = patchInfo.subRect.size;

    // Corners
    const tl = sling.math.rect(dpos.x, dpos.y, patchInfo.left, patchInfo.top);
    const tls = sling.math.rect(spos.x, spos.y, patchInfo.left, patchInfo.top);
    const tr = sling.math.rect(dpos.x + dsiz.x - patchInfo.right, dpos.y, patchInfo.right, patchInfo.top);
    const trs = sling.math.rect(ssiz.x - patchInfo.right, spos.y, patchInfo.right, patchInfo.top);
    const bl = sling.math.rect(dpos.x, dpos.y + dsiz.y - patchInfo.bottom, patchInfo.left, patchInfo.bottom);
    const bls = sling.math.rect(spos.x, spos.y + ssiz.y - patchInfo.bottom, patchInfo.left, patchInfo.bottom);
    const br = sling.math.rect(dpos.x + dsiz.x - patchInfo.right, dpos.y + dsiz.y - patchInfo.bottom, patchInfo.right, patchInfo.bottom);
    const brs = sling.math.rect(spos.x + ssiz.x - patchInfo.right, spos.y + ssiz.y - patchInfo.bottom, patchInfo.right, patchInfo.bottom);

    self.texture(space, depth, textureId, tl.position, tl.size, color, tls, null);
    self.texture(space, depth, textureId, tr.position, tr.size, color, trs, null);
    self.texture(space, depth, textureId, bl.position, bl.size, color, bls, null);
    self.texture(space, depth, textureId, br.position, br.size, color, brs, null);

    // Checks for middle pieces.
    const tm = sling.math.rect(dpos.x + patchInfo.left, dpos.y, dsiz.x - patchInfo.left - patchInfo.right, patchInfo.top);
    if (tm.size.x > 0.0) {
        const tms = sling.math.rect(spos.x + patchInfo.left, spos.y, ssiz.x - patchInfo.left - patchInfo.right, patchInfo.top);
        self.texture(space, depth, textureId, tm.position, tm.size, color, tms, null);
    }
    const bm = sling.math.rect(dpos.x + patchInfo.left, dpos.y + dsiz.y - patchInfo.bottom, dsiz.x - patchInfo.left - patchInfo.right, patchInfo.bottom);
    if (tm.size.x > 0.0) {
        const bms = sling.math.rect(spos.x + patchInfo.left, spos.y + ssiz.y - patchInfo.bottom, ssiz.x - patchInfo.left - patchInfo.right, patchInfo.top);
        self.texture(space, depth, textureId, bm.position, bm.size, color, bms, null);
    }
    const ml = sling.math.rect(dpos.x, dpos.y + patchInfo.top, patchInfo.left, dsiz.y - patchInfo.top - patchInfo.bottom);
    if (ml.size.y > 0.0) {
        const mls = sling.math.rect(spos.x, spos.y + patchInfo.top, patchInfo.left, ssiz.y - patchInfo.top - patchInfo.bottom);
        self.texture(space, depth, textureId, ml.position, ml.size, color, mls, null);
    }
    const mr = sling.math.rect(dpos.x + dsiz.x - patchInfo.right, dpos.y + patchInfo.top, patchInfo.right, dsiz.y - patchInfo.top - patchInfo.bottom);
    if (ml.size.y > 0.0) {
        const mrs = sling.math.rect(spos.x + ssiz.x - patchInfo.right, spos.y + patchInfo.top, patchInfo.left, ssiz.y - patchInfo.top - patchInfo.bottom);
        self.texture(space, depth, textureId, mr.position, mr.size, color, mrs, null);
    }
    const m = sling.math.rect(dpos.x + patchInfo.left, dpos.y + patchInfo.top, dsiz.x - patchInfo.left - patchInfo.right, dsiz.y - patchInfo.top - patchInfo.bottom);
    if (ml.size.y > 0.0 and tm.size.x > 0.0) {
        const ms = sling.math.rect(spos.x + patchInfo.left, spos.y + patchInfo.top, ssiz.x - patchInfo.left - patchInfo.right, ssiz.y - patchInfo.top - patchInfo.bottom);
        self.texture(space, depth, textureId, m.position, m.size, color, ms, null);
    }
}

/// If thickness is null, this is a filled rectangle, otherwise thickness denotes the size of the outlines.
pub fn rectangle(self: *Self, space: Space, depth: Depth, rect: sling.math.Rect, color: sling.math.Vec4, thickness: ?f32) void {
    var targetBuffer = if (space == .world) &self.worldRequests else &self.screenRequests;
    targetBuffer.append(.{ .depth = depth, .shader = self.currentShader, .data = .{ .Rectangle = .{
        .value = rect,
        .thickness = if (thickness != null) thickness.? else -1,
        .color = color,
    } } }) catch unreachable;
}

pub fn text(self: *Self, space: Space, depth: Depth, fontId: usize, point: sling.math.Vec2, message: []const u8, color: sling.math.Vec4, originNormalized: ?sling.math.Vec2) void {
    var font = sling.asset.get(sling.asset.Font, fontId);
    var stamp: sling.math.Vec2 = point;
    var dests: []sling.math.Rect = sling.alloc.alloc(sling.math.Rect, message.len) catch unreachable;
    defer sling.alloc.free(dests);
    var fullRect: sling.math.Rect = .{
        .position=point,
        .size=.{.y=font.information.lineHeight}
    };
    for(message) |char, i| {
        if(char == '\n') {
            fullRect.size.y += font.information.lineHeight;
            stamp.x = point.x;
            stamp.y += font.information.lineHeight;
            continue;
        }
        if(font.characters.get(char)) |character| {
            dests[i] = sling.math.Rect{
                .size = character.atlasSourceRect.size,
                .position = .{
                    .x = stamp.x+character.offset.x,
                    .y = stamp.y+character.offset.y,
                }
            };
            stamp.x += character.advance;

            fullRect.size.x = std.math.max(fullRect.size.x, stamp.x-point.x);
        }
    }
    var offset = if(originNormalized == null) sling.math.Vec2{} else fullRect.size.mul(originNormalized.?);
    for(message) |char, i| {
        if(char == '\n') {
            continue;
        }
        if(font.characters.get(char)) |character| {
            const sourceRect = character.atlasSourceRect;
            const id = font.pages.items[character.atlas];
            const pos = dests[i].position.sub(offset);
            const siz = dests[i].size;
            self.texture(space, depth, id, pos, siz, color, sourceRect, null);
        }
    }
}

pub fn line(self: *Self, space: Space, depth: Depth, from: sling.math.Vec2, to: sling.math.Vec2, thickness: f32, color: sling.math.Vec4) void {
    var targetBuffer = if (space == .world) &self.worldRequests else &self.screenRequests;
    targetBuffer.append(.{ .depth = depth, .shader = self.currentShader, .data = .{ .Line = .{
        .from = from,
        .to = to,
        .width = thickness,
        .colorFrom = color,
        .colorTo = color,
    } } }) catch unreachable;
}

pub fn circle(self: *Self, space: Space, depth: Depth, point: sling.math.Vec2, radius: f32, color: sling.math.Vec4) void {
    var targetBuffer = if (space == .world) &self.worldRequests else &self.screenRequests;
    targetBuffer.append(.{ .depth = depth, .shader = self.currentShader, .data = .{ .Circle = .{
        .position = point,
        .radius = radius,
        .color = color,
    } } }) catch unreachable;
}
