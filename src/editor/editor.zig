const std = @import("std");
const sling = @import("../main.zig");
const ig = sling.package.imgui;

const dict = @import("dictionary.zig");

const menu = @import("menu.zig");
const console = @import("console.zig");

var demoOpen: bool = false;

pub fn editorUI() void {
    controls();
    menu.update();
    if (sling.state.scene) |scene| {
        if (sling.state.room == null) {
            objectEditor(scene);
        }
    }

    if (sling.state.room == null) {
        console.update();
    }
}

fn controls() void {
    const Key = sling.input.Key;
    var io = ig.igGetIO();
    if (sling.input.mwheel != 0) {
        var newZoom = std.math.clamp(sling.render.camera.zoom + sling.input.mwheel, 1, 12);
        sling.render.camera.setZoom(newZoom);
    }
    if (Key.mmb.down()) {
        sling.render.camera.setPosition(sling.render.camera.position.sub(io.*.MouseDelta.scaleDiv(sling.render.camera.zoom)));
    }
}

fn objectEditor(scene: *sling.Scene) void {
    if (ig.igBegin(dict.windowTitleSceneEditor.ptr, null, ig.ImGuiWindowFlags_None)) {
        switch (scene.baseObject.data) {
            .Singleton => {
                scene.baseObject.data.Singleton.editor(scene.baseObject);
            },
            .Collection => {
                var max = scene.baseObject.data.Collection.getCount(scene.baseObject);
                var i: usize = 0;
                while (i < max) : (i += 1) {
                    scene.baseObject.data.Collection.editor(scene.baseObject, i);
                }
            },
        }
    }
    ig.igEnd();

    ig.igPushStyleVar_Vec2(ig.ImGuiStyleVar_WindowPadding, .{ .x = 2, .y = 2 });
    if (ig.igBegin(dict.windowTitlePalette.ptr, null, ig.ImGuiWindowFlags_None)) {
        ig.igPushStyleVar_Vec2(ig.ImGuiStyleVar_FramePadding, .{});
        for (scene.childObjects) |interface, i| {
            ig.igPushID_Int(@intCast(c_int, i));
            defer ig.igPopID();

            switch (interface.data) {
                .Singleton => {
                    if (ig.igSelectable_Bool(interface.information.name.ptr, i == scene.editorData.selectedObjectGroup, ig.ImGuiSelectableFlags_SpanAvailWidth, .{})) {
                        scene.editorData.selectedObjectGroup = i;
                        scene.editorData.selectedEntity = 0;
                    }
                },
                .Collection => {
                    if (scene.editorData.selectedObjectGroup == i) {
                        ig.igSetNextItemOpen(true, ig.ImGuiCond_Once);
                    }
                    var open = ig.igTreeNode_Str(interface.information.name.ptr);
                    var s: ig.ImVec2 = undefined;
                    var ws: ig.ImVec2 = undefined;
                    ig.igGetItemRectSize(&s);
                    ig.igGetWindowSize(&ws);
                    ig.igSameLine(ws.x - 22, 0);
                    if (ig.igButton(dict.addNew.ptr, .{ .x = 20, .y = s.y })) {
                        interface.data.Collection.append(interface);
                        scene.editorData.selectedObjectGroup = i;
                    }
                    if (scene.editorData.selectedObjectGroup == i and interface.data.Collection.getCount(interface) > 0) {
                        ig.igSameLine(ws.x - 44, 0);
                        if (ig.igButton(dict.duplicate.ptr, .{ .x = 20, .y = s.y })) {
                            interface.data.Collection.append(interface);
                            interface.data.Collection.copyFromTo(interface, scene.editorData.selectedEntity, interface.data.Collection.getCount(interface) - 1);
                        }
                        if (ig.igIsItemHovered(ig.ImGuiHoveredFlags_None)) {
                            ig.igBeginTooltip();
                            ig.igText("Duplicate the currently selected entity.");
                            ig.igEndTooltip();
                        }
                    }
                    if (open) {
                        var max = interface.data.Collection.getCount(interface);
                        var j: usize = 0;
                        while (j < max) : (j += 1) {
                            ig.igPushID_Int(@intCast(c_int, j));
                            var txt = interface.data.Collection.getName(interface, j);

                            var openNode = ig.igSelectable_Bool(txt.ptr, i == scene.editorData.selectedObjectGroup and j == scene.editorData.selectedEntity, ig.ImGuiSelectableFlags_SpanAvailWidth, .{});
                            if (ig.igBeginPopupContextItem("ENTITY_POPUP_CONTEXT", ig.ImGuiPopupFlags_MouseButtonRight)) {
                                if (ig.igSelectable_Bool("Delete", false, ig.ImGuiSelectableFlags_None, .{ .x = 110 })) {
                                    interface.data.Collection.remove(interface, j);
                                    max -= 1;
                                }
                                if (ig.igSelectable_Bool("Duplicate", false, ig.ImGuiSelectableFlags_None, .{ .x = 110 })) {
                                    interface.data.Collection.append(interface);
                                    interface.data.Collection.copyFromTo(interface, j, interface.data.Collection.getCount(interface) - 1);
                                }
                                ig.igEndPopup();
                            }
                            if (openNode) {
                                scene.editorData.selectedObjectGroup = i;
                                scene.editorData.selectedEntity = j;
                            }
                            ig.igPopID();
                        }
                        ig.igTreePop();
                    }
                },
            }
        }
        ig.igPopStyleVar(1);
    }
    ig.igEnd();
    ig.igPopStyleVar(1);
    if (ig.igBegin(dict.windowTitleObjectEditor.ptr, null, ig.ImGuiWindowFlags_None)) {
        if (scene.editorData.selectedObjectGroup < scene.childObjects.len) {
            var currentInterface = scene.childObjects[scene.editorData.selectedObjectGroup];
            switch (currentInterface.data) {
                .Singleton => {
                    currentInterface.data.Singleton.editor(currentInterface);
                },
                .Collection => {
                    var count = currentInterface.data.Collection.getCount(currentInterface);
                    if (count > 0 and scene.editorData.selectedEntity < count) {
                        currentInterface.data.Collection.editor(currentInterface, scene.editorData.selectedEntity);
                    }
                },
            }
        }
    }
    ig.igEnd();
}
