const std = @import("std");
const zt = @import("zt");
const sling = @import("sling.zig");
const ig = @import("imgui");

var possibleLevels = std.ArrayList([]const u8).init(sling.alloc);
var isSaving: ?bool = null;
var fileWrite: [512:0]u8 = std.mem.zeroes([512:0]u8);

var demoOpen: bool = false;

pub fn editorUI() void {
    controls();
    menu();
    if(sling.scene) |scene| {
        if(sling.room == null) {
            objectEditor(scene);
        }
    }
    saveLoadInterface();
}

fn controls() void {
    const Key = sling.input.Key;
    var io = ig.igGetIO();
    if(sling.input.mwheel != 0) {
        var newZoom = std.math.clamp(sling.render.camera.zoom+sling.input.mwheel, 1, 12);
        sling.render.camera.setZoom(newZoom);
    }
    if(Key.mmb.down()) {
        sling.render.camera.setPosition(sling.render.camera.position.sub(io.*.MouseDelta.scaleDiv(sling.render.camera.zoom)));
    }

}

fn objectEditor(scene: *sling.Scene) void {
    if(ig.igBegin("Scene Editor##SLING_SCENE_EDITOR", null, ig.ImGuiWindowFlags_None)) {
        switch(scene.baseObject.data) {
            .Singleton => {
                scene.baseObject.data.Singleton.editor(scene.baseObject);
            },
            .Collection => {
                var max = scene.baseObject.data.Collection.getCount(scene.baseObject);
                var i: usize = 0;
                while(i < max) : (i += 1) {
                    scene.baseObject.data.Collection.editor(scene.baseObject,i);
                }
            }
        }
    }
    ig.igEnd();

    ig.igPushStyleVar_Vec2(ig.ImGuiStyleVar_WindowPadding, .{.x=2,.y=2});
    if(ig.igBegin("Object Selector##SLING_OBJECT_SELECTOR", null, ig.ImGuiWindowFlags_None)) {
        ig.igPushStyleVar_Vec2(ig.ImGuiStyleVar_FramePadding, .{});
        for(scene.childObjects) |interface, i| {
            ig.igPushID_Int(@intCast(c_int, i));
            defer ig.igPopID();

            switch(interface.data) {
                .Singleton => {
                    if(ig.igSelectable_Bool(interface.information.name.ptr, i == scene.editorData.selectedObjectGroup, ig.ImGuiSelectableFlags_SpanAvailWidth,.{})) {
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

                    ig.igSameLine(ws.x-22, 0);
                    if(ig.igButton("+", .{.x=20,.y=s.y})) {
                        interface.data.Collection.append(interface);
                    }
                    if(open) {
                        var max = interface.data.Collection.getCount(interface);
                        var j: usize = 0;
                        while(j < max) : (j += 1) {
                            ig.igPushID_Int(@intCast(c_int, j));
                            var txt = interface.data.Collection.getName(interface, j);
                            if(ig.igSelectable_Bool(txt.ptr, i == scene.editorData.selectedObjectGroup and j == scene.editorData.selectedEntity, ig.ImGuiSelectableFlags_SpanAvailWidth,.{})) {
                                scene.editorData.selectedObjectGroup = i;
                                scene.editorData.selectedEntity = j;
                            }
                            ig.igPopID();
                        }
                        ig.igTreePop();
                    }
                }
            }
        }
        ig.igPopStyleVar(1);
    }
    ig.igEnd();
    ig.igPopStyleVar(1);
    if(ig.igBegin("Object Editor##SLING_OBJECT_EDITOR", null, ig.ImGuiWindowFlags_None)) {
        if(scene.editorData.selectedObjectGroup < scene.childObjects.len) {
            var currentInterface = scene.childObjects[scene.editorData.selectedObjectGroup];
            switch(currentInterface.data) {
                .Singleton => {
                    currentInterface.data.Singleton.editor(currentInterface);
                },
                .Collection => {
                    var count = currentInterface.data.Collection.getCount(currentInterface);
                    if(count > 0 and scene.editorData.selectedEntity < count) {
                        currentInterface.data.Collection.editor(currentInterface, scene.editorData.selectedEntity);
                    }
                }
            }
        }
    
    }
    ig.igEnd();
}

fn menu() void {
    if (ig.igBeginMainMenuBar()) {
        if(sling.room) |idx| {
            if (ig.igBeginMenu("<- Back", true)) {
                sling.room = null;
                if(sling.register.RegisteredRooms[idx].items[idx].deinitMethod) |deinit| {
                    deinit();
                }
                ig.igEndMenu();
            }
        }
        // Creation tab
        if (ig.igBeginMenu("File", sling.room == null)) {
            newSceneMenu();
            ig.igSeparator();
            if(ig.igMenuItem_Bool("Save", "CTRL+S", false, true)) {
                isSaving = true;
                fileWrite = std.mem.zeroes([512:0]u8);
                refreshLevels();
            }
            if(ig.igMenuItem_Bool("Load", "CTRL+O", false, true)) {
                isSaving = false;
                fileWrite = std.mem.zeroes([512:0]u8);
                refreshLevels();
            }
            ig.igEndMenu();
        }
        if (ig.igBeginMenu("Room", true)) {
            for(sling.register.RegisteredRooms.items) |room, i| {
                if(ig.igMenuItem_Bool(room.name.ptr, null, false, true)) {
                    sling.room = i;
                }
            }
            ig.igEndMenu();
        }
        if (ig.igBeginMenu("Misc", true)) {
            if(ig.igMenuItem_Bool("ImGui Demo", null, demoOpen, true)) {
                demoOpen = !demoOpen;
            }
            ig.igEndMenu();
        }
        ig.igEndMainMenuBar();
    }
    if(demoOpen) {
        ig.igShowDemoWindow(&demoOpen);
    }
}

fn newSceneMenu() void {
    if(ig.igBeginMenu("New", true)) {
        var registers = sling.register.RegisteredScenes.valueIterator();
        while(registers.next()) |sceneRegister| {
            var cast: *sling.register.SceneRegister = sceneRegister;
            var baseInfo = sling.Object.Information.get(cast.base);
            if(ig.igMenuItem_Bool(baseInfo.name.ptr, null, false, true)) {
                sling.scene = sling.Scene.initFromInfo(cast.*);
            }
        }
        ig.igEndMenu();
    }
}

fn refreshLevels() void {
    for(possibleLevels.items) |item| {
        sling.alloc.free(item);
    }
    possibleLevels.clearRetainingCapacity();
    _search("") catch |err| {
        std.debug.panic("Failed to search the local folders for scenes:\n{s}", .{@errorName(err)});
    };
}

fn _search(path: []const u8) anyerror!void {
    var currentPath = try std.fs.cwd().openDir(path, .{.iterate=true});
    defer currentPath.close();
    var iterator = currentPath.iterate();
    while(try iterator.next()) |item| {
        var cast: std.fs.Dir.Entry = item;
        switch(cast.kind) {
            .Directory => {
                var fullPath = try std.fs.path.join(sling.alloc, &[_][]const u8 { path, cast.name });
                defer sling.alloc.free(fullPath);
                try _search(fullPath);
            },
            .File => {
                var ext = std.fs.path.extension(cast.name);
                if(std.mem.eql(u8, ext, ".scene") or std.mem.eql(u8, ext, ".sc")) {
                    try possibleLevels.append(try sling.alloc.dupeZ(u8, cast.name));
                }
            },
            else => {}
        }

    }
}
fn saveLoadInterface() void {
    if(isSaving == null) {
        return;
    }
    if(ig.igBegin("Save/Load", null, ig.ImGuiWindowFlags_None)) {
        _ = sling.util.igEdit("File Location", &fileWrite);
        if(ig.igButton("Refresh", .{})) {
            refreshLevels();
        }
        ig.igSameLine(0, 4);
        if(isSaving.? == true) {
            if(ig.igButton("Save##SLING_SAVE_SAVE_BUTTON", .{})) {
                isSaving = null;
                var bytes = sling.scene.?.toBytes(sling.alloc);
                defer sling.alloc.free(bytes);
                std.fs.cwd().writeFile(std.mem.spanZ(&fileWrite), bytes) catch unreachable;
            }
        } else {
            if(ig.igButton("Load##SLING_SAVE_LOAD_BUTTON", .{})) {
                isSaving = null;
                if(sling.scene) |scene| {
                    scene.deinit();
                    sling.scene = null;
                }
                sling.scene = sling.Scene.initFromFilepath(std.mem.spanZ(&fileWrite));
            }
        }
        ig.igSeparator();
        for(possibleLevels.items) |path| {
            if(ig.igSelectable_Bool(path.ptr, std.mem.eql(u8, path, std.mem.spanZ(&fileWrite)), ig.ImGuiSelectableFlags_SpanAvailWidth, .{})) {
                fileWrite = std.mem.zeroes([512:0]u8);
                for(path) |byte, j| {
                    fileWrite[j] = byte;
                }
            }
        }
    }
    ig.igEnd();
}