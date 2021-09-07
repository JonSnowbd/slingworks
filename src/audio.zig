const std = @import("std");
const sling = @import("sling.zig");
const fmod = @import("fmod.zig");

pub var sys: ?*fmod.FMOD_STUDIO_SYSTEM = null;

var events = sling.util.HoleQueue(?*fmod.FMOD_STUDIO_EVENTINSTANCE).init(sling.alloc);

var banks = std.ArrayList(Bank).init(sling.alloc);

pub const Bank = struct {
    raw: ?*fmod.FMOD_STUDIO_BANK,
    pub fn loadImpl(path: []const u8) Bank {
        var self = Bank{
            .raw = undefined,
        };
        var res = fmod.FMOD_Studio_System_LoadBankFile(sys, path.ptr, fmod.FMOD_STUDIO_LOAD_BANK_NORMAL, &self.raw);
        errCheck(res, "Loading bank");

        return self;
    }
    pub fn freeEvent(self: *Bank, event: Event) void {
        _ = self;
        _ = event;
    }
};

pub fn loadBank(bankPath: []const u8) void {
    banks.append(Bank.loadImpl(bankPath)) catch unreachable;
}

pub fn makeEvent(eventName: []const u8) Event {
    var evt = Event{
        .raw = undefined
    };

    var desc: ?*fmod.FMOD_STUDIO_EVENTDESCRIPTION = null;
    var res = fmod.FMOD_Studio_System_GetEvent(sys, eventName.ptr, &desc);
    errCheck(res, "Getting event from system");

    var inst: ?*fmod.FMOD_STUDIO_EVENTINSTANCE = null;
    res = fmod.FMOD_Studio_EventDescription_CreateInstance(desc, &inst);
    errCheck(res, "Creating an instance");

    evt.raw = events.take(inst) catch {std.debug.panic("Failed to reserve an fmod instance", .{});};

    return evt;
}

pub const Event = struct {
    volume: f32 = 1.0,
    raw: usize,
    pub fn set(self:*Event, param: []const u8, value: f32) void {
        var inst: ?*fmod.FMOD_STUDIO_EVENTINSTANCE = events.getCopy(self.raw);
        errCheck(fmod.FMOD_Studio_EventInstance_SetParameterByName(inst, param.ptr, value, 1), "Setting event parameter by name");
    }
    pub fn seek(self:*Event, timelineMs: i32) void {
        var inst: ?*fmod.FMOD_STUDIO_EVENTINSTANCE = events.getCopy(self.raw);
        errCheck(fmod.FMOD_Studio_EventInstance_SetTimelinePosition(inst, @intCast(c_int, timelineMs)), "Setting event timeline");
    }
    pub fn play(self:*Event) void {
        var inst: ?*fmod.FMOD_STUDIO_EVENTINSTANCE = events.getCopy(self.raw);
        errCheck(fmod.FMOD_Studio_EventInstance_Start(inst), "Playing event instance");
    }
    pub fn triggerCue(self:*Event) void {
        var inst: ?*fmod.FMOD_STUDIO_EVENTINSTANCE = events.getCopy(self.raw);
        errCheck(fmod.FMOD_Studio_EventInstance_TriggerCue(inst), "Triggering cue in event instance");
    }
    pub fn stop(self:*Event) void {
        var inst: ?*fmod.FMOD_STUDIO_EVENTINSTANCE = events.getCopy(self.raw);
        errCheck(fmod.FMOD_Studio_EventInstance_Stop(inst, fmod.FMOD_STUDIO_STOP_ALLOWFADEOUT), "Stopping event instance");
    }
    pub fn release(self:*Event) void {
        var inst: ?*fmod.FMOD_STUDIO_EVENTINSTANCE = events.getCopy(self.raw);
        errCheck(fmod.FMOD_Studio_EventInstance_Release(inst), "Releasing event instance");
        events.release(self.raw) catch {std.debug.panic("Failed to release fmod event", .{});};
    }
    pub fn halt(self:*Event) void {
        var inst: ?*fmod.FMOD_STUDIO_EVENTINSTANCE = events.getCopy(self.raw);
        errCheck(fmod.FMOD_Studio_EventInstance_Stop(inst, fmod.FMOD_STUDIO_STOP_IMMEDIATE), "Stopping event instance");
    }
    pub fn setVolume(self:*Event, value:f32) void {
        if(value == self.volume) {
            return;
        }
        var inst: ?*fmod.FMOD_STUDIO_EVENTINSTANCE = events.getCopy(self.raw);
        errCheck(fmod.FMOD_Studio_EventInstance_SetVolume(inst, value), "Changing volume");
        self.volume = value;
    }
};

fn errCheck(result: fmod.FMOD_RESULT, message: []const u8) void {
    if(result != fmod.FMOD_OK) {
        std.debug.panic("Fmod error while '{s}'\nError Code: {any}", .{message, result});
    }
}

pub fn init() void {
    var res: fmod.FMOD_RESULT = undefined;
    res = fmod.FMOD_Studio_System_Create(&sys, fmod.FMOD_VERSION);
    errCheck(res, "Creating the FMOD Studio System");

    if(std.builtin.mode == .Debug) {
        res = fmod.FMOD_Studio_System_Initialize(sys, 256, fmod.FMOD_STUDIO_INIT_LIVEUPDATE, fmod.FMOD_INIT_NORMAL, null);
        errCheck(res, "Initializing FMOD Studio System");
    } else {
        res = fmod.FMOD_Studio_System_Initialize(sys, 256, fmod.FMOD_STUDIO_INIT_NORMAL, fmod.FMOD_INIT_NORMAL, null);
        errCheck(res, "Initializing FMOD Studio System");
    }
}

pub fn update() void {
    var res = fmod.FMOD_Studio_System_Update(sys);
    errCheck(res, "Updating FMOD");
}