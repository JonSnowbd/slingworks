const sg = @import("sokol").gfx;
//
//  #version:1# (machine generated, don't edit!)
//
//  Generated by sokol-shdc (https://github.com/floooh/sokol-tools)
//
//  Cmdline: sokol-shdc --input ./src/reroute/shaders_raw/imgui.glsl --output ./src/reroute/shaders/imgui.glsl.zig --slang glsl330:hlsl4:metal_macos --format sokol_zig
//
//  Overview:
//
//      Shader program 'imgui':
//          Get shader desc: shd.imguiShaderDesc(sg.queryBackend());
//          Vertex shader: vs
//              Attribute slots:
//                  ATTR_vs_Position = 0
//                  ATTR_vs_UV = 1
//                  ATTR_vs_Color = 2
//              Uniform block 'params':
//                  C struct: params_t
//                  Bind slot: SLOT_params = 0
//          Fragment shader: fs
//              Image 'Texture':
//                  Type: ._2D
//                  Component Type: .FLOAT
//                  Bind slot: SLOT_Texture = 0
//
//
pub const ATTR_vs_Position = 0;
pub const ATTR_vs_UV = 1;
pub const ATTR_vs_Color = 2;
pub const SLOT_Texture = 0;
pub const SLOT_params = 0;
pub const Params = extern struct {
    ProjMtx: [16]f32 align(16),
};
//
// #version 330
// 
// uniform vec4 params[4];
// out vec2 Frag_UV;
// layout(location = 1) in vec2 UV;
// out vec4 Frag_Color;
// layout(location = 2) in vec4 Color;
// layout(location = 0) in vec2 Position;
// 
// void main()
// {
//     Frag_UV = UV;
//     Frag_Color = Color;
//     gl_Position = mat4(params[0], params[1], params[2], params[3]) * vec4(Position, 0.0, 1.0);
// }
// 
//
const vs_source_glsl330 = [341]u8 {
    0x23,0x76,0x65,0x72,0x73,0x69,0x6f,0x6e,0x20,0x33,0x33,0x30,0x0a,0x0a,0x75,0x6e,
    0x69,0x66,0x6f,0x72,0x6d,0x20,0x76,0x65,0x63,0x34,0x20,0x70,0x61,0x72,0x61,0x6d,
    0x73,0x5b,0x34,0x5d,0x3b,0x0a,0x6f,0x75,0x74,0x20,0x76,0x65,0x63,0x32,0x20,0x46,
    0x72,0x61,0x67,0x5f,0x55,0x56,0x3b,0x0a,0x6c,0x61,0x79,0x6f,0x75,0x74,0x28,0x6c,
    0x6f,0x63,0x61,0x74,0x69,0x6f,0x6e,0x20,0x3d,0x20,0x31,0x29,0x20,0x69,0x6e,0x20,
    0x76,0x65,0x63,0x32,0x20,0x55,0x56,0x3b,0x0a,0x6f,0x75,0x74,0x20,0x76,0x65,0x63,
    0x34,0x20,0x46,0x72,0x61,0x67,0x5f,0x43,0x6f,0x6c,0x6f,0x72,0x3b,0x0a,0x6c,0x61,
    0x79,0x6f,0x75,0x74,0x28,0x6c,0x6f,0x63,0x61,0x74,0x69,0x6f,0x6e,0x20,0x3d,0x20,
    0x32,0x29,0x20,0x69,0x6e,0x20,0x76,0x65,0x63,0x34,0x20,0x43,0x6f,0x6c,0x6f,0x72,
    0x3b,0x0a,0x6c,0x61,0x79,0x6f,0x75,0x74,0x28,0x6c,0x6f,0x63,0x61,0x74,0x69,0x6f,
    0x6e,0x20,0x3d,0x20,0x30,0x29,0x20,0x69,0x6e,0x20,0x76,0x65,0x63,0x32,0x20,0x50,
    0x6f,0x73,0x69,0x74,0x69,0x6f,0x6e,0x3b,0x0a,0x0a,0x76,0x6f,0x69,0x64,0x20,0x6d,
    0x61,0x69,0x6e,0x28,0x29,0x0a,0x7b,0x0a,0x20,0x20,0x20,0x20,0x46,0x72,0x61,0x67,
    0x5f,0x55,0x56,0x20,0x3d,0x20,0x55,0x56,0x3b,0x0a,0x20,0x20,0x20,0x20,0x46,0x72,
    0x61,0x67,0x5f,0x43,0x6f,0x6c,0x6f,0x72,0x20,0x3d,0x20,0x43,0x6f,0x6c,0x6f,0x72,
    0x3b,0x0a,0x20,0x20,0x20,0x20,0x67,0x6c,0x5f,0x50,0x6f,0x73,0x69,0x74,0x69,0x6f,
    0x6e,0x20,0x3d,0x20,0x6d,0x61,0x74,0x34,0x28,0x70,0x61,0x72,0x61,0x6d,0x73,0x5b,
    0x30,0x5d,0x2c,0x20,0x70,0x61,0x72,0x61,0x6d,0x73,0x5b,0x31,0x5d,0x2c,0x20,0x70,
    0x61,0x72,0x61,0x6d,0x73,0x5b,0x32,0x5d,0x2c,0x20,0x70,0x61,0x72,0x61,0x6d,0x73,
    0x5b,0x33,0x5d,0x29,0x20,0x2a,0x20,0x76,0x65,0x63,0x34,0x28,0x50,0x6f,0x73,0x69,
    0x74,0x69,0x6f,0x6e,0x2c,0x20,0x30,0x2e,0x30,0x2c,0x20,0x31,0x2e,0x30,0x29,0x3b,
    0x0a,0x7d,0x0a,0x0a,0x00,
};
//
// #version 330
// 
// uniform sampler2D Texture;
// 
// layout(location = 0) out vec4 Out_Color;
// in vec4 Frag_Color;
// in vec2 Frag_UV;
// 
// void main()
// {
//     Out_Color = Frag_Color * texture(Texture, Frag_UV);
// }
// 
//
const fs_source_glsl330 = [195]u8 {
    0x23,0x76,0x65,0x72,0x73,0x69,0x6f,0x6e,0x20,0x33,0x33,0x30,0x0a,0x0a,0x75,0x6e,
    0x69,0x66,0x6f,0x72,0x6d,0x20,0x73,0x61,0x6d,0x70,0x6c,0x65,0x72,0x32,0x44,0x20,
    0x54,0x65,0x78,0x74,0x75,0x72,0x65,0x3b,0x0a,0x0a,0x6c,0x61,0x79,0x6f,0x75,0x74,
    0x28,0x6c,0x6f,0x63,0x61,0x74,0x69,0x6f,0x6e,0x20,0x3d,0x20,0x30,0x29,0x20,0x6f,
    0x75,0x74,0x20,0x76,0x65,0x63,0x34,0x20,0x4f,0x75,0x74,0x5f,0x43,0x6f,0x6c,0x6f,
    0x72,0x3b,0x0a,0x69,0x6e,0x20,0x76,0x65,0x63,0x34,0x20,0x46,0x72,0x61,0x67,0x5f,
    0x43,0x6f,0x6c,0x6f,0x72,0x3b,0x0a,0x69,0x6e,0x20,0x76,0x65,0x63,0x32,0x20,0x46,
    0x72,0x61,0x67,0x5f,0x55,0x56,0x3b,0x0a,0x0a,0x76,0x6f,0x69,0x64,0x20,0x6d,0x61,
    0x69,0x6e,0x28,0x29,0x0a,0x7b,0x0a,0x20,0x20,0x20,0x20,0x4f,0x75,0x74,0x5f,0x43,
    0x6f,0x6c,0x6f,0x72,0x20,0x3d,0x20,0x46,0x72,0x61,0x67,0x5f,0x43,0x6f,0x6c,0x6f,
    0x72,0x20,0x2a,0x20,0x74,0x65,0x78,0x74,0x75,0x72,0x65,0x28,0x54,0x65,0x78,0x74,
    0x75,0x72,0x65,0x2c,0x20,0x46,0x72,0x61,0x67,0x5f,0x55,0x56,0x29,0x3b,0x0a,0x7d,
    0x0a,0x0a,0x00,
};
//
// cbuffer params : register(b0)
// {
//     row_major float4x4 _32_ProjMtx : packoffset(c0);
// };
// 
// 
// static float4 gl_Position;
// static float2 Frag_UV;
// static float2 UV;
// static float4 Frag_Color;
// static float4 Color;
// static float2 Position;
// 
// struct SPIRV_Cross_Input
// {
//     float2 Position : TEXCOORD0;
//     float2 UV : TEXCOORD1;
//     float4 Color : TEXCOORD2;
// };
// 
// struct SPIRV_Cross_Output
// {
//     float2 Frag_UV : TEXCOORD0;
//     float4 Frag_Color : TEXCOORD1;
//     float4 gl_Position : SV_Position;
// };
// 
// #line 16 "./src/reroute/shaders_raw/imgui.glsl"
// void vert_main()
// {
// #line 16 "./src/reroute/shaders_raw/imgui.glsl"
//     Frag_UV = UV;
// #line 17 "./src/reroute/shaders_raw/imgui.glsl"
//     Frag_Color = Color;
// #line 18 "./src/reroute/shaders_raw/imgui.glsl"
//     gl_Position = mul(float4(Position, 0.0f, 1.0f), _32_ProjMtx);
// }
// 
// SPIRV_Cross_Output main(SPIRV_Cross_Input stage_input)
// {
//     UV = stage_input.UV;
//     Color = stage_input.Color;
//     Position = stage_input.Position;
//     vert_main();
//     SPIRV_Cross_Output stage_output;
//     stage_output.gl_Position = gl_Position;
//     stage_output.Frag_UV = Frag_UV;
//     stage_output.Frag_Color = Frag_Color;
//     return stage_output;
// }
//
const vs_source_hlsl4 = [1164]u8 {
    0x63,0x62,0x75,0x66,0x66,0x65,0x72,0x20,0x70,0x61,0x72,0x61,0x6d,0x73,0x20,0x3a,
    0x20,0x72,0x65,0x67,0x69,0x73,0x74,0x65,0x72,0x28,0x62,0x30,0x29,0x0a,0x7b,0x0a,
    0x20,0x20,0x20,0x20,0x72,0x6f,0x77,0x5f,0x6d,0x61,0x6a,0x6f,0x72,0x20,0x66,0x6c,
    0x6f,0x61,0x74,0x34,0x78,0x34,0x20,0x5f,0x33,0x32,0x5f,0x50,0x72,0x6f,0x6a,0x4d,
    0x74,0x78,0x20,0x3a,0x20,0x70,0x61,0x63,0x6b,0x6f,0x66,0x66,0x73,0x65,0x74,0x28,
    0x63,0x30,0x29,0x3b,0x0a,0x7d,0x3b,0x0a,0x0a,0x0a,0x73,0x74,0x61,0x74,0x69,0x63,
    0x20,0x66,0x6c,0x6f,0x61,0x74,0x34,0x20,0x67,0x6c,0x5f,0x50,0x6f,0x73,0x69,0x74,
    0x69,0x6f,0x6e,0x3b,0x0a,0x73,0x74,0x61,0x74,0x69,0x63,0x20,0x66,0x6c,0x6f,0x61,
    0x74,0x32,0x20,0x46,0x72,0x61,0x67,0x5f,0x55,0x56,0x3b,0x0a,0x73,0x74,0x61,0x74,
    0x69,0x63,0x20,0x66,0x6c,0x6f,0x61,0x74,0x32,0x20,0x55,0x56,0x3b,0x0a,0x73,0x74,
    0x61,0x74,0x69,0x63,0x20,0x66,0x6c,0x6f,0x61,0x74,0x34,0x20,0x46,0x72,0x61,0x67,
    0x5f,0x43,0x6f,0x6c,0x6f,0x72,0x3b,0x0a,0x73,0x74,0x61,0x74,0x69,0x63,0x20,0x66,
    0x6c,0x6f,0x61,0x74,0x34,0x20,0x43,0x6f,0x6c,0x6f,0x72,0x3b,0x0a,0x73,0x74,0x61,
    0x74,0x69,0x63,0x20,0x66,0x6c,0x6f,0x61,0x74,0x32,0x20,0x50,0x6f,0x73,0x69,0x74,
    0x69,0x6f,0x6e,0x3b,0x0a,0x0a,0x73,0x74,0x72,0x75,0x63,0x74,0x20,0x53,0x50,0x49,
    0x52,0x56,0x5f,0x43,0x72,0x6f,0x73,0x73,0x5f,0x49,0x6e,0x70,0x75,0x74,0x0a,0x7b,
    0x0a,0x20,0x20,0x20,0x20,0x66,0x6c,0x6f,0x61,0x74,0x32,0x20,0x50,0x6f,0x73,0x69,
    0x74,0x69,0x6f,0x6e,0x20,0x3a,0x20,0x54,0x45,0x58,0x43,0x4f,0x4f,0x52,0x44,0x30,
    0x3b,0x0a,0x20,0x20,0x20,0x20,0x66,0x6c,0x6f,0x61,0x74,0x32,0x20,0x55,0x56,0x20,
    0x3a,0x20,0x54,0x45,0x58,0x43,0x4f,0x4f,0x52,0x44,0x31,0x3b,0x0a,0x20,0x20,0x20,
    0x20,0x66,0x6c,0x6f,0x61,0x74,0x34,0x20,0x43,0x6f,0x6c,0x6f,0x72,0x20,0x3a,0x20,
    0x54,0x45,0x58,0x43,0x4f,0x4f,0x52,0x44,0x32,0x3b,0x0a,0x7d,0x3b,0x0a,0x0a,0x73,
    0x74,0x72,0x75,0x63,0x74,0x20,0x53,0x50,0x49,0x52,0x56,0x5f,0x43,0x72,0x6f,0x73,
    0x73,0x5f,0x4f,0x75,0x74,0x70,0x75,0x74,0x0a,0x7b,0x0a,0x20,0x20,0x20,0x20,0x66,
    0x6c,0x6f,0x61,0x74,0x32,0x20,0x46,0x72,0x61,0x67,0x5f,0x55,0x56,0x20,0x3a,0x20,
    0x54,0x45,0x58,0x43,0x4f,0x4f,0x52,0x44,0x30,0x3b,0x0a,0x20,0x20,0x20,0x20,0x66,
    0x6c,0x6f,0x61,0x74,0x34,0x20,0x46,0x72,0x61,0x67,0x5f,0x43,0x6f,0x6c,0x6f,0x72,
    0x20,0x3a,0x20,0x54,0x45,0x58,0x43,0x4f,0x4f,0x52,0x44,0x31,0x3b,0x0a,0x20,0x20,
    0x20,0x20,0x66,0x6c,0x6f,0x61,0x74,0x34,0x20,0x67,0x6c,0x5f,0x50,0x6f,0x73,0x69,
    0x74,0x69,0x6f,0x6e,0x20,0x3a,0x20,0x53,0x56,0x5f,0x50,0x6f,0x73,0x69,0x74,0x69,
    0x6f,0x6e,0x3b,0x0a,0x7d,0x3b,0x0a,0x0a,0x23,0x6c,0x69,0x6e,0x65,0x20,0x31,0x36,
    0x20,0x22,0x2e,0x2f,0x73,0x72,0x63,0x2f,0x72,0x65,0x72,0x6f,0x75,0x74,0x65,0x2f,
    0x73,0x68,0x61,0x64,0x65,0x72,0x73,0x5f,0x72,0x61,0x77,0x2f,0x69,0x6d,0x67,0x75,
    0x69,0x2e,0x67,0x6c,0x73,0x6c,0x22,0x0a,0x76,0x6f,0x69,0x64,0x20,0x76,0x65,0x72,
    0x74,0x5f,0x6d,0x61,0x69,0x6e,0x28,0x29,0x0a,0x7b,0x0a,0x23,0x6c,0x69,0x6e,0x65,
    0x20,0x31,0x36,0x20,0x22,0x2e,0x2f,0x73,0x72,0x63,0x2f,0x72,0x65,0x72,0x6f,0x75,
    0x74,0x65,0x2f,0x73,0x68,0x61,0x64,0x65,0x72,0x73,0x5f,0x72,0x61,0x77,0x2f,0x69,
    0x6d,0x67,0x75,0x69,0x2e,0x67,0x6c,0x73,0x6c,0x22,0x0a,0x20,0x20,0x20,0x20,0x46,
    0x72,0x61,0x67,0x5f,0x55,0x56,0x20,0x3d,0x20,0x55,0x56,0x3b,0x0a,0x23,0x6c,0x69,
    0x6e,0x65,0x20,0x31,0x37,0x20,0x22,0x2e,0x2f,0x73,0x72,0x63,0x2f,0x72,0x65,0x72,
    0x6f,0x75,0x74,0x65,0x2f,0x73,0x68,0x61,0x64,0x65,0x72,0x73,0x5f,0x72,0x61,0x77,
    0x2f,0x69,0x6d,0x67,0x75,0x69,0x2e,0x67,0x6c,0x73,0x6c,0x22,0x0a,0x20,0x20,0x20,
    0x20,0x46,0x72,0x61,0x67,0x5f,0x43,0x6f,0x6c,0x6f,0x72,0x20,0x3d,0x20,0x43,0x6f,
    0x6c,0x6f,0x72,0x3b,0x0a,0x23,0x6c,0x69,0x6e,0x65,0x20,0x31,0x38,0x20,0x22,0x2e,
    0x2f,0x73,0x72,0x63,0x2f,0x72,0x65,0x72,0x6f,0x75,0x74,0x65,0x2f,0x73,0x68,0x61,
    0x64,0x65,0x72,0x73,0x5f,0x72,0x61,0x77,0x2f,0x69,0x6d,0x67,0x75,0x69,0x2e,0x67,
    0x6c,0x73,0x6c,0x22,0x0a,0x20,0x20,0x20,0x20,0x67,0x6c,0x5f,0x50,0x6f,0x73,0x69,
    0x74,0x69,0x6f,0x6e,0x20,0x3d,0x20,0x6d,0x75,0x6c,0x28,0x66,0x6c,0x6f,0x61,0x74,
    0x34,0x28,0x50,0x6f,0x73,0x69,0x74,0x69,0x6f,0x6e,0x2c,0x20,0x30,0x2e,0x30,0x66,
    0x2c,0x20,0x31,0x2e,0x30,0x66,0x29,0x2c,0x20,0x5f,0x33,0x32,0x5f,0x50,0x72,0x6f,
    0x6a,0x4d,0x74,0x78,0x29,0x3b,0x0a,0x7d,0x0a,0x0a,0x53,0x50,0x49,0x52,0x56,0x5f,
    0x43,0x72,0x6f,0x73,0x73,0x5f,0x4f,0x75,0x74,0x70,0x75,0x74,0x20,0x6d,0x61,0x69,
    0x6e,0x28,0x53,0x50,0x49,0x52,0x56,0x5f,0x43,0x72,0x6f,0x73,0x73,0x5f,0x49,0x6e,
    0x70,0x75,0x74,0x20,0x73,0x74,0x61,0x67,0x65,0x5f,0x69,0x6e,0x70,0x75,0x74,0x29,
    0x0a,0x7b,0x0a,0x20,0x20,0x20,0x20,0x55,0x56,0x20,0x3d,0x20,0x73,0x74,0x61,0x67,
    0x65,0x5f,0x69,0x6e,0x70,0x75,0x74,0x2e,0x55,0x56,0x3b,0x0a,0x20,0x20,0x20,0x20,
    0x43,0x6f,0x6c,0x6f,0x72,0x20,0x3d,0x20,0x73,0x74,0x61,0x67,0x65,0x5f,0x69,0x6e,
    0x70,0x75,0x74,0x2e,0x43,0x6f,0x6c,0x6f,0x72,0x3b,0x0a,0x20,0x20,0x20,0x20,0x50,
    0x6f,0x73,0x69,0x74,0x69,0x6f,0x6e,0x20,0x3d,0x20,0x73,0x74,0x61,0x67,0x65,0x5f,
    0x69,0x6e,0x70,0x75,0x74,0x2e,0x50,0x6f,0x73,0x69,0x74,0x69,0x6f,0x6e,0x3b,0x0a,
    0x20,0x20,0x20,0x20,0x76,0x65,0x72,0x74,0x5f,0x6d,0x61,0x69,0x6e,0x28,0x29,0x3b,
    0x0a,0x20,0x20,0x20,0x20,0x53,0x50,0x49,0x52,0x56,0x5f,0x43,0x72,0x6f,0x73,0x73,
    0x5f,0x4f,0x75,0x74,0x70,0x75,0x74,0x20,0x73,0x74,0x61,0x67,0x65,0x5f,0x6f,0x75,
    0x74,0x70,0x75,0x74,0x3b,0x0a,0x20,0x20,0x20,0x20,0x73,0x74,0x61,0x67,0x65,0x5f,
    0x6f,0x75,0x74,0x70,0x75,0x74,0x2e,0x67,0x6c,0x5f,0x50,0x6f,0x73,0x69,0x74,0x69,
    0x6f,0x6e,0x20,0x3d,0x20,0x67,0x6c,0x5f,0x50,0x6f,0x73,0x69,0x74,0x69,0x6f,0x6e,
    0x3b,0x0a,0x20,0x20,0x20,0x20,0x73,0x74,0x61,0x67,0x65,0x5f,0x6f,0x75,0x74,0x70,
    0x75,0x74,0x2e,0x46,0x72,0x61,0x67,0x5f,0x55,0x56,0x20,0x3d,0x20,0x46,0x72,0x61,
    0x67,0x5f,0x55,0x56,0x3b,0x0a,0x20,0x20,0x20,0x20,0x73,0x74,0x61,0x67,0x65,0x5f,
    0x6f,0x75,0x74,0x70,0x75,0x74,0x2e,0x46,0x72,0x61,0x67,0x5f,0x43,0x6f,0x6c,0x6f,
    0x72,0x20,0x3d,0x20,0x46,0x72,0x61,0x67,0x5f,0x43,0x6f,0x6c,0x6f,0x72,0x3b,0x0a,
    0x20,0x20,0x20,0x20,0x72,0x65,0x74,0x75,0x72,0x6e,0x20,0x73,0x74,0x61,0x67,0x65,
    0x5f,0x6f,0x75,0x74,0x70,0x75,0x74,0x3b,0x0a,0x7d,0x0a,0x00,
};
//
// Texture2D<float4> Texture : register(t0);
// SamplerState _Texture_sampler : register(s0);
// 
// static float4 Out_Color;
// static float4 Frag_Color;
// static float2 Frag_UV;
// 
// struct SPIRV_Cross_Input
// {
//     float2 Frag_UV : TEXCOORD0;
//     float4 Frag_Color : TEXCOORD1;
// };
// 
// struct SPIRV_Cross_Output
// {
//     float4 Out_Color : SV_Target0;
// };
// 
// #line 12 "./src/reroute/shaders_raw/imgui.glsl"
// void frag_main()
// {
// #line 12 "./src/reroute/shaders_raw/imgui.glsl"
//     Out_Color = Frag_Color * Texture.Sample(_Texture_sampler, Frag_UV);
// }
// 
// SPIRV_Cross_Output main(SPIRV_Cross_Input stage_input)
// {
//     Frag_Color = stage_input.Frag_Color;
//     Frag_UV = stage_input.Frag_UV;
//     frag_main();
//     SPIRV_Cross_Output stage_output;
//     stage_output.Out_Color = Out_Color;
//     return stage_output;
// }
//
const fs_source_hlsl4 = [774]u8 {
    0x54,0x65,0x78,0x74,0x75,0x72,0x65,0x32,0x44,0x3c,0x66,0x6c,0x6f,0x61,0x74,0x34,
    0x3e,0x20,0x54,0x65,0x78,0x74,0x75,0x72,0x65,0x20,0x3a,0x20,0x72,0x65,0x67,0x69,
    0x73,0x74,0x65,0x72,0x28,0x74,0x30,0x29,0x3b,0x0a,0x53,0x61,0x6d,0x70,0x6c,0x65,
    0x72,0x53,0x74,0x61,0x74,0x65,0x20,0x5f,0x54,0x65,0x78,0x74,0x75,0x72,0x65,0x5f,
    0x73,0x61,0x6d,0x70,0x6c,0x65,0x72,0x20,0x3a,0x20,0x72,0x65,0x67,0x69,0x73,0x74,
    0x65,0x72,0x28,0x73,0x30,0x29,0x3b,0x0a,0x0a,0x73,0x74,0x61,0x74,0x69,0x63,0x20,
    0x66,0x6c,0x6f,0x61,0x74,0x34,0x20,0x4f,0x75,0x74,0x5f,0x43,0x6f,0x6c,0x6f,0x72,
    0x3b,0x0a,0x73,0x74,0x61,0x74,0x69,0x63,0x20,0x66,0x6c,0x6f,0x61,0x74,0x34,0x20,
    0x46,0x72,0x61,0x67,0x5f,0x43,0x6f,0x6c,0x6f,0x72,0x3b,0x0a,0x73,0x74,0x61,0x74,
    0x69,0x63,0x20,0x66,0x6c,0x6f,0x61,0x74,0x32,0x20,0x46,0x72,0x61,0x67,0x5f,0x55,
    0x56,0x3b,0x0a,0x0a,0x73,0x74,0x72,0x75,0x63,0x74,0x20,0x53,0x50,0x49,0x52,0x56,
    0x5f,0x43,0x72,0x6f,0x73,0x73,0x5f,0x49,0x6e,0x70,0x75,0x74,0x0a,0x7b,0x0a,0x20,
    0x20,0x20,0x20,0x66,0x6c,0x6f,0x61,0x74,0x32,0x20,0x46,0x72,0x61,0x67,0x5f,0x55,
    0x56,0x20,0x3a,0x20,0x54,0x45,0x58,0x43,0x4f,0x4f,0x52,0x44,0x30,0x3b,0x0a,0x20,
    0x20,0x20,0x20,0x66,0x6c,0x6f,0x61,0x74,0x34,0x20,0x46,0x72,0x61,0x67,0x5f,0x43,
    0x6f,0x6c,0x6f,0x72,0x20,0x3a,0x20,0x54,0x45,0x58,0x43,0x4f,0x4f,0x52,0x44,0x31,
    0x3b,0x0a,0x7d,0x3b,0x0a,0x0a,0x73,0x74,0x72,0x75,0x63,0x74,0x20,0x53,0x50,0x49,
    0x52,0x56,0x5f,0x43,0x72,0x6f,0x73,0x73,0x5f,0x4f,0x75,0x74,0x70,0x75,0x74,0x0a,
    0x7b,0x0a,0x20,0x20,0x20,0x20,0x66,0x6c,0x6f,0x61,0x74,0x34,0x20,0x4f,0x75,0x74,
    0x5f,0x43,0x6f,0x6c,0x6f,0x72,0x20,0x3a,0x20,0x53,0x56,0x5f,0x54,0x61,0x72,0x67,
    0x65,0x74,0x30,0x3b,0x0a,0x7d,0x3b,0x0a,0x0a,0x23,0x6c,0x69,0x6e,0x65,0x20,0x31,
    0x32,0x20,0x22,0x2e,0x2f,0x73,0x72,0x63,0x2f,0x72,0x65,0x72,0x6f,0x75,0x74,0x65,
    0x2f,0x73,0x68,0x61,0x64,0x65,0x72,0x73,0x5f,0x72,0x61,0x77,0x2f,0x69,0x6d,0x67,
    0x75,0x69,0x2e,0x67,0x6c,0x73,0x6c,0x22,0x0a,0x76,0x6f,0x69,0x64,0x20,0x66,0x72,
    0x61,0x67,0x5f,0x6d,0x61,0x69,0x6e,0x28,0x29,0x0a,0x7b,0x0a,0x23,0x6c,0x69,0x6e,
    0x65,0x20,0x31,0x32,0x20,0x22,0x2e,0x2f,0x73,0x72,0x63,0x2f,0x72,0x65,0x72,0x6f,
    0x75,0x74,0x65,0x2f,0x73,0x68,0x61,0x64,0x65,0x72,0x73,0x5f,0x72,0x61,0x77,0x2f,
    0x69,0x6d,0x67,0x75,0x69,0x2e,0x67,0x6c,0x73,0x6c,0x22,0x0a,0x20,0x20,0x20,0x20,
    0x4f,0x75,0x74,0x5f,0x43,0x6f,0x6c,0x6f,0x72,0x20,0x3d,0x20,0x46,0x72,0x61,0x67,
    0x5f,0x43,0x6f,0x6c,0x6f,0x72,0x20,0x2a,0x20,0x54,0x65,0x78,0x74,0x75,0x72,0x65,
    0x2e,0x53,0x61,0x6d,0x70,0x6c,0x65,0x28,0x5f,0x54,0x65,0x78,0x74,0x75,0x72,0x65,
    0x5f,0x73,0x61,0x6d,0x70,0x6c,0x65,0x72,0x2c,0x20,0x46,0x72,0x61,0x67,0x5f,0x55,
    0x56,0x29,0x3b,0x0a,0x7d,0x0a,0x0a,0x53,0x50,0x49,0x52,0x56,0x5f,0x43,0x72,0x6f,
    0x73,0x73,0x5f,0x4f,0x75,0x74,0x70,0x75,0x74,0x20,0x6d,0x61,0x69,0x6e,0x28,0x53,
    0x50,0x49,0x52,0x56,0x5f,0x43,0x72,0x6f,0x73,0x73,0x5f,0x49,0x6e,0x70,0x75,0x74,
    0x20,0x73,0x74,0x61,0x67,0x65,0x5f,0x69,0x6e,0x70,0x75,0x74,0x29,0x0a,0x7b,0x0a,
    0x20,0x20,0x20,0x20,0x46,0x72,0x61,0x67,0x5f,0x43,0x6f,0x6c,0x6f,0x72,0x20,0x3d,
    0x20,0x73,0x74,0x61,0x67,0x65,0x5f,0x69,0x6e,0x70,0x75,0x74,0x2e,0x46,0x72,0x61,
    0x67,0x5f,0x43,0x6f,0x6c,0x6f,0x72,0x3b,0x0a,0x20,0x20,0x20,0x20,0x46,0x72,0x61,
    0x67,0x5f,0x55,0x56,0x20,0x3d,0x20,0x73,0x74,0x61,0x67,0x65,0x5f,0x69,0x6e,0x70,
    0x75,0x74,0x2e,0x46,0x72,0x61,0x67,0x5f,0x55,0x56,0x3b,0x0a,0x20,0x20,0x20,0x20,
    0x66,0x72,0x61,0x67,0x5f,0x6d,0x61,0x69,0x6e,0x28,0x29,0x3b,0x0a,0x20,0x20,0x20,
    0x20,0x53,0x50,0x49,0x52,0x56,0x5f,0x43,0x72,0x6f,0x73,0x73,0x5f,0x4f,0x75,0x74,
    0x70,0x75,0x74,0x20,0x73,0x74,0x61,0x67,0x65,0x5f,0x6f,0x75,0x74,0x70,0x75,0x74,
    0x3b,0x0a,0x20,0x20,0x20,0x20,0x73,0x74,0x61,0x67,0x65,0x5f,0x6f,0x75,0x74,0x70,
    0x75,0x74,0x2e,0x4f,0x75,0x74,0x5f,0x43,0x6f,0x6c,0x6f,0x72,0x20,0x3d,0x20,0x4f,
    0x75,0x74,0x5f,0x43,0x6f,0x6c,0x6f,0x72,0x3b,0x0a,0x20,0x20,0x20,0x20,0x72,0x65,
    0x74,0x75,0x72,0x6e,0x20,0x73,0x74,0x61,0x67,0x65,0x5f,0x6f,0x75,0x74,0x70,0x75,
    0x74,0x3b,0x0a,0x7d,0x0a,0x00,
};
//
// #include <metal_stdlib>
// #include <simd/simd.h>
// 
// using namespace metal;
// 
// struct params
// {
//     float4x4 ProjMtx;
// };
// 
// struct main0_out
// {
//     float2 Frag_UV [[user(locn0)]];
//     float4 Frag_Color [[user(locn1)]];
//     float4 gl_Position [[position]];
// };
// 
// struct main0_in
// {
//     float2 Position [[attribute(0)]];
//     float2 UV [[attribute(1)]];
//     float4 Color [[attribute(2)]];
// };
// 
// #line 16 "./src/reroute/shaders_raw/imgui.glsl"
// vertex main0_out main0(main0_in in [[stage_in]], constant params& _32 [[buffer(0)]])
// {
//     main0_out out = {};
// #line 16 "./src/reroute/shaders_raw/imgui.glsl"
//     out.Frag_UV = in.UV;
// #line 17 "./src/reroute/shaders_raw/imgui.glsl"
//     out.Frag_Color = in.Color;
// #line 18 "./src/reroute/shaders_raw/imgui.glsl"
//     out.gl_Position = _32.ProjMtx * float4(in.Position, 0.0, 1.0);
//     return out;
// }
// 
//
const vs_source_metal_macos = [822]u8 {
    0x23,0x69,0x6e,0x63,0x6c,0x75,0x64,0x65,0x20,0x3c,0x6d,0x65,0x74,0x61,0x6c,0x5f,
    0x73,0x74,0x64,0x6c,0x69,0x62,0x3e,0x0a,0x23,0x69,0x6e,0x63,0x6c,0x75,0x64,0x65,
    0x20,0x3c,0x73,0x69,0x6d,0x64,0x2f,0x73,0x69,0x6d,0x64,0x2e,0x68,0x3e,0x0a,0x0a,
    0x75,0x73,0x69,0x6e,0x67,0x20,0x6e,0x61,0x6d,0x65,0x73,0x70,0x61,0x63,0x65,0x20,
    0x6d,0x65,0x74,0x61,0x6c,0x3b,0x0a,0x0a,0x73,0x74,0x72,0x75,0x63,0x74,0x20,0x70,
    0x61,0x72,0x61,0x6d,0x73,0x0a,0x7b,0x0a,0x20,0x20,0x20,0x20,0x66,0x6c,0x6f,0x61,
    0x74,0x34,0x78,0x34,0x20,0x50,0x72,0x6f,0x6a,0x4d,0x74,0x78,0x3b,0x0a,0x7d,0x3b,
    0x0a,0x0a,0x73,0x74,0x72,0x75,0x63,0x74,0x20,0x6d,0x61,0x69,0x6e,0x30,0x5f,0x6f,
    0x75,0x74,0x0a,0x7b,0x0a,0x20,0x20,0x20,0x20,0x66,0x6c,0x6f,0x61,0x74,0x32,0x20,
    0x46,0x72,0x61,0x67,0x5f,0x55,0x56,0x20,0x5b,0x5b,0x75,0x73,0x65,0x72,0x28,0x6c,
    0x6f,0x63,0x6e,0x30,0x29,0x5d,0x5d,0x3b,0x0a,0x20,0x20,0x20,0x20,0x66,0x6c,0x6f,
    0x61,0x74,0x34,0x20,0x46,0x72,0x61,0x67,0x5f,0x43,0x6f,0x6c,0x6f,0x72,0x20,0x5b,
    0x5b,0x75,0x73,0x65,0x72,0x28,0x6c,0x6f,0x63,0x6e,0x31,0x29,0x5d,0x5d,0x3b,0x0a,
    0x20,0x20,0x20,0x20,0x66,0x6c,0x6f,0x61,0x74,0x34,0x20,0x67,0x6c,0x5f,0x50,0x6f,
    0x73,0x69,0x74,0x69,0x6f,0x6e,0x20,0x5b,0x5b,0x70,0x6f,0x73,0x69,0x74,0x69,0x6f,
    0x6e,0x5d,0x5d,0x3b,0x0a,0x7d,0x3b,0x0a,0x0a,0x73,0x74,0x72,0x75,0x63,0x74,0x20,
    0x6d,0x61,0x69,0x6e,0x30,0x5f,0x69,0x6e,0x0a,0x7b,0x0a,0x20,0x20,0x20,0x20,0x66,
    0x6c,0x6f,0x61,0x74,0x32,0x20,0x50,0x6f,0x73,0x69,0x74,0x69,0x6f,0x6e,0x20,0x5b,
    0x5b,0x61,0x74,0x74,0x72,0x69,0x62,0x75,0x74,0x65,0x28,0x30,0x29,0x5d,0x5d,0x3b,
    0x0a,0x20,0x20,0x20,0x20,0x66,0x6c,0x6f,0x61,0x74,0x32,0x20,0x55,0x56,0x20,0x5b,
    0x5b,0x61,0x74,0x74,0x72,0x69,0x62,0x75,0x74,0x65,0x28,0x31,0x29,0x5d,0x5d,0x3b,
    0x0a,0x20,0x20,0x20,0x20,0x66,0x6c,0x6f,0x61,0x74,0x34,0x20,0x43,0x6f,0x6c,0x6f,
    0x72,0x20,0x5b,0x5b,0x61,0x74,0x74,0x72,0x69,0x62,0x75,0x74,0x65,0x28,0x32,0x29,
    0x5d,0x5d,0x3b,0x0a,0x7d,0x3b,0x0a,0x0a,0x23,0x6c,0x69,0x6e,0x65,0x20,0x31,0x36,
    0x20,0x22,0x2e,0x2f,0x73,0x72,0x63,0x2f,0x72,0x65,0x72,0x6f,0x75,0x74,0x65,0x2f,
    0x73,0x68,0x61,0x64,0x65,0x72,0x73,0x5f,0x72,0x61,0x77,0x2f,0x69,0x6d,0x67,0x75,
    0x69,0x2e,0x67,0x6c,0x73,0x6c,0x22,0x0a,0x76,0x65,0x72,0x74,0x65,0x78,0x20,0x6d,
    0x61,0x69,0x6e,0x30,0x5f,0x6f,0x75,0x74,0x20,0x6d,0x61,0x69,0x6e,0x30,0x28,0x6d,
    0x61,0x69,0x6e,0x30,0x5f,0x69,0x6e,0x20,0x69,0x6e,0x20,0x5b,0x5b,0x73,0x74,0x61,
    0x67,0x65,0x5f,0x69,0x6e,0x5d,0x5d,0x2c,0x20,0x63,0x6f,0x6e,0x73,0x74,0x61,0x6e,
    0x74,0x20,0x70,0x61,0x72,0x61,0x6d,0x73,0x26,0x20,0x5f,0x33,0x32,0x20,0x5b,0x5b,
    0x62,0x75,0x66,0x66,0x65,0x72,0x28,0x30,0x29,0x5d,0x5d,0x29,0x0a,0x7b,0x0a,0x20,
    0x20,0x20,0x20,0x6d,0x61,0x69,0x6e,0x30,0x5f,0x6f,0x75,0x74,0x20,0x6f,0x75,0x74,
    0x20,0x3d,0x20,0x7b,0x7d,0x3b,0x0a,0x23,0x6c,0x69,0x6e,0x65,0x20,0x31,0x36,0x20,
    0x22,0x2e,0x2f,0x73,0x72,0x63,0x2f,0x72,0x65,0x72,0x6f,0x75,0x74,0x65,0x2f,0x73,
    0x68,0x61,0x64,0x65,0x72,0x73,0x5f,0x72,0x61,0x77,0x2f,0x69,0x6d,0x67,0x75,0x69,
    0x2e,0x67,0x6c,0x73,0x6c,0x22,0x0a,0x20,0x20,0x20,0x20,0x6f,0x75,0x74,0x2e,0x46,
    0x72,0x61,0x67,0x5f,0x55,0x56,0x20,0x3d,0x20,0x69,0x6e,0x2e,0x55,0x56,0x3b,0x0a,
    0x23,0x6c,0x69,0x6e,0x65,0x20,0x31,0x37,0x20,0x22,0x2e,0x2f,0x73,0x72,0x63,0x2f,
    0x72,0x65,0x72,0x6f,0x75,0x74,0x65,0x2f,0x73,0x68,0x61,0x64,0x65,0x72,0x73,0x5f,
    0x72,0x61,0x77,0x2f,0x69,0x6d,0x67,0x75,0x69,0x2e,0x67,0x6c,0x73,0x6c,0x22,0x0a,
    0x20,0x20,0x20,0x20,0x6f,0x75,0x74,0x2e,0x46,0x72,0x61,0x67,0x5f,0x43,0x6f,0x6c,
    0x6f,0x72,0x20,0x3d,0x20,0x69,0x6e,0x2e,0x43,0x6f,0x6c,0x6f,0x72,0x3b,0x0a,0x23,
    0x6c,0x69,0x6e,0x65,0x20,0x31,0x38,0x20,0x22,0x2e,0x2f,0x73,0x72,0x63,0x2f,0x72,
    0x65,0x72,0x6f,0x75,0x74,0x65,0x2f,0x73,0x68,0x61,0x64,0x65,0x72,0x73,0x5f,0x72,
    0x61,0x77,0x2f,0x69,0x6d,0x67,0x75,0x69,0x2e,0x67,0x6c,0x73,0x6c,0x22,0x0a,0x20,
    0x20,0x20,0x20,0x6f,0x75,0x74,0x2e,0x67,0x6c,0x5f,0x50,0x6f,0x73,0x69,0x74,0x69,
    0x6f,0x6e,0x20,0x3d,0x20,0x5f,0x33,0x32,0x2e,0x50,0x72,0x6f,0x6a,0x4d,0x74,0x78,
    0x20,0x2a,0x20,0x66,0x6c,0x6f,0x61,0x74,0x34,0x28,0x69,0x6e,0x2e,0x50,0x6f,0x73,
    0x69,0x74,0x69,0x6f,0x6e,0x2c,0x20,0x30,0x2e,0x30,0x2c,0x20,0x31,0x2e,0x30,0x29,
    0x3b,0x0a,0x20,0x20,0x20,0x20,0x72,0x65,0x74,0x75,0x72,0x6e,0x20,0x6f,0x75,0x74,
    0x3b,0x0a,0x7d,0x0a,0x0a,0x00,
};
//
// #include <metal_stdlib>
// #include <simd/simd.h>
// 
// using namespace metal;
// 
// struct main0_out
// {
//     float4 Out_Color [[color(0)]];
// };
// 
// struct main0_in
// {
//     float2 Frag_UV [[user(locn0)]];
//     float4 Frag_Color [[user(locn1)]];
// };
// 
// #line 12 "./src/reroute/shaders_raw/imgui.glsl"
// fragment main0_out main0(main0_in in [[stage_in]], texture2d<float> Texture [[texture(0)]], sampler TextureSmplr [[sampler(0)]])
// {
//     main0_out out = {};
// #line 12 "./src/reroute/shaders_raw/imgui.glsl"
//     out.Out_Color = in.Frag_Color * Texture.sample(TextureSmplr, in.Frag_UV);
//     return out;
// }
// 
//
const fs_source_metal_macos = [576]u8 {
    0x23,0x69,0x6e,0x63,0x6c,0x75,0x64,0x65,0x20,0x3c,0x6d,0x65,0x74,0x61,0x6c,0x5f,
    0x73,0x74,0x64,0x6c,0x69,0x62,0x3e,0x0a,0x23,0x69,0x6e,0x63,0x6c,0x75,0x64,0x65,
    0x20,0x3c,0x73,0x69,0x6d,0x64,0x2f,0x73,0x69,0x6d,0x64,0x2e,0x68,0x3e,0x0a,0x0a,
    0x75,0x73,0x69,0x6e,0x67,0x20,0x6e,0x61,0x6d,0x65,0x73,0x70,0x61,0x63,0x65,0x20,
    0x6d,0x65,0x74,0x61,0x6c,0x3b,0x0a,0x0a,0x73,0x74,0x72,0x75,0x63,0x74,0x20,0x6d,
    0x61,0x69,0x6e,0x30,0x5f,0x6f,0x75,0x74,0x0a,0x7b,0x0a,0x20,0x20,0x20,0x20,0x66,
    0x6c,0x6f,0x61,0x74,0x34,0x20,0x4f,0x75,0x74,0x5f,0x43,0x6f,0x6c,0x6f,0x72,0x20,
    0x5b,0x5b,0x63,0x6f,0x6c,0x6f,0x72,0x28,0x30,0x29,0x5d,0x5d,0x3b,0x0a,0x7d,0x3b,
    0x0a,0x0a,0x73,0x74,0x72,0x75,0x63,0x74,0x20,0x6d,0x61,0x69,0x6e,0x30,0x5f,0x69,
    0x6e,0x0a,0x7b,0x0a,0x20,0x20,0x20,0x20,0x66,0x6c,0x6f,0x61,0x74,0x32,0x20,0x46,
    0x72,0x61,0x67,0x5f,0x55,0x56,0x20,0x5b,0x5b,0x75,0x73,0x65,0x72,0x28,0x6c,0x6f,
    0x63,0x6e,0x30,0x29,0x5d,0x5d,0x3b,0x0a,0x20,0x20,0x20,0x20,0x66,0x6c,0x6f,0x61,
    0x74,0x34,0x20,0x46,0x72,0x61,0x67,0x5f,0x43,0x6f,0x6c,0x6f,0x72,0x20,0x5b,0x5b,
    0x75,0x73,0x65,0x72,0x28,0x6c,0x6f,0x63,0x6e,0x31,0x29,0x5d,0x5d,0x3b,0x0a,0x7d,
    0x3b,0x0a,0x0a,0x23,0x6c,0x69,0x6e,0x65,0x20,0x31,0x32,0x20,0x22,0x2e,0x2f,0x73,
    0x72,0x63,0x2f,0x72,0x65,0x72,0x6f,0x75,0x74,0x65,0x2f,0x73,0x68,0x61,0x64,0x65,
    0x72,0x73,0x5f,0x72,0x61,0x77,0x2f,0x69,0x6d,0x67,0x75,0x69,0x2e,0x67,0x6c,0x73,
    0x6c,0x22,0x0a,0x66,0x72,0x61,0x67,0x6d,0x65,0x6e,0x74,0x20,0x6d,0x61,0x69,0x6e,
    0x30,0x5f,0x6f,0x75,0x74,0x20,0x6d,0x61,0x69,0x6e,0x30,0x28,0x6d,0x61,0x69,0x6e,
    0x30,0x5f,0x69,0x6e,0x20,0x69,0x6e,0x20,0x5b,0x5b,0x73,0x74,0x61,0x67,0x65,0x5f,
    0x69,0x6e,0x5d,0x5d,0x2c,0x20,0x74,0x65,0x78,0x74,0x75,0x72,0x65,0x32,0x64,0x3c,
    0x66,0x6c,0x6f,0x61,0x74,0x3e,0x20,0x54,0x65,0x78,0x74,0x75,0x72,0x65,0x20,0x5b,
    0x5b,0x74,0x65,0x78,0x74,0x75,0x72,0x65,0x28,0x30,0x29,0x5d,0x5d,0x2c,0x20,0x73,
    0x61,0x6d,0x70,0x6c,0x65,0x72,0x20,0x54,0x65,0x78,0x74,0x75,0x72,0x65,0x53,0x6d,
    0x70,0x6c,0x72,0x20,0x5b,0x5b,0x73,0x61,0x6d,0x70,0x6c,0x65,0x72,0x28,0x30,0x29,
    0x5d,0x5d,0x29,0x0a,0x7b,0x0a,0x20,0x20,0x20,0x20,0x6d,0x61,0x69,0x6e,0x30,0x5f,
    0x6f,0x75,0x74,0x20,0x6f,0x75,0x74,0x20,0x3d,0x20,0x7b,0x7d,0x3b,0x0a,0x23,0x6c,
    0x69,0x6e,0x65,0x20,0x31,0x32,0x20,0x22,0x2e,0x2f,0x73,0x72,0x63,0x2f,0x72,0x65,
    0x72,0x6f,0x75,0x74,0x65,0x2f,0x73,0x68,0x61,0x64,0x65,0x72,0x73,0x5f,0x72,0x61,
    0x77,0x2f,0x69,0x6d,0x67,0x75,0x69,0x2e,0x67,0x6c,0x73,0x6c,0x22,0x0a,0x20,0x20,
    0x20,0x20,0x6f,0x75,0x74,0x2e,0x4f,0x75,0x74,0x5f,0x43,0x6f,0x6c,0x6f,0x72,0x20,
    0x3d,0x20,0x69,0x6e,0x2e,0x46,0x72,0x61,0x67,0x5f,0x43,0x6f,0x6c,0x6f,0x72,0x20,
    0x2a,0x20,0x54,0x65,0x78,0x74,0x75,0x72,0x65,0x2e,0x73,0x61,0x6d,0x70,0x6c,0x65,
    0x28,0x54,0x65,0x78,0x74,0x75,0x72,0x65,0x53,0x6d,0x70,0x6c,0x72,0x2c,0x20,0x69,
    0x6e,0x2e,0x46,0x72,0x61,0x67,0x5f,0x55,0x56,0x29,0x3b,0x0a,0x20,0x20,0x20,0x20,
    0x72,0x65,0x74,0x75,0x72,0x6e,0x20,0x6f,0x75,0x74,0x3b,0x0a,0x7d,0x0a,0x0a,0x00,

};
pub fn imguiShaderDesc(backend: sg.Backend) sg.ShaderDesc {
    var desc: sg.ShaderDesc = .{};
    switch (backend) {
        .GLCORE33 => {
            desc.attrs[0].name = "Position";
            desc.attrs[1].name = "UV";
            desc.attrs[2].name = "Color";
            desc.vs.source = &vs_source_glsl330;
            desc.vs.entry = "main";
            desc.vs.uniform_blocks[0].size = 64;
            desc.vs.uniform_blocks[0].layout = .STD140;
            desc.vs.uniform_blocks[0].uniforms[0].name = "params";
            desc.vs.uniform_blocks[0].uniforms[0].type = .FLOAT4;
            desc.vs.uniform_blocks[0].uniforms[0].array_count = 4;
            desc.fs.source = &fs_source_glsl330;
            desc.fs.entry = "main";
            desc.fs.images[0].name = "Texture";
            desc.fs.images[0].image_type = ._2D;
            desc.fs.images[0].sampler_type = .FLOAT;
            desc.label = "imgui_shader";
        },
        .D3D11 => {
            desc.attrs[0].sem_name = "TEXCOORD";
            desc.attrs[0].sem_index = 0;
            desc.attrs[1].sem_name = "TEXCOORD";
            desc.attrs[1].sem_index = 1;
            desc.attrs[2].sem_name = "TEXCOORD";
            desc.attrs[2].sem_index = 2;
            desc.vs.source = &vs_source_hlsl4;
            desc.vs.d3d11_target = "vs_4_0";
            desc.vs.entry = "main";
            desc.vs.uniform_blocks[0].size = 64;
            desc.vs.uniform_blocks[0].layout = .STD140;
            desc.fs.source = &fs_source_hlsl4;
            desc.fs.d3d11_target = "ps_4_0";
            desc.fs.entry = "main";
            desc.fs.images[0].name = "Texture";
            desc.fs.images[0].image_type = ._2D;
            desc.fs.images[0].sampler_type = .FLOAT;
            desc.label = "imgui_shader";
        },
        .METAL_MACOS => {
            desc.vs.source = &vs_source_metal_macos;
            desc.vs.entry = "main0";
            desc.vs.uniform_blocks[0].size = 64;
            desc.vs.uniform_blocks[0].layout = .STD140;
            desc.fs.source = &fs_source_metal_macos;
            desc.fs.entry = "main0";
            desc.fs.images[0].name = "Texture";
            desc.fs.images[0].image_type = ._2D;
            desc.fs.images[0].sampler_type = .FLOAT;
            desc.label = "imgui_shader";
        },
        else => {},
    }
    return desc;
}
