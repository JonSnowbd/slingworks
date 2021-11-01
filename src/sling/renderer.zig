const std = @import("std");
const sling = @import("../main.zig");
const sg = sling.package.sokol.gfx;
const sapp = sling.package.sokol.app;

const Self = @This();
const Vert = struct { pos: sling.math.Vec2, uv: sling.math.Vec2, color: sling.math.Vec4 };
const RenderPipeline = sling.package.reroute.RenderPipeline(Vert, 65536);
const PipelineShader = @import("../reroute/shaders/imgui.glsl.zig");

pub const Space = enum { screen, world };
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
pub const RenderRequestData = struct {
    verts: [][4]Vert,
    targetTexture: usize,
};
pub const RenderRequest = struct {
    depth: Depth,
    data: RenderRequestData,
    const Context = struct { filler: u1 = 0 };
    fn sort(context: Context, lhs: RenderRequest, rhs: RenderRequest) bool {
        _ = context;
        const ldep = lhs.depth.getDepth();
        const rdep = rhs.depth.getDepth();

        if (ldep != rdep) {
            return ldep > rdep;
        }

        if (lhs.depth == .YSorted and rhs.depth == .YSorted) {
            return lhs.depth.YSorted.y < rhs.depth.YSorted.y;
        }

        return ldep > rdep;
    }
    pub fn getTexture(self: RenderRequest) usize {
        return self.data.targetTexture;
    }
};

fba: std.heap.FixedBufferAllocator,
camera: sling.Camera = .{},
worldRequests: std.ArrayList(RenderRequest) = std.ArrayList(RenderRequest).init(sling.mem.Allocator),
screenRequests: std.ArrayList(RenderRequest) = std.ArrayList(RenderRequest).init(sling.mem.Allocator),
pipeline: RenderPipeline,
pixelSnap: bool = true,
/// This value is reset on each frame, modifying it will do nothing
drawCalls: usize = 0,
whitePixelId: usize,

pub fn init() Self {
    // Create internal default pipeline
    // var customPipeline = sg.PipelineDesc{};
    // customPipeline.colors[0].write_mask = .RGB;
    // customPipeline.colors[0].blend.enabled = true;
    // customPipeline.colors[0].blend.src_factor_rgb = .SRC_ALPHA;
    // customPipeline.colors[0].blend.dst_factor_rgb = .ONE_MINUS_SRC_ALPHA;
    // customPipeline.depth = .{
    //     .write_enabled = false,
    //     .compare = .LESS_EQUAL,
    // };
    // customPipeline.index_type = .UINT16;
    // customPipeline.label = "StandardSlingRenderer";
    // customPipeline.cull_mode = sg.CullMode.DEFAULT;
    // Create image to represent a white pixel for primitives.
    var desc = sg.ImageDesc{
        .width = 1,
        .height = 1,
        .pixel_format = sg.PixelFormat.RGBA8,
        .min_filter = sg.Filter.NEAREST,
        .mag_filter = sg.Filter.NEAREST,
    };
    desc.data.subimage[0][0] = sg.asRange([_]sling.math.Vec4{sling.math.Vec4.new(1.0, 1.0, 1.0, 1.0)});
    var whitePix = sg.makeImage(desc);
    sling.logFmt("SLING: Uploaded image #{any} to the gpu. ({any}x{any})", .{ whitePix.id, desc.width, desc.height });

    var objDump = sling.asset.manualUpload(sling.Texture, whitePix);
    return .{
        .fba = std.heap.FixedBufferAllocator.init(sling.mem.Allocator.alloc(u8, 12_000_000) catch unreachable),
        .pipeline = RenderPipeline.init(sling.mem.Allocator, PipelineShader, "imgui"),
        .whitePixelId = objDump,
    };
}

/// This is called by sling itself, consider not touching this unless you know what you want from this.
/// If you need to call this for your game, let me know in an issue how I can make this more ergonomic.
pub fn finish(self: *Self) void {
    self.drawRequests(&self.worldRequests);
    self.drawRequests(&self.screenRequests);
    self.worldRequests.clearRetainingCapacity();
    self.screenRequests.clearRetainingCapacity();
    self.fba.reset();
    self.drawCalls = self.pipeline.drawCalls;
}

fn drawRequests(self: *Self, target: *std.ArrayList(RenderRequest)) void {
    if (target.items.len == 0) {
        return;
    }
    std.sort.sort(RenderRequest, target.items, RenderRequest.Context{}, RenderRequest.sort);
    dump: for (target.items) |*req| {
        var tex = sling.asset.getCopy(sling.Texture, req.data.targetTexture);
        for (req.data.verts) |*q| {
            if (self.pixelSnap) {
                for (q) |*vert| {
                    vert.pos = vert.pos.round();
                }
            }
            self.pipeline.add(q.*, tex.id) catch break :dump;
        }
    }
    // Dump
    self.camera.recalc();
    var projmtx = sling.math.Matrix.mul(self.camera.viewMatrix, self.camera.projectionMatrix);
    var vs = PipelineShader.Params{ .ProjMtx = projmtx.inlined() };
    self.pipeline.flush(sg.asRange(vs), null);
}

pub const SpriteConfig = struct {
    sourceRect: ?sling.math.Rect = null,
    normalizedOrigin: sling.math.Vec2 = sling.math.Vec2{},
    depth: Depth = Depth.init(0),
    space: Space = .world,
    color: sling.math.Vec4 = sling.math.Vec4.new(1.0, 1.0, 1.0, 1.0),
};
/// Pass in the asset ID of the texture you want to use. Source rect in config is to be given
/// in pixel space. Normalized origin is 0,0 for top left origin; 1,1 for bottom right origin.
pub fn sprite(self: *Self, texture: usize, destination: sling.math.Rect, config: SpriteConfig) void {
    const uv = config.sourceRect orelse sling.math.Rect.new(0, 0, 1, 1);
    var offset: sling.math.Vec2 = .{};
    offset.x = -(destination.size.x * config.normalizedOrigin.x);
    offset.y = -(destination.size.y * config.normalizedOrigin.y);
    const tl = Vert{
        .pos = destination.position.add(offset),
        .uv = uv.position,
        .color = config.color,
    };
    const tr = Vert{
        .pos = destination.position.add(.{ .x = destination.size.x }).add(offset),
        .uv = uv.position.add(.{ .x = uv.size.x }),
        .color = config.color,
    };
    const bl = Vert{
        .pos = destination.position.add(.{ .y = destination.size.y }).add(offset),
        .uv = uv.position.add(.{ .y = uv.size.y }),
        .color = config.color,
    };
    const br = Vert{
        .pos = destination.position.add(destination.size).add(offset),
        .uv = uv.position.add(uv.size),
        .color = config.color,
    };
    self.rawQuad(config.space, config.depth, texture, .{ tl, tr, br, bl });
}

/// Manually submit a quad. Very useful for (slightly inefficiently) drawing
/// 2D meshes manually for say water, or cloth.
/// Verts is expected in order: tl tr br bl
pub fn rawQuad(self: *Self, space: Space, depth: Depth, texture: usize, verts: [4]Vert) void {
    var data = self.fba.allocator.alloc([4]Vert, 1) catch {
        // the gui can hang when this happens, so we use std logging rather than depending on imgui logging.
        std.debug.print("Vertex buffer is full, you're drawing too much in one frame. Consider upping the FBA allocation.\n", .{});
        return;
    };
    data[0] = verts;
    var targetBuffer = if (space == .world) &self.worldRequests else &self.screenRequests;
    targetBuffer.append(.{ .depth = depth, .data = RenderRequestData{
        .verts = data,
        .targetTexture = texture,
    } }) catch unreachable;
}

pub const RectangleConfig = struct {
    space: Space = .world,
    depth: Depth = Depth.init(0),
    /// If you set this away from null and above 0, the rectangle will become a hollow box.
    thickness: ?f32 = null,
    color: sling.math.Vec4 = sling.math.Vec4.new(1.0, 1.0, 1.0, 1.0),

    topLeftColorOverride: ?sling.math.Vec4 = null,
    bottomLeftColorOverride: ?sling.math.Vec4 = null,
    topRightColorOverride: ?sling.math.Vec4 = null,
    bottomRightColorOverride: ?sling.math.Vec4 = null,

    // internal utils for rendering
    inline fn solveRectangleCorners(angle: f32, position: sling.math.Vec2, radius: f32, col: sling.math.Vec4, innerVert: *Vert, outerVert: *Vert) void {
        const rad = angle * sling.math.DEG_2_RAD;
        const inward = sling.math.Vec2.new(std.math.sin(rad), std.math.cos(rad)).scale(radius);
        innerVert.pos = position.add(inward);
        outerVert.pos = position.add(inward.scale(-1));
        innerVert.color = col;
        outerVert.color = col;
    }
};
/// See config for details on all the things you can change about the rectangle.
pub fn rectangle(self: *Self, rect: sling.math.Rect, config: RectangleConfig) void {
    if (config.thickness) |thickness| {
        var data = self.fba.allocator.alloc([4]Vert, 4) catch {
            // the gui can hang when this happens, so we use std logging rather than depending on imgui logging.
            std.debug.print("Vertex buffer is full, you're drawing too much in one frame. Consider upping the FBA allocation.\n", .{});
            return;
        };

        // TL
        const tlCol = config.topLeftColorOverride orelse config.color;
        data[0][0].uv = sling.math.Vec2.new(0, 0); // OUTER
        data[0][1].uv = sling.math.Vec2.new(1, 0); // INNER
        RectangleConfig.solveRectangleCorners(225.0, rect.position, thickness * 0.5, tlCol, &data[0][1], &data[0][0]);
        data[1][0] = data[0][0];
        data[1][3] = data[0][1];
        // TR
        const trPos = rect.position.add(sling.math.Vec2.new(rect.size.x, 0));
        const trCol = config.topRightColorOverride orelse config.color;
        data[2][1].uv = sling.math.Vec2.new(1, 0); // OUTER
        data[2][0].uv = sling.math.Vec2.new(0, 0); // INNER
        RectangleConfig.solveRectangleCorners(135.0, trPos, thickness * 0.5, trCol, &data[2][0], &data[2][1]);
        data[1][1] = data[2][1];
        data[1][2] = data[2][0];
        // BR
        const brPos = rect.position.add(rect.size);
        const brCol = config.bottomRightColorOverride orelse config.color;
        data[2][2].uv = sling.math.Vec2.new(1, 1); // OUTER
        data[2][3].uv = sling.math.Vec2.new(0, 1); // INNER
        RectangleConfig.solveRectangleCorners(45.0, brPos, thickness * 0.5, brCol, &data[2][3], &data[2][2]);
        data[3][1] = data[2][3];
        data[3][2] = data[2][2];
        // BL
        const blPos = rect.position.add(sling.math.Vec2.new(0, rect.size.y));
        const blCol = config.bottomLeftColorOverride orelse config.color;
        data[0][3].uv = sling.math.Vec2.new(0, 1); // OUTER
        data[0][2].uv = sling.math.Vec2.new(0, 1); // INNER
        RectangleConfig.solveRectangleCorners(315.0, blPos, thickness * 0.5, blCol, &data[0][2], &data[0][3]);
        data[3][0] = data[0][2];
        data[3][3] = data[0][3];

        var targetBuffer = if (config.space == .world) &self.worldRequests else &self.screenRequests;
        targetBuffer.append(.{ .depth = config.depth, .data = RenderRequestData{
            .verts = data,
            .targetTexture = self.whitePixelId,
        } }) catch unreachable;
    } else {
        const tl = Vert{
            .pos = rect.position,
            .uv = sling.math.Vec2.new(0, 0),
            .color = config.color,
        };
        const tr = Vert{
            .pos = rect.position.add(.{ .x = rect.size.x }),
            .uv = sling.math.Vec2.new(1, 0),
            .color = config.color,
        };
        const bl = Vert{
            .pos = rect.position.add(.{ .y = rect.size.y }),
            .uv = sling.math.Vec2.new(0, 1),
            .color = config.color,
        };
        const br = Vert{
            .pos = rect.position.add(rect.size),
            .uv = sling.math.Vec2.new(1, 1),
            .color = config.color,
        };
        self.rawQuad(config.space, config.depth, self.whitePixelId, .{ tl, tr, br, bl });
    }
}
