const std = @import("std");
const ig = @import("../cimgui/imgui.zig");
const shader = @import("shaders/imgui.glsl.zig");
const math = @import("math.zig");

const sokol = @import("../sokol/sokol.zig");
const sg = sokol.gfx;
const sapp = sokol.app;
const stm = sokol.time;

const IgVertex = struct {
    pos: math.Vec2 = .{},
    uv: math.Vec2 = .{},
    col: math.Vec4 = .{},
};

var pipeline: sg.Pipeline = undefined;
var bindings: sg.Bindings = .{};
var vertices: std.ArrayList(IgVertex) = undefined;
var indices: std.ArrayList(u16) = undefined;

/// How long Imgui took to render this frame.
pub var renderTime: f32 = 0.0;

/// ImguiRenderer is statically allocated, you just need to call this once and `.feed` every update
/// and `.discard()` to avoid rendering and update state accordingly or `.render()` to display imgui.
pub fn init() void {
    sg.pushDebugGroup("ImGui Initialization");
    // First we create a custom description since imgui requires some different defaults.
    var customPipeline = sg.PipelineDesc{};
    customPipeline.colors[0].write_mask = .RGB;
    customPipeline.colors[0].blend.enabled = true;
    customPipeline.colors[0].blend.src_factor_rgb = .SRC_ALPHA;
    customPipeline.colors[0].blend.dst_factor_rgb = .ONE_MINUS_SRC_ALPHA;
    customPipeline.depth = .{
        .write_enabled = false,
        .compare = .LESS_EQUAL,
    };
    customPipeline.index_type = .UINT16;
    customPipeline.cull_mode = .DEFAULT;
    customPipeline.label = "ImGuiPipeline";
    customPipeline.shader = sg.makeShader(shader.imguiShaderDesc(sg.queryBackend()));
    customPipeline.layout.attrs[0].format = .FLOAT2;
    customPipeline.layout.attrs[1].format = .FLOAT2;
    customPipeline.layout.attrs[2].format = .FLOAT4;
    pipeline = sg.makePipeline(customPipeline);

    vertices = std.ArrayList(IgVertex).init(std.heap.c_allocator);
    indices = std.ArrayList(u16).init(std.heap.c_allocator);
    bindings.vertex_buffers[0] = sg.makeBuffer(.{
        .type = .VERTEXBUFFER,
        .usage = .STREAM,
        .size = @sizeOf(IgVertex) * 65536,
    });
    bindings.index_buffer = sg.makeBuffer(.{
        .type = .INDEXBUFFER,
        .usage = .STREAM,
        .size = @sizeOf(u16) * 393216,
    });
    var ctx = ig.igCreateContext(null);
    ig.igSetCurrentContext(ctx);

    var io = ig.igGetIO();
    io.*.KeyMap[ig.ImGuiKey_A] = @enumToInt(sapp.Keycode.A);
    io.*.KeyMap[ig.ImGuiKey_Backspace] = @enumToInt(sapp.Keycode.BACKSPACE);
    io.*.KeyMap[ig.ImGuiKey_C] = @enumToInt(sapp.Keycode.C);
    io.*.KeyMap[ig.ImGuiKey_Delete] = @enumToInt(sapp.Keycode.DELETE);
    io.*.KeyMap[ig.ImGuiKey_DownArrow] = @enumToInt(sapp.Keycode.DOWN);
    io.*.KeyMap[ig.ImGuiKey_End] = @enumToInt(sapp.Keycode.END);
    io.*.KeyMap[ig.ImGuiKey_Enter] = @enumToInt(sapp.Keycode.ENTER);
    io.*.KeyMap[ig.ImGuiKey_Escape] = @enumToInt(sapp.Keycode.ESCAPE);
    io.*.KeyMap[ig.ImGuiKey_Home] = @enumToInt(sapp.Keycode.HOME);
    io.*.KeyMap[ig.ImGuiKey_Insert] = @enumToInt(sapp.Keycode.INSERT);
    io.*.KeyMap[ig.ImGuiKey_KeyPadEnter] = @enumToInt(sapp.Keycode.KP_ENTER);
    io.*.KeyMap[ig.ImGuiKey_LeftArrow] = @enumToInt(sapp.Keycode.LEFT);
    io.*.KeyMap[ig.ImGuiKey_PageDown] = @enumToInt(sapp.Keycode.PAGE_DOWN);
    io.*.KeyMap[ig.ImGuiKey_PageUp] = @enumToInt(sapp.Keycode.PAGE_UP);
    io.*.KeyMap[ig.ImGuiKey_RightArrow] = @enumToInt(sapp.Keycode.RIGHT);
    io.*.KeyMap[ig.ImGuiKey_Space] = @enumToInt(sapp.Keycode.SPACE);
    io.*.KeyMap[ig.ImGuiKey_Tab] = @enumToInt(sapp.Keycode.TAB);
    io.*.KeyMap[ig.ImGuiKey_UpArrow] = @enumToInt(sapp.Keycode.UP);
    io.*.KeyMap[ig.ImGuiKey_V] = @enumToInt(sapp.Keycode.V);
    io.*.KeyMap[ig.ImGuiKey_X] = @enumToInt(sapp.Keycode.X);
    io.*.KeyMap[ig.ImGuiKey_Y] = @enumToInt(sapp.Keycode.Y);
    io.*.KeyMap[ig.ImGuiKey_Z] = @enumToInt(sapp.Keycode.Z);
    io.*.BackendFlags |= ig.ImGuiBackendFlags_RendererHasVtxOffset;
    io.*.ConfigFlags |= ig.ImGuiConfigFlags_DockingEnable;
    io.*.DisplaySize.x = sapp.widthf();
    io.*.DisplaySize.y = sapp.heightf();
    sg.popDebugGroup();
}
pub fn deinit() void {
    ig.igShutdown(ig.igGetCurrentContext());
}

/// if true, you may continue to feed the event to the rest of your application.
pub fn feed(event: [*c]const sapp.Event) bool {
    var value: bool = true;
    var io = ig.igGetIO();
    switch (event.*.type) {
        .KEY_UP => {
            io.*.KeysDown[@intCast(usize, @enumToInt(event.*.key_code))] = false;
            io.*.KeyCtrl = io.*.KeysDown[@intCast(usize, @enumToInt(sapp.Keycode.LEFT_CONTROL))] or io.*.KeysDown[@intCast(usize, @enumToInt(sapp.Keycode.RIGHT_CONTROL))];
            io.*.KeyShift = io.*.KeysDown[@intCast(usize, @enumToInt(sapp.Keycode.LEFT_SHIFT))] or io.*.KeysDown[@intCast(usize, @enumToInt(sapp.Keycode.RIGHT_SHIFT))];
            io.*.KeyAlt = io.*.KeysDown[@intCast(usize, @enumToInt(sapp.Keycode.LEFT_ALT))] or io.*.KeysDown[@intCast(usize, @enumToInt(sapp.Keycode.RIGHT_ALT))];
            if (io.*.WantCaptureKeyboard) value = false;
        },
        .KEY_DOWN => {
            io.*.KeysDown[@intCast(usize, @enumToInt(event.*.key_code))] = true;
            io.*.KeyCtrl = io.*.KeysDown[@intCast(usize, @enumToInt(sapp.Keycode.LEFT_CONTROL))] or io.*.KeysDown[@intCast(usize, @enumToInt(sapp.Keycode.RIGHT_CONTROL))];
            io.*.KeyShift = io.*.KeysDown[@intCast(usize, @enumToInt(sapp.Keycode.LEFT_SHIFT))] or io.*.KeysDown[@intCast(usize, @enumToInt(sapp.Keycode.RIGHT_SHIFT))];
            io.*.KeyAlt = io.*.KeysDown[@intCast(usize, @enumToInt(sapp.Keycode.LEFT_ALT))] or io.*.KeysDown[@intCast(usize, @enumToInt(sapp.Keycode.RIGHT_ALT))];
            if (io.*.WantCaptureKeyboard) value = false;
        },
        .CHAR => {
            ig.ImGuiIO_AddInputCharacter(io, @intCast(c_uint, event.*.char_code));
            if (io.*.WantCaptureKeyboard) value = false;
        },
        .MOUSE_UP => {
            switch (event.*.mouse_button) {
                .LEFT => {
                    io.*.MouseDown[@intCast(usize, ig.ImGuiMouseButton_Left)] = false;
                },
                .RIGHT => {
                    io.*.MouseDown[@intCast(usize, ig.ImGuiMouseButton_Right)] = false;
                },
                .MIDDLE => {
                    io.*.MouseDown[@intCast(usize, ig.ImGuiMouseButton_Middle)] = false;
                },
                else => {},
            }
        },
        .MOUSE_DOWN => {
            switch (event.*.mouse_button) {
                .LEFT => {
                    io.*.MouseDown[ig.ImGuiMouseButton_Left] = true;
                },
                .RIGHT => {
                    io.*.MouseDown[ig.ImGuiMouseButton_Right] = true;
                },
                .MIDDLE => {
                    io.*.MouseDown[ig.ImGuiMouseButton_Middle] = true;
                },
                else => {},
            }
        },
        .MOUSE_MOVE => {
            io.*.MousePos.x = event.*.mouse_x;
            io.*.MousePos.y = event.*.mouse_y;
        },
        .MOUSE_SCROLL => {
            io.*.MouseWheel = event.*.scroll_y;
            io.*.MouseWheelH = event.*.scroll_x;
        },
        .RESIZED, .RESTORED => {
            io.*.DisplaySize.x = @intToFloat(f32, event.*.window_width);
            io.*.DisplaySize.y = @intToFloat(f32, event.*.window_height);
        },
        else => {},
    }
    return value;
}
/// Starts a frame
pub fn begin(deltaTime: f32) void {
    var io = ig.igGetIO();
    io.*.DeltaTime = deltaTime;
    ig.igNewFrame();
}
/// Ends a frame without rendering.
pub fn discard() void {
    ig.igEndFrame();
}
/// Ends the frame, and renders imgui via sokol-gfx
pub fn render() void {
    sg.pushDebugGroup("ImGui-Rendering-Phase");
    var time = stm.now();
    ig.igRender();
    var groups = ig.igGetDrawData();
    if (groups.*.CmdListsCount <= 0) {
        return;
    }

    // Pre allocate all memory:
    for (groups.*.CmdLists[0..@intCast(usize, groups.*.CmdListsCount)]) |commands| {
        var i: c_int = 0;
        while (i < commands.*.VtxBuffer.Size) : (i += 1) {
            var colorSplit = @bitCast([4]u8, commands.*.VtxBuffer.Data[@intCast(usize, i)].col);
            var vert = IgVertex{
                .pos = commands.*.VtxBuffer.Data[@intCast(usize, i)].pos,
                .uv = commands.*.VtxBuffer.Data[@intCast(usize, i)].uv,
                .col = math.Vec4.new(@intToFloat(f32, colorSplit[0]) / 255, @intToFloat(f32, colorSplit[1]) / 255, @intToFloat(f32, colorSplit[2]) / 255, @intToFloat(f32, colorSplit[3]) / 255),
            };
            vertices.append(vert) catch break;
        }
        i = 0;
        while (i < commands.*.IdxBuffer.Size) : (i += 1) {
            indices.append(@intCast(u16, commands.*.IdxBuffer.Data[@intCast(usize, i)])) catch break;
        }
    }
    sg.updateBuffer(bindings.vertex_buffers[0], sg.asRange(vertices.items));
    sg.updateBuffer(bindings.index_buffer, sg.asRange(indices.items));
    var vbOffset: i32 = 0;
    var ibOffset: i32 = 0;
    for (groups.*.CmdLists[0..@intCast(usize, groups.*.CmdListsCount)]) |commands| {
        var w = sapp.widthf();
        var h = sapp.heightf();

        // Make the ortho projection
        // Set up render state
        var params = shader.Params{
            .ProjMtx = math.Matrix.createOrthogonal(0, w, h, 0, 0, 1).inlined(),
        };
        sg.applyPipeline(pipeline);
        sg.applyUniforms(.VS, 0, sg.asRange(&params));
        // Draw out the commands
        var baseElement: c_uint = 0;
        var currentTexture: u32 = 0;
        for (commands.*.CmdBuffer.Data[0..@intCast(usize, commands.*.CmdBuffer.Size)]) |pcmd_uncast| {
            var pcmd: ig.ImDrawCmd = pcmd_uncast;
            if (pcmd.UserCallback != null) {
                continue;
            }

            var newTexture = @intCast(u32, @ptrToInt(pcmd.TextureId));
            if (newTexture != currentTexture) {
                var image: sg.Image = .{ .id = newTexture };
                bindings.fs_images[0] = image;
                bindings.vertex_buffer_offsets[0] = vbOffset;
                bindings.index_buffer_offset = ibOffset;
                sg.applyBindings(bindings);
                currentTexture = newTexture;
            }

            sg.applyScissorRectf(pcmd.ClipRect.x, pcmd.ClipRect.y, pcmd.ClipRect.z - pcmd.ClipRect.x, pcmd.ClipRect.w - pcmd.ClipRect.y, true);
            sg.draw(baseElement, @intCast(u32, pcmd.ElemCount), 1);
            baseElement += pcmd.ElemCount;
        }
        vbOffset += @intCast(i32, @intCast(c_int, @sizeOf(IgVertex)) * commands.*.VtxBuffer.Size);
        ibOffset += @intCast(i32, @intCast(c_int, @sizeOf(i16)) * commands.*.IdxBuffer.Size);
    }
    sg.popDebugGroup();
    indices.clearRetainingCapacity();
    vertices.clearRetainingCapacity();
    renderTime = @floatCast(f32, stm.sec(stm.laptime(&time)));
}
