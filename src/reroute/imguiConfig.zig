const std = @import("std");
const ig = @import("../cimgui/imgui.zig");
const math = @import("math.zig");

const sokol = @import("../sokol/sokol.zig");
const sg = sokol.gfx;
const sapp = sokol.app;
const rg = @import("imguiComponents.zig");

pub const icons = struct{};
var currentFontId: u32 = 0;

pub const FontStepConfig = struct {
    name: []const u8 = "New Font",
    size: f32 = 18.0,
    range:?[2]u32 = null,
    includeDefaultRanges:bool = true,
    /// Overdraw of 2 means its rendered at twice the size, and is
    /// smoothed by linear scaling to make a better looking font.
    overdraw:usize = 2,
    pub fn generateConfig(self:FontStepConfig, merger:bool) [*c]ig.ImFontConfig {
        var cfg = ig.ImFontConfig_ImFontConfig();
        cfg.*.MergeMode = merger;
        for(self.name) |char,i| {
            if(i >= 40) {break;}
            cfg.*.Name[i] = char;
        }
        cfg.*.OversampleH = @intCast(c_int, self.overdraw);
        cfg.*.OversampleV = @intCast(c_int, self.overdraw);
        var builder = ig.ImFontGlyphRangesBuilder_ImFontGlyphRangesBuilder();
        var ranges: [*c]ig.ImVector_ImWchar = ig.ImVector_ImWchar_create();
        if(self.includeDefaultRanges) {
            ig.ImFontGlyphRangesBuilder_AddRanges(builder, ig.ImFontAtlas_GetGlyphRangesDefault(ig.igGetIO().*.Fonts));
        }
        if(self.range) |customRange| {
            ig.ImFontGlyphRangesBuilder_AddRanges(builder, &[_]u16{@intCast(u16, customRange[0]),@intCast(u16, customRange[1])});
        }
        ig.ImFontGlyphRangesBuilder_BuildRanges(builder, ranges);
        cfg.*.GlyphRanges = ranges.*.Data;
        return cfg;
    }
};
const FontCreationConfig = struct {
    atlas: [*c]ig.ImFontAtlas,
    addedFirstFont: bool = false,
    nearestNeighbour: bool = false,
    pub fn addDefaultFont(self: *FontCreationConfig) [*c]ig.ImFont {
        self.addedFirstFont = true;
        return ig.ImFontAtlas_AddFontDefault(self.atlas, null);
    }
    /// Takes a path, and loads the ttf.
    pub fn addTTFFromPath(self: *FontCreationConfig, path: []const u8, config: FontStepConfig) [*c]ig.ImFont {
        var cfg = config.generateConfig(self.addedFirstFont);
        self.addedFirstFont = true;
        return ig.ImFontAtlas_AddFontFromFileTTF(self.atlas, path, config.size, cfg, null);
    }
    pub fn addEmbeddedTTF(self: *FontCreationConfig, bytes: []const u8, config: FontStepConfig) [*c]ig.ImFont {
        var copy = std.heap.c_allocator.dupeZ(u8, bytes) catch unreachable;
        // defer std.heap.c_allocator.free(copy);
        var compiledConfig = config.generateConfig(self.addedFirstFont);
        self.addedFirstFont = true;
        return ig.ImFontAtlas_AddFontFromMemoryTTF(self.atlas, copy.ptr, @intCast(c_int, copy.len), config.size, compiledConfig, compiledConfig.*.GlyphRanges);
    }
    pub fn build(self: *FontCreationConfig) void {
        if(!self.addedFirstFont) {
            _ = self.addDefaultFont();
        }
        var io = ig.igGetIO();
        // Font stuff, move into config later.
        var pixels: [*c]u8 = undefined;
        var w: c_int = undefined;
        var h: c_int = undefined;
        var bpp: c_int = undefined;
        ig.ImFontAtlas_GetTexDataAsRGBA32(self.atlas, &pixels, &w, &h, &bpp);

        var imageDesc: sg.ImageDesc = .{};
        imageDesc.width = @intCast(i32, w);
        imageDesc.height = @intCast(i32, h);
        imageDesc.pixel_format = sg.PixelFormat.RGBA8;
        imageDesc.wrap_u = sg.Wrap.CLAMP_TO_EDGE;
        imageDesc.wrap_v = sg.Wrap.CLAMP_TO_EDGE;
        // We definitely want linear for oversampled fonts.
        imageDesc.min_filter = if(self.nearestNeighbour) sg.Filter.NEAREST else sg.Filter.LINEAR;
        imageDesc.mag_filter = if(self.nearestNeighbour) sg.Filter.NEAREST else sg.Filter.LINEAR;
        imageDesc.label = "imgui_font";
        imageDesc.data.subimage[0][0].ptr = pixels[0..@intCast(usize, w*h)].ptr;
        imageDesc.data.subimage[0][0].size = @intCast(usize, w*h);

        var image = sg.makeImage(imageDesc);
        self.atlas.*.TexID = @intToPtr(*c_void, image.id);

        ig.ImFontAtlas_destroy(io.*.Fonts);
        io.*.Fonts = self.atlas;   
    }
    pub fn cancel(self:*FontCreationConfig) void {
        ig.ImFontAtlas_destroy(self.atlas);
    }
};

pub fn startFontCreation() FontCreationConfig {
    return .{
        .atlas = ig.ImFontAtlas_ImFontAtlas()
    };
}

/// Sets imgui style to be compact, does not affect colors. Recommended to follow this up
/// with your own custom colors, or one from this file `styleColor*()`
pub fn styleSizeCompact() void {
    var style = ig.igGetStyle();

    // Paddings
    style.*.WindowPadding = .{.x=4,.y=4};
    style.*.FramePadding = .{.x=2,.y=2};
    style.*.CellPadding = .{.x=4,.y=2};
    style.*.ItemSpacing = .{.x=10,.y=2};
    style.*.ItemInnerSpacing = .{.x=2,.y=2};
    style.*.IndentSpacing = 12;
    style.*.ScrollbarSize = 4;

    // Borders
    style.*.TabBorderSize = 0;
    style.*.ChildBorderSize = 0;
    style.*.FrameBorderSize = 0;
    style.*.PopupBorderSize = 0;
    style.*.WindowBorderSize = 0;

    // Rounding
    style.*.TabRounding = 2;
    style.*.GrabRounding = 0;
    style.*.ChildRounding = 0;
    style.*.FrameRounding = 2;
    style.*.PopupRounding = 0;
    style.*.WindowRounding = 2;
    style.*.ScrollbarRounding = 0;

    // Align
    style.*.WindowTitleAlign = .{.x=0.5,.y=0.5};
    style.*.WindowMenuButtonPosition = ig.ImGuiDir_None;
}

/// Provide 4 colors, contrast, and if it is a light theme, and reroute will automatically
/// style each of your imgui colors. If you're changing this and re-building often, prefer to use
/// styleColorEditor() to toy with this in real time.
pub fn styleColorCustom(background:ig.ImVec4, foreground:ig.ImVec4, highlight:ig.ImVec4, special:ig.ImVec4, contrast:f32, isLightTheme: bool) void {
    const bg0 = if(isLightTheme) background.brighten(contrast) else background.brighten(-contrast);
    const bg1 = background;
    const bg2 = if(isLightTheme) background.brighten(-contrast) else background.brighten(contrast);

    const fg0 = if(isLightTheme) foreground.brighten(contrast) else foreground.brighten(-contrast);
    const fg1 = foreground;
    const fg2 = if(isLightTheme) foreground.brighten(-contrast) else foreground.brighten(contrast);

    const hl0 = if(isLightTheme) highlight.brighten(contrast) else highlight.brighten(-contrast);
    const hl1 = highlight;
    const hl2 = if(isLightTheme) highlight.brighten(-contrast) else highlight.brighten(contrast);

    const sp0 = if(isLightTheme) special.brighten(contrast) else special.brighten(-contrast);
    const sp1 = special;
    const sp2 = if(isLightTheme) special.brighten(-contrast) else special.brighten(contrast);

    var style = ig.igGetStyle();
    style.*.Colors[ig.ImGuiCol_Text]                   = fg1;
    style.*.Colors[ig.ImGuiCol_TextDisabled]           = fg0;
    style.*.Colors[ig.ImGuiCol_WindowBg]               = bg0;
    style.*.Colors[ig.ImGuiCol_ChildBg]                = bg0;
    style.*.Colors[ig.ImGuiCol_PopupBg]                = bg0;
    style.*.Colors[ig.ImGuiCol_Border]                 = bg0.brighten(-0.5);
    style.*.Colors[ig.ImGuiCol_BorderShadow]           = bg0.brighten(-0.5);
    style.*.Colors[ig.ImGuiCol_FrameBg]                = if(isLightTheme) bg1.brighten(-0.33) else bg1.brighten(0.33);
    style.*.Colors[ig.ImGuiCol_FrameBgHovered]         = bg2;
    style.*.Colors[ig.ImGuiCol_FrameBgActive]          = bg2.brighten(0.7);
    style.*.Colors[ig.ImGuiCol_TitleBg]                = hl0;
    style.*.Colors[ig.ImGuiCol_TitleBgActive]          = hl1;
    style.*.Colors[ig.ImGuiCol_TitleBgCollapsed]       = hl0;
    style.*.Colors[ig.ImGuiCol_MenuBarBg]              = bg0.brighten(-0.1);
    style.*.Colors[ig.ImGuiCol_ScrollbarBg]            = bg0;
    style.*.Colors[ig.ImGuiCol_ScrollbarGrab]          = fg0;
    style.*.Colors[ig.ImGuiCol_ScrollbarGrabHovered]   = fg1;
    style.*.Colors[ig.ImGuiCol_ScrollbarGrabActive]    = fg2;
    style.*.Colors[ig.ImGuiCol_CheckMark]              = hl0;
    style.*.Colors[ig.ImGuiCol_SliderGrab]             = hl0;
    style.*.Colors[ig.ImGuiCol_SliderGrabActive]       = hl2;
    style.*.Colors[ig.ImGuiCol_Button]                 = hl0;
    style.*.Colors[ig.ImGuiCol_ButtonHovered]          = hl1;
    style.*.Colors[ig.ImGuiCol_ButtonActive]           = hl2;
    style.*.Colors[ig.ImGuiCol_Header]                 = bg1;
    style.*.Colors[ig.ImGuiCol_HeaderHovered]          = bg1;
    style.*.Colors[ig.ImGuiCol_HeaderActive]           = bg2;
    style.*.Colors[ig.ImGuiCol_Separator]              = bg2;
    style.*.Colors[ig.ImGuiCol_SeparatorHovered]       = sp0;
    style.*.Colors[ig.ImGuiCol_SeparatorActive]        = sp1;
    style.*.Colors[ig.ImGuiCol_ResizeGrip]             = sp0;
    style.*.Colors[ig.ImGuiCol_ResizeGripHovered]      = sp1;
    style.*.Colors[ig.ImGuiCol_ResizeGripActive]       = sp2;
    style.*.Colors[ig.ImGuiCol_Tab]                    = bg2;
    style.*.Colors[ig.ImGuiCol_TabHovered]             = bg2;
    style.*.Colors[ig.ImGuiCol_TabActive]              = bg2.brighten(0.3);
    style.*.Colors[ig.ImGuiCol_TabUnfocused]           = bg1;
    style.*.Colors[ig.ImGuiCol_TabUnfocusedActive]     = bg2;
    style.*.Colors[ig.ImGuiCol_DockingPreview]         = hl1;
    style.*.Colors[ig.ImGuiCol_DockingEmptyBg]         = hl0;
    style.*.Colors[ig.ImGuiCol_PlotLines]              = ig.ImVec4{.x=0.61, .y=0.61, .z=0.61, .w=1.00};
    style.*.Colors[ig.ImGuiCol_PlotLinesHovered]       = ig.ImVec4{.x=1.00, .y=0.43, .z=0.35, .w=1.00};
    style.*.Colors[ig.ImGuiCol_PlotHistogram]          = ig.ImVec4{.x=0.90, .y=0.70, .z=0.00, .w=1.00};
    style.*.Colors[ig.ImGuiCol_PlotHistogramHovered]   = ig.ImVec4{.x=1.00, .y=0.60, .z=0.00, .w=1.00};
    style.*.Colors[ig.ImGuiCol_TableHeaderBg]          = ig.ImVec4{.x=0.19, .y=0.19, .z=0.20, .w=1.00};
    style.*.Colors[ig.ImGuiCol_TableBorderStrong]      = ig.ImVec4{.x=0.31, .y=0.31, .z=0.35, .w=1.00};
    style.*.Colors[ig.ImGuiCol_TableBorderLight]       = ig.ImVec4{.x=0.23, .y=0.23, .z=0.25, .w=1.00};
    style.*.Colors[ig.ImGuiCol_TableRowBg]             = ig.ImVec4{.x=0.00, .y=0.00, .z=0.00, .w=0.00};
    style.*.Colors[ig.ImGuiCol_TableRowBgAlt]          = ig.ImVec4{.x=1.00, .y=1.00, .z=1.00, .w=0.06};
    style.*.Colors[ig.ImGuiCol_TextSelectedBg]         = ig.ImVec4{.x=0.26, .y=0.59, .z=0.98, .w=0.35};
    style.*.Colors[ig.ImGuiCol_DragDropTarget]         = ig.ImVec4{.x=1.00, .y=1.00, .z=0.00, .w=0.90};
    style.*.Colors[ig.ImGuiCol_NavHighlight]           = ig.ImVec4{.x=0.26, .y=0.59, .z=0.98, .w=1.00};
    style.*.Colors[ig.ImGuiCol_NavWindowingHighlight]  = ig.ImVec4{.x=1.00, .y=1.00, .z=1.00, .w=0.70};
    style.*.Colors[ig.ImGuiCol_NavWindowingDimBg]      = ig.ImVec4{.x=0.80, .y=0.80, .z=0.80, .w=0.20};
    style.*.Colors[ig.ImGuiCol_ModalWindowDimBg]       = ig.ImVec4{.x=0.80, .y=0.80, .z=0.80, .w=0.35};
}

var edit_bg: math.Vec4 = math.Vec4.new(0.1,0.1,0.15,1.0);
var edit_fg: math.Vec4 = math.Vec4.new(0.89,0.89,0.91,1.0);
var edit_sp: math.Vec4 = math.Vec4.new(0.9,0.34,0.2,1.0);
var edit_hl: math.Vec4 = math.Vec4.new(0.9,0.34,0.2,1.0);
var edit_diff: f32 = 0.2;
var edit_isLight: bool = false;
fn stringVec(vec:math.Vec4) []const u8 {
    return rg.format("reroute.math.Vec4{{.x={d:.2},.y={d:.2},.z={d:.2},.w={d:.2}}}", .{vec.x,vec.y,vec.z,vec.w});
}
pub fn styleColorEditor() void {
    var updated:bool = false;
    if(rg.beginWindow("Custom Style Editor", .{})) {
        if(rg.input("Background", &edit_bg, .{})) {
            updated = true;
        }
        if(rg.input("Foreground", &edit_fg, .{})) {
            updated = true;
        }
        if(rg.input("Special", &edit_sp, .{})) {
            updated = true;
        }
        if(rg.input("Highlight", &edit_hl, .{})) {
            updated = true;
        }
        if(rg.input("Contrast", &edit_diff, .{.step=0.01})) {
            edit_diff = std.math.clamp(edit_diff, 0.0, 1.0);
            updated = true;
        }
        rg.help("Changing this will set the contrast between inactive/active colors", .{});
        if(rg.input("Is Light Theme", &edit_isLight, .{})) {
            updated = true;
        }
        rg.help("Setting this to true prefers to darken things\nlike headers and titles, rather than brighten for dark modes.",.{});
        if(rg.button("Print zigcall", .{})) {
            std.debug.print("reroute.imgui.config.styleColorCustom({s},{s},{s},{s},{d:.2},{any});\n", .{
                stringVec(edit_bg), stringVec(edit_fg), stringVec(edit_hl), stringVec(edit_sp), edit_diff, edit_isLight
            });
        }
        rg.help("Check your stdout for the zig function that you'd need to recreate this\nfrom your init function.", .{});
        
    }
    rg.endWindow();
    if(updated) {
        styleColorCustom(edit_bg, edit_fg, edit_hl, edit_sp, edit_diff, edit_isLight);
    }
}

/// A slate/orange dark theme
pub fn styleColorOrangeSlate() void {
    styleColorCustom(
        math.Vec4{.x=0.16,.y=0.19,.z=0.22,.w=1.00},
        math.Vec4{.x=0.89,.y=0.89,.z=0.89,.w=1.00},
        math.Vec4{.x=0.90,.y=0.34,.z=0.20,.w=1.00},
        math.Vec4{.x=0.00,.y=0.00,.z=0.00,.w=0.36},0.30,false);
}