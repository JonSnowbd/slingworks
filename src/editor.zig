const std = @import("std");
const zt = @import("zt");
const sling = @import("sling.zig");
const ig = @import("imgui");

const menu = @import("editor/menu.zig");

var demoOpen: bool = false;

pub fn editorUI() void {
    controls();
    menu.update();
    if (sling.scene) |scene| {
        if (sling.room == null) {
            objectEditor(scene);
        }
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
    if (ig.igBegin("Scene Editor##SLING_SCENE_EDITOR", null, ig.ImGuiWindowFlags_None)) {
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
    if (ig.igBegin("Object Selector##SLING_OBJECT_SELECTOR", null, ig.ImGuiWindowFlags_None)) {
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
                    var open = ig.igTreeNode_Str(interface.information.name.ptr);
                    var s: ig.ImVec2 = undefined;
                    var ws: ig.ImVec2 = undefined;
                    ig.igGetItemRectSize(&s);
                    ig.igGetWindowSize(&ws);

                    ig.igSameLine(ws.x - 22, 0);
                    if (ig.igButton("+", .{ .x = 20, .y = s.y })) {
                        interface.data.Collection.append(interface);
                    }
                    if (open) {
                        var max = interface.data.Collection.getCount(interface);
                        var j: usize = 0;
                        while (j < max) : (j += 1) {
                            ig.igPushID_Int(@intCast(c_int, j));
                            var txt = interface.data.Collection.getName(interface, j);
                            if (ig.igSelectable_Bool(txt.ptr, i == scene.editorData.selectedObjectGroup and j == scene.editorData.selectedEntity, ig.ImGuiSelectableFlags_SpanAvailWidth, .{})) {
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
    if (ig.igBegin("Object Editor##SLING_OBJECT_EDITOR", null, ig.ImGuiWindowFlags_None)) {
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
