const sg = @import("../sokol/sokol.zig").gfx;
const sapp = @import("../sokol/sokol.zig").app;
const reroute = @import("main.zig");
const std = @import("std");

/// Takes a vertex type and returns a renderer that uses textures to draw.
pub fn Generate(comptime Vertex: type, MaxQuads: usize) type {
    return struct {
        const MaxVertCount = MaxQuads * 4;
        const MaxIndCount = MaxQuads * 6;
        pub const VertexGroup = std.ArrayList(Vertex);
        pub const IndexGroup = std.ArrayList(u32);
        const Self = @This();
        allocator: *std.mem.Allocator = std.heap.c_allocator,
        vertices: []Vertex,
        indices: []u32,
        // Bit inefficient, todo clean this up into pairs of texture, texture start index instead.
        textures: [MaxQuads]u32 = undefined,
        quadCount: usize = 0,
        drawCalls: usize = 0,

        pipeline: sg.Pipeline,
        bindings: sg.Bindings,

        /// Where `shader` is an import of the sokol shaderc output, e.g. `@import("yourshader/shader.glsl.zig")`
        /// and program name is the name you are selecting. For example if your glsl file ends with `@program triangle vs fs`
        /// and you want to use the triangle pair, you pass in `triangle`.
        pub fn init(allocator: *std.mem.Allocator, comptime shader: anytype, comptime programName: []const u8) Self {
            // SHADER:
            sg.pushDebugGroup("Pipeline Initialization");
            comptime var prog: []const u8 = "";
            inline for (programName) |ascii| {
                prog = prog ++ &[_]u8{std.ascii.toLower(ascii)};
            }
            const shaderDesc = @field(shader, prog ++ "ShaderDesc")(sg.queryBackend());

            // PIPELINE:
            var pipelineDesc: sg.PipelineDesc = .{ .depth = .{
                .write_enabled = false,
                .compare = .LESS_EQUAL,
            }, .index_type = .UINT32, .cull_mode = .DEFAULT };
            pipelineDesc.shader = sg.makeShader(shaderDesc);
            // pipelineDesc.color_count = 1;
            pipelineDesc.colors[0].write_mask = sg.ColorMask.RGBA;
            inline for (std.meta.fields(Vertex)) |field, i| {
                switch (field.field_type) {
                    f32 => {
                        pipelineDesc.layout.attrs[i].format = .FLOAT;
                    },
                    reroute.math.Vec2 => {
                        pipelineDesc.layout.attrs[i].format = .FLOAT2;
                    },
                    reroute.math.Vec3 => {
                        pipelineDesc.layout.attrs[i].format = .FLOAT3;
                    },
                    reroute.math.Vec4 => {
                        pipelineDesc.layout.attrs[i].format = .FLOAT4;
                    },
                    else => {
                        @compileError("Cant have a " ++ @typeName(field.field_type) ++ " in this buffer.");
                    },
                }
            }

            // BINDINGS:
            var bindings = sg.Bindings{};
            bindings.vertex_buffers[0] = sg.makeBuffer(.{
                .type = .VERTEXBUFFER,
                .usage = .STREAM,
                .size = @sizeOf(Vertex) * MaxVertCount,
            });
            bindings.index_buffer = sg.makeBuffer(.{
                .type = .INDEXBUFFER,
                .usage = .STREAM,
                .size = @sizeOf(u32) * MaxIndCount,
            });
            var self: Self = .{
                .allocator = allocator,
                .vertices = allocator.alloc(Vertex, MaxVertCount) catch unreachable,
                .indices = allocator.alloc(u32, MaxIndCount) catch unreachable,
                .pipeline = sg.makePipeline(pipelineDesc),
                .bindings = bindings,
            };
            self.vertices.len = 0;
            self.indices.len = 0;

            sg.popDebugGroup();
            std.debug.print("SLING: Initialized new Spritebatch\n", .{});
            return self;
        }

        pub fn add(self: *Self, quad: [4]Vertex, texture: u32) !void {
            if (self.vertices.len + 4 >= MaxVertCount or self.indices.len + 6 >= MaxIndCount) {
                return error.Full;
            }
            const vind: usize = self.vertices.len;
            const iind: usize = self.indices.len;
            self.vertices.len += 4;
            self.indices.len += 6;

            self.vertices[vind + 0] = quad[0];
            self.vertices[vind + 1] = quad[1];
            self.vertices[vind + 2] = quad[2];
            self.vertices[vind + 3] = quad[3];

            self.indices[iind + 0] = @intCast(u32, vind + 0);
            self.indices[iind + 1] = @intCast(u32, vind + 1);
            self.indices[iind + 2] = @intCast(u32, vind + 3);
            self.indices[iind + 3] = @intCast(u32, vind + 1);
            self.indices[iind + 4] = @intCast(u32, vind + 2);
            self.indices[iind + 5] = @intCast(u32, vind + 3);
            self.textures[self.quadCount] = texture;
            self.quadCount += 1;
        }
        pub fn flush(self: *Self, vsParams: ?sg.Range, fsParams: ?sg.Range) void {
            self.drawCalls = 0;
            if (self.vertices.len == 0 or self.indices.len == 0) {
                return;
            }
            sg.updateBuffer(self.bindings.vertex_buffers[0], sg.asRange(self.vertices));
            sg.updateBuffer(self.bindings.index_buffer, sg.asRange(self.indices));
            sg.applyPipeline(self.pipeline);
            if (vsParams) |vs| {
                sg.applyUniforms(.VS, 0, vs);
            }
            if (fsParams) |fs| {
                sg.applyUniforms(.FS, 0, fs);
            }
            var previousTex = self.textures[0];

            var i: usize = 0;
            var starting: usize = 0;
            while (i < self.quadCount) : (i += 1) {
                var tex = self.textures[i];
                if (tex != previousTex) {
                    var from = @intCast(u32, starting * 6);
                    var amount = @intCast(u32, (i - starting) * 6);
                    self.bindings.fs_images[0] = sg.Image{ .id = previousTex };
                    sg.applyBindings(self.bindings);
                    sg.draw(from, amount, 1);
                    starting = i;
                    self.drawCalls += 1;
                }
                previousTex = tex;
            }

            if (i != starting) {
                var from = @intCast(u32, starting * 6);
                var amount = @intCast(u32, (i - starting) * 6);
                self.bindings.fs_images[0] = sg.Image{ .id = previousTex };
                sg.applyBindings(self.bindings);
                sg.draw(from, amount, 1);
                self.drawCalls += 1;
            }

            self.quadCount = 0;
            self.vertices.len = 0;
            self.indices.len = 0;
        }
    };
}
