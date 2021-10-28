const std = @import("std");
const sling = @import("../main.zig");

pub const Register = struct {
    /// The name of the room, used for debug purposes, and as a display if register is
    /// used to 
    name: []const u8,
    updateMethod: fn () void,
    initMethod: ?fn () void = null,
    deinitMethod: ?fn () void = null,
};