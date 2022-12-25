const std = @import("std");
const sling = @import("../main.zig");
const ig = sling.package.imgui;

/// Depends on each state having an `fn(*SelfState,*Context) ?TaggedUnion` named `update`.
/// Pass in an `union(enum)` that contains each state, the update signature above
/// returns the union if it will transition to a new state, or null if it will
/// remain the same.
pub fn StateMachine(comptime TaggedUnion: type, comptime Context: type) type {
    std.debug.assert(@typeInfo(TaggedUnion) == .Union);
    return struct {
        /// If true, the next state is updated on transitions.
        followThroughUpdate: bool = true,
        currentState: TaggedUnion,
        pub fn init(initialState: TaggedUnion) @This() {
            return .{
                .currentState = initialState,
            };
        }
        pub fn update(self: *@This(), context: Context) void {
            var activeTag = std.meta.activeTag(self.currentState);
            const info = @typeInfo(TaggedUnion).Union;
            inline for (info.fields) |field_info| {
                if (std.mem.eql(u8, field_info.name, @tagName(activeTag))) {
                    const T = field_info.type;
                    if (@hasDecl(T, "update")) {
                        if (T.update(&@field(self.currentState, field_info.name), context)) |newState| {
                            if (@hasDecl(T, "leave")) {
                                T.leave(&@field(self.currentState, field_info.name), context);
                            }
                            self.goto(newState, context);
                        }
                    } else {
                        @compileError("Each state of a statemachine should have an `fn update(self:*State, target:*Context) ?Union`");
                    }
                }
            }
        }
        fn goto(self: *@This(), newState: TaggedUnion, context: Context) void {
            self.currentState = newState;
            var nextTag = std.meta.activeTag(self.currentState);
            const info = @typeInfo(TaggedUnion).Union;
            inline for (info.fields) |field_info| {
                if (std.mem.eql(u8, field_info.name, @tagName(nextTag))) {
                    const T = field_info.type;
                    if (@hasDecl(T, "enter")) {
                        T.enter(&@field(self.currentState, field_info.name), context);
                    }
                }
            }
            if (self.followThroughUpdate) {
                self.update(context);
            }
        }
    };
}
