usingnamespace @import("std").zig.c_builtins;
pub const FMOD_BOOL = c_int;
pub const struct_FMOD_SYSTEM = opaque {};
pub const FMOD_SYSTEM = struct_FMOD_SYSTEM;
pub const struct_FMOD_SOUND = opaque {};
pub const FMOD_SOUND = struct_FMOD_SOUND;
pub const struct_FMOD_CHANNELCONTROL = opaque {};
pub const FMOD_CHANNELCONTROL = struct_FMOD_CHANNELCONTROL;
pub const struct_FMOD_CHANNEL = opaque {};
pub const FMOD_CHANNEL = struct_FMOD_CHANNEL;
pub const struct_FMOD_CHANNELGROUP = opaque {};
pub const FMOD_CHANNELGROUP = struct_FMOD_CHANNELGROUP;
pub const struct_FMOD_SOUNDGROUP = opaque {};
pub const FMOD_SOUNDGROUP = struct_FMOD_SOUNDGROUP;
pub const struct_FMOD_REVERB3D = opaque {};
pub const FMOD_REVERB3D = struct_FMOD_REVERB3D;
pub const struct_FMOD_DSP = opaque {};
pub const FMOD_DSP = struct_FMOD_DSP;
pub const struct_FMOD_DSPCONNECTION = opaque {};
pub const FMOD_DSPCONNECTION = struct_FMOD_DSPCONNECTION;
pub const struct_FMOD_POLYGON = opaque {};
pub const FMOD_POLYGON = struct_FMOD_POLYGON;
pub const struct_FMOD_GEOMETRY = opaque {};
pub const FMOD_GEOMETRY = struct_FMOD_GEOMETRY;
pub const struct_FMOD_SYNCPOINT = opaque {};
pub const FMOD_SYNCPOINT = struct_FMOD_SYNCPOINT;
pub const FMOD_ASYNCREADINFO = struct_FMOD_ASYNCREADINFO;
pub const FMOD_OK: c_int = 0;
pub const FMOD_ERR_BADCOMMAND: c_int = 1;
pub const FMOD_ERR_CHANNEL_ALLOC: c_int = 2;
pub const FMOD_ERR_CHANNEL_STOLEN: c_int = 3;
pub const FMOD_ERR_DMA: c_int = 4;
pub const FMOD_ERR_DSP_CONNECTION: c_int = 5;
pub const FMOD_ERR_DSP_DONTPROCESS: c_int = 6;
pub const FMOD_ERR_DSP_FORMAT: c_int = 7;
pub const FMOD_ERR_DSP_INUSE: c_int = 8;
pub const FMOD_ERR_DSP_NOTFOUND: c_int = 9;
pub const FMOD_ERR_DSP_RESERVED: c_int = 10;
pub const FMOD_ERR_DSP_SILENCE: c_int = 11;
pub const FMOD_ERR_DSP_TYPE: c_int = 12;
pub const FMOD_ERR_FILE_BAD: c_int = 13;
pub const FMOD_ERR_FILE_COULDNOTSEEK: c_int = 14;
pub const FMOD_ERR_FILE_DISKEJECTED: c_int = 15;
pub const FMOD_ERR_FILE_EOF: c_int = 16;
pub const FMOD_ERR_FILE_ENDOFDATA: c_int = 17;
pub const FMOD_ERR_FILE_NOTFOUND: c_int = 18;
pub const FMOD_ERR_FORMAT: c_int = 19;
pub const FMOD_ERR_HEADER_MISMATCH: c_int = 20;
pub const FMOD_ERR_HTTP: c_int = 21;
pub const FMOD_ERR_HTTP_ACCESS: c_int = 22;
pub const FMOD_ERR_HTTP_PROXY_AUTH: c_int = 23;
pub const FMOD_ERR_HTTP_SERVER_ERROR: c_int = 24;
pub const FMOD_ERR_HTTP_TIMEOUT: c_int = 25;
pub const FMOD_ERR_INITIALIZATION: c_int = 26;
pub const FMOD_ERR_INITIALIZED: c_int = 27;
pub const FMOD_ERR_INTERNAL: c_int = 28;
pub const FMOD_ERR_INVALID_FLOAT: c_int = 29;
pub const FMOD_ERR_INVALID_HANDLE: c_int = 30;
pub const FMOD_ERR_INVALID_PARAM: c_int = 31;
pub const FMOD_ERR_INVALID_POSITION: c_int = 32;
pub const FMOD_ERR_INVALID_SPEAKER: c_int = 33;
pub const FMOD_ERR_INVALID_SYNCPOINT: c_int = 34;
pub const FMOD_ERR_INVALID_THREAD: c_int = 35;
pub const FMOD_ERR_INVALID_VECTOR: c_int = 36;
pub const FMOD_ERR_MAXAUDIBLE: c_int = 37;
pub const FMOD_ERR_MEMORY: c_int = 38;
pub const FMOD_ERR_MEMORY_CANTPOINT: c_int = 39;
pub const FMOD_ERR_NEEDS3D: c_int = 40;
pub const FMOD_ERR_NEEDSHARDWARE: c_int = 41;
pub const FMOD_ERR_NET_CONNECT: c_int = 42;
pub const FMOD_ERR_NET_SOCKET_ERROR: c_int = 43;
pub const FMOD_ERR_NET_URL: c_int = 44;
pub const FMOD_ERR_NET_WOULD_BLOCK: c_int = 45;
pub const FMOD_ERR_NOTREADY: c_int = 46;
pub const FMOD_ERR_OUTPUT_ALLOCATED: c_int = 47;
pub const FMOD_ERR_OUTPUT_CREATEBUFFER: c_int = 48;
pub const FMOD_ERR_OUTPUT_DRIVERCALL: c_int = 49;
pub const FMOD_ERR_OUTPUT_FORMAT: c_int = 50;
pub const FMOD_ERR_OUTPUT_INIT: c_int = 51;
pub const FMOD_ERR_OUTPUT_NODRIVERS: c_int = 52;
pub const FMOD_ERR_PLUGIN: c_int = 53;
pub const FMOD_ERR_PLUGIN_MISSING: c_int = 54;
pub const FMOD_ERR_PLUGIN_RESOURCE: c_int = 55;
pub const FMOD_ERR_PLUGIN_VERSION: c_int = 56;
pub const FMOD_ERR_RECORD: c_int = 57;
pub const FMOD_ERR_REVERB_CHANNELGROUP: c_int = 58;
pub const FMOD_ERR_REVERB_INSTANCE: c_int = 59;
pub const FMOD_ERR_SUBSOUNDS: c_int = 60;
pub const FMOD_ERR_SUBSOUND_ALLOCATED: c_int = 61;
pub const FMOD_ERR_SUBSOUND_CANTMOVE: c_int = 62;
pub const FMOD_ERR_TAGNOTFOUND: c_int = 63;
pub const FMOD_ERR_TOOMANYCHANNELS: c_int = 64;
pub const FMOD_ERR_TRUNCATED: c_int = 65;
pub const FMOD_ERR_UNIMPLEMENTED: c_int = 66;
pub const FMOD_ERR_UNINITIALIZED: c_int = 67;
pub const FMOD_ERR_UNSUPPORTED: c_int = 68;
pub const FMOD_ERR_VERSION: c_int = 69;
pub const FMOD_ERR_EVENT_ALREADY_LOADED: c_int = 70;
pub const FMOD_ERR_EVENT_LIVEUPDATE_BUSY: c_int = 71;
pub const FMOD_ERR_EVENT_LIVEUPDATE_MISMATCH: c_int = 72;
pub const FMOD_ERR_EVENT_LIVEUPDATE_TIMEOUT: c_int = 73;
pub const FMOD_ERR_EVENT_NOTFOUND: c_int = 74;
pub const FMOD_ERR_STUDIO_UNINITIALIZED: c_int = 75;
pub const FMOD_ERR_STUDIO_NOT_LOADED: c_int = 76;
pub const FMOD_ERR_INVALID_STRING: c_int = 77;
pub const FMOD_ERR_ALREADY_LOCKED: c_int = 78;
pub const FMOD_ERR_NOT_LOCKED: c_int = 79;
pub const FMOD_ERR_RECORD_DISCONNECTED: c_int = 80;
pub const FMOD_ERR_TOOMANYSAMPLES: c_int = 81;
pub const FMOD_RESULT_FORCEINT: c_int = 65536;
pub const enum_FMOD_RESULT = c_uint;
pub const FMOD_RESULT = enum_FMOD_RESULT;
pub const FMOD_FILE_ASYNCDONE_FUNC = ?fn ([*c]FMOD_ASYNCREADINFO, FMOD_RESULT) callconv(.C) void;
pub const struct_FMOD_ASYNCREADINFO = extern struct {
    handle: ?*c_void,
    offset: c_uint,
    sizebytes: c_uint,
    priority: c_int,
    userdata: ?*c_void,
    buffer: ?*c_void,
    bytesread: c_uint,
    done: FMOD_FILE_ASYNCDONE_FUNC,
};
pub const FMOD_PORT_TYPE = c_uint;
pub const FMOD_PORT_INDEX = c_ulonglong;
pub const FMOD_DEBUG_FLAGS = c_uint;
pub const FMOD_MEMORY_TYPE = c_uint;
pub const FMOD_INITFLAGS = c_uint;
pub const FMOD_DRIVER_STATE = c_uint;
pub const FMOD_TIMEUNIT = c_uint;
pub const FMOD_SYSTEM_CALLBACK_TYPE = c_uint;
pub const FMOD_MODE = c_uint;
pub const FMOD_CHANNELMASK = c_uint;
pub const FMOD_THREAD_PRIORITY = c_int;
pub const FMOD_THREAD_STACK_SIZE = c_uint;
pub const FMOD_THREAD_AFFINITY = c_ulonglong;
pub const FMOD_THREAD_TYPE_MIXER: c_int = 0;
pub const FMOD_THREAD_TYPE_FEEDER: c_int = 1;
pub const FMOD_THREAD_TYPE_STREAM: c_int = 2;
pub const FMOD_THREAD_TYPE_FILE: c_int = 3;
pub const FMOD_THREAD_TYPE_NONBLOCKING: c_int = 4;
pub const FMOD_THREAD_TYPE_RECORD: c_int = 5;
pub const FMOD_THREAD_TYPE_GEOMETRY: c_int = 6;
pub const FMOD_THREAD_TYPE_PROFILER: c_int = 7;
pub const FMOD_THREAD_TYPE_STUDIO_UPDATE: c_int = 8;
pub const FMOD_THREAD_TYPE_STUDIO_LOAD_BANK: c_int = 9;
pub const FMOD_THREAD_TYPE_STUDIO_LOAD_SAMPLE: c_int = 10;
pub const FMOD_THREAD_TYPE_CONVOLUTION1: c_int = 11;
pub const FMOD_THREAD_TYPE_CONVOLUTION2: c_int = 12;
pub const FMOD_THREAD_TYPE_MAX: c_int = 13;
pub const FMOD_THREAD_TYPE_FORCEINT: c_int = 65536;
pub const enum_FMOD_THREAD_TYPE = c_uint;
pub const FMOD_THREAD_TYPE = enum_FMOD_THREAD_TYPE;
pub const FMOD_CHANNELCONTROL_CHANNEL: c_int = 0;
pub const FMOD_CHANNELCONTROL_CHANNELGROUP: c_int = 1;
pub const FMOD_CHANNELCONTROL_MAX: c_int = 2;
pub const FMOD_CHANNELCONTROL_FORCEINT: c_int = 65536;
pub const enum_FMOD_CHANNELCONTROL_TYPE = c_uint;
pub const FMOD_CHANNELCONTROL_TYPE = enum_FMOD_CHANNELCONTROL_TYPE;
pub const FMOD_OUTPUTTYPE_AUTODETECT: c_int = 0;
pub const FMOD_OUTPUTTYPE_UNKNOWN: c_int = 1;
pub const FMOD_OUTPUTTYPE_NOSOUND: c_int = 2;
pub const FMOD_OUTPUTTYPE_WAVWRITER: c_int = 3;
pub const FMOD_OUTPUTTYPE_NOSOUND_NRT: c_int = 4;
pub const FMOD_OUTPUTTYPE_WAVWRITER_NRT: c_int = 5;
pub const FMOD_OUTPUTTYPE_WASAPI: c_int = 6;
pub const FMOD_OUTPUTTYPE_ASIO: c_int = 7;
pub const FMOD_OUTPUTTYPE_PULSEAUDIO: c_int = 8;
pub const FMOD_OUTPUTTYPE_ALSA: c_int = 9;
pub const FMOD_OUTPUTTYPE_COREAUDIO: c_int = 10;
pub const FMOD_OUTPUTTYPE_AUDIOTRACK: c_int = 11;
pub const FMOD_OUTPUTTYPE_OPENSL: c_int = 12;
pub const FMOD_OUTPUTTYPE_AUDIOOUT: c_int = 13;
pub const FMOD_OUTPUTTYPE_AUDIO3D: c_int = 14;
pub const FMOD_OUTPUTTYPE_WEBAUDIO: c_int = 15;
pub const FMOD_OUTPUTTYPE_NNAUDIO: c_int = 16;
pub const FMOD_OUTPUTTYPE_WINSONIC: c_int = 17;
pub const FMOD_OUTPUTTYPE_AAUDIO: c_int = 18;
pub const FMOD_OUTPUTTYPE_MAX: c_int = 19;
pub const FMOD_OUTPUTTYPE_FORCEINT: c_int = 65536;
pub const enum_FMOD_OUTPUTTYPE = c_uint;
pub const FMOD_OUTPUTTYPE = enum_FMOD_OUTPUTTYPE;
pub const FMOD_DEBUG_MODE_TTY: c_int = 0;
pub const FMOD_DEBUG_MODE_FILE: c_int = 1;
pub const FMOD_DEBUG_MODE_CALLBACK: c_int = 2;
pub const FMOD_DEBUG_MODE_FORCEINT: c_int = 65536;
pub const enum_FMOD_DEBUG_MODE = c_uint;
pub const FMOD_DEBUG_MODE = enum_FMOD_DEBUG_MODE;
pub const FMOD_SPEAKERMODE_DEFAULT: c_int = 0;
pub const FMOD_SPEAKERMODE_RAW: c_int = 1;
pub const FMOD_SPEAKERMODE_MONO: c_int = 2;
pub const FMOD_SPEAKERMODE_STEREO: c_int = 3;
pub const FMOD_SPEAKERMODE_QUAD: c_int = 4;
pub const FMOD_SPEAKERMODE_SURROUND: c_int = 5;
pub const FMOD_SPEAKERMODE_5POINT1: c_int = 6;
pub const FMOD_SPEAKERMODE_7POINT1: c_int = 7;
pub const FMOD_SPEAKERMODE_7POINT1POINT4: c_int = 8;
pub const FMOD_SPEAKERMODE_MAX: c_int = 9;
pub const FMOD_SPEAKERMODE_FORCEINT: c_int = 65536;
pub const enum_FMOD_SPEAKERMODE = c_uint;
pub const FMOD_SPEAKERMODE = enum_FMOD_SPEAKERMODE;
pub const FMOD_SPEAKER_NONE: c_int = -1;
pub const FMOD_SPEAKER_FRONT_LEFT: c_int = 0;
pub const FMOD_SPEAKER_FRONT_RIGHT: c_int = 1;
pub const FMOD_SPEAKER_FRONT_CENTER: c_int = 2;
pub const FMOD_SPEAKER_LOW_FREQUENCY: c_int = 3;
pub const FMOD_SPEAKER_SURROUND_LEFT: c_int = 4;
pub const FMOD_SPEAKER_SURROUND_RIGHT: c_int = 5;
pub const FMOD_SPEAKER_BACK_LEFT: c_int = 6;
pub const FMOD_SPEAKER_BACK_RIGHT: c_int = 7;
pub const FMOD_SPEAKER_TOP_FRONT_LEFT: c_int = 8;
pub const FMOD_SPEAKER_TOP_FRONT_RIGHT: c_int = 9;
pub const FMOD_SPEAKER_TOP_BACK_LEFT: c_int = 10;
pub const FMOD_SPEAKER_TOP_BACK_RIGHT: c_int = 11;
pub const FMOD_SPEAKER_MAX: c_int = 12;
pub const FMOD_SPEAKER_FORCEINT: c_int = 65536;
pub const enum_FMOD_SPEAKER = c_int;
pub const FMOD_SPEAKER = enum_FMOD_SPEAKER;
pub const FMOD_CHANNELORDER_DEFAULT: c_int = 0;
pub const FMOD_CHANNELORDER_WAVEFORMAT: c_int = 1;
pub const FMOD_CHANNELORDER_PROTOOLS: c_int = 2;
pub const FMOD_CHANNELORDER_ALLMONO: c_int = 3;
pub const FMOD_CHANNELORDER_ALLSTEREO: c_int = 4;
pub const FMOD_CHANNELORDER_ALSA: c_int = 5;
pub const FMOD_CHANNELORDER_MAX: c_int = 6;
pub const FMOD_CHANNELORDER_FORCEINT: c_int = 65536;
pub const enum_FMOD_CHANNELORDER = c_uint;
pub const FMOD_CHANNELORDER = enum_FMOD_CHANNELORDER;
pub const FMOD_PLUGINTYPE_OUTPUT: c_int = 0;
pub const FMOD_PLUGINTYPE_CODEC: c_int = 1;
pub const FMOD_PLUGINTYPE_DSP: c_int = 2;
pub const FMOD_PLUGINTYPE_MAX: c_int = 3;
pub const FMOD_PLUGINTYPE_FORCEINT: c_int = 65536;
pub const enum_FMOD_PLUGINTYPE = c_uint;
pub const FMOD_PLUGINTYPE = enum_FMOD_PLUGINTYPE;
pub const FMOD_SOUND_TYPE_UNKNOWN: c_int = 0;
pub const FMOD_SOUND_TYPE_AIFF: c_int = 1;
pub const FMOD_SOUND_TYPE_ASF: c_int = 2;
pub const FMOD_SOUND_TYPE_DLS: c_int = 3;
pub const FMOD_SOUND_TYPE_FLAC: c_int = 4;
pub const FMOD_SOUND_TYPE_FSB: c_int = 5;
pub const FMOD_SOUND_TYPE_IT: c_int = 6;
pub const FMOD_SOUND_TYPE_MIDI: c_int = 7;
pub const FMOD_SOUND_TYPE_MOD: c_int = 8;
pub const FMOD_SOUND_TYPE_MPEG: c_int = 9;
pub const FMOD_SOUND_TYPE_OGGVORBIS: c_int = 10;
pub const FMOD_SOUND_TYPE_PLAYLIST: c_int = 11;
pub const FMOD_SOUND_TYPE_RAW: c_int = 12;
pub const FMOD_SOUND_TYPE_S3M: c_int = 13;
pub const FMOD_SOUND_TYPE_USER: c_int = 14;
pub const FMOD_SOUND_TYPE_WAV: c_int = 15;
pub const FMOD_SOUND_TYPE_XM: c_int = 16;
pub const FMOD_SOUND_TYPE_XMA: c_int = 17;
pub const FMOD_SOUND_TYPE_AUDIOQUEUE: c_int = 18;
pub const FMOD_SOUND_TYPE_AT9: c_int = 19;
pub const FMOD_SOUND_TYPE_VORBIS: c_int = 20;
pub const FMOD_SOUND_TYPE_MEDIA_FOUNDATION: c_int = 21;
pub const FMOD_SOUND_TYPE_MEDIACODEC: c_int = 22;
pub const FMOD_SOUND_TYPE_FADPCM: c_int = 23;
pub const FMOD_SOUND_TYPE_OPUS: c_int = 24;
pub const FMOD_SOUND_TYPE_MAX: c_int = 25;
pub const FMOD_SOUND_TYPE_FORCEINT: c_int = 65536;
pub const enum_FMOD_SOUND_TYPE = c_uint;
pub const FMOD_SOUND_TYPE = enum_FMOD_SOUND_TYPE;
pub const FMOD_SOUND_FORMAT_NONE: c_int = 0;
pub const FMOD_SOUND_FORMAT_PCM8: c_int = 1;
pub const FMOD_SOUND_FORMAT_PCM16: c_int = 2;
pub const FMOD_SOUND_FORMAT_PCM24: c_int = 3;
pub const FMOD_SOUND_FORMAT_PCM32: c_int = 4;
pub const FMOD_SOUND_FORMAT_PCMFLOAT: c_int = 5;
pub const FMOD_SOUND_FORMAT_BITSTREAM: c_int = 6;
pub const FMOD_SOUND_FORMAT_MAX: c_int = 7;
pub const FMOD_SOUND_FORMAT_FORCEINT: c_int = 65536;
pub const enum_FMOD_SOUND_FORMAT = c_uint;
pub const FMOD_SOUND_FORMAT = enum_FMOD_SOUND_FORMAT;
pub const FMOD_OPENSTATE_READY: c_int = 0;
pub const FMOD_OPENSTATE_LOADING: c_int = 1;
pub const FMOD_OPENSTATE_ERROR: c_int = 2;
pub const FMOD_OPENSTATE_CONNECTING: c_int = 3;
pub const FMOD_OPENSTATE_BUFFERING: c_int = 4;
pub const FMOD_OPENSTATE_SEEKING: c_int = 5;
pub const FMOD_OPENSTATE_PLAYING: c_int = 6;
pub const FMOD_OPENSTATE_SETPOSITION: c_int = 7;
pub const FMOD_OPENSTATE_MAX: c_int = 8;
pub const FMOD_OPENSTATE_FORCEINT: c_int = 65536;
pub const enum_FMOD_OPENSTATE = c_uint;
pub const FMOD_OPENSTATE = enum_FMOD_OPENSTATE;
pub const FMOD_SOUNDGROUP_BEHAVIOR_FAIL: c_int = 0;
pub const FMOD_SOUNDGROUP_BEHAVIOR_MUTE: c_int = 1;
pub const FMOD_SOUNDGROUP_BEHAVIOR_STEALLOWEST: c_int = 2;
pub const FMOD_SOUNDGROUP_BEHAVIOR_MAX: c_int = 3;
pub const FMOD_SOUNDGROUP_BEHAVIOR_FORCEINT: c_int = 65536;
pub const enum_FMOD_SOUNDGROUP_BEHAVIOR = c_uint;
pub const FMOD_SOUNDGROUP_BEHAVIOR = enum_FMOD_SOUNDGROUP_BEHAVIOR;
pub const FMOD_CHANNELCONTROL_CALLBACK_END: c_int = 0;
pub const FMOD_CHANNELCONTROL_CALLBACK_VIRTUALVOICE: c_int = 1;
pub const FMOD_CHANNELCONTROL_CALLBACK_SYNCPOINT: c_int = 2;
pub const FMOD_CHANNELCONTROL_CALLBACK_OCCLUSION: c_int = 3;
pub const FMOD_CHANNELCONTROL_CALLBACK_MAX: c_int = 4;
pub const FMOD_CHANNELCONTROL_CALLBACK_FORCEINT: c_int = 65536;
pub const enum_FMOD_CHANNELCONTROL_CALLBACK_TYPE = c_uint;
pub const FMOD_CHANNELCONTROL_CALLBACK_TYPE = enum_FMOD_CHANNELCONTROL_CALLBACK_TYPE;
pub const FMOD_CHANNELCONTROL_DSP_HEAD: c_int = -1;
pub const FMOD_CHANNELCONTROL_DSP_FADER: c_int = -2;
pub const FMOD_CHANNELCONTROL_DSP_TAIL: c_int = -3;
pub const FMOD_CHANNELCONTROL_DSP_FORCEINT: c_int = 65536;
pub const enum_FMOD_CHANNELCONTROL_DSP_INDEX = c_int;
pub const FMOD_CHANNELCONTROL_DSP_INDEX = enum_FMOD_CHANNELCONTROL_DSP_INDEX;
pub const FMOD_ERRORCALLBACK_INSTANCETYPE_NONE: c_int = 0;
pub const FMOD_ERRORCALLBACK_INSTANCETYPE_SYSTEM: c_int = 1;
pub const FMOD_ERRORCALLBACK_INSTANCETYPE_CHANNEL: c_int = 2;
pub const FMOD_ERRORCALLBACK_INSTANCETYPE_CHANNELGROUP: c_int = 3;
pub const FMOD_ERRORCALLBACK_INSTANCETYPE_CHANNELCONTROL: c_int = 4;
pub const FMOD_ERRORCALLBACK_INSTANCETYPE_SOUND: c_int = 5;
pub const FMOD_ERRORCALLBACK_INSTANCETYPE_SOUNDGROUP: c_int = 6;
pub const FMOD_ERRORCALLBACK_INSTANCETYPE_DSP: c_int = 7;
pub const FMOD_ERRORCALLBACK_INSTANCETYPE_DSPCONNECTION: c_int = 8;
pub const FMOD_ERRORCALLBACK_INSTANCETYPE_GEOMETRY: c_int = 9;
pub const FMOD_ERRORCALLBACK_INSTANCETYPE_REVERB3D: c_int = 10;
pub const FMOD_ERRORCALLBACK_INSTANCETYPE_STUDIO_SYSTEM: c_int = 11;
pub const FMOD_ERRORCALLBACK_INSTANCETYPE_STUDIO_EVENTDESCRIPTION: c_int = 12;
pub const FMOD_ERRORCALLBACK_INSTANCETYPE_STUDIO_EVENTINSTANCE: c_int = 13;
pub const FMOD_ERRORCALLBACK_INSTANCETYPE_STUDIO_PARAMETERINSTANCE: c_int = 14;
pub const FMOD_ERRORCALLBACK_INSTANCETYPE_STUDIO_BUS: c_int = 15;
pub const FMOD_ERRORCALLBACK_INSTANCETYPE_STUDIO_VCA: c_int = 16;
pub const FMOD_ERRORCALLBACK_INSTANCETYPE_STUDIO_BANK: c_int = 17;
pub const FMOD_ERRORCALLBACK_INSTANCETYPE_STUDIO_COMMANDREPLAY: c_int = 18;
pub const FMOD_ERRORCALLBACK_INSTANCETYPE_FORCEINT: c_int = 65536;
pub const enum_FMOD_ERRORCALLBACK_INSTANCETYPE = c_uint;
pub const FMOD_ERRORCALLBACK_INSTANCETYPE = enum_FMOD_ERRORCALLBACK_INSTANCETYPE;
pub const FMOD_DSP_RESAMPLER_DEFAULT: c_int = 0;
pub const FMOD_DSP_RESAMPLER_NOINTERP: c_int = 1;
pub const FMOD_DSP_RESAMPLER_LINEAR: c_int = 2;
pub const FMOD_DSP_RESAMPLER_CUBIC: c_int = 3;
pub const FMOD_DSP_RESAMPLER_SPLINE: c_int = 4;
pub const FMOD_DSP_RESAMPLER_MAX: c_int = 5;
pub const FMOD_DSP_RESAMPLER_FORCEINT: c_int = 65536;
pub const enum_FMOD_DSP_RESAMPLER = c_uint;
pub const FMOD_DSP_RESAMPLER = enum_FMOD_DSP_RESAMPLER;
pub const FMOD_DSPCONNECTION_TYPE_STANDARD: c_int = 0;
pub const FMOD_DSPCONNECTION_TYPE_SIDECHAIN: c_int = 1;
pub const FMOD_DSPCONNECTION_TYPE_SEND: c_int = 2;
pub const FMOD_DSPCONNECTION_TYPE_SEND_SIDECHAIN: c_int = 3;
pub const FMOD_DSPCONNECTION_TYPE_MAX: c_int = 4;
pub const FMOD_DSPCONNECTION_TYPE_FORCEINT: c_int = 65536;
pub const enum_FMOD_DSPCONNECTION_TYPE = c_uint;
pub const FMOD_DSPCONNECTION_TYPE = enum_FMOD_DSPCONNECTION_TYPE;
pub const FMOD_TAGTYPE_UNKNOWN: c_int = 0;
pub const FMOD_TAGTYPE_ID3V1: c_int = 1;
pub const FMOD_TAGTYPE_ID3V2: c_int = 2;
pub const FMOD_TAGTYPE_VORBISCOMMENT: c_int = 3;
pub const FMOD_TAGTYPE_SHOUTCAST: c_int = 4;
pub const FMOD_TAGTYPE_ICECAST: c_int = 5;
pub const FMOD_TAGTYPE_ASF: c_int = 6;
pub const FMOD_TAGTYPE_MIDI: c_int = 7;
pub const FMOD_TAGTYPE_PLAYLIST: c_int = 8;
pub const FMOD_TAGTYPE_FMOD: c_int = 9;
pub const FMOD_TAGTYPE_USER: c_int = 10;
pub const FMOD_TAGTYPE_MAX: c_int = 11;
pub const FMOD_TAGTYPE_FORCEINT: c_int = 65536;
pub const enum_FMOD_TAGTYPE = c_uint;
pub const FMOD_TAGTYPE = enum_FMOD_TAGTYPE;
pub const FMOD_TAGDATATYPE_BINARY: c_int = 0;
pub const FMOD_TAGDATATYPE_INT: c_int = 1;
pub const FMOD_TAGDATATYPE_FLOAT: c_int = 2;
pub const FMOD_TAGDATATYPE_STRING: c_int = 3;
pub const FMOD_TAGDATATYPE_STRING_UTF16: c_int = 4;
pub const FMOD_TAGDATATYPE_STRING_UTF16BE: c_int = 5;
pub const FMOD_TAGDATATYPE_STRING_UTF8: c_int = 6;
pub const FMOD_TAGDATATYPE_MAX: c_int = 7;
pub const FMOD_TAGDATATYPE_FORCEINT: c_int = 65536;
pub const enum_FMOD_TAGDATATYPE = c_uint;
pub const FMOD_TAGDATATYPE = enum_FMOD_TAGDATATYPE;
pub const FMOD_DEBUG_CALLBACK = ?fn (FMOD_DEBUG_FLAGS, [*c]const u8, c_int, [*c]const u8, [*c]const u8) callconv(.C) FMOD_RESULT;
pub const FMOD_SYSTEM_CALLBACK = ?fn (?*FMOD_SYSTEM, FMOD_SYSTEM_CALLBACK_TYPE, ?*c_void, ?*c_void, ?*c_void) callconv(.C) FMOD_RESULT;
pub const FMOD_CHANNELCONTROL_CALLBACK = ?fn (?*FMOD_CHANNELCONTROL, FMOD_CHANNELCONTROL_TYPE, FMOD_CHANNELCONTROL_CALLBACK_TYPE, ?*c_void, ?*c_void) callconv(.C) FMOD_RESULT;
pub const FMOD_SOUND_NONBLOCK_CALLBACK = ?fn (?*FMOD_SOUND, FMOD_RESULT) callconv(.C) FMOD_RESULT;
pub const FMOD_SOUND_PCMREAD_CALLBACK = ?fn (?*FMOD_SOUND, ?*c_void, c_uint) callconv(.C) FMOD_RESULT;
pub const FMOD_SOUND_PCMSETPOS_CALLBACK = ?fn (?*FMOD_SOUND, c_int, c_uint, FMOD_TIMEUNIT) callconv(.C) FMOD_RESULT;
pub const FMOD_FILE_OPEN_CALLBACK = ?fn ([*c]const u8, [*c]c_uint, [*c]?*c_void, ?*c_void) callconv(.C) FMOD_RESULT;
pub const FMOD_FILE_CLOSE_CALLBACK = ?fn (?*c_void, ?*c_void) callconv(.C) FMOD_RESULT;
pub const FMOD_FILE_READ_CALLBACK = ?fn (?*c_void, ?*c_void, c_uint, [*c]c_uint, ?*c_void) callconv(.C) FMOD_RESULT;
pub const FMOD_FILE_SEEK_CALLBACK = ?fn (?*c_void, c_uint, ?*c_void) callconv(.C) FMOD_RESULT;
pub const FMOD_FILE_ASYNCREAD_CALLBACK = ?fn ([*c]FMOD_ASYNCREADINFO, ?*c_void) callconv(.C) FMOD_RESULT;
pub const FMOD_FILE_ASYNCCANCEL_CALLBACK = ?fn ([*c]FMOD_ASYNCREADINFO, ?*c_void) callconv(.C) FMOD_RESULT;
pub const FMOD_MEMORY_ALLOC_CALLBACK = ?fn (c_uint, FMOD_MEMORY_TYPE, [*c]const u8) callconv(.C) ?*c_void;
pub const FMOD_MEMORY_REALLOC_CALLBACK = ?fn (?*c_void, c_uint, FMOD_MEMORY_TYPE, [*c]const u8) callconv(.C) ?*c_void;
pub const FMOD_MEMORY_FREE_CALLBACK = ?fn (?*c_void, FMOD_MEMORY_TYPE, [*c]const u8) callconv(.C) void;
pub const FMOD_3D_ROLLOFF_CALLBACK = ?fn (?*FMOD_CHANNELCONTROL, f32) callconv(.C) f32;
pub const struct_FMOD_VECTOR = extern struct {
    x: f32,
    y: f32,
    z: f32,
};
pub const FMOD_VECTOR = struct_FMOD_VECTOR;
pub const struct_FMOD_3D_ATTRIBUTES = extern struct {
    position: FMOD_VECTOR,
    velocity: FMOD_VECTOR,
    forward: FMOD_VECTOR,
    up: FMOD_VECTOR,
};
pub const FMOD_3D_ATTRIBUTES = struct_FMOD_3D_ATTRIBUTES;
pub const struct_FMOD_GUID = extern struct {
    Data1: c_uint,
    Data2: c_ushort,
    Data3: c_ushort,
    Data4: [8]u8,
};
pub const FMOD_GUID = struct_FMOD_GUID;
pub const struct_FMOD_PLUGINLIST = extern struct {
    type: FMOD_PLUGINTYPE,
    description: ?*c_void,
};
pub const FMOD_PLUGINLIST = struct_FMOD_PLUGINLIST;
pub const struct_FMOD_ADVANCEDSETTINGS = extern struct {
    cbSize: c_int,
    maxMPEGCodecs: c_int,
    maxADPCMCodecs: c_int,
    maxXMACodecs: c_int,
    maxVorbisCodecs: c_int,
    maxAT9Codecs: c_int,
    maxFADPCMCodecs: c_int,
    maxPCMCodecs: c_int,
    ASIONumChannels: c_int,
    ASIOChannelList: [*c][*c]u8,
    ASIOSpeakerList: [*c]FMOD_SPEAKER,
    vol0virtualvol: f32,
    defaultDecodeBufferSize: c_uint,
    profilePort: c_ushort,
    geometryMaxFadeTime: c_uint,
    distanceFilterCenterFreq: f32,
    reverb3Dinstance: c_int,
    DSPBufferPoolSize: c_int,
    resamplerMethod: FMOD_DSP_RESAMPLER,
    randomSeed: c_uint,
    maxConvolutionThreads: c_int,
};
pub const FMOD_ADVANCEDSETTINGS = struct_FMOD_ADVANCEDSETTINGS;
pub const struct_FMOD_TAG = extern struct {
    type: FMOD_TAGTYPE,
    datatype: FMOD_TAGDATATYPE,
    name: [*c]u8,
    data: ?*c_void,
    datalen: c_uint,
    updated: FMOD_BOOL,
};
pub const FMOD_TAG = struct_FMOD_TAG;
pub const struct_FMOD_CREATESOUNDEXINFO = extern struct {
    cbsize: c_int,
    length: c_uint,
    fileoffset: c_uint,
    numchannels: c_int,
    defaultfrequency: c_int,
    format: FMOD_SOUND_FORMAT,
    decodebuffersize: c_uint,
    initialsubsound: c_int,
    numsubsounds: c_int,
    inclusionlist: [*c]c_int,
    inclusionlistnum: c_int,
    pcmreadcallback: FMOD_SOUND_PCMREAD_CALLBACK,
    pcmsetposcallback: FMOD_SOUND_PCMSETPOS_CALLBACK,
    nonblockcallback: FMOD_SOUND_NONBLOCK_CALLBACK,
    dlsname: [*c]const u8,
    encryptionkey: [*c]const u8,
    maxpolyphony: c_int,
    userdata: ?*c_void,
    suggestedsoundtype: FMOD_SOUND_TYPE,
    fileuseropen: FMOD_FILE_OPEN_CALLBACK,
    fileuserclose: FMOD_FILE_CLOSE_CALLBACK,
    fileuserread: FMOD_FILE_READ_CALLBACK,
    fileuserseek: FMOD_FILE_SEEK_CALLBACK,
    fileuserasyncread: FMOD_FILE_ASYNCREAD_CALLBACK,
    fileuserasynccancel: FMOD_FILE_ASYNCCANCEL_CALLBACK,
    fileuserdata: ?*c_void,
    filebuffersize: c_int,
    channelorder: FMOD_CHANNELORDER,
    initialsoundgroup: ?*FMOD_SOUNDGROUP,
    initialseekposition: c_uint,
    initialseekpostype: FMOD_TIMEUNIT,
    ignoresetfilesystem: c_int,
    audioqueuepolicy: c_uint,
    minmidigranularity: c_uint,
    nonblockthreadid: c_int,
    fsbguid: [*c]FMOD_GUID,
};
pub const FMOD_CREATESOUNDEXINFO = struct_FMOD_CREATESOUNDEXINFO;
pub const struct_FMOD_REVERB_PROPERTIES = extern struct {
    DecayTime: f32,
    EarlyDelay: f32,
    LateDelay: f32,
    HFReference: f32,
    HFDecayRatio: f32,
    Diffusion: f32,
    Density: f32,
    LowShelfFrequency: f32,
    LowShelfGain: f32,
    HighCut: f32,
    EarlyLateMix: f32,
    WetLevel: f32,
};
pub const FMOD_REVERB_PROPERTIES = struct_FMOD_REVERB_PROPERTIES;
pub const struct_FMOD_ERRORCALLBACK_INFO = extern struct {
    result: FMOD_RESULT,
    instancetype: FMOD_ERRORCALLBACK_INSTANCETYPE,
    instance: ?*c_void,
    functionname: [*c]const u8,
    functionparams: [*c]const u8,
};
pub const FMOD_ERRORCALLBACK_INFO = struct_FMOD_ERRORCALLBACK_INFO;
pub const struct_FMOD_CODEC_WAVEFORMAT = extern struct {
    name: [*c]const u8,
    format: FMOD_SOUND_FORMAT,
    channels: c_int,
    frequency: c_int,
    lengthbytes: c_uint,
    lengthpcm: c_uint,
    pcmblocksize: c_uint,
    loopstart: c_int,
    loopend: c_int,
    mode: FMOD_MODE,
    channelmask: FMOD_CHANNELMASK,
    channelorder: FMOD_CHANNELORDER,
    peakvolume: f32,
};
pub const FMOD_CODEC_WAVEFORMAT = struct_FMOD_CODEC_WAVEFORMAT;
pub const FMOD_CODEC_STATE = struct_FMOD_CODEC_STATE;
pub const FMOD_CODEC_METADATA_FUNC = ?fn ([*c]FMOD_CODEC_STATE, FMOD_TAGTYPE, [*c]u8, ?*c_void, c_uint, FMOD_TAGDATATYPE, c_int) callconv(.C) FMOD_RESULT;
pub const struct_FMOD_CODEC_STATE = extern struct {
    numsubsounds: c_int,
    waveformat: [*c]FMOD_CODEC_WAVEFORMAT,
    plugindata: ?*c_void,
    filehandle: ?*c_void,
    filesize: c_uint,
    fileread: FMOD_FILE_READ_CALLBACK,
    fileseek: FMOD_FILE_SEEK_CALLBACK,
    metadata: FMOD_CODEC_METADATA_FUNC,
    waveformatversion: c_int,
};
pub const FMOD_CODEC_OPEN_CALLBACK = ?fn ([*c]FMOD_CODEC_STATE, FMOD_MODE, [*c]FMOD_CREATESOUNDEXINFO) callconv(.C) FMOD_RESULT;
pub const FMOD_CODEC_CLOSE_CALLBACK = ?fn ([*c]FMOD_CODEC_STATE) callconv(.C) FMOD_RESULT;
pub const FMOD_CODEC_READ_CALLBACK = ?fn ([*c]FMOD_CODEC_STATE, ?*c_void, c_uint, [*c]c_uint) callconv(.C) FMOD_RESULT;
pub const FMOD_CODEC_GETLENGTH_CALLBACK = ?fn ([*c]FMOD_CODEC_STATE, [*c]c_uint, FMOD_TIMEUNIT) callconv(.C) FMOD_RESULT;
pub const FMOD_CODEC_SETPOSITION_CALLBACK = ?fn ([*c]FMOD_CODEC_STATE, c_int, c_uint, FMOD_TIMEUNIT) callconv(.C) FMOD_RESULT;
pub const FMOD_CODEC_GETPOSITION_CALLBACK = ?fn ([*c]FMOD_CODEC_STATE, [*c]c_uint, FMOD_TIMEUNIT) callconv(.C) FMOD_RESULT;
pub const FMOD_CODEC_SOUNDCREATE_CALLBACK = ?fn ([*c]FMOD_CODEC_STATE, c_int, ?*FMOD_SOUND) callconv(.C) FMOD_RESULT;
pub const FMOD_CODEC_GETWAVEFORMAT_CALLBACK = ?fn ([*c]FMOD_CODEC_STATE, c_int, [*c]FMOD_CODEC_WAVEFORMAT) callconv(.C) FMOD_RESULT;
pub const struct_FMOD_CODEC_DESCRIPTION = extern struct {
    name: [*c]const u8,
    version: c_uint,
    defaultasstream: c_int,
    timeunits: FMOD_TIMEUNIT,
    open: FMOD_CODEC_OPEN_CALLBACK,
    close: FMOD_CODEC_CLOSE_CALLBACK,
    read: FMOD_CODEC_READ_CALLBACK,
    getlength: FMOD_CODEC_GETLENGTH_CALLBACK,
    setposition: FMOD_CODEC_SETPOSITION_CALLBACK,
    getposition: FMOD_CODEC_GETPOSITION_CALLBACK,
    soundcreate: FMOD_CODEC_SOUNDCREATE_CALLBACK,
    getwaveformat: FMOD_CODEC_GETWAVEFORMAT_CALLBACK,
};
pub const FMOD_CODEC_DESCRIPTION = struct_FMOD_CODEC_DESCRIPTION;
pub const FMOD_DSP_TYPE_UNKNOWN: c_int = 0;
pub const FMOD_DSP_TYPE_MIXER: c_int = 1;
pub const FMOD_DSP_TYPE_OSCILLATOR: c_int = 2;
pub const FMOD_DSP_TYPE_LOWPASS: c_int = 3;
pub const FMOD_DSP_TYPE_ITLOWPASS: c_int = 4;
pub const FMOD_DSP_TYPE_HIGHPASS: c_int = 5;
pub const FMOD_DSP_TYPE_ECHO: c_int = 6;
pub const FMOD_DSP_TYPE_FADER: c_int = 7;
pub const FMOD_DSP_TYPE_FLANGE: c_int = 8;
pub const FMOD_DSP_TYPE_DISTORTION: c_int = 9;
pub const FMOD_DSP_TYPE_NORMALIZE: c_int = 10;
pub const FMOD_DSP_TYPE_LIMITER: c_int = 11;
pub const FMOD_DSP_TYPE_PARAMEQ: c_int = 12;
pub const FMOD_DSP_TYPE_PITCHSHIFT: c_int = 13;
pub const FMOD_DSP_TYPE_CHORUS: c_int = 14;
pub const FMOD_DSP_TYPE_VSTPLUGIN: c_int = 15;
pub const FMOD_DSP_TYPE_WINAMPPLUGIN: c_int = 16;
pub const FMOD_DSP_TYPE_ITECHO: c_int = 17;
pub const FMOD_DSP_TYPE_COMPRESSOR: c_int = 18;
pub const FMOD_DSP_TYPE_SFXREVERB: c_int = 19;
pub const FMOD_DSP_TYPE_LOWPASS_SIMPLE: c_int = 20;
pub const FMOD_DSP_TYPE_DELAY: c_int = 21;
pub const FMOD_DSP_TYPE_TREMOLO: c_int = 22;
pub const FMOD_DSP_TYPE_LADSPAPLUGIN: c_int = 23;
pub const FMOD_DSP_TYPE_SEND: c_int = 24;
pub const FMOD_DSP_TYPE_RETURN: c_int = 25;
pub const FMOD_DSP_TYPE_HIGHPASS_SIMPLE: c_int = 26;
pub const FMOD_DSP_TYPE_PAN: c_int = 27;
pub const FMOD_DSP_TYPE_THREE_EQ: c_int = 28;
pub const FMOD_DSP_TYPE_FFT: c_int = 29;
pub const FMOD_DSP_TYPE_LOUDNESS_METER: c_int = 30;
pub const FMOD_DSP_TYPE_ENVELOPEFOLLOWER: c_int = 31;
pub const FMOD_DSP_TYPE_CONVOLUTIONREVERB: c_int = 32;
pub const FMOD_DSP_TYPE_CHANNELMIX: c_int = 33;
pub const FMOD_DSP_TYPE_TRANSCEIVER: c_int = 34;
pub const FMOD_DSP_TYPE_OBJECTPAN: c_int = 35;
pub const FMOD_DSP_TYPE_MULTIBAND_EQ: c_int = 36;
pub const FMOD_DSP_TYPE_MAX: c_int = 37;
pub const FMOD_DSP_TYPE_FORCEINT: c_int = 65536;
pub const FMOD_DSP_TYPE = c_uint;
pub const FMOD_DSP_OSCILLATOR_TYPE: c_int = 0;
pub const FMOD_DSP_OSCILLATOR_RATE: c_int = 1;
pub const FMOD_DSP_OSCILLATOR = c_uint;
pub const FMOD_DSP_LOWPASS_CUTOFF: c_int = 0;
pub const FMOD_DSP_LOWPASS_RESONANCE: c_int = 1;
pub const FMOD_DSP_LOWPASS = c_uint;
pub const FMOD_DSP_ITLOWPASS_CUTOFF: c_int = 0;
pub const FMOD_DSP_ITLOWPASS_RESONANCE: c_int = 1;
pub const FMOD_DSP_ITLOWPASS = c_uint;
pub const FMOD_DSP_HIGHPASS_CUTOFF: c_int = 0;
pub const FMOD_DSP_HIGHPASS_RESONANCE: c_int = 1;
pub const FMOD_DSP_HIGHPASS = c_uint;
pub const FMOD_DSP_ECHO_DELAY: c_int = 0;
pub const FMOD_DSP_ECHO_FEEDBACK: c_int = 1;
pub const FMOD_DSP_ECHO_DRYLEVEL: c_int = 2;
pub const FMOD_DSP_ECHO_WETLEVEL: c_int = 3;
pub const FMOD_DSP_ECHO = c_uint;
pub const FMOD_DSP_FADER_GAIN: c_int = 0;
pub const FMOD_DSP_FADER_OVERALL_GAIN: c_int = 1;
pub const enum_FMOD_DSP_FADER = c_uint;
pub const FMOD_DSP_FADER = enum_FMOD_DSP_FADER;
pub const FMOD_DSP_FLANGE_MIX: c_int = 0;
pub const FMOD_DSP_FLANGE_DEPTH: c_int = 1;
pub const FMOD_DSP_FLANGE_RATE: c_int = 2;
pub const FMOD_DSP_FLANGE = c_uint;
pub const FMOD_DSP_DISTORTION_LEVEL: c_int = 0;
pub const FMOD_DSP_DISTORTION = c_uint;
pub const FMOD_DSP_NORMALIZE_FADETIME: c_int = 0;
pub const FMOD_DSP_NORMALIZE_THRESHHOLD: c_int = 1;
pub const FMOD_DSP_NORMALIZE_MAXAMP: c_int = 2;
pub const FMOD_DSP_NORMALIZE = c_uint;
pub const FMOD_DSP_LIMITER_RELEASETIME: c_int = 0;
pub const FMOD_DSP_LIMITER_CEILING: c_int = 1;
pub const FMOD_DSP_LIMITER_MAXIMIZERGAIN: c_int = 2;
pub const FMOD_DSP_LIMITER_MODE: c_int = 3;
pub const FMOD_DSP_LIMITER = c_uint;
pub const FMOD_DSP_PARAMEQ_CENTER: c_int = 0;
pub const FMOD_DSP_PARAMEQ_BANDWIDTH: c_int = 1;
pub const FMOD_DSP_PARAMEQ_GAIN: c_int = 2;
pub const FMOD_DSP_PARAMEQ = c_uint;
pub const FMOD_DSP_MULTIBAND_EQ_A_FILTER: c_int = 0;
pub const FMOD_DSP_MULTIBAND_EQ_A_FREQUENCY: c_int = 1;
pub const FMOD_DSP_MULTIBAND_EQ_A_Q: c_int = 2;
pub const FMOD_DSP_MULTIBAND_EQ_A_GAIN: c_int = 3;
pub const FMOD_DSP_MULTIBAND_EQ_B_FILTER: c_int = 4;
pub const FMOD_DSP_MULTIBAND_EQ_B_FREQUENCY: c_int = 5;
pub const FMOD_DSP_MULTIBAND_EQ_B_Q: c_int = 6;
pub const FMOD_DSP_MULTIBAND_EQ_B_GAIN: c_int = 7;
pub const FMOD_DSP_MULTIBAND_EQ_C_FILTER: c_int = 8;
pub const FMOD_DSP_MULTIBAND_EQ_C_FREQUENCY: c_int = 9;
pub const FMOD_DSP_MULTIBAND_EQ_C_Q: c_int = 10;
pub const FMOD_DSP_MULTIBAND_EQ_C_GAIN: c_int = 11;
pub const FMOD_DSP_MULTIBAND_EQ_D_FILTER: c_int = 12;
pub const FMOD_DSP_MULTIBAND_EQ_D_FREQUENCY: c_int = 13;
pub const FMOD_DSP_MULTIBAND_EQ_D_Q: c_int = 14;
pub const FMOD_DSP_MULTIBAND_EQ_D_GAIN: c_int = 15;
pub const FMOD_DSP_MULTIBAND_EQ_E_FILTER: c_int = 16;
pub const FMOD_DSP_MULTIBAND_EQ_E_FREQUENCY: c_int = 17;
pub const FMOD_DSP_MULTIBAND_EQ_E_Q: c_int = 18;
pub const FMOD_DSP_MULTIBAND_EQ_E_GAIN: c_int = 19;
pub const enum_FMOD_DSP_MULTIBAND_EQ = c_uint;
pub const FMOD_DSP_MULTIBAND_EQ = enum_FMOD_DSP_MULTIBAND_EQ;
pub const FMOD_DSP_MULTIBAND_EQ_FILTER_DISABLED: c_int = 0;
pub const FMOD_DSP_MULTIBAND_EQ_FILTER_LOWPASS_12DB: c_int = 1;
pub const FMOD_DSP_MULTIBAND_EQ_FILTER_LOWPASS_24DB: c_int = 2;
pub const FMOD_DSP_MULTIBAND_EQ_FILTER_LOWPASS_48DB: c_int = 3;
pub const FMOD_DSP_MULTIBAND_EQ_FILTER_HIGHPASS_12DB: c_int = 4;
pub const FMOD_DSP_MULTIBAND_EQ_FILTER_HIGHPASS_24DB: c_int = 5;
pub const FMOD_DSP_MULTIBAND_EQ_FILTER_HIGHPASS_48DB: c_int = 6;
pub const FMOD_DSP_MULTIBAND_EQ_FILTER_LOWSHELF: c_int = 7;
pub const FMOD_DSP_MULTIBAND_EQ_FILTER_HIGHSHELF: c_int = 8;
pub const FMOD_DSP_MULTIBAND_EQ_FILTER_PEAKING: c_int = 9;
pub const FMOD_DSP_MULTIBAND_EQ_FILTER_BANDPASS: c_int = 10;
pub const FMOD_DSP_MULTIBAND_EQ_FILTER_NOTCH: c_int = 11;
pub const FMOD_DSP_MULTIBAND_EQ_FILTER_ALLPASS: c_int = 12;
pub const enum_FMOD_DSP_MULTIBAND_EQ_FILTER_TYPE = c_uint;
pub const FMOD_DSP_MULTIBAND_EQ_FILTER_TYPE = enum_FMOD_DSP_MULTIBAND_EQ_FILTER_TYPE;
pub const FMOD_DSP_PITCHSHIFT_PITCH: c_int = 0;
pub const FMOD_DSP_PITCHSHIFT_FFTSIZE: c_int = 1;
pub const FMOD_DSP_PITCHSHIFT_OVERLAP: c_int = 2;
pub const FMOD_DSP_PITCHSHIFT_MAXCHANNELS: c_int = 3;
pub const FMOD_DSP_PITCHSHIFT = c_uint;
pub const FMOD_DSP_CHORUS_MIX: c_int = 0;
pub const FMOD_DSP_CHORUS_RATE: c_int = 1;
pub const FMOD_DSP_CHORUS_DEPTH: c_int = 2;
pub const FMOD_DSP_CHORUS = c_uint;
pub const FMOD_DSP_ITECHO_WETDRYMIX: c_int = 0;
pub const FMOD_DSP_ITECHO_FEEDBACK: c_int = 1;
pub const FMOD_DSP_ITECHO_LEFTDELAY: c_int = 2;
pub const FMOD_DSP_ITECHO_RIGHTDELAY: c_int = 3;
pub const FMOD_DSP_ITECHO_PANDELAY: c_int = 4;
pub const FMOD_DSP_ITECHO = c_uint;
pub const FMOD_DSP_COMPRESSOR_THRESHOLD: c_int = 0;
pub const FMOD_DSP_COMPRESSOR_RATIO: c_int = 1;
pub const FMOD_DSP_COMPRESSOR_ATTACK: c_int = 2;
pub const FMOD_DSP_COMPRESSOR_RELEASE: c_int = 3;
pub const FMOD_DSP_COMPRESSOR_GAINMAKEUP: c_int = 4;
pub const FMOD_DSP_COMPRESSOR_USESIDECHAIN: c_int = 5;
pub const FMOD_DSP_COMPRESSOR_LINKED: c_int = 6;
pub const FMOD_DSP_COMPRESSOR = c_uint;
pub const FMOD_DSP_SFXREVERB_DECAYTIME: c_int = 0;
pub const FMOD_DSP_SFXREVERB_EARLYDELAY: c_int = 1;
pub const FMOD_DSP_SFXREVERB_LATEDELAY: c_int = 2;
pub const FMOD_DSP_SFXREVERB_HFREFERENCE: c_int = 3;
pub const FMOD_DSP_SFXREVERB_HFDECAYRATIO: c_int = 4;
pub const FMOD_DSP_SFXREVERB_DIFFUSION: c_int = 5;
pub const FMOD_DSP_SFXREVERB_DENSITY: c_int = 6;
pub const FMOD_DSP_SFXREVERB_LOWSHELFFREQUENCY: c_int = 7;
pub const FMOD_DSP_SFXREVERB_LOWSHELFGAIN: c_int = 8;
pub const FMOD_DSP_SFXREVERB_HIGHCUT: c_int = 9;
pub const FMOD_DSP_SFXREVERB_EARLYLATEMIX: c_int = 10;
pub const FMOD_DSP_SFXREVERB_WETLEVEL: c_int = 11;
pub const FMOD_DSP_SFXREVERB_DRYLEVEL: c_int = 12;
pub const FMOD_DSP_SFXREVERB = c_uint;
pub const FMOD_DSP_LOWPASS_SIMPLE_CUTOFF: c_int = 0;
pub const FMOD_DSP_LOWPASS_SIMPLE = c_uint;
pub const FMOD_DSP_DELAY_CH0: c_int = 0;
pub const FMOD_DSP_DELAY_CH1: c_int = 1;
pub const FMOD_DSP_DELAY_CH2: c_int = 2;
pub const FMOD_DSP_DELAY_CH3: c_int = 3;
pub const FMOD_DSP_DELAY_CH4: c_int = 4;
pub const FMOD_DSP_DELAY_CH5: c_int = 5;
pub const FMOD_DSP_DELAY_CH6: c_int = 6;
pub const FMOD_DSP_DELAY_CH7: c_int = 7;
pub const FMOD_DSP_DELAY_CH8: c_int = 8;
pub const FMOD_DSP_DELAY_CH9: c_int = 9;
pub const FMOD_DSP_DELAY_CH10: c_int = 10;
pub const FMOD_DSP_DELAY_CH11: c_int = 11;
pub const FMOD_DSP_DELAY_CH12: c_int = 12;
pub const FMOD_DSP_DELAY_CH13: c_int = 13;
pub const FMOD_DSP_DELAY_CH14: c_int = 14;
pub const FMOD_DSP_DELAY_CH15: c_int = 15;
pub const FMOD_DSP_DELAY_MAXDELAY: c_int = 16;
pub const FMOD_DSP_DELAY = c_uint;
pub const FMOD_DSP_TREMOLO_FREQUENCY: c_int = 0;
pub const FMOD_DSP_TREMOLO_DEPTH: c_int = 1;
pub const FMOD_DSP_TREMOLO_SHAPE: c_int = 2;
pub const FMOD_DSP_TREMOLO_SKEW: c_int = 3;
pub const FMOD_DSP_TREMOLO_DUTY: c_int = 4;
pub const FMOD_DSP_TREMOLO_SQUARE: c_int = 5;
pub const FMOD_DSP_TREMOLO_PHASE: c_int = 6;
pub const FMOD_DSP_TREMOLO_SPREAD: c_int = 7;
pub const FMOD_DSP_TREMOLO = c_uint;
pub const FMOD_DSP_SEND_RETURNID: c_int = 0;
pub const FMOD_DSP_SEND_LEVEL: c_int = 1;
pub const FMOD_DSP_SEND = c_uint;
pub const FMOD_DSP_RETURN_ID: c_int = 0;
pub const FMOD_DSP_RETURN_INPUT_SPEAKER_MODE: c_int = 1;
pub const FMOD_DSP_RETURN = c_uint;
pub const FMOD_DSP_HIGHPASS_SIMPLE_CUTOFF: c_int = 0;
pub const FMOD_DSP_HIGHPASS_SIMPLE = c_uint;
pub const FMOD_DSP_PAN_2D_STEREO_MODE_DISTRIBUTED: c_int = 0;
pub const FMOD_DSP_PAN_2D_STEREO_MODE_DISCRETE: c_int = 1;
pub const FMOD_DSP_PAN_2D_STEREO_MODE_TYPE = c_uint;
pub const FMOD_DSP_PAN_MODE_MONO: c_int = 0;
pub const FMOD_DSP_PAN_MODE_STEREO: c_int = 1;
pub const FMOD_DSP_PAN_MODE_SURROUND: c_int = 2;
pub const FMOD_DSP_PAN_MODE_TYPE = c_uint;
pub const FMOD_DSP_PAN_3D_ROLLOFF_LINEARSQUARED: c_int = 0;
pub const FMOD_DSP_PAN_3D_ROLLOFF_LINEAR: c_int = 1;
pub const FMOD_DSP_PAN_3D_ROLLOFF_INVERSE: c_int = 2;
pub const FMOD_DSP_PAN_3D_ROLLOFF_INVERSETAPERED: c_int = 3;
pub const FMOD_DSP_PAN_3D_ROLLOFF_CUSTOM: c_int = 4;
pub const FMOD_DSP_PAN_3D_ROLLOFF_TYPE = c_uint;
pub const FMOD_DSP_PAN_3D_EXTENT_MODE_AUTO: c_int = 0;
pub const FMOD_DSP_PAN_3D_EXTENT_MODE_USER: c_int = 1;
pub const FMOD_DSP_PAN_3D_EXTENT_MODE_OFF: c_int = 2;
pub const FMOD_DSP_PAN_3D_EXTENT_MODE_TYPE = c_uint;
pub const FMOD_DSP_PAN_MODE: c_int = 0;
pub const FMOD_DSP_PAN_2D_STEREO_POSITION: c_int = 1;
pub const FMOD_DSP_PAN_2D_DIRECTION: c_int = 2;
pub const FMOD_DSP_PAN_2D_EXTENT: c_int = 3;
pub const FMOD_DSP_PAN_2D_ROTATION: c_int = 4;
pub const FMOD_DSP_PAN_2D_LFE_LEVEL: c_int = 5;
pub const FMOD_DSP_PAN_2D_STEREO_MODE: c_int = 6;
pub const FMOD_DSP_PAN_2D_STEREO_SEPARATION: c_int = 7;
pub const FMOD_DSP_PAN_2D_STEREO_AXIS: c_int = 8;
pub const FMOD_DSP_PAN_ENABLED_SPEAKERS: c_int = 9;
pub const FMOD_DSP_PAN_3D_POSITION: c_int = 10;
pub const FMOD_DSP_PAN_3D_ROLLOFF: c_int = 11;
pub const FMOD_DSP_PAN_3D_MIN_DISTANCE: c_int = 12;
pub const FMOD_DSP_PAN_3D_MAX_DISTANCE: c_int = 13;
pub const FMOD_DSP_PAN_3D_EXTENT_MODE: c_int = 14;
pub const FMOD_DSP_PAN_3D_SOUND_SIZE: c_int = 15;
pub const FMOD_DSP_PAN_3D_MIN_EXTENT: c_int = 16;
pub const FMOD_DSP_PAN_3D_PAN_BLEND: c_int = 17;
pub const FMOD_DSP_PAN_LFE_UPMIX_ENABLED: c_int = 18;
pub const FMOD_DSP_PAN_OVERALL_GAIN: c_int = 19;
pub const FMOD_DSP_PAN_SURROUND_SPEAKER_MODE: c_int = 20;
pub const FMOD_DSP_PAN_2D_HEIGHT_BLEND: c_int = 21;
pub const FMOD_DSP_PAN = c_uint;
pub const FMOD_DSP_THREE_EQ_CROSSOVERSLOPE_12DB: c_int = 0;
pub const FMOD_DSP_THREE_EQ_CROSSOVERSLOPE_24DB: c_int = 1;
pub const FMOD_DSP_THREE_EQ_CROSSOVERSLOPE_48DB: c_int = 2;
pub const FMOD_DSP_THREE_EQ_CROSSOVERSLOPE_TYPE = c_uint;
pub const FMOD_DSP_THREE_EQ_LOWGAIN: c_int = 0;
pub const FMOD_DSP_THREE_EQ_MIDGAIN: c_int = 1;
pub const FMOD_DSP_THREE_EQ_HIGHGAIN: c_int = 2;
pub const FMOD_DSP_THREE_EQ_LOWCROSSOVER: c_int = 3;
pub const FMOD_DSP_THREE_EQ_HIGHCROSSOVER: c_int = 4;
pub const FMOD_DSP_THREE_EQ_CROSSOVERSLOPE: c_int = 5;
pub const FMOD_DSP_THREE_EQ = c_uint;
pub const FMOD_DSP_FFT_WINDOW_RECT: c_int = 0;
pub const FMOD_DSP_FFT_WINDOW_TRIANGLE: c_int = 1;
pub const FMOD_DSP_FFT_WINDOW_HAMMING: c_int = 2;
pub const FMOD_DSP_FFT_WINDOW_HANNING: c_int = 3;
pub const FMOD_DSP_FFT_WINDOW_BLACKMAN: c_int = 4;
pub const FMOD_DSP_FFT_WINDOW_BLACKMANHARRIS: c_int = 5;
pub const FMOD_DSP_FFT_WINDOW = c_uint;
pub const FMOD_DSP_FFT_WINDOWSIZE: c_int = 0;
pub const FMOD_DSP_FFT_WINDOWTYPE: c_int = 1;
pub const FMOD_DSP_FFT_SPECTRUMDATA: c_int = 2;
pub const FMOD_DSP_FFT_DOMINANT_FREQ: c_int = 3;
pub const FMOD_DSP_FFT = c_uint;
pub const FMOD_DSP_LOUDNESS_METER_STATE: c_int = 0;
pub const FMOD_DSP_LOUDNESS_METER_WEIGHTING: c_int = 1;
pub const FMOD_DSP_LOUDNESS_METER_INFO: c_int = 2;
pub const FMOD_DSP_LOUDNESS_METER = c_uint;
pub const FMOD_DSP_LOUDNESS_METER_STATE_RESET_INTEGRATED: c_int = -3;
pub const FMOD_DSP_LOUDNESS_METER_STATE_RESET_MAXPEAK: c_int = -2;
pub const FMOD_DSP_LOUDNESS_METER_STATE_RESET_ALL: c_int = -1;
pub const FMOD_DSP_LOUDNESS_METER_STATE_PAUSED: c_int = 0;
pub const FMOD_DSP_LOUDNESS_METER_STATE_ANALYZING: c_int = 1;
pub const FMOD_DSP_LOUDNESS_METER_STATE_TYPE = c_int;
pub const struct_FMOD_DSP_LOUDNESS_METER_INFO_TYPE = extern struct {
    momentaryloudness: f32,
    shorttermloudness: f32,
    integratedloudness: f32,
    loudness10thpercentile: f32,
    loudness95thpercentile: f32,
    loudnesshistogram: [66]f32,
    maxtruepeak: f32,
    maxmomentaryloudness: f32,
};
pub const FMOD_DSP_LOUDNESS_METER_INFO_TYPE = struct_FMOD_DSP_LOUDNESS_METER_INFO_TYPE;
pub const struct_FMOD_DSP_LOUDNESS_METER_WEIGHTING_TYPE = extern struct {
    channelweight: [32]f32,
};
pub const FMOD_DSP_LOUDNESS_METER_WEIGHTING_TYPE = struct_FMOD_DSP_LOUDNESS_METER_WEIGHTING_TYPE;
pub const FMOD_DSP_ENVELOPEFOLLOWER_ATTACK: c_int = 0;
pub const FMOD_DSP_ENVELOPEFOLLOWER_RELEASE: c_int = 1;
pub const FMOD_DSP_ENVELOPEFOLLOWER_ENVELOPE: c_int = 2;
pub const FMOD_DSP_ENVELOPEFOLLOWER_USESIDECHAIN: c_int = 3;
pub const FMOD_DSP_ENVELOPEFOLLOWER = c_uint;
pub const FMOD_DSP_CONVOLUTION_REVERB_PARAM_IR: c_int = 0;
pub const FMOD_DSP_CONVOLUTION_REVERB_PARAM_WET: c_int = 1;
pub const FMOD_DSP_CONVOLUTION_REVERB_PARAM_DRY: c_int = 2;
pub const FMOD_DSP_CONVOLUTION_REVERB_PARAM_LINKED: c_int = 3;
pub const FMOD_DSP_CONVOLUTION_REVERB = c_uint;
pub const FMOD_DSP_CHANNELMIX_OUTPUT_DEFAULT: c_int = 0;
pub const FMOD_DSP_CHANNELMIX_OUTPUT_ALLMONO: c_int = 1;
pub const FMOD_DSP_CHANNELMIX_OUTPUT_ALLSTEREO: c_int = 2;
pub const FMOD_DSP_CHANNELMIX_OUTPUT_ALLQUAD: c_int = 3;
pub const FMOD_DSP_CHANNELMIX_OUTPUT_ALL5POINT1: c_int = 4;
pub const FMOD_DSP_CHANNELMIX_OUTPUT_ALL7POINT1: c_int = 5;
pub const FMOD_DSP_CHANNELMIX_OUTPUT_ALLLFE: c_int = 6;
pub const FMOD_DSP_CHANNELMIX_OUTPUT_ALL7POINT1POINT4: c_int = 7;
pub const FMOD_DSP_CHANNELMIX_OUTPUT = c_uint;
pub const FMOD_DSP_CHANNELMIX_OUTPUTGROUPING: c_int = 0;
pub const FMOD_DSP_CHANNELMIX_GAIN_CH0: c_int = 1;
pub const FMOD_DSP_CHANNELMIX_GAIN_CH1: c_int = 2;
pub const FMOD_DSP_CHANNELMIX_GAIN_CH2: c_int = 3;
pub const FMOD_DSP_CHANNELMIX_GAIN_CH3: c_int = 4;
pub const FMOD_DSP_CHANNELMIX_GAIN_CH4: c_int = 5;
pub const FMOD_DSP_CHANNELMIX_GAIN_CH5: c_int = 6;
pub const FMOD_DSP_CHANNELMIX_GAIN_CH6: c_int = 7;
pub const FMOD_DSP_CHANNELMIX_GAIN_CH7: c_int = 8;
pub const FMOD_DSP_CHANNELMIX_GAIN_CH8: c_int = 9;
pub const FMOD_DSP_CHANNELMIX_GAIN_CH9: c_int = 10;
pub const FMOD_DSP_CHANNELMIX_GAIN_CH10: c_int = 11;
pub const FMOD_DSP_CHANNELMIX_GAIN_CH11: c_int = 12;
pub const FMOD_DSP_CHANNELMIX_GAIN_CH12: c_int = 13;
pub const FMOD_DSP_CHANNELMIX_GAIN_CH13: c_int = 14;
pub const FMOD_DSP_CHANNELMIX_GAIN_CH14: c_int = 15;
pub const FMOD_DSP_CHANNELMIX_GAIN_CH15: c_int = 16;
pub const FMOD_DSP_CHANNELMIX_GAIN_CH16: c_int = 17;
pub const FMOD_DSP_CHANNELMIX_GAIN_CH17: c_int = 18;
pub const FMOD_DSP_CHANNELMIX_GAIN_CH18: c_int = 19;
pub const FMOD_DSP_CHANNELMIX_GAIN_CH19: c_int = 20;
pub const FMOD_DSP_CHANNELMIX_GAIN_CH20: c_int = 21;
pub const FMOD_DSP_CHANNELMIX_GAIN_CH21: c_int = 22;
pub const FMOD_DSP_CHANNELMIX_GAIN_CH22: c_int = 23;
pub const FMOD_DSP_CHANNELMIX_GAIN_CH23: c_int = 24;
pub const FMOD_DSP_CHANNELMIX_GAIN_CH24: c_int = 25;
pub const FMOD_DSP_CHANNELMIX_GAIN_CH25: c_int = 26;
pub const FMOD_DSP_CHANNELMIX_GAIN_CH26: c_int = 27;
pub const FMOD_DSP_CHANNELMIX_GAIN_CH27: c_int = 28;
pub const FMOD_DSP_CHANNELMIX_GAIN_CH28: c_int = 29;
pub const FMOD_DSP_CHANNELMIX_GAIN_CH29: c_int = 30;
pub const FMOD_DSP_CHANNELMIX_GAIN_CH30: c_int = 31;
pub const FMOD_DSP_CHANNELMIX_GAIN_CH31: c_int = 32;
pub const FMOD_DSP_CHANNELMIX_OUTPUT_CH0: c_int = 33;
pub const FMOD_DSP_CHANNELMIX_OUTPUT_CH1: c_int = 34;
pub const FMOD_DSP_CHANNELMIX_OUTPUT_CH2: c_int = 35;
pub const FMOD_DSP_CHANNELMIX_OUTPUT_CH3: c_int = 36;
pub const FMOD_DSP_CHANNELMIX_OUTPUT_CH4: c_int = 37;
pub const FMOD_DSP_CHANNELMIX_OUTPUT_CH5: c_int = 38;
pub const FMOD_DSP_CHANNELMIX_OUTPUT_CH6: c_int = 39;
pub const FMOD_DSP_CHANNELMIX_OUTPUT_CH7: c_int = 40;
pub const FMOD_DSP_CHANNELMIX_OUTPUT_CH8: c_int = 41;
pub const FMOD_DSP_CHANNELMIX_OUTPUT_CH9: c_int = 42;
pub const FMOD_DSP_CHANNELMIX_OUTPUT_CH10: c_int = 43;
pub const FMOD_DSP_CHANNELMIX_OUTPUT_CH11: c_int = 44;
pub const FMOD_DSP_CHANNELMIX_OUTPUT_CH12: c_int = 45;
pub const FMOD_DSP_CHANNELMIX_OUTPUT_CH13: c_int = 46;
pub const FMOD_DSP_CHANNELMIX_OUTPUT_CH14: c_int = 47;
pub const FMOD_DSP_CHANNELMIX_OUTPUT_CH15: c_int = 48;
pub const FMOD_DSP_CHANNELMIX_OUTPUT_CH16: c_int = 49;
pub const FMOD_DSP_CHANNELMIX_OUTPUT_CH17: c_int = 50;
pub const FMOD_DSP_CHANNELMIX_OUTPUT_CH18: c_int = 51;
pub const FMOD_DSP_CHANNELMIX_OUTPUT_CH19: c_int = 52;
pub const FMOD_DSP_CHANNELMIX_OUTPUT_CH20: c_int = 53;
pub const FMOD_DSP_CHANNELMIX_OUTPUT_CH21: c_int = 54;
pub const FMOD_DSP_CHANNELMIX_OUTPUT_CH22: c_int = 55;
pub const FMOD_DSP_CHANNELMIX_OUTPUT_CH23: c_int = 56;
pub const FMOD_DSP_CHANNELMIX_OUTPUT_CH24: c_int = 57;
pub const FMOD_DSP_CHANNELMIX_OUTPUT_CH25: c_int = 58;
pub const FMOD_DSP_CHANNELMIX_OUTPUT_CH26: c_int = 59;
pub const FMOD_DSP_CHANNELMIX_OUTPUT_CH27: c_int = 60;
pub const FMOD_DSP_CHANNELMIX_OUTPUT_CH28: c_int = 61;
pub const FMOD_DSP_CHANNELMIX_OUTPUT_CH29: c_int = 62;
pub const FMOD_DSP_CHANNELMIX_OUTPUT_CH30: c_int = 63;
pub const FMOD_DSP_CHANNELMIX_OUTPUT_CH31: c_int = 64;
pub const FMOD_DSP_CHANNELMIX = c_uint;
pub const FMOD_DSP_TRANSCEIVER_SPEAKERMODE_AUTO: c_int = -1;
pub const FMOD_DSP_TRANSCEIVER_SPEAKERMODE_MONO: c_int = 0;
pub const FMOD_DSP_TRANSCEIVER_SPEAKERMODE_STEREO: c_int = 1;
pub const FMOD_DSP_TRANSCEIVER_SPEAKERMODE_SURROUND: c_int = 2;
pub const FMOD_DSP_TRANSCEIVER_SPEAKERMODE = c_int;
pub const FMOD_DSP_TRANSCEIVER_TRANSMIT: c_int = 0;
pub const FMOD_DSP_TRANSCEIVER_GAIN: c_int = 1;
pub const FMOD_DSP_TRANSCEIVER_CHANNEL: c_int = 2;
pub const FMOD_DSP_TRANSCEIVER_TRANSMITSPEAKERMODE: c_int = 3;
pub const FMOD_DSP_TRANSCEIVER = c_uint;
pub const FMOD_DSP_OBJECTPAN_3D_POSITION: c_int = 0;
pub const FMOD_DSP_OBJECTPAN_3D_ROLLOFF: c_int = 1;
pub const FMOD_DSP_OBJECTPAN_3D_MIN_DISTANCE: c_int = 2;
pub const FMOD_DSP_OBJECTPAN_3D_MAX_DISTANCE: c_int = 3;
pub const FMOD_DSP_OBJECTPAN_3D_EXTENT_MODE: c_int = 4;
pub const FMOD_DSP_OBJECTPAN_3D_SOUND_SIZE: c_int = 5;
pub const FMOD_DSP_OBJECTPAN_3D_MIN_EXTENT: c_int = 6;
pub const FMOD_DSP_OBJECTPAN_OVERALL_GAIN: c_int = 7;
pub const FMOD_DSP_OBJECTPAN_OUTPUTGAIN: c_int = 8;
pub const FMOD_DSP_OBJECTPAN = c_uint;
pub const FMOD_DSP_ALLOC_FUNC = ?fn (c_uint, FMOD_MEMORY_TYPE, [*c]const u8) callconv(.C) ?*c_void;
pub const FMOD_DSP_REALLOC_FUNC = ?fn (?*c_void, c_uint, FMOD_MEMORY_TYPE, [*c]const u8) callconv(.C) ?*c_void;
pub const FMOD_DSP_FREE_FUNC = ?fn (?*c_void, FMOD_MEMORY_TYPE, [*c]const u8) callconv(.C) void;
pub const FMOD_DSP_STATE = struct_FMOD_DSP_STATE;
pub const FMOD_DSP_GETSAMPLERATE_FUNC = ?fn ([*c]FMOD_DSP_STATE, [*c]c_int) callconv(.C) FMOD_RESULT;
pub const FMOD_DSP_GETBLOCKSIZE_FUNC = ?fn ([*c]FMOD_DSP_STATE, [*c]c_uint) callconv(.C) FMOD_RESULT;
pub const struct_FMOD_COMPLEX = extern struct {
    real: f32,
    imag: f32,
};
pub const FMOD_COMPLEX = struct_FMOD_COMPLEX;
pub const FMOD_DSP_DFT_FFTREAL_FUNC = ?fn ([*c]FMOD_DSP_STATE, c_int, [*c]const f32, [*c]FMOD_COMPLEX, [*c]const f32, c_int) callconv(.C) FMOD_RESULT;
pub const FMOD_DSP_DFT_IFFTREAL_FUNC = ?fn ([*c]FMOD_DSP_STATE, c_int, [*c]const FMOD_COMPLEX, [*c]f32, [*c]const f32, c_int) callconv(.C) FMOD_RESULT;
pub const struct_FMOD_DSP_STATE_DFT_FUNCTIONS = extern struct {
    fftreal: FMOD_DSP_DFT_FFTREAL_FUNC,
    inversefftreal: FMOD_DSP_DFT_IFFTREAL_FUNC,
};
pub const FMOD_DSP_STATE_DFT_FUNCTIONS = struct_FMOD_DSP_STATE_DFT_FUNCTIONS;
pub const FMOD_DSP_PAN_SUMMONOMATRIX_FUNC = ?fn ([*c]FMOD_DSP_STATE, FMOD_SPEAKERMODE, f32, f32, [*c]f32) callconv(.C) FMOD_RESULT;
pub const FMOD_DSP_PAN_SUMSTEREOMATRIX_FUNC = ?fn ([*c]FMOD_DSP_STATE, FMOD_SPEAKERMODE, f32, f32, f32, c_int, [*c]f32) callconv(.C) FMOD_RESULT;
pub const FMOD_DSP_PAN_SURROUND_DEFAULT: c_int = 0;
pub const FMOD_DSP_PAN_SURROUND_ROTATION_NOT_BIASED: c_int = 1;
pub const FMOD_DSP_PAN_SURROUND_FLAGS_FORCEINT: c_int = 65536;
pub const enum_FMOD_DSP_PAN_SURROUND_FLAGS = c_uint;
pub const FMOD_DSP_PAN_SURROUND_FLAGS = enum_FMOD_DSP_PAN_SURROUND_FLAGS;
pub const FMOD_DSP_PAN_SUMSURROUNDMATRIX_FUNC = ?fn ([*c]FMOD_DSP_STATE, FMOD_SPEAKERMODE, FMOD_SPEAKERMODE, f32, f32, f32, f32, f32, c_int, [*c]f32, FMOD_DSP_PAN_SURROUND_FLAGS) callconv(.C) FMOD_RESULT;
pub const FMOD_DSP_PAN_SUMMONOTOSURROUNDMATRIX_FUNC = ?fn ([*c]FMOD_DSP_STATE, FMOD_SPEAKERMODE, f32, f32, f32, f32, c_int, [*c]f32) callconv(.C) FMOD_RESULT;
pub const FMOD_DSP_PAN_SUMSTEREOTOSURROUNDMATRIX_FUNC = ?fn ([*c]FMOD_DSP_STATE, FMOD_SPEAKERMODE, f32, f32, f32, f32, f32, c_int, [*c]f32) callconv(.C) FMOD_RESULT;
pub const FMOD_DSP_PAN_GETROLLOFFGAIN_FUNC = ?fn ([*c]FMOD_DSP_STATE, FMOD_DSP_PAN_3D_ROLLOFF_TYPE, f32, f32, f32, [*c]f32) callconv(.C) FMOD_RESULT;
pub const struct_FMOD_DSP_STATE_PAN_FUNCTIONS = extern struct {
    summonomatrix: FMOD_DSP_PAN_SUMMONOMATRIX_FUNC,
    sumstereomatrix: FMOD_DSP_PAN_SUMSTEREOMATRIX_FUNC,
    sumsurroundmatrix: FMOD_DSP_PAN_SUMSURROUNDMATRIX_FUNC,
    summonotosurroundmatrix: FMOD_DSP_PAN_SUMMONOTOSURROUNDMATRIX_FUNC,
    sumstereotosurroundmatrix: FMOD_DSP_PAN_SUMSTEREOTOSURROUNDMATRIX_FUNC,
    getrolloffgain: FMOD_DSP_PAN_GETROLLOFFGAIN_FUNC,
};
pub const FMOD_DSP_STATE_PAN_FUNCTIONS = struct_FMOD_DSP_STATE_PAN_FUNCTIONS;
pub const FMOD_DSP_GETSPEAKERMODE_FUNC = ?fn ([*c]FMOD_DSP_STATE, [*c]FMOD_SPEAKERMODE, [*c]FMOD_SPEAKERMODE) callconv(.C) FMOD_RESULT;
pub const FMOD_DSP_GETCLOCK_FUNC = ?fn ([*c]FMOD_DSP_STATE, [*c]c_ulonglong, [*c]c_uint, [*c]c_uint) callconv(.C) FMOD_RESULT;
pub const FMOD_DSP_GETLISTENERATTRIBUTES_FUNC = ?fn ([*c]FMOD_DSP_STATE, [*c]c_int, [*c]FMOD_3D_ATTRIBUTES) callconv(.C) FMOD_RESULT;
pub const FMOD_DSP_LOG_FUNC = ?fn (FMOD_DEBUG_FLAGS, [*c]const u8, c_int, [*c]const u8, [*c]const u8, ...) callconv(.C) void;
pub const FMOD_DSP_GETUSERDATA_FUNC = ?fn ([*c]FMOD_DSP_STATE, [*c]?*c_void) callconv(.C) FMOD_RESULT;
pub const struct_FMOD_DSP_STATE_FUNCTIONS = extern struct {
    alloc: FMOD_DSP_ALLOC_FUNC,
    realloc: FMOD_DSP_REALLOC_FUNC,
    free: FMOD_DSP_FREE_FUNC,
    getsamplerate: FMOD_DSP_GETSAMPLERATE_FUNC,
    getblocksize: FMOD_DSP_GETBLOCKSIZE_FUNC,
    dft: [*c]FMOD_DSP_STATE_DFT_FUNCTIONS,
    pan: [*c]FMOD_DSP_STATE_PAN_FUNCTIONS,
    getspeakermode: FMOD_DSP_GETSPEAKERMODE_FUNC,
    getclock: FMOD_DSP_GETCLOCK_FUNC,
    getlistenerattributes: FMOD_DSP_GETLISTENERATTRIBUTES_FUNC,
    log: FMOD_DSP_LOG_FUNC,
    getuserdata: FMOD_DSP_GETUSERDATA_FUNC,
};
pub const FMOD_DSP_STATE_FUNCTIONS = struct_FMOD_DSP_STATE_FUNCTIONS;
pub const struct_FMOD_DSP_STATE = extern struct {
    instance: ?*c_void,
    plugindata: ?*c_void,
    channelmask: FMOD_CHANNELMASK,
    source_speakermode: FMOD_SPEAKERMODE,
    sidechaindata: [*c]f32,
    sidechainchannels: c_int,
    functions: [*c]FMOD_DSP_STATE_FUNCTIONS,
    systemobject: c_int,
};
pub const struct_FMOD_DSP_BUFFER_ARRAY = extern struct {
    numbuffers: c_int,
    buffernumchannels: [*c]c_int,
    bufferchannelmask: [*c]FMOD_CHANNELMASK,
    buffers: [*c][*c]f32,
    speakermode: FMOD_SPEAKERMODE,
};
pub const FMOD_DSP_BUFFER_ARRAY = struct_FMOD_DSP_BUFFER_ARRAY;
pub const FMOD_DSP_PROCESS_PERFORM: c_int = 0;
pub const FMOD_DSP_PROCESS_QUERY: c_int = 1;
pub const FMOD_DSP_PROCESS_OPERATION = c_uint;
pub const FMOD_DSP_PARAMETER_TYPE_FLOAT: c_int = 0;
pub const FMOD_DSP_PARAMETER_TYPE_INT: c_int = 1;
pub const FMOD_DSP_PARAMETER_TYPE_BOOL: c_int = 2;
pub const FMOD_DSP_PARAMETER_TYPE_DATA: c_int = 3;
pub const FMOD_DSP_PARAMETER_TYPE_MAX: c_int = 4;
pub const FMOD_DSP_PARAMETER_TYPE_FORCEINT: c_int = 65536;
pub const FMOD_DSP_PARAMETER_TYPE = c_uint;
pub const FMOD_DSP_PARAMETER_FLOAT_MAPPING_TYPE_LINEAR: c_int = 0;
pub const FMOD_DSP_PARAMETER_FLOAT_MAPPING_TYPE_AUTO: c_int = 1;
pub const FMOD_DSP_PARAMETER_FLOAT_MAPPING_TYPE_PIECEWISE_LINEAR: c_int = 2;
pub const FMOD_DSP_PARAMETER_FLOAT_MAPPING_TYPE_FORCEINT: c_int = 65536;
pub const FMOD_DSP_PARAMETER_FLOAT_MAPPING_TYPE = c_uint;
pub const FMOD_DSP_PARAMETER_DATA_TYPE_USER: c_int = 0;
pub const FMOD_DSP_PARAMETER_DATA_TYPE_OVERALLGAIN: c_int = -1;
pub const FMOD_DSP_PARAMETER_DATA_TYPE_3DATTRIBUTES: c_int = -2;
pub const FMOD_DSP_PARAMETER_DATA_TYPE_SIDECHAIN: c_int = -3;
pub const FMOD_DSP_PARAMETER_DATA_TYPE_FFT: c_int = -4;
pub const FMOD_DSP_PARAMETER_DATA_TYPE_3DATTRIBUTES_MULTI: c_int = -5;
pub const FMOD_DSP_PARAMETER_DATA_TYPE = c_int;
pub const FMOD_DSP_CREATE_CALLBACK = ?fn ([*c]FMOD_DSP_STATE) callconv(.C) FMOD_RESULT;
pub const FMOD_DSP_RELEASE_CALLBACK = ?fn ([*c]FMOD_DSP_STATE) callconv(.C) FMOD_RESULT;
pub const FMOD_DSP_RESET_CALLBACK = ?fn ([*c]FMOD_DSP_STATE) callconv(.C) FMOD_RESULT;
pub const FMOD_DSP_READ_CALLBACK = ?fn ([*c]FMOD_DSP_STATE, [*c]f32, [*c]f32, c_uint, c_int, [*c]c_int) callconv(.C) FMOD_RESULT;
pub const FMOD_DSP_PROCESS_CALLBACK = ?fn ([*c]FMOD_DSP_STATE, c_uint, [*c]const FMOD_DSP_BUFFER_ARRAY, [*c]FMOD_DSP_BUFFER_ARRAY, FMOD_BOOL, FMOD_DSP_PROCESS_OPERATION) callconv(.C) FMOD_RESULT;
pub const FMOD_DSP_SETPOSITION_CALLBACK = ?fn ([*c]FMOD_DSP_STATE, c_uint) callconv(.C) FMOD_RESULT;
pub const FMOD_DSP_SHOULDIPROCESS_CALLBACK = ?fn ([*c]FMOD_DSP_STATE, FMOD_BOOL, c_uint, FMOD_CHANNELMASK, c_int, FMOD_SPEAKERMODE) callconv(.C) FMOD_RESULT;
pub const FMOD_DSP_SETPARAM_FLOAT_CALLBACK = ?fn ([*c]FMOD_DSP_STATE, c_int, f32) callconv(.C) FMOD_RESULT;
pub const FMOD_DSP_SETPARAM_INT_CALLBACK = ?fn ([*c]FMOD_DSP_STATE, c_int, c_int) callconv(.C) FMOD_RESULT;
pub const FMOD_DSP_SETPARAM_BOOL_CALLBACK = ?fn ([*c]FMOD_DSP_STATE, c_int, FMOD_BOOL) callconv(.C) FMOD_RESULT;
pub const FMOD_DSP_SETPARAM_DATA_CALLBACK = ?fn ([*c]FMOD_DSP_STATE, c_int, ?*c_void, c_uint) callconv(.C) FMOD_RESULT;
pub const FMOD_DSP_GETPARAM_FLOAT_CALLBACK = ?fn ([*c]FMOD_DSP_STATE, c_int, [*c]f32, [*c]u8) callconv(.C) FMOD_RESULT;
pub const FMOD_DSP_GETPARAM_INT_CALLBACK = ?fn ([*c]FMOD_DSP_STATE, c_int, [*c]c_int, [*c]u8) callconv(.C) FMOD_RESULT;
pub const FMOD_DSP_GETPARAM_BOOL_CALLBACK = ?fn ([*c]FMOD_DSP_STATE, c_int, [*c]FMOD_BOOL, [*c]u8) callconv(.C) FMOD_RESULT;
pub const FMOD_DSP_GETPARAM_DATA_CALLBACK = ?fn ([*c]FMOD_DSP_STATE, c_int, [*c]?*c_void, [*c]c_uint, [*c]u8) callconv(.C) FMOD_RESULT;
pub const FMOD_DSP_SYSTEM_REGISTER_CALLBACK = ?fn ([*c]FMOD_DSP_STATE) callconv(.C) FMOD_RESULT;
pub const FMOD_DSP_SYSTEM_DEREGISTER_CALLBACK = ?fn ([*c]FMOD_DSP_STATE) callconv(.C) FMOD_RESULT;
pub const FMOD_DSP_SYSTEM_MIX_CALLBACK = ?fn ([*c]FMOD_DSP_STATE, c_int) callconv(.C) FMOD_RESULT;
pub const struct_FMOD_DSP_PARAMETER_FLOAT_MAPPING_PIECEWISE_LINEAR = extern struct {
    numpoints: c_int,
    pointparamvalues: [*c]f32,
    pointpositions: [*c]f32,
};
pub const FMOD_DSP_PARAMETER_FLOAT_MAPPING_PIECEWISE_LINEAR = struct_FMOD_DSP_PARAMETER_FLOAT_MAPPING_PIECEWISE_LINEAR;
pub const struct_FMOD_DSP_PARAMETER_FLOAT_MAPPING = extern struct {
    type: FMOD_DSP_PARAMETER_FLOAT_MAPPING_TYPE,
    piecewiselinearmapping: FMOD_DSP_PARAMETER_FLOAT_MAPPING_PIECEWISE_LINEAR,
};
pub const FMOD_DSP_PARAMETER_FLOAT_MAPPING = struct_FMOD_DSP_PARAMETER_FLOAT_MAPPING;
pub const struct_FMOD_DSP_PARAMETER_DESC_FLOAT = extern struct {
    min: f32,
    max: f32,
    defaultval: f32,
    mapping: FMOD_DSP_PARAMETER_FLOAT_MAPPING,
};
pub const FMOD_DSP_PARAMETER_DESC_FLOAT = struct_FMOD_DSP_PARAMETER_DESC_FLOAT;
pub const struct_FMOD_DSP_PARAMETER_DESC_INT = extern struct {
    min: c_int,
    max: c_int,
    defaultval: c_int,
    goestoinf: FMOD_BOOL,
    valuenames: [*c]const [*c]const u8,
};
pub const FMOD_DSP_PARAMETER_DESC_INT = struct_FMOD_DSP_PARAMETER_DESC_INT;
pub const struct_FMOD_DSP_PARAMETER_DESC_BOOL = extern struct {
    defaultval: FMOD_BOOL,
    valuenames: [*c]const [*c]const u8,
};
pub const FMOD_DSP_PARAMETER_DESC_BOOL = struct_FMOD_DSP_PARAMETER_DESC_BOOL;
pub const struct_FMOD_DSP_PARAMETER_DESC_DATA = extern struct {
    datatype: c_int,
};
pub const FMOD_DSP_PARAMETER_DESC_DATA = struct_FMOD_DSP_PARAMETER_DESC_DATA;
const union_unnamed_1 = extern union {
    floatdesc: FMOD_DSP_PARAMETER_DESC_FLOAT,
    intdesc: FMOD_DSP_PARAMETER_DESC_INT,
    booldesc: FMOD_DSP_PARAMETER_DESC_BOOL,
    datadesc: FMOD_DSP_PARAMETER_DESC_DATA,
};
pub const struct_FMOD_DSP_PARAMETER_DESC = extern struct {
    type: FMOD_DSP_PARAMETER_TYPE,
    name: [16]u8,
    label: [16]u8,
    description: [*c]const u8,
    unnamed_0: union_unnamed_1,
};
pub const FMOD_DSP_PARAMETER_DESC = struct_FMOD_DSP_PARAMETER_DESC;
pub const struct_FMOD_DSP_PARAMETER_OVERALLGAIN = extern struct {
    linear_gain: f32,
    linear_gain_additive: f32,
};
pub const FMOD_DSP_PARAMETER_OVERALLGAIN = struct_FMOD_DSP_PARAMETER_OVERALLGAIN;
pub const struct_FMOD_DSP_PARAMETER_3DATTRIBUTES = extern struct {
    relative: FMOD_3D_ATTRIBUTES,
    absolute: FMOD_3D_ATTRIBUTES,
};
pub const FMOD_DSP_PARAMETER_3DATTRIBUTES = struct_FMOD_DSP_PARAMETER_3DATTRIBUTES;
pub const struct_FMOD_DSP_PARAMETER_3DATTRIBUTES_MULTI = extern struct {
    numlisteners: c_int,
    relative: [8]FMOD_3D_ATTRIBUTES,
    weight: [8]f32,
    absolute: FMOD_3D_ATTRIBUTES,
};
pub const FMOD_DSP_PARAMETER_3DATTRIBUTES_MULTI = struct_FMOD_DSP_PARAMETER_3DATTRIBUTES_MULTI;
pub const struct_FMOD_DSP_PARAMETER_SIDECHAIN = extern struct {
    sidechainenable: FMOD_BOOL,
};
pub const FMOD_DSP_PARAMETER_SIDECHAIN = struct_FMOD_DSP_PARAMETER_SIDECHAIN;
pub const struct_FMOD_DSP_PARAMETER_FFT = extern struct {
    length: c_int,
    numchannels: c_int,
    spectrum: [32][*c]f32,
};
pub const FMOD_DSP_PARAMETER_FFT = struct_FMOD_DSP_PARAMETER_FFT;
pub const struct_FMOD_DSP_DESCRIPTION = extern struct {
    pluginsdkversion: c_uint,
    name: [32]u8,
    version: c_uint,
    numinputbuffers: c_int,
    numoutputbuffers: c_int,
    create: FMOD_DSP_CREATE_CALLBACK,
    release: FMOD_DSP_RELEASE_CALLBACK,
    reset: FMOD_DSP_RESET_CALLBACK,
    read: FMOD_DSP_READ_CALLBACK,
    process: FMOD_DSP_PROCESS_CALLBACK,
    setposition: FMOD_DSP_SETPOSITION_CALLBACK,
    numparameters: c_int,
    paramdesc: [*c][*c]FMOD_DSP_PARAMETER_DESC,
    setparameterfloat: FMOD_DSP_SETPARAM_FLOAT_CALLBACK,
    setparameterint: FMOD_DSP_SETPARAM_INT_CALLBACK,
    setparameterbool: FMOD_DSP_SETPARAM_BOOL_CALLBACK,
    setparameterdata: FMOD_DSP_SETPARAM_DATA_CALLBACK,
    getparameterfloat: FMOD_DSP_GETPARAM_FLOAT_CALLBACK,
    getparameterint: FMOD_DSP_GETPARAM_INT_CALLBACK,
    getparameterbool: FMOD_DSP_GETPARAM_BOOL_CALLBACK,
    getparameterdata: FMOD_DSP_GETPARAM_DATA_CALLBACK,
    shouldiprocess: FMOD_DSP_SHOULDIPROCESS_CALLBACK,
    userdata: ?*c_void,
    sys_register: FMOD_DSP_SYSTEM_REGISTER_CALLBACK,
    sys_deregister: FMOD_DSP_SYSTEM_DEREGISTER_CALLBACK,
    sys_mix: FMOD_DSP_SYSTEM_MIX_CALLBACK,
};
pub const FMOD_DSP_DESCRIPTION = struct_FMOD_DSP_DESCRIPTION;
pub const struct_FMOD_DSP_METERING_INFO = extern struct {
    numsamples: c_int,
    peaklevel: [32]f32,
    rmslevel: [32]f32,
    numchannels: c_short,
};
pub const FMOD_DSP_METERING_INFO = struct_FMOD_DSP_METERING_INFO;
pub const FMOD_OUTPUT_STATE = struct_FMOD_OUTPUT_STATE;
pub const FMOD_OUTPUT_READFROMMIXER_FUNC = ?fn ([*c]FMOD_OUTPUT_STATE, ?*c_void, c_uint) callconv(.C) FMOD_RESULT;
pub const FMOD_OUTPUT_ALLOC_FUNC = ?fn (c_uint, c_uint, [*c]const u8, c_int) callconv(.C) ?*c_void;
pub const FMOD_OUTPUT_FREE_FUNC = ?fn (?*c_void, [*c]const u8, c_int) callconv(.C) void;
pub const FMOD_OUTPUT_LOG_FUNC = ?fn (FMOD_DEBUG_FLAGS, [*c]const u8, c_int, [*c]const u8, [*c]const u8, ...) callconv(.C) void;
pub const FMOD_OUTPUT_COPYPORT_FUNC = ?fn ([*c]FMOD_OUTPUT_STATE, c_int, ?*c_void, c_uint) callconv(.C) FMOD_RESULT;
pub const FMOD_OUTPUT_REQUESTRESET_FUNC = ?fn ([*c]FMOD_OUTPUT_STATE) callconv(.C) FMOD_RESULT;
pub const struct_FMOD_OUTPUT_STATE = extern struct {
    plugindata: ?*c_void,
    readfrommixer: FMOD_OUTPUT_READFROMMIXER_FUNC,
    alloc: FMOD_OUTPUT_ALLOC_FUNC,
    free: FMOD_OUTPUT_FREE_FUNC,
    log: FMOD_OUTPUT_LOG_FUNC,
    copyport: FMOD_OUTPUT_COPYPORT_FUNC,
    requestreset: FMOD_OUTPUT_REQUESTRESET_FUNC,
};
pub const struct_FMOD_OUTPUT_OBJECT3DINFO = extern struct {
    buffer: [*c]f32,
    bufferlength: c_uint,
    position: FMOD_VECTOR,
    gain: f32,
    spread: f32,
    priority: f32,
};
pub const FMOD_OUTPUT_OBJECT3DINFO = struct_FMOD_OUTPUT_OBJECT3DINFO;
pub const FMOD_OUTPUT_METHOD = c_uint;
pub const FMOD_OUTPUT_GETNUMDRIVERS_CALLBACK = ?fn ([*c]FMOD_OUTPUT_STATE, [*c]c_int) callconv(.C) FMOD_RESULT;
pub const FMOD_OUTPUT_GETDRIVERINFO_CALLBACK = ?fn ([*c]FMOD_OUTPUT_STATE, c_int, [*c]u8, c_int, [*c]FMOD_GUID, [*c]c_int, [*c]FMOD_SPEAKERMODE, [*c]c_int) callconv(.C) FMOD_RESULT;
pub const FMOD_OUTPUT_INIT_CALLBACK = ?fn ([*c]FMOD_OUTPUT_STATE, c_int, FMOD_INITFLAGS, [*c]c_int, [*c]FMOD_SPEAKERMODE, [*c]c_int, [*c]FMOD_SOUND_FORMAT, c_int, c_int, ?*c_void) callconv(.C) FMOD_RESULT;
pub const FMOD_OUTPUT_START_CALLBACK = ?fn ([*c]FMOD_OUTPUT_STATE) callconv(.C) FMOD_RESULT;
pub const FMOD_OUTPUT_STOP_CALLBACK = ?fn ([*c]FMOD_OUTPUT_STATE) callconv(.C) FMOD_RESULT;
pub const FMOD_OUTPUT_CLOSE_CALLBACK = ?fn ([*c]FMOD_OUTPUT_STATE) callconv(.C) FMOD_RESULT;
pub const FMOD_OUTPUT_UPDATE_CALLBACK = ?fn ([*c]FMOD_OUTPUT_STATE) callconv(.C) FMOD_RESULT;
pub const FMOD_OUTPUT_GETHANDLE_CALLBACK = ?fn ([*c]FMOD_OUTPUT_STATE, [*c]?*c_void) callconv(.C) FMOD_RESULT;
pub const FMOD_OUTPUT_GETPOSITION_CALLBACK = ?fn ([*c]FMOD_OUTPUT_STATE, [*c]c_uint) callconv(.C) FMOD_RESULT;
pub const FMOD_OUTPUT_LOCK_CALLBACK = ?fn ([*c]FMOD_OUTPUT_STATE, c_uint, c_uint, [*c]?*c_void, [*c]?*c_void, [*c]c_uint, [*c]c_uint) callconv(.C) FMOD_RESULT;
pub const FMOD_OUTPUT_UNLOCK_CALLBACK = ?fn ([*c]FMOD_OUTPUT_STATE, ?*c_void, ?*c_void, c_uint, c_uint) callconv(.C) FMOD_RESULT;
pub const FMOD_OUTPUT_MIXER_CALLBACK = ?fn ([*c]FMOD_OUTPUT_STATE) callconv(.C) FMOD_RESULT;
pub const FMOD_OUTPUT_OBJECT3DGETINFO_CALLBACK = ?fn ([*c]FMOD_OUTPUT_STATE, [*c]c_int) callconv(.C) FMOD_RESULT;
pub const FMOD_OUTPUT_OBJECT3DALLOC_CALLBACK = ?fn ([*c]FMOD_OUTPUT_STATE, [*c]?*c_void) callconv(.C) FMOD_RESULT;
pub const FMOD_OUTPUT_OBJECT3DFREE_CALLBACK = ?fn ([*c]FMOD_OUTPUT_STATE, ?*c_void) callconv(.C) FMOD_RESULT;
pub const FMOD_OUTPUT_OBJECT3DUPDATE_CALLBACK = ?fn ([*c]FMOD_OUTPUT_STATE, ?*c_void, [*c]const FMOD_OUTPUT_OBJECT3DINFO) callconv(.C) FMOD_RESULT;
pub const FMOD_OUTPUT_OPENPORT_CALLBACK = ?fn ([*c]FMOD_OUTPUT_STATE, FMOD_PORT_TYPE, FMOD_PORT_INDEX, [*c]c_int, [*c]c_int, [*c]c_int, [*c]FMOD_SOUND_FORMAT) callconv(.C) FMOD_RESULT;
pub const FMOD_OUTPUT_CLOSEPORT_CALLBACK = ?fn ([*c]FMOD_OUTPUT_STATE, c_int) callconv(.C) FMOD_RESULT;
pub const FMOD_OUTPUT_DEVICELISTCHANGED_CALLBACK = ?fn ([*c]FMOD_OUTPUT_STATE) callconv(.C) FMOD_RESULT;
pub const struct_FMOD_OUTPUT_DESCRIPTION = extern struct {
    apiversion: c_uint,
    name: [*c]const u8,
    version: c_uint,
    method: FMOD_OUTPUT_METHOD,
    getnumdrivers: FMOD_OUTPUT_GETNUMDRIVERS_CALLBACK,
    getdriverinfo: FMOD_OUTPUT_GETDRIVERINFO_CALLBACK,
    init: FMOD_OUTPUT_INIT_CALLBACK,
    start: FMOD_OUTPUT_START_CALLBACK,
    stop: FMOD_OUTPUT_STOP_CALLBACK,
    close: FMOD_OUTPUT_CLOSE_CALLBACK,
    update: FMOD_OUTPUT_UPDATE_CALLBACK,
    gethandle: FMOD_OUTPUT_GETHANDLE_CALLBACK,
    getposition: FMOD_OUTPUT_GETPOSITION_CALLBACK,
    lock: FMOD_OUTPUT_LOCK_CALLBACK,
    unlock: FMOD_OUTPUT_UNLOCK_CALLBACK,
    mixer: FMOD_OUTPUT_MIXER_CALLBACK,
    object3dgetinfo: FMOD_OUTPUT_OBJECT3DGETINFO_CALLBACK,
    object3dalloc: FMOD_OUTPUT_OBJECT3DALLOC_CALLBACK,
    object3dfree: FMOD_OUTPUT_OBJECT3DFREE_CALLBACK,
    object3dupdate: FMOD_OUTPUT_OBJECT3DUPDATE_CALLBACK,
    openport: FMOD_OUTPUT_OPENPORT_CALLBACK,
    closeport: FMOD_OUTPUT_CLOSEPORT_CALLBACK,
    devicelistchanged: FMOD_OUTPUT_DEVICELISTCHANGED_CALLBACK,
};
pub const FMOD_OUTPUT_DESCRIPTION = struct_FMOD_OUTPUT_DESCRIPTION;
pub extern fn FMOD_Memory_Initialize(poolmem: ?*c_void, poollen: c_int, useralloc: FMOD_MEMORY_ALLOC_CALLBACK, userrealloc: FMOD_MEMORY_REALLOC_CALLBACK, userfree: FMOD_MEMORY_FREE_CALLBACK, memtypeflags: FMOD_MEMORY_TYPE) FMOD_RESULT;
pub extern fn FMOD_Memory_GetStats(currentalloced: [*c]c_int, maxalloced: [*c]c_int, blocking: FMOD_BOOL) FMOD_RESULT;
pub extern fn FMOD_Debug_Initialize(flags: FMOD_DEBUG_FLAGS, mode: FMOD_DEBUG_MODE, callback: FMOD_DEBUG_CALLBACK, filename: [*c]const u8) FMOD_RESULT;
pub extern fn FMOD_File_SetDiskBusy(busy: c_int) FMOD_RESULT;
pub extern fn FMOD_File_GetDiskBusy(busy: [*c]c_int) FMOD_RESULT;
pub extern fn FMOD_Thread_SetAttributes(type: FMOD_THREAD_TYPE, affinity: FMOD_THREAD_AFFINITY, priority: FMOD_THREAD_PRIORITY, stacksize: FMOD_THREAD_STACK_SIZE) FMOD_RESULT;
pub extern fn FMOD_System_Create(system: [*c]?*FMOD_SYSTEM) FMOD_RESULT;
pub extern fn FMOD_System_Release(system: ?*FMOD_SYSTEM) FMOD_RESULT;
pub extern fn FMOD_System_SetOutput(system: ?*FMOD_SYSTEM, output: FMOD_OUTPUTTYPE) FMOD_RESULT;
pub extern fn FMOD_System_GetOutput(system: ?*FMOD_SYSTEM, output: [*c]FMOD_OUTPUTTYPE) FMOD_RESULT;
pub extern fn FMOD_System_GetNumDrivers(system: ?*FMOD_SYSTEM, numdrivers: [*c]c_int) FMOD_RESULT;
pub extern fn FMOD_System_GetDriverInfo(system: ?*FMOD_SYSTEM, id: c_int, name: [*c]u8, namelen: c_int, guid: [*c]FMOD_GUID, systemrate: [*c]c_int, speakermode: [*c]FMOD_SPEAKERMODE, speakermodechannels: [*c]c_int) FMOD_RESULT;
pub extern fn FMOD_System_SetDriver(system: ?*FMOD_SYSTEM, driver: c_int) FMOD_RESULT;
pub extern fn FMOD_System_GetDriver(system: ?*FMOD_SYSTEM, driver: [*c]c_int) FMOD_RESULT;
pub extern fn FMOD_System_SetSoftwareChannels(system: ?*FMOD_SYSTEM, numsoftwarechannels: c_int) FMOD_RESULT;
pub extern fn FMOD_System_GetSoftwareChannels(system: ?*FMOD_SYSTEM, numsoftwarechannels: [*c]c_int) FMOD_RESULT;
pub extern fn FMOD_System_SetSoftwareFormat(system: ?*FMOD_SYSTEM, samplerate: c_int, speakermode: FMOD_SPEAKERMODE, numrawspeakers: c_int) FMOD_RESULT;
pub extern fn FMOD_System_GetSoftwareFormat(system: ?*FMOD_SYSTEM, samplerate: [*c]c_int, speakermode: [*c]FMOD_SPEAKERMODE, numrawspeakers: [*c]c_int) FMOD_RESULT;
pub extern fn FMOD_System_SetDSPBufferSize(system: ?*FMOD_SYSTEM, bufferlength: c_uint, numbuffers: c_int) FMOD_RESULT;
pub extern fn FMOD_System_GetDSPBufferSize(system: ?*FMOD_SYSTEM, bufferlength: [*c]c_uint, numbuffers: [*c]c_int) FMOD_RESULT;
pub extern fn FMOD_System_SetFileSystem(system: ?*FMOD_SYSTEM, useropen: FMOD_FILE_OPEN_CALLBACK, userclose: FMOD_FILE_CLOSE_CALLBACK, userread: FMOD_FILE_READ_CALLBACK, userseek: FMOD_FILE_SEEK_CALLBACK, userasyncread: FMOD_FILE_ASYNCREAD_CALLBACK, userasynccancel: FMOD_FILE_ASYNCCANCEL_CALLBACK, blockalign: c_int) FMOD_RESULT;
pub extern fn FMOD_System_AttachFileSystem(system: ?*FMOD_SYSTEM, useropen: FMOD_FILE_OPEN_CALLBACK, userclose: FMOD_FILE_CLOSE_CALLBACK, userread: FMOD_FILE_READ_CALLBACK, userseek: FMOD_FILE_SEEK_CALLBACK) FMOD_RESULT;
pub extern fn FMOD_System_SetAdvancedSettings(system: ?*FMOD_SYSTEM, settings: [*c]FMOD_ADVANCEDSETTINGS) FMOD_RESULT;
pub extern fn FMOD_System_GetAdvancedSettings(system: ?*FMOD_SYSTEM, settings: [*c]FMOD_ADVANCEDSETTINGS) FMOD_RESULT;
pub extern fn FMOD_System_SetCallback(system: ?*FMOD_SYSTEM, callback: FMOD_SYSTEM_CALLBACK, callbackmask: FMOD_SYSTEM_CALLBACK_TYPE) FMOD_RESULT;
pub extern fn FMOD_System_SetPluginPath(system: ?*FMOD_SYSTEM, path: [*c]const u8) FMOD_RESULT;
pub extern fn FMOD_System_LoadPlugin(system: ?*FMOD_SYSTEM, filename: [*c]const u8, handle: [*c]c_uint, priority: c_uint) FMOD_RESULT;
pub extern fn FMOD_System_UnloadPlugin(system: ?*FMOD_SYSTEM, handle: c_uint) FMOD_RESULT;
pub extern fn FMOD_System_GetNumNestedPlugins(system: ?*FMOD_SYSTEM, handle: c_uint, count: [*c]c_int) FMOD_RESULT;
pub extern fn FMOD_System_GetNestedPlugin(system: ?*FMOD_SYSTEM, handle: c_uint, index: c_int, nestedhandle: [*c]c_uint) FMOD_RESULT;
pub extern fn FMOD_System_GetNumPlugins(system: ?*FMOD_SYSTEM, plugintype: FMOD_PLUGINTYPE, numplugins: [*c]c_int) FMOD_RESULT;
pub extern fn FMOD_System_GetPluginHandle(system: ?*FMOD_SYSTEM, plugintype: FMOD_PLUGINTYPE, index: c_int, handle: [*c]c_uint) FMOD_RESULT;
pub extern fn FMOD_System_GetPluginInfo(system: ?*FMOD_SYSTEM, handle: c_uint, plugintype: [*c]FMOD_PLUGINTYPE, name: [*c]u8, namelen: c_int, version: [*c]c_uint) FMOD_RESULT;
pub extern fn FMOD_System_SetOutputByPlugin(system: ?*FMOD_SYSTEM, handle: c_uint) FMOD_RESULT;
pub extern fn FMOD_System_GetOutputByPlugin(system: ?*FMOD_SYSTEM, handle: [*c]c_uint) FMOD_RESULT;
pub extern fn FMOD_System_CreateDSPByPlugin(system: ?*FMOD_SYSTEM, handle: c_uint, dsp: [*c]?*FMOD_DSP) FMOD_RESULT;
pub extern fn FMOD_System_GetDSPInfoByPlugin(system: ?*FMOD_SYSTEM, handle: c_uint, description: [*c][*c]const FMOD_DSP_DESCRIPTION) FMOD_RESULT;
pub extern fn FMOD_System_RegisterCodec(system: ?*FMOD_SYSTEM, description: [*c]FMOD_CODEC_DESCRIPTION, handle: [*c]c_uint, priority: c_uint) FMOD_RESULT;
pub extern fn FMOD_System_RegisterDSP(system: ?*FMOD_SYSTEM, description: [*c]const FMOD_DSP_DESCRIPTION, handle: [*c]c_uint) FMOD_RESULT;
pub extern fn FMOD_System_RegisterOutput(system: ?*FMOD_SYSTEM, description: [*c]const FMOD_OUTPUT_DESCRIPTION, handle: [*c]c_uint) FMOD_RESULT;
pub extern fn FMOD_System_Init(system: ?*FMOD_SYSTEM, maxchannels: c_int, flags: FMOD_INITFLAGS, extradriverdata: ?*c_void) FMOD_RESULT;
pub extern fn FMOD_System_Close(system: ?*FMOD_SYSTEM) FMOD_RESULT;
pub extern fn FMOD_System_Update(system: ?*FMOD_SYSTEM) FMOD_RESULT;
pub extern fn FMOD_System_SetSpeakerPosition(system: ?*FMOD_SYSTEM, speaker: FMOD_SPEAKER, x: f32, y: f32, active: FMOD_BOOL) FMOD_RESULT;
pub extern fn FMOD_System_GetSpeakerPosition(system: ?*FMOD_SYSTEM, speaker: FMOD_SPEAKER, x: [*c]f32, y: [*c]f32, active: [*c]FMOD_BOOL) FMOD_RESULT;
pub extern fn FMOD_System_SetStreamBufferSize(system: ?*FMOD_SYSTEM, filebuffersize: c_uint, filebuffersizetype: FMOD_TIMEUNIT) FMOD_RESULT;
pub extern fn FMOD_System_GetStreamBufferSize(system: ?*FMOD_SYSTEM, filebuffersize: [*c]c_uint, filebuffersizetype: [*c]FMOD_TIMEUNIT) FMOD_RESULT;
pub extern fn FMOD_System_Set3DSettings(system: ?*FMOD_SYSTEM, dopplerscale: f32, distancefactor: f32, rolloffscale: f32) FMOD_RESULT;
pub extern fn FMOD_System_Get3DSettings(system: ?*FMOD_SYSTEM, dopplerscale: [*c]f32, distancefactor: [*c]f32, rolloffscale: [*c]f32) FMOD_RESULT;
pub extern fn FMOD_System_Set3DNumListeners(system: ?*FMOD_SYSTEM, numlisteners: c_int) FMOD_RESULT;
pub extern fn FMOD_System_Get3DNumListeners(system: ?*FMOD_SYSTEM, numlisteners: [*c]c_int) FMOD_RESULT;
pub extern fn FMOD_System_Set3DListenerAttributes(system: ?*FMOD_SYSTEM, listener: c_int, pos: [*c]const FMOD_VECTOR, vel: [*c]const FMOD_VECTOR, forward: [*c]const FMOD_VECTOR, up: [*c]const FMOD_VECTOR) FMOD_RESULT;
pub extern fn FMOD_System_Get3DListenerAttributes(system: ?*FMOD_SYSTEM, listener: c_int, pos: [*c]FMOD_VECTOR, vel: [*c]FMOD_VECTOR, forward: [*c]FMOD_VECTOR, up: [*c]FMOD_VECTOR) FMOD_RESULT;
pub extern fn FMOD_System_MixerSuspend(system: ?*FMOD_SYSTEM) FMOD_RESULT;
pub extern fn FMOD_System_MixerResume(system: ?*FMOD_SYSTEM) FMOD_RESULT;
pub extern fn FMOD_System_GetDefaultMixMatrix(system: ?*FMOD_SYSTEM, sourcespeakermode: FMOD_SPEAKERMODE, targetspeakermode: FMOD_SPEAKERMODE, matrix: [*c]f32, matrixhop: c_int) FMOD_RESULT;
pub extern fn FMOD_System_GetSpeakerModeChannels(system: ?*FMOD_SYSTEM, mode: FMOD_SPEAKERMODE, channels: [*c]c_int) FMOD_RESULT;
pub extern fn FMOD_System_GetVersion(system: ?*FMOD_SYSTEM, version: [*c]c_uint) FMOD_RESULT;
pub extern fn FMOD_System_GetOutputHandle(system: ?*FMOD_SYSTEM, handle: [*c]?*c_void) FMOD_RESULT;
pub extern fn FMOD_System_GetChannelsPlaying(system: ?*FMOD_SYSTEM, channels: [*c]c_int, realchannels: [*c]c_int) FMOD_RESULT;
pub extern fn FMOD_System_GetCPUUsage(system: ?*FMOD_SYSTEM, dsp: [*c]f32, stream: [*c]f32, geometry: [*c]f32, update: [*c]f32, total: [*c]f32) FMOD_RESULT;
pub extern fn FMOD_System_GetCPUUsageEx(system: ?*FMOD_SYSTEM, convolutionThread1: [*c]f32, convolutionThread2: [*c]f32) FMOD_RESULT;
pub extern fn FMOD_System_GetFileUsage(system: ?*FMOD_SYSTEM, sampleBytesRead: [*c]c_longlong, streamBytesRead: [*c]c_longlong, otherBytesRead: [*c]c_longlong) FMOD_RESULT;
pub extern fn FMOD_System_CreateSound(system: ?*FMOD_SYSTEM, name_or_data: [*c]const u8, mode: FMOD_MODE, exinfo: [*c]FMOD_CREATESOUNDEXINFO, sound: [*c]?*FMOD_SOUND) FMOD_RESULT;
pub extern fn FMOD_System_CreateStream(system: ?*FMOD_SYSTEM, name_or_data: [*c]const u8, mode: FMOD_MODE, exinfo: [*c]FMOD_CREATESOUNDEXINFO, sound: [*c]?*FMOD_SOUND) FMOD_RESULT;
pub extern fn FMOD_System_CreateDSP(system: ?*FMOD_SYSTEM, description: [*c]const FMOD_DSP_DESCRIPTION, dsp: [*c]?*FMOD_DSP) FMOD_RESULT;
pub extern fn FMOD_System_CreateDSPByType(system: ?*FMOD_SYSTEM, type: FMOD_DSP_TYPE, dsp: [*c]?*FMOD_DSP) FMOD_RESULT;
pub extern fn FMOD_System_CreateChannelGroup(system: ?*FMOD_SYSTEM, name: [*c]const u8, channelgroup: [*c]?*FMOD_CHANNELGROUP) FMOD_RESULT;
pub extern fn FMOD_System_CreateSoundGroup(system: ?*FMOD_SYSTEM, name: [*c]const u8, soundgroup: [*c]?*FMOD_SOUNDGROUP) FMOD_RESULT;
pub extern fn FMOD_System_CreateReverb3D(system: ?*FMOD_SYSTEM, reverb: [*c]?*FMOD_REVERB3D) FMOD_RESULT;
pub extern fn FMOD_System_PlaySound(system: ?*FMOD_SYSTEM, sound: ?*FMOD_SOUND, channelgroup: ?*FMOD_CHANNELGROUP, paused: FMOD_BOOL, channel: [*c]?*FMOD_CHANNEL) FMOD_RESULT;
pub extern fn FMOD_System_PlayDSP(system: ?*FMOD_SYSTEM, dsp: ?*FMOD_DSP, channelgroup: ?*FMOD_CHANNELGROUP, paused: FMOD_BOOL, channel: [*c]?*FMOD_CHANNEL) FMOD_RESULT;
pub extern fn FMOD_System_GetChannel(system: ?*FMOD_SYSTEM, channelid: c_int, channel: [*c]?*FMOD_CHANNEL) FMOD_RESULT;
pub extern fn FMOD_System_GetDSPInfoByType(system: ?*FMOD_SYSTEM, type: FMOD_DSP_TYPE, description: [*c][*c]const FMOD_DSP_DESCRIPTION) FMOD_RESULT;
pub extern fn FMOD_System_GetMasterChannelGroup(system: ?*FMOD_SYSTEM, channelgroup: [*c]?*FMOD_CHANNELGROUP) FMOD_RESULT;
pub extern fn FMOD_System_GetMasterSoundGroup(system: ?*FMOD_SYSTEM, soundgroup: [*c]?*FMOD_SOUNDGROUP) FMOD_RESULT;
pub extern fn FMOD_System_AttachChannelGroupToPort(system: ?*FMOD_SYSTEM, portType: FMOD_PORT_TYPE, portIndex: FMOD_PORT_INDEX, channelgroup: ?*FMOD_CHANNELGROUP, passThru: FMOD_BOOL) FMOD_RESULT;
pub extern fn FMOD_System_DetachChannelGroupFromPort(system: ?*FMOD_SYSTEM, channelgroup: ?*FMOD_CHANNELGROUP) FMOD_RESULT;
pub extern fn FMOD_System_SetReverbProperties(system: ?*FMOD_SYSTEM, instance: c_int, prop: [*c]const FMOD_REVERB_PROPERTIES) FMOD_RESULT;
pub extern fn FMOD_System_GetReverbProperties(system: ?*FMOD_SYSTEM, instance: c_int, prop: [*c]FMOD_REVERB_PROPERTIES) FMOD_RESULT;
pub extern fn FMOD_System_LockDSP(system: ?*FMOD_SYSTEM) FMOD_RESULT;
pub extern fn FMOD_System_UnlockDSP(system: ?*FMOD_SYSTEM) FMOD_RESULT;
pub extern fn FMOD_System_GetRecordNumDrivers(system: ?*FMOD_SYSTEM, numdrivers: [*c]c_int, numconnected: [*c]c_int) FMOD_RESULT;
pub extern fn FMOD_System_GetRecordDriverInfo(system: ?*FMOD_SYSTEM, id: c_int, name: [*c]u8, namelen: c_int, guid: [*c]FMOD_GUID, systemrate: [*c]c_int, speakermode: [*c]FMOD_SPEAKERMODE, speakermodechannels: [*c]c_int, state: [*c]FMOD_DRIVER_STATE) FMOD_RESULT;
pub extern fn FMOD_System_GetRecordPosition(system: ?*FMOD_SYSTEM, id: c_int, position: [*c]c_uint) FMOD_RESULT;
pub extern fn FMOD_System_RecordStart(system: ?*FMOD_SYSTEM, id: c_int, sound: ?*FMOD_SOUND, loop: FMOD_BOOL) FMOD_RESULT;
pub extern fn FMOD_System_RecordStop(system: ?*FMOD_SYSTEM, id: c_int) FMOD_RESULT;
pub extern fn FMOD_System_IsRecording(system: ?*FMOD_SYSTEM, id: c_int, recording: [*c]FMOD_BOOL) FMOD_RESULT;
pub extern fn FMOD_System_CreateGeometry(system: ?*FMOD_SYSTEM, maxpolygons: c_int, maxvertices: c_int, geometry: [*c]?*FMOD_GEOMETRY) FMOD_RESULT;
pub extern fn FMOD_System_SetGeometrySettings(system: ?*FMOD_SYSTEM, maxworldsize: f32) FMOD_RESULT;
pub extern fn FMOD_System_GetGeometrySettings(system: ?*FMOD_SYSTEM, maxworldsize: [*c]f32) FMOD_RESULT;
pub extern fn FMOD_System_LoadGeometry(system: ?*FMOD_SYSTEM, data: ?*const c_void, datasize: c_int, geometry: [*c]?*FMOD_GEOMETRY) FMOD_RESULT;
pub extern fn FMOD_System_GetGeometryOcclusion(system: ?*FMOD_SYSTEM, listener: [*c]const FMOD_VECTOR, source: [*c]const FMOD_VECTOR, direct: [*c]f32, reverb: [*c]f32) FMOD_RESULT;
pub extern fn FMOD_System_SetNetworkProxy(system: ?*FMOD_SYSTEM, proxy: [*c]const u8) FMOD_RESULT;
pub extern fn FMOD_System_GetNetworkProxy(system: ?*FMOD_SYSTEM, proxy: [*c]u8, proxylen: c_int) FMOD_RESULT;
pub extern fn FMOD_System_SetNetworkTimeout(system: ?*FMOD_SYSTEM, timeout: c_int) FMOD_RESULT;
pub extern fn FMOD_System_GetNetworkTimeout(system: ?*FMOD_SYSTEM, timeout: [*c]c_int) FMOD_RESULT;
pub extern fn FMOD_System_SetUserData(system: ?*FMOD_SYSTEM, userdata: ?*c_void) FMOD_RESULT;
pub extern fn FMOD_System_GetUserData(system: ?*FMOD_SYSTEM, userdata: [*c]?*c_void) FMOD_RESULT;
pub extern fn FMOD_Sound_Release(sound: ?*FMOD_SOUND) FMOD_RESULT;
pub extern fn FMOD_Sound_GetSystemObject(sound: ?*FMOD_SOUND, system: [*c]?*FMOD_SYSTEM) FMOD_RESULT;
pub extern fn FMOD_Sound_Lock(sound: ?*FMOD_SOUND, offset: c_uint, length: c_uint, ptr1: [*c]?*c_void, ptr2: [*c]?*c_void, len1: [*c]c_uint, len2: [*c]c_uint) FMOD_RESULT;
pub extern fn FMOD_Sound_Unlock(sound: ?*FMOD_SOUND, ptr1: ?*c_void, ptr2: ?*c_void, len1: c_uint, len2: c_uint) FMOD_RESULT;
pub extern fn FMOD_Sound_SetDefaults(sound: ?*FMOD_SOUND, frequency: f32, priority: c_int) FMOD_RESULT;
pub extern fn FMOD_Sound_GetDefaults(sound: ?*FMOD_SOUND, frequency: [*c]f32, priority: [*c]c_int) FMOD_RESULT;
pub extern fn FMOD_Sound_Set3DMinMaxDistance(sound: ?*FMOD_SOUND, min: f32, max: f32) FMOD_RESULT;
pub extern fn FMOD_Sound_Get3DMinMaxDistance(sound: ?*FMOD_SOUND, min: [*c]f32, max: [*c]f32) FMOD_RESULT;
pub extern fn FMOD_Sound_Set3DConeSettings(sound: ?*FMOD_SOUND, insideconeangle: f32, outsideconeangle: f32, outsidevolume: f32) FMOD_RESULT;
pub extern fn FMOD_Sound_Get3DConeSettings(sound: ?*FMOD_SOUND, insideconeangle: [*c]f32, outsideconeangle: [*c]f32, outsidevolume: [*c]f32) FMOD_RESULT;
pub extern fn FMOD_Sound_Set3DCustomRolloff(sound: ?*FMOD_SOUND, points: [*c]FMOD_VECTOR, numpoints: c_int) FMOD_RESULT;
pub extern fn FMOD_Sound_Get3DCustomRolloff(sound: ?*FMOD_SOUND, points: [*c][*c]FMOD_VECTOR, numpoints: [*c]c_int) FMOD_RESULT;
pub extern fn FMOD_Sound_GetSubSound(sound: ?*FMOD_SOUND, index: c_int, subsound: [*c]?*FMOD_SOUND) FMOD_RESULT;
pub extern fn FMOD_Sound_GetSubSoundParent(sound: ?*FMOD_SOUND, parentsound: [*c]?*FMOD_SOUND) FMOD_RESULT;
pub extern fn FMOD_Sound_GetName(sound: ?*FMOD_SOUND, name: [*c]u8, namelen: c_int) FMOD_RESULT;
pub extern fn FMOD_Sound_GetLength(sound: ?*FMOD_SOUND, length: [*c]c_uint, lengthtype: FMOD_TIMEUNIT) FMOD_RESULT;
pub extern fn FMOD_Sound_GetFormat(sound: ?*FMOD_SOUND, type: [*c]FMOD_SOUND_TYPE, format: [*c]FMOD_SOUND_FORMAT, channels: [*c]c_int, bits: [*c]c_int) FMOD_RESULT;
pub extern fn FMOD_Sound_GetNumSubSounds(sound: ?*FMOD_SOUND, numsubsounds: [*c]c_int) FMOD_RESULT;
pub extern fn FMOD_Sound_GetNumTags(sound: ?*FMOD_SOUND, numtags: [*c]c_int, numtagsupdated: [*c]c_int) FMOD_RESULT;
pub extern fn FMOD_Sound_GetTag(sound: ?*FMOD_SOUND, name: [*c]const u8, index: c_int, tag: [*c]FMOD_TAG) FMOD_RESULT;
pub extern fn FMOD_Sound_GetOpenState(sound: ?*FMOD_SOUND, openstate: [*c]FMOD_OPENSTATE, percentbuffered: [*c]c_uint, starving: [*c]FMOD_BOOL, diskbusy: [*c]FMOD_BOOL) FMOD_RESULT;
pub extern fn FMOD_Sound_ReadData(sound: ?*FMOD_SOUND, buffer: ?*c_void, length: c_uint, read: [*c]c_uint) FMOD_RESULT;
pub extern fn FMOD_Sound_SeekData(sound: ?*FMOD_SOUND, pcm: c_uint) FMOD_RESULT;
pub extern fn FMOD_Sound_SetSoundGroup(sound: ?*FMOD_SOUND, soundgroup: ?*FMOD_SOUNDGROUP) FMOD_RESULT;
pub extern fn FMOD_Sound_GetSoundGroup(sound: ?*FMOD_SOUND, soundgroup: [*c]?*FMOD_SOUNDGROUP) FMOD_RESULT;
pub extern fn FMOD_Sound_GetNumSyncPoints(sound: ?*FMOD_SOUND, numsyncpoints: [*c]c_int) FMOD_RESULT;
pub extern fn FMOD_Sound_GetSyncPoint(sound: ?*FMOD_SOUND, index: c_int, point: [*c]?*FMOD_SYNCPOINT) FMOD_RESULT;
pub extern fn FMOD_Sound_GetSyncPointInfo(sound: ?*FMOD_SOUND, point: ?*FMOD_SYNCPOINT, name: [*c]u8, namelen: c_int, offset: [*c]c_uint, offsettype: FMOD_TIMEUNIT) FMOD_RESULT;
pub extern fn FMOD_Sound_AddSyncPoint(sound: ?*FMOD_SOUND, offset: c_uint, offsettype: FMOD_TIMEUNIT, name: [*c]const u8, point: [*c]?*FMOD_SYNCPOINT) FMOD_RESULT;
pub extern fn FMOD_Sound_DeleteSyncPoint(sound: ?*FMOD_SOUND, point: ?*FMOD_SYNCPOINT) FMOD_RESULT;
pub extern fn FMOD_Sound_SetMode(sound: ?*FMOD_SOUND, mode: FMOD_MODE) FMOD_RESULT;
pub extern fn FMOD_Sound_GetMode(sound: ?*FMOD_SOUND, mode: [*c]FMOD_MODE) FMOD_RESULT;
pub extern fn FMOD_Sound_SetLoopCount(sound: ?*FMOD_SOUND, loopcount: c_int) FMOD_RESULT;
pub extern fn FMOD_Sound_GetLoopCount(sound: ?*FMOD_SOUND, loopcount: [*c]c_int) FMOD_RESULT;
pub extern fn FMOD_Sound_SetLoopPoints(sound: ?*FMOD_SOUND, loopstart: c_uint, loopstarttype: FMOD_TIMEUNIT, loopend: c_uint, loopendtype: FMOD_TIMEUNIT) FMOD_RESULT;
pub extern fn FMOD_Sound_GetLoopPoints(sound: ?*FMOD_SOUND, loopstart: [*c]c_uint, loopstarttype: FMOD_TIMEUNIT, loopend: [*c]c_uint, loopendtype: FMOD_TIMEUNIT) FMOD_RESULT;
pub extern fn FMOD_Sound_GetMusicNumChannels(sound: ?*FMOD_SOUND, numchannels: [*c]c_int) FMOD_RESULT;
pub extern fn FMOD_Sound_SetMusicChannelVolume(sound: ?*FMOD_SOUND, channel: c_int, volume: f32) FMOD_RESULT;
pub extern fn FMOD_Sound_GetMusicChannelVolume(sound: ?*FMOD_SOUND, channel: c_int, volume: [*c]f32) FMOD_RESULT;
pub extern fn FMOD_Sound_SetMusicSpeed(sound: ?*FMOD_SOUND, speed: f32) FMOD_RESULT;
pub extern fn FMOD_Sound_GetMusicSpeed(sound: ?*FMOD_SOUND, speed: [*c]f32) FMOD_RESULT;
pub extern fn FMOD_Sound_SetUserData(sound: ?*FMOD_SOUND, userdata: ?*c_void) FMOD_RESULT;
pub extern fn FMOD_Sound_GetUserData(sound: ?*FMOD_SOUND, userdata: [*c]?*c_void) FMOD_RESULT;
pub extern fn FMOD_Channel_GetSystemObject(channel: ?*FMOD_CHANNEL, system: [*c]?*FMOD_SYSTEM) FMOD_RESULT;
pub extern fn FMOD_Channel_Stop(channel: ?*FMOD_CHANNEL) FMOD_RESULT;
pub extern fn FMOD_Channel_SetPaused(channel: ?*FMOD_CHANNEL, paused: FMOD_BOOL) FMOD_RESULT;
pub extern fn FMOD_Channel_GetPaused(channel: ?*FMOD_CHANNEL, paused: [*c]FMOD_BOOL) FMOD_RESULT;
pub extern fn FMOD_Channel_SetVolume(channel: ?*FMOD_CHANNEL, volume: f32) FMOD_RESULT;
pub extern fn FMOD_Channel_GetVolume(channel: ?*FMOD_CHANNEL, volume: [*c]f32) FMOD_RESULT;
pub extern fn FMOD_Channel_SetVolumeRamp(channel: ?*FMOD_CHANNEL, ramp: FMOD_BOOL) FMOD_RESULT;
pub extern fn FMOD_Channel_GetVolumeRamp(channel: ?*FMOD_CHANNEL, ramp: [*c]FMOD_BOOL) FMOD_RESULT;
pub extern fn FMOD_Channel_GetAudibility(channel: ?*FMOD_CHANNEL, audibility: [*c]f32) FMOD_RESULT;
pub extern fn FMOD_Channel_SetPitch(channel: ?*FMOD_CHANNEL, pitch: f32) FMOD_RESULT;
pub extern fn FMOD_Channel_GetPitch(channel: ?*FMOD_CHANNEL, pitch: [*c]f32) FMOD_RESULT;
pub extern fn FMOD_Channel_SetMute(channel: ?*FMOD_CHANNEL, mute: FMOD_BOOL) FMOD_RESULT;
pub extern fn FMOD_Channel_GetMute(channel: ?*FMOD_CHANNEL, mute: [*c]FMOD_BOOL) FMOD_RESULT;
pub extern fn FMOD_Channel_SetReverbProperties(channel: ?*FMOD_CHANNEL, instance: c_int, wet: f32) FMOD_RESULT;
pub extern fn FMOD_Channel_GetReverbProperties(channel: ?*FMOD_CHANNEL, instance: c_int, wet: [*c]f32) FMOD_RESULT;
pub extern fn FMOD_Channel_SetLowPassGain(channel: ?*FMOD_CHANNEL, gain: f32) FMOD_RESULT;
pub extern fn FMOD_Channel_GetLowPassGain(channel: ?*FMOD_CHANNEL, gain: [*c]f32) FMOD_RESULT;
pub extern fn FMOD_Channel_SetMode(channel: ?*FMOD_CHANNEL, mode: FMOD_MODE) FMOD_RESULT;
pub extern fn FMOD_Channel_GetMode(channel: ?*FMOD_CHANNEL, mode: [*c]FMOD_MODE) FMOD_RESULT;
pub extern fn FMOD_Channel_SetCallback(channel: ?*FMOD_CHANNEL, callback: FMOD_CHANNELCONTROL_CALLBACK) FMOD_RESULT;
pub extern fn FMOD_Channel_IsPlaying(channel: ?*FMOD_CHANNEL, isplaying: [*c]FMOD_BOOL) FMOD_RESULT;
pub extern fn FMOD_Channel_SetPan(channel: ?*FMOD_CHANNEL, pan: f32) FMOD_RESULT;
pub extern fn FMOD_Channel_SetMixLevelsOutput(channel: ?*FMOD_CHANNEL, frontleft: f32, frontright: f32, center: f32, lfe: f32, surroundleft: f32, surroundright: f32, backleft: f32, backright: f32) FMOD_RESULT;
pub extern fn FMOD_Channel_SetMixLevelsInput(channel: ?*FMOD_CHANNEL, levels: [*c]f32, numlevels: c_int) FMOD_RESULT;
pub extern fn FMOD_Channel_SetMixMatrix(channel: ?*FMOD_CHANNEL, matrix: [*c]f32, outchannels: c_int, inchannels: c_int, inchannel_hop: c_int) FMOD_RESULT;
pub extern fn FMOD_Channel_GetMixMatrix(channel: ?*FMOD_CHANNEL, matrix: [*c]f32, outchannels: [*c]c_int, inchannels: [*c]c_int, inchannel_hop: c_int) FMOD_RESULT;
pub extern fn FMOD_Channel_GetDSPClock(channel: ?*FMOD_CHANNEL, dspclock: [*c]c_ulonglong, parentclock: [*c]c_ulonglong) FMOD_RESULT;
pub extern fn FMOD_Channel_SetDelay(channel: ?*FMOD_CHANNEL, dspclock_start: c_ulonglong, dspclock_end: c_ulonglong, stopchannels: FMOD_BOOL) FMOD_RESULT;
pub extern fn FMOD_Channel_GetDelay(channel: ?*FMOD_CHANNEL, dspclock_start: [*c]c_ulonglong, dspclock_end: [*c]c_ulonglong, stopchannels: [*c]FMOD_BOOL) FMOD_RESULT;
pub extern fn FMOD_Channel_AddFadePoint(channel: ?*FMOD_CHANNEL, dspclock: c_ulonglong, volume: f32) FMOD_RESULT;
pub extern fn FMOD_Channel_SetFadePointRamp(channel: ?*FMOD_CHANNEL, dspclock: c_ulonglong, volume: f32) FMOD_RESULT;
pub extern fn FMOD_Channel_RemoveFadePoints(channel: ?*FMOD_CHANNEL, dspclock_start: c_ulonglong, dspclock_end: c_ulonglong) FMOD_RESULT;
pub extern fn FMOD_Channel_GetFadePoints(channel: ?*FMOD_CHANNEL, numpoints: [*c]c_uint, point_dspclock: [*c]c_ulonglong, point_volume: [*c]f32) FMOD_RESULT;
pub extern fn FMOD_Channel_GetDSP(channel: ?*FMOD_CHANNEL, index: c_int, dsp: [*c]?*FMOD_DSP) FMOD_RESULT;
pub extern fn FMOD_Channel_AddDSP(channel: ?*FMOD_CHANNEL, index: c_int, dsp: ?*FMOD_DSP) FMOD_RESULT;
pub extern fn FMOD_Channel_RemoveDSP(channel: ?*FMOD_CHANNEL, dsp: ?*FMOD_DSP) FMOD_RESULT;
pub extern fn FMOD_Channel_GetNumDSPs(channel: ?*FMOD_CHANNEL, numdsps: [*c]c_int) FMOD_RESULT;
pub extern fn FMOD_Channel_SetDSPIndex(channel: ?*FMOD_CHANNEL, dsp: ?*FMOD_DSP, index: c_int) FMOD_RESULT;
pub extern fn FMOD_Channel_GetDSPIndex(channel: ?*FMOD_CHANNEL, dsp: ?*FMOD_DSP, index: [*c]c_int) FMOD_RESULT;
pub extern fn FMOD_Channel_Set3DAttributes(channel: ?*FMOD_CHANNEL, pos: [*c]const FMOD_VECTOR, vel: [*c]const FMOD_VECTOR) FMOD_RESULT;
pub extern fn FMOD_Channel_Get3DAttributes(channel: ?*FMOD_CHANNEL, pos: [*c]FMOD_VECTOR, vel: [*c]FMOD_VECTOR) FMOD_RESULT;
pub extern fn FMOD_Channel_Set3DMinMaxDistance(channel: ?*FMOD_CHANNEL, mindistance: f32, maxdistance: f32) FMOD_RESULT;
pub extern fn FMOD_Channel_Get3DMinMaxDistance(channel: ?*FMOD_CHANNEL, mindistance: [*c]f32, maxdistance: [*c]f32) FMOD_RESULT;
pub extern fn FMOD_Channel_Set3DConeSettings(channel: ?*FMOD_CHANNEL, insideconeangle: f32, outsideconeangle: f32, outsidevolume: f32) FMOD_RESULT;
pub extern fn FMOD_Channel_Get3DConeSettings(channel: ?*FMOD_CHANNEL, insideconeangle: [*c]f32, outsideconeangle: [*c]f32, outsidevolume: [*c]f32) FMOD_RESULT;
pub extern fn FMOD_Channel_Set3DConeOrientation(channel: ?*FMOD_CHANNEL, orientation: [*c]FMOD_VECTOR) FMOD_RESULT;
pub extern fn FMOD_Channel_Get3DConeOrientation(channel: ?*FMOD_CHANNEL, orientation: [*c]FMOD_VECTOR) FMOD_RESULT;
pub extern fn FMOD_Channel_Set3DCustomRolloff(channel: ?*FMOD_CHANNEL, points: [*c]FMOD_VECTOR, numpoints: c_int) FMOD_RESULT;
pub extern fn FMOD_Channel_Get3DCustomRolloff(channel: ?*FMOD_CHANNEL, points: [*c][*c]FMOD_VECTOR, numpoints: [*c]c_int) FMOD_RESULT;
pub extern fn FMOD_Channel_Set3DOcclusion(channel: ?*FMOD_CHANNEL, directocclusion: f32, reverbocclusion: f32) FMOD_RESULT;
pub extern fn FMOD_Channel_Get3DOcclusion(channel: ?*FMOD_CHANNEL, directocclusion: [*c]f32, reverbocclusion: [*c]f32) FMOD_RESULT;
pub extern fn FMOD_Channel_Set3DSpread(channel: ?*FMOD_CHANNEL, angle: f32) FMOD_RESULT;
pub extern fn FMOD_Channel_Get3DSpread(channel: ?*FMOD_CHANNEL, angle: [*c]f32) FMOD_RESULT;
pub extern fn FMOD_Channel_Set3DLevel(channel: ?*FMOD_CHANNEL, level: f32) FMOD_RESULT;
pub extern fn FMOD_Channel_Get3DLevel(channel: ?*FMOD_CHANNEL, level: [*c]f32) FMOD_RESULT;
pub extern fn FMOD_Channel_Set3DDopplerLevel(channel: ?*FMOD_CHANNEL, level: f32) FMOD_RESULT;
pub extern fn FMOD_Channel_Get3DDopplerLevel(channel: ?*FMOD_CHANNEL, level: [*c]f32) FMOD_RESULT;
pub extern fn FMOD_Channel_Set3DDistanceFilter(channel: ?*FMOD_CHANNEL, custom: FMOD_BOOL, customLevel: f32, centerFreq: f32) FMOD_RESULT;
pub extern fn FMOD_Channel_Get3DDistanceFilter(channel: ?*FMOD_CHANNEL, custom: [*c]FMOD_BOOL, customLevel: [*c]f32, centerFreq: [*c]f32) FMOD_RESULT;
pub extern fn FMOD_Channel_SetUserData(channel: ?*FMOD_CHANNEL, userdata: ?*c_void) FMOD_RESULT;
pub extern fn FMOD_Channel_GetUserData(channel: ?*FMOD_CHANNEL, userdata: [*c]?*c_void) FMOD_RESULT;
pub extern fn FMOD_Channel_SetFrequency(channel: ?*FMOD_CHANNEL, frequency: f32) FMOD_RESULT;
pub extern fn FMOD_Channel_GetFrequency(channel: ?*FMOD_CHANNEL, frequency: [*c]f32) FMOD_RESULT;
pub extern fn FMOD_Channel_SetPriority(channel: ?*FMOD_CHANNEL, priority: c_int) FMOD_RESULT;
pub extern fn FMOD_Channel_GetPriority(channel: ?*FMOD_CHANNEL, priority: [*c]c_int) FMOD_RESULT;
pub extern fn FMOD_Channel_SetPosition(channel: ?*FMOD_CHANNEL, position: c_uint, postype: FMOD_TIMEUNIT) FMOD_RESULT;
pub extern fn FMOD_Channel_GetPosition(channel: ?*FMOD_CHANNEL, position: [*c]c_uint, postype: FMOD_TIMEUNIT) FMOD_RESULT;
pub extern fn FMOD_Channel_SetChannelGroup(channel: ?*FMOD_CHANNEL, channelgroup: ?*FMOD_CHANNELGROUP) FMOD_RESULT;
pub extern fn FMOD_Channel_GetChannelGroup(channel: ?*FMOD_CHANNEL, channelgroup: [*c]?*FMOD_CHANNELGROUP) FMOD_RESULT;
pub extern fn FMOD_Channel_SetLoopCount(channel: ?*FMOD_CHANNEL, loopcount: c_int) FMOD_RESULT;
pub extern fn FMOD_Channel_GetLoopCount(channel: ?*FMOD_CHANNEL, loopcount: [*c]c_int) FMOD_RESULT;
pub extern fn FMOD_Channel_SetLoopPoints(channel: ?*FMOD_CHANNEL, loopstart: c_uint, loopstarttype: FMOD_TIMEUNIT, loopend: c_uint, loopendtype: FMOD_TIMEUNIT) FMOD_RESULT;
pub extern fn FMOD_Channel_GetLoopPoints(channel: ?*FMOD_CHANNEL, loopstart: [*c]c_uint, loopstarttype: FMOD_TIMEUNIT, loopend: [*c]c_uint, loopendtype: FMOD_TIMEUNIT) FMOD_RESULT;
pub extern fn FMOD_Channel_IsVirtual(channel: ?*FMOD_CHANNEL, isvirtual: [*c]FMOD_BOOL) FMOD_RESULT;
pub extern fn FMOD_Channel_GetCurrentSound(channel: ?*FMOD_CHANNEL, sound: [*c]?*FMOD_SOUND) FMOD_RESULT;
pub extern fn FMOD_Channel_GetIndex(channel: ?*FMOD_CHANNEL, index: [*c]c_int) FMOD_RESULT;
pub extern fn FMOD_ChannelGroup_GetSystemObject(channelgroup: ?*FMOD_CHANNELGROUP, system: [*c]?*FMOD_SYSTEM) FMOD_RESULT;
pub extern fn FMOD_ChannelGroup_Stop(channelgroup: ?*FMOD_CHANNELGROUP) FMOD_RESULT;
pub extern fn FMOD_ChannelGroup_SetPaused(channelgroup: ?*FMOD_CHANNELGROUP, paused: FMOD_BOOL) FMOD_RESULT;
pub extern fn FMOD_ChannelGroup_GetPaused(channelgroup: ?*FMOD_CHANNELGROUP, paused: [*c]FMOD_BOOL) FMOD_RESULT;
pub extern fn FMOD_ChannelGroup_SetVolume(channelgroup: ?*FMOD_CHANNELGROUP, volume: f32) FMOD_RESULT;
pub extern fn FMOD_ChannelGroup_GetVolume(channelgroup: ?*FMOD_CHANNELGROUP, volume: [*c]f32) FMOD_RESULT;
pub extern fn FMOD_ChannelGroup_SetVolumeRamp(channelgroup: ?*FMOD_CHANNELGROUP, ramp: FMOD_BOOL) FMOD_RESULT;
pub extern fn FMOD_ChannelGroup_GetVolumeRamp(channelgroup: ?*FMOD_CHANNELGROUP, ramp: [*c]FMOD_BOOL) FMOD_RESULT;
pub extern fn FMOD_ChannelGroup_GetAudibility(channelgroup: ?*FMOD_CHANNELGROUP, audibility: [*c]f32) FMOD_RESULT;
pub extern fn FMOD_ChannelGroup_SetPitch(channelgroup: ?*FMOD_CHANNELGROUP, pitch: f32) FMOD_RESULT;
pub extern fn FMOD_ChannelGroup_GetPitch(channelgroup: ?*FMOD_CHANNELGROUP, pitch: [*c]f32) FMOD_RESULT;
pub extern fn FMOD_ChannelGroup_SetMute(channelgroup: ?*FMOD_CHANNELGROUP, mute: FMOD_BOOL) FMOD_RESULT;
pub extern fn FMOD_ChannelGroup_GetMute(channelgroup: ?*FMOD_CHANNELGROUP, mute: [*c]FMOD_BOOL) FMOD_RESULT;
pub extern fn FMOD_ChannelGroup_SetReverbProperties(channelgroup: ?*FMOD_CHANNELGROUP, instance: c_int, wet: f32) FMOD_RESULT;
pub extern fn FMOD_ChannelGroup_GetReverbProperties(channelgroup: ?*FMOD_CHANNELGROUP, instance: c_int, wet: [*c]f32) FMOD_RESULT;
pub extern fn FMOD_ChannelGroup_SetLowPassGain(channelgroup: ?*FMOD_CHANNELGROUP, gain: f32) FMOD_RESULT;
pub extern fn FMOD_ChannelGroup_GetLowPassGain(channelgroup: ?*FMOD_CHANNELGROUP, gain: [*c]f32) FMOD_RESULT;
pub extern fn FMOD_ChannelGroup_SetMode(channelgroup: ?*FMOD_CHANNELGROUP, mode: FMOD_MODE) FMOD_RESULT;
pub extern fn FMOD_ChannelGroup_GetMode(channelgroup: ?*FMOD_CHANNELGROUP, mode: [*c]FMOD_MODE) FMOD_RESULT;
pub extern fn FMOD_ChannelGroup_SetCallback(channelgroup: ?*FMOD_CHANNELGROUP, callback: FMOD_CHANNELCONTROL_CALLBACK) FMOD_RESULT;
pub extern fn FMOD_ChannelGroup_IsPlaying(channelgroup: ?*FMOD_CHANNELGROUP, isplaying: [*c]FMOD_BOOL) FMOD_RESULT;
pub extern fn FMOD_ChannelGroup_SetPan(channelgroup: ?*FMOD_CHANNELGROUP, pan: f32) FMOD_RESULT;
pub extern fn FMOD_ChannelGroup_SetMixLevelsOutput(channelgroup: ?*FMOD_CHANNELGROUP, frontleft: f32, frontright: f32, center: f32, lfe: f32, surroundleft: f32, surroundright: f32, backleft: f32, backright: f32) FMOD_RESULT;
pub extern fn FMOD_ChannelGroup_SetMixLevelsInput(channelgroup: ?*FMOD_CHANNELGROUP, levels: [*c]f32, numlevels: c_int) FMOD_RESULT;
pub extern fn FMOD_ChannelGroup_SetMixMatrix(channelgroup: ?*FMOD_CHANNELGROUP, matrix: [*c]f32, outchannels: c_int, inchannels: c_int, inchannel_hop: c_int) FMOD_RESULT;
pub extern fn FMOD_ChannelGroup_GetMixMatrix(channelgroup: ?*FMOD_CHANNELGROUP, matrix: [*c]f32, outchannels: [*c]c_int, inchannels: [*c]c_int, inchannel_hop: c_int) FMOD_RESULT;
pub extern fn FMOD_ChannelGroup_GetDSPClock(channelgroup: ?*FMOD_CHANNELGROUP, dspclock: [*c]c_ulonglong, parentclock: [*c]c_ulonglong) FMOD_RESULT;
pub extern fn FMOD_ChannelGroup_SetDelay(channelgroup: ?*FMOD_CHANNELGROUP, dspclock_start: c_ulonglong, dspclock_end: c_ulonglong, stopchannels: FMOD_BOOL) FMOD_RESULT;
pub extern fn FMOD_ChannelGroup_GetDelay(channelgroup: ?*FMOD_CHANNELGROUP, dspclock_start: [*c]c_ulonglong, dspclock_end: [*c]c_ulonglong, stopchannels: [*c]FMOD_BOOL) FMOD_RESULT;
pub extern fn FMOD_ChannelGroup_AddFadePoint(channelgroup: ?*FMOD_CHANNELGROUP, dspclock: c_ulonglong, volume: f32) FMOD_RESULT;
pub extern fn FMOD_ChannelGroup_SetFadePointRamp(channelgroup: ?*FMOD_CHANNELGROUP, dspclock: c_ulonglong, volume: f32) FMOD_RESULT;
pub extern fn FMOD_ChannelGroup_RemoveFadePoints(channelgroup: ?*FMOD_CHANNELGROUP, dspclock_start: c_ulonglong, dspclock_end: c_ulonglong) FMOD_RESULT;
pub extern fn FMOD_ChannelGroup_GetFadePoints(channelgroup: ?*FMOD_CHANNELGROUP, numpoints: [*c]c_uint, point_dspclock: [*c]c_ulonglong, point_volume: [*c]f32) FMOD_RESULT;
pub extern fn FMOD_ChannelGroup_GetDSP(channelgroup: ?*FMOD_CHANNELGROUP, index: c_int, dsp: [*c]?*FMOD_DSP) FMOD_RESULT;
pub extern fn FMOD_ChannelGroup_AddDSP(channelgroup: ?*FMOD_CHANNELGROUP, index: c_int, dsp: ?*FMOD_DSP) FMOD_RESULT;
pub extern fn FMOD_ChannelGroup_RemoveDSP(channelgroup: ?*FMOD_CHANNELGROUP, dsp: ?*FMOD_DSP) FMOD_RESULT;
pub extern fn FMOD_ChannelGroup_GetNumDSPs(channelgroup: ?*FMOD_CHANNELGROUP, numdsps: [*c]c_int) FMOD_RESULT;
pub extern fn FMOD_ChannelGroup_SetDSPIndex(channelgroup: ?*FMOD_CHANNELGROUP, dsp: ?*FMOD_DSP, index: c_int) FMOD_RESULT;
pub extern fn FMOD_ChannelGroup_GetDSPIndex(channelgroup: ?*FMOD_CHANNELGROUP, dsp: ?*FMOD_DSP, index: [*c]c_int) FMOD_RESULT;
pub extern fn FMOD_ChannelGroup_Set3DAttributes(channelgroup: ?*FMOD_CHANNELGROUP, pos: [*c]const FMOD_VECTOR, vel: [*c]const FMOD_VECTOR) FMOD_RESULT;
pub extern fn FMOD_ChannelGroup_Get3DAttributes(channelgroup: ?*FMOD_CHANNELGROUP, pos: [*c]FMOD_VECTOR, vel: [*c]FMOD_VECTOR) FMOD_RESULT;
pub extern fn FMOD_ChannelGroup_Set3DMinMaxDistance(channelgroup: ?*FMOD_CHANNELGROUP, mindistance: f32, maxdistance: f32) FMOD_RESULT;
pub extern fn FMOD_ChannelGroup_Get3DMinMaxDistance(channelgroup: ?*FMOD_CHANNELGROUP, mindistance: [*c]f32, maxdistance: [*c]f32) FMOD_RESULT;
pub extern fn FMOD_ChannelGroup_Set3DConeSettings(channelgroup: ?*FMOD_CHANNELGROUP, insideconeangle: f32, outsideconeangle: f32, outsidevolume: f32) FMOD_RESULT;
pub extern fn FMOD_ChannelGroup_Get3DConeSettings(channelgroup: ?*FMOD_CHANNELGROUP, insideconeangle: [*c]f32, outsideconeangle: [*c]f32, outsidevolume: [*c]f32) FMOD_RESULT;
pub extern fn FMOD_ChannelGroup_Set3DConeOrientation(channelgroup: ?*FMOD_CHANNELGROUP, orientation: [*c]FMOD_VECTOR) FMOD_RESULT;
pub extern fn FMOD_ChannelGroup_Get3DConeOrientation(channelgroup: ?*FMOD_CHANNELGROUP, orientation: [*c]FMOD_VECTOR) FMOD_RESULT;
pub extern fn FMOD_ChannelGroup_Set3DCustomRolloff(channelgroup: ?*FMOD_CHANNELGROUP, points: [*c]FMOD_VECTOR, numpoints: c_int) FMOD_RESULT;
pub extern fn FMOD_ChannelGroup_Get3DCustomRolloff(channelgroup: ?*FMOD_CHANNELGROUP, points: [*c][*c]FMOD_VECTOR, numpoints: [*c]c_int) FMOD_RESULT;
pub extern fn FMOD_ChannelGroup_Set3DOcclusion(channelgroup: ?*FMOD_CHANNELGROUP, directocclusion: f32, reverbocclusion: f32) FMOD_RESULT;
pub extern fn FMOD_ChannelGroup_Get3DOcclusion(channelgroup: ?*FMOD_CHANNELGROUP, directocclusion: [*c]f32, reverbocclusion: [*c]f32) FMOD_RESULT;
pub extern fn FMOD_ChannelGroup_Set3DSpread(channelgroup: ?*FMOD_CHANNELGROUP, angle: f32) FMOD_RESULT;
pub extern fn FMOD_ChannelGroup_Get3DSpread(channelgroup: ?*FMOD_CHANNELGROUP, angle: [*c]f32) FMOD_RESULT;
pub extern fn FMOD_ChannelGroup_Set3DLevel(channelgroup: ?*FMOD_CHANNELGROUP, level: f32) FMOD_RESULT;
pub extern fn FMOD_ChannelGroup_Get3DLevel(channelgroup: ?*FMOD_CHANNELGROUP, level: [*c]f32) FMOD_RESULT;
pub extern fn FMOD_ChannelGroup_Set3DDopplerLevel(channelgroup: ?*FMOD_CHANNELGROUP, level: f32) FMOD_RESULT;
pub extern fn FMOD_ChannelGroup_Get3DDopplerLevel(channelgroup: ?*FMOD_CHANNELGROUP, level: [*c]f32) FMOD_RESULT;
pub extern fn FMOD_ChannelGroup_Set3DDistanceFilter(channelgroup: ?*FMOD_CHANNELGROUP, custom: FMOD_BOOL, customLevel: f32, centerFreq: f32) FMOD_RESULT;
pub extern fn FMOD_ChannelGroup_Get3DDistanceFilter(channelgroup: ?*FMOD_CHANNELGROUP, custom: [*c]FMOD_BOOL, customLevel: [*c]f32, centerFreq: [*c]f32) FMOD_RESULT;
pub extern fn FMOD_ChannelGroup_SetUserData(channelgroup: ?*FMOD_CHANNELGROUP, userdata: ?*c_void) FMOD_RESULT;
pub extern fn FMOD_ChannelGroup_GetUserData(channelgroup: ?*FMOD_CHANNELGROUP, userdata: [*c]?*c_void) FMOD_RESULT;
pub extern fn FMOD_ChannelGroup_Release(channelgroup: ?*FMOD_CHANNELGROUP) FMOD_RESULT;
pub extern fn FMOD_ChannelGroup_AddGroup(channelgroup: ?*FMOD_CHANNELGROUP, group: ?*FMOD_CHANNELGROUP, propagatedspclock: FMOD_BOOL, connection: [*c]?*FMOD_DSPCONNECTION) FMOD_RESULT;
pub extern fn FMOD_ChannelGroup_GetNumGroups(channelgroup: ?*FMOD_CHANNELGROUP, numgroups: [*c]c_int) FMOD_RESULT;
pub extern fn FMOD_ChannelGroup_GetGroup(channelgroup: ?*FMOD_CHANNELGROUP, index: c_int, group: [*c]?*FMOD_CHANNELGROUP) FMOD_RESULT;
pub extern fn FMOD_ChannelGroup_GetParentGroup(channelgroup: ?*FMOD_CHANNELGROUP, group: [*c]?*FMOD_CHANNELGROUP) FMOD_RESULT;
pub extern fn FMOD_ChannelGroup_GetName(channelgroup: ?*FMOD_CHANNELGROUP, name: [*c]u8, namelen: c_int) FMOD_RESULT;
pub extern fn FMOD_ChannelGroup_GetNumChannels(channelgroup: ?*FMOD_CHANNELGROUP, numchannels: [*c]c_int) FMOD_RESULT;
pub extern fn FMOD_ChannelGroup_GetChannel(channelgroup: ?*FMOD_CHANNELGROUP, index: c_int, channel: [*c]?*FMOD_CHANNEL) FMOD_RESULT;
pub extern fn FMOD_SoundGroup_Release(soundgroup: ?*FMOD_SOUNDGROUP) FMOD_RESULT;
pub extern fn FMOD_SoundGroup_GetSystemObject(soundgroup: ?*FMOD_SOUNDGROUP, system: [*c]?*FMOD_SYSTEM) FMOD_RESULT;
pub extern fn FMOD_SoundGroup_SetMaxAudible(soundgroup: ?*FMOD_SOUNDGROUP, maxaudible: c_int) FMOD_RESULT;
pub extern fn FMOD_SoundGroup_GetMaxAudible(soundgroup: ?*FMOD_SOUNDGROUP, maxaudible: [*c]c_int) FMOD_RESULT;
pub extern fn FMOD_SoundGroup_SetMaxAudibleBehavior(soundgroup: ?*FMOD_SOUNDGROUP, behavior: FMOD_SOUNDGROUP_BEHAVIOR) FMOD_RESULT;
pub extern fn FMOD_SoundGroup_GetMaxAudibleBehavior(soundgroup: ?*FMOD_SOUNDGROUP, behavior: [*c]FMOD_SOUNDGROUP_BEHAVIOR) FMOD_RESULT;
pub extern fn FMOD_SoundGroup_SetMuteFadeSpeed(soundgroup: ?*FMOD_SOUNDGROUP, speed: f32) FMOD_RESULT;
pub extern fn FMOD_SoundGroup_GetMuteFadeSpeed(soundgroup: ?*FMOD_SOUNDGROUP, speed: [*c]f32) FMOD_RESULT;
pub extern fn FMOD_SoundGroup_SetVolume(soundgroup: ?*FMOD_SOUNDGROUP, volume: f32) FMOD_RESULT;
pub extern fn FMOD_SoundGroup_GetVolume(soundgroup: ?*FMOD_SOUNDGROUP, volume: [*c]f32) FMOD_RESULT;
pub extern fn FMOD_SoundGroup_Stop(soundgroup: ?*FMOD_SOUNDGROUP) FMOD_RESULT;
pub extern fn FMOD_SoundGroup_GetName(soundgroup: ?*FMOD_SOUNDGROUP, name: [*c]u8, namelen: c_int) FMOD_RESULT;
pub extern fn FMOD_SoundGroup_GetNumSounds(soundgroup: ?*FMOD_SOUNDGROUP, numsounds: [*c]c_int) FMOD_RESULT;
pub extern fn FMOD_SoundGroup_GetSound(soundgroup: ?*FMOD_SOUNDGROUP, index: c_int, sound: [*c]?*FMOD_SOUND) FMOD_RESULT;
pub extern fn FMOD_SoundGroup_GetNumPlaying(soundgroup: ?*FMOD_SOUNDGROUP, numplaying: [*c]c_int) FMOD_RESULT;
pub extern fn FMOD_SoundGroup_SetUserData(soundgroup: ?*FMOD_SOUNDGROUP, userdata: ?*c_void) FMOD_RESULT;
pub extern fn FMOD_SoundGroup_GetUserData(soundgroup: ?*FMOD_SOUNDGROUP, userdata: [*c]?*c_void) FMOD_RESULT;
pub extern fn FMOD_DSP_Release(dsp: ?*FMOD_DSP) FMOD_RESULT;
pub extern fn FMOD_DSP_GetSystemObject(dsp: ?*FMOD_DSP, system: [*c]?*FMOD_SYSTEM) FMOD_RESULT;
pub extern fn FMOD_DSP_AddInput(dsp: ?*FMOD_DSP, input: ?*FMOD_DSP, connection: [*c]?*FMOD_DSPCONNECTION, type: FMOD_DSPCONNECTION_TYPE) FMOD_RESULT;
pub extern fn FMOD_DSP_DisconnectFrom(dsp: ?*FMOD_DSP, target: ?*FMOD_DSP, connection: ?*FMOD_DSPCONNECTION) FMOD_RESULT;
pub extern fn FMOD_DSP_DisconnectAll(dsp: ?*FMOD_DSP, inputs: FMOD_BOOL, outputs: FMOD_BOOL) FMOD_RESULT;
pub extern fn FMOD_DSP_GetNumInputs(dsp: ?*FMOD_DSP, numinputs: [*c]c_int) FMOD_RESULT;
pub extern fn FMOD_DSP_GetNumOutputs(dsp: ?*FMOD_DSP, numoutputs: [*c]c_int) FMOD_RESULT;
pub extern fn FMOD_DSP_GetInput(dsp: ?*FMOD_DSP, index: c_int, input: [*c]?*FMOD_DSP, inputconnection: [*c]?*FMOD_DSPCONNECTION) FMOD_RESULT;
pub extern fn FMOD_DSP_GetOutput(dsp: ?*FMOD_DSP, index: c_int, output: [*c]?*FMOD_DSP, outputconnection: [*c]?*FMOD_DSPCONNECTION) FMOD_RESULT;
pub extern fn FMOD_DSP_SetActive(dsp: ?*FMOD_DSP, active: FMOD_BOOL) FMOD_RESULT;
pub extern fn FMOD_DSP_GetActive(dsp: ?*FMOD_DSP, active: [*c]FMOD_BOOL) FMOD_RESULT;
pub extern fn FMOD_DSP_SetBypass(dsp: ?*FMOD_DSP, bypass: FMOD_BOOL) FMOD_RESULT;
pub extern fn FMOD_DSP_GetBypass(dsp: ?*FMOD_DSP, bypass: [*c]FMOD_BOOL) FMOD_RESULT;
pub extern fn FMOD_DSP_SetWetDryMix(dsp: ?*FMOD_DSP, prewet: f32, postwet: f32, dry: f32) FMOD_RESULT;
pub extern fn FMOD_DSP_GetWetDryMix(dsp: ?*FMOD_DSP, prewet: [*c]f32, postwet: [*c]f32, dry: [*c]f32) FMOD_RESULT;
pub extern fn FMOD_DSP_SetChannelFormat(dsp: ?*FMOD_DSP, channelmask: FMOD_CHANNELMASK, numchannels: c_int, source_speakermode: FMOD_SPEAKERMODE) FMOD_RESULT;
pub extern fn FMOD_DSP_GetChannelFormat(dsp: ?*FMOD_DSP, channelmask: [*c]FMOD_CHANNELMASK, numchannels: [*c]c_int, source_speakermode: [*c]FMOD_SPEAKERMODE) FMOD_RESULT;
pub extern fn FMOD_DSP_GetOutputChannelFormat(dsp: ?*FMOD_DSP, inmask: FMOD_CHANNELMASK, inchannels: c_int, inspeakermode: FMOD_SPEAKERMODE, outmask: [*c]FMOD_CHANNELMASK, outchannels: [*c]c_int, outspeakermode: [*c]FMOD_SPEAKERMODE) FMOD_RESULT;
pub extern fn FMOD_DSP_Reset(dsp: ?*FMOD_DSP) FMOD_RESULT;
pub extern fn FMOD_DSP_SetParameterFloat(dsp: ?*FMOD_DSP, index: c_int, value: f32) FMOD_RESULT;
pub extern fn FMOD_DSP_SetParameterInt(dsp: ?*FMOD_DSP, index: c_int, value: c_int) FMOD_RESULT;
pub extern fn FMOD_DSP_SetParameterBool(dsp: ?*FMOD_DSP, index: c_int, value: FMOD_BOOL) FMOD_RESULT;
pub extern fn FMOD_DSP_SetParameterData(dsp: ?*FMOD_DSP, index: c_int, data: ?*c_void, length: c_uint) FMOD_RESULT;
pub extern fn FMOD_DSP_GetParameterFloat(dsp: ?*FMOD_DSP, index: c_int, value: [*c]f32, valuestr: [*c]u8, valuestrlen: c_int) FMOD_RESULT;
pub extern fn FMOD_DSP_GetParameterInt(dsp: ?*FMOD_DSP, index: c_int, value: [*c]c_int, valuestr: [*c]u8, valuestrlen: c_int) FMOD_RESULT;
pub extern fn FMOD_DSP_GetParameterBool(dsp: ?*FMOD_DSP, index: c_int, value: [*c]FMOD_BOOL, valuestr: [*c]u8, valuestrlen: c_int) FMOD_RESULT;
pub extern fn FMOD_DSP_GetParameterData(dsp: ?*FMOD_DSP, index: c_int, data: [*c]?*c_void, length: [*c]c_uint, valuestr: [*c]u8, valuestrlen: c_int) FMOD_RESULT;
pub extern fn FMOD_DSP_GetNumParameters(dsp: ?*FMOD_DSP, numparams: [*c]c_int) FMOD_RESULT;
pub extern fn FMOD_DSP_GetParameterInfo(dsp: ?*FMOD_DSP, index: c_int, desc: [*c][*c]FMOD_DSP_PARAMETER_DESC) FMOD_RESULT;
pub extern fn FMOD_DSP_GetDataParameterIndex(dsp: ?*FMOD_DSP, datatype: c_int, index: [*c]c_int) FMOD_RESULT;
pub extern fn FMOD_DSP_ShowConfigDialog(dsp: ?*FMOD_DSP, hwnd: ?*c_void, show: FMOD_BOOL) FMOD_RESULT;
pub extern fn FMOD_DSP_GetInfo(dsp: ?*FMOD_DSP, name: [*c]u8, version: [*c]c_uint, channels: [*c]c_int, configwidth: [*c]c_int, configheight: [*c]c_int) FMOD_RESULT;
pub extern fn FMOD_DSP_GetType(dsp: ?*FMOD_DSP, type: [*c]FMOD_DSP_TYPE) FMOD_RESULT;
pub extern fn FMOD_DSP_GetIdle(dsp: ?*FMOD_DSP, idle: [*c]FMOD_BOOL) FMOD_RESULT;
pub extern fn FMOD_DSP_SetUserData(dsp: ?*FMOD_DSP, userdata: ?*c_void) FMOD_RESULT;
pub extern fn FMOD_DSP_GetUserData(dsp: ?*FMOD_DSP, userdata: [*c]?*c_void) FMOD_RESULT;
pub extern fn FMOD_DSP_SetMeteringEnabled(dsp: ?*FMOD_DSP, inputEnabled: FMOD_BOOL, outputEnabled: FMOD_BOOL) FMOD_RESULT;
pub extern fn FMOD_DSP_GetMeteringEnabled(dsp: ?*FMOD_DSP, inputEnabled: [*c]FMOD_BOOL, outputEnabled: [*c]FMOD_BOOL) FMOD_RESULT;
pub extern fn FMOD_DSP_GetMeteringInfo(dsp: ?*FMOD_DSP, inputInfo: [*c]FMOD_DSP_METERING_INFO, outputInfo: [*c]FMOD_DSP_METERING_INFO) FMOD_RESULT;
pub extern fn FMOD_DSP_GetCPUUsage(dsp: ?*FMOD_DSP, exclusive: [*c]c_uint, inclusive: [*c]c_uint) FMOD_RESULT;
pub extern fn FMOD_DSPConnection_GetInput(dspconnection: ?*FMOD_DSPCONNECTION, input: [*c]?*FMOD_DSP) FMOD_RESULT;
pub extern fn FMOD_DSPConnection_GetOutput(dspconnection: ?*FMOD_DSPCONNECTION, output: [*c]?*FMOD_DSP) FMOD_RESULT;
pub extern fn FMOD_DSPConnection_SetMix(dspconnection: ?*FMOD_DSPCONNECTION, volume: f32) FMOD_RESULT;
pub extern fn FMOD_DSPConnection_GetMix(dspconnection: ?*FMOD_DSPCONNECTION, volume: [*c]f32) FMOD_RESULT;
pub extern fn FMOD_DSPConnection_SetMixMatrix(dspconnection: ?*FMOD_DSPCONNECTION, matrix: [*c]f32, outchannels: c_int, inchannels: c_int, inchannel_hop: c_int) FMOD_RESULT;
pub extern fn FMOD_DSPConnection_GetMixMatrix(dspconnection: ?*FMOD_DSPCONNECTION, matrix: [*c]f32, outchannels: [*c]c_int, inchannels: [*c]c_int, inchannel_hop: c_int) FMOD_RESULT;
pub extern fn FMOD_DSPConnection_GetType(dspconnection: ?*FMOD_DSPCONNECTION, type: [*c]FMOD_DSPCONNECTION_TYPE) FMOD_RESULT;
pub extern fn FMOD_DSPConnection_SetUserData(dspconnection: ?*FMOD_DSPCONNECTION, userdata: ?*c_void) FMOD_RESULT;
pub extern fn FMOD_DSPConnection_GetUserData(dspconnection: ?*FMOD_DSPCONNECTION, userdata: [*c]?*c_void) FMOD_RESULT;
pub extern fn FMOD_Geometry_Release(geometry: ?*FMOD_GEOMETRY) FMOD_RESULT;
pub extern fn FMOD_Geometry_AddPolygon(geometry: ?*FMOD_GEOMETRY, directocclusion: f32, reverbocclusion: f32, doublesided: FMOD_BOOL, numvertices: c_int, vertices: [*c]const FMOD_VECTOR, polygonindex: [*c]c_int) FMOD_RESULT;
pub extern fn FMOD_Geometry_GetNumPolygons(geometry: ?*FMOD_GEOMETRY, numpolygons: [*c]c_int) FMOD_RESULT;
pub extern fn FMOD_Geometry_GetMaxPolygons(geometry: ?*FMOD_GEOMETRY, maxpolygons: [*c]c_int, maxvertices: [*c]c_int) FMOD_RESULT;
pub extern fn FMOD_Geometry_GetPolygonNumVertices(geometry: ?*FMOD_GEOMETRY, index: c_int, numvertices: [*c]c_int) FMOD_RESULT;
pub extern fn FMOD_Geometry_SetPolygonVertex(geometry: ?*FMOD_GEOMETRY, index: c_int, vertexindex: c_int, vertex: [*c]const FMOD_VECTOR) FMOD_RESULT;
pub extern fn FMOD_Geometry_GetPolygonVertex(geometry: ?*FMOD_GEOMETRY, index: c_int, vertexindex: c_int, vertex: [*c]FMOD_VECTOR) FMOD_RESULT;
pub extern fn FMOD_Geometry_SetPolygonAttributes(geometry: ?*FMOD_GEOMETRY, index: c_int, directocclusion: f32, reverbocclusion: f32, doublesided: FMOD_BOOL) FMOD_RESULT;
pub extern fn FMOD_Geometry_GetPolygonAttributes(geometry: ?*FMOD_GEOMETRY, index: c_int, directocclusion: [*c]f32, reverbocclusion: [*c]f32, doublesided: [*c]FMOD_BOOL) FMOD_RESULT;
pub extern fn FMOD_Geometry_SetActive(geometry: ?*FMOD_GEOMETRY, active: FMOD_BOOL) FMOD_RESULT;
pub extern fn FMOD_Geometry_GetActive(geometry: ?*FMOD_GEOMETRY, active: [*c]FMOD_BOOL) FMOD_RESULT;
pub extern fn FMOD_Geometry_SetRotation(geometry: ?*FMOD_GEOMETRY, forward: [*c]const FMOD_VECTOR, up: [*c]const FMOD_VECTOR) FMOD_RESULT;
pub extern fn FMOD_Geometry_GetRotation(geometry: ?*FMOD_GEOMETRY, forward: [*c]FMOD_VECTOR, up: [*c]FMOD_VECTOR) FMOD_RESULT;
pub extern fn FMOD_Geometry_SetPosition(geometry: ?*FMOD_GEOMETRY, position: [*c]const FMOD_VECTOR) FMOD_RESULT;
pub extern fn FMOD_Geometry_GetPosition(geometry: ?*FMOD_GEOMETRY, position: [*c]FMOD_VECTOR) FMOD_RESULT;
pub extern fn FMOD_Geometry_SetScale(geometry: ?*FMOD_GEOMETRY, scale: [*c]const FMOD_VECTOR) FMOD_RESULT;
pub extern fn FMOD_Geometry_GetScale(geometry: ?*FMOD_GEOMETRY, scale: [*c]FMOD_VECTOR) FMOD_RESULT;
pub extern fn FMOD_Geometry_Save(geometry: ?*FMOD_GEOMETRY, data: ?*c_void, datasize: [*c]c_int) FMOD_RESULT;
pub extern fn FMOD_Geometry_SetUserData(geometry: ?*FMOD_GEOMETRY, userdata: ?*c_void) FMOD_RESULT;
pub extern fn FMOD_Geometry_GetUserData(geometry: ?*FMOD_GEOMETRY, userdata: [*c]?*c_void) FMOD_RESULT;
pub extern fn FMOD_Reverb3D_Release(reverb3d: ?*FMOD_REVERB3D) FMOD_RESULT;
pub extern fn FMOD_Reverb3D_Set3DAttributes(reverb3d: ?*FMOD_REVERB3D, position: [*c]const FMOD_VECTOR, mindistance: f32, maxdistance: f32) FMOD_RESULT;
pub extern fn FMOD_Reverb3D_Get3DAttributes(reverb3d: ?*FMOD_REVERB3D, position: [*c]FMOD_VECTOR, mindistance: [*c]f32, maxdistance: [*c]f32) FMOD_RESULT;
pub extern fn FMOD_Reverb3D_SetProperties(reverb3d: ?*FMOD_REVERB3D, properties: [*c]const FMOD_REVERB_PROPERTIES) FMOD_RESULT;
pub extern fn FMOD_Reverb3D_GetProperties(reverb3d: ?*FMOD_REVERB3D, properties: [*c]FMOD_REVERB_PROPERTIES) FMOD_RESULT;
pub extern fn FMOD_Reverb3D_SetActive(reverb3d: ?*FMOD_REVERB3D, active: FMOD_BOOL) FMOD_RESULT;
pub extern fn FMOD_Reverb3D_GetActive(reverb3d: ?*FMOD_REVERB3D, active: [*c]FMOD_BOOL) FMOD_RESULT;
pub extern fn FMOD_Reverb3D_SetUserData(reverb3d: ?*FMOD_REVERB3D, userdata: ?*c_void) FMOD_RESULT;
pub extern fn FMOD_Reverb3D_GetUserData(reverb3d: ?*FMOD_REVERB3D, userdata: [*c]?*c_void) FMOD_RESULT;
pub const struct_FMOD_STUDIO_SYSTEM = opaque {};
pub const FMOD_STUDIO_SYSTEM = struct_FMOD_STUDIO_SYSTEM;
pub const struct_FMOD_STUDIO_EVENTDESCRIPTION = opaque {};
pub const FMOD_STUDIO_EVENTDESCRIPTION = struct_FMOD_STUDIO_EVENTDESCRIPTION;
pub const struct_FMOD_STUDIO_EVENTINSTANCE = opaque {};
pub const FMOD_STUDIO_EVENTINSTANCE = struct_FMOD_STUDIO_EVENTINSTANCE;
pub const struct_FMOD_STUDIO_BUS = opaque {};
pub const FMOD_STUDIO_BUS = struct_FMOD_STUDIO_BUS;
pub const struct_FMOD_STUDIO_VCA = opaque {};
pub const FMOD_STUDIO_VCA = struct_FMOD_STUDIO_VCA;
pub const struct_FMOD_STUDIO_BANK = opaque {};
pub const FMOD_STUDIO_BANK = struct_FMOD_STUDIO_BANK;
pub const struct_FMOD_STUDIO_COMMANDREPLAY = opaque {};
pub const FMOD_STUDIO_COMMANDREPLAY = struct_FMOD_STUDIO_COMMANDREPLAY;
pub const FMOD_STUDIO_INITFLAGS = c_uint;
pub const FMOD_STUDIO_PARAMETER_FLAGS = c_uint;
pub const FMOD_STUDIO_SYSTEM_CALLBACK_TYPE = c_uint;
pub const FMOD_STUDIO_EVENT_CALLBACK_TYPE = c_uint;
pub const FMOD_STUDIO_LOAD_BANK_FLAGS = c_uint;
pub const FMOD_STUDIO_COMMANDCAPTURE_FLAGS = c_uint;
pub const FMOD_STUDIO_COMMANDREPLAY_FLAGS = c_uint;
pub const FMOD_STUDIO_LOADING_STATE_UNLOADING: c_int = 0;
pub const FMOD_STUDIO_LOADING_STATE_UNLOADED: c_int = 1;
pub const FMOD_STUDIO_LOADING_STATE_LOADING: c_int = 2;
pub const FMOD_STUDIO_LOADING_STATE_LOADED: c_int = 3;
pub const FMOD_STUDIO_LOADING_STATE_ERROR: c_int = 4;
pub const FMOD_STUDIO_LOADING_STATE_FORCEINT: c_int = 65536;
pub const enum_FMOD_STUDIO_LOADING_STATE = c_uint;
pub const FMOD_STUDIO_LOADING_STATE = enum_FMOD_STUDIO_LOADING_STATE;
pub const FMOD_STUDIO_LOAD_MEMORY: c_int = 0;
pub const FMOD_STUDIO_LOAD_MEMORY_POINT: c_int = 1;
pub const FMOD_STUDIO_LOAD_MEMORY_FORCEINT: c_int = 65536;
pub const enum_FMOD_STUDIO_LOAD_MEMORY_MODE = c_uint;
pub const FMOD_STUDIO_LOAD_MEMORY_MODE = enum_FMOD_STUDIO_LOAD_MEMORY_MODE;
pub const FMOD_STUDIO_PARAMETER_GAME_CONTROLLED: c_int = 0;
pub const FMOD_STUDIO_PARAMETER_AUTOMATIC_DISTANCE: c_int = 1;
pub const FMOD_STUDIO_PARAMETER_AUTOMATIC_EVENT_CONE_ANGLE: c_int = 2;
pub const FMOD_STUDIO_PARAMETER_AUTOMATIC_EVENT_ORIENTATION: c_int = 3;
pub const FMOD_STUDIO_PARAMETER_AUTOMATIC_DIRECTION: c_int = 4;
pub const FMOD_STUDIO_PARAMETER_AUTOMATIC_ELEVATION: c_int = 5;
pub const FMOD_STUDIO_PARAMETER_AUTOMATIC_LISTENER_ORIENTATION: c_int = 6;
pub const FMOD_STUDIO_PARAMETER_AUTOMATIC_SPEED: c_int = 7;
pub const FMOD_STUDIO_PARAMETER_AUTOMATIC_SPEED_ABSOLUTE: c_int = 8;
pub const FMOD_STUDIO_PARAMETER_MAX: c_int = 9;
pub const FMOD_STUDIO_PARAMETER_FORCEINT: c_int = 65536;
pub const enum_FMOD_STUDIO_PARAMETER_TYPE = c_uint;
pub const FMOD_STUDIO_PARAMETER_TYPE = enum_FMOD_STUDIO_PARAMETER_TYPE;
pub const FMOD_STUDIO_USER_PROPERTY_TYPE_INTEGER: c_int = 0;
pub const FMOD_STUDIO_USER_PROPERTY_TYPE_BOOLEAN: c_int = 1;
pub const FMOD_STUDIO_USER_PROPERTY_TYPE_FLOAT: c_int = 2;
pub const FMOD_STUDIO_USER_PROPERTY_TYPE_STRING: c_int = 3;
pub const FMOD_STUDIO_USER_PROPERTY_TYPE_FORCEINT: c_int = 65536;
pub const enum_FMOD_STUDIO_USER_PROPERTY_TYPE = c_uint;
pub const FMOD_STUDIO_USER_PROPERTY_TYPE = enum_FMOD_STUDIO_USER_PROPERTY_TYPE;
pub const FMOD_STUDIO_EVENT_PROPERTY_CHANNELPRIORITY: c_int = 0;
pub const FMOD_STUDIO_EVENT_PROPERTY_SCHEDULE_DELAY: c_int = 1;
pub const FMOD_STUDIO_EVENT_PROPERTY_SCHEDULE_LOOKAHEAD: c_int = 2;
pub const FMOD_STUDIO_EVENT_PROPERTY_MINIMUM_DISTANCE: c_int = 3;
pub const FMOD_STUDIO_EVENT_PROPERTY_MAXIMUM_DISTANCE: c_int = 4;
pub const FMOD_STUDIO_EVENT_PROPERTY_COOLDOWN: c_int = 5;
pub const FMOD_STUDIO_EVENT_PROPERTY_MAX: c_int = 6;
pub const FMOD_STUDIO_EVENT_PROPERTY_FORCEINT: c_int = 65536;
pub const enum_FMOD_STUDIO_EVENT_PROPERTY = c_uint;
pub const FMOD_STUDIO_EVENT_PROPERTY = enum_FMOD_STUDIO_EVENT_PROPERTY;
pub const FMOD_STUDIO_PLAYBACK_PLAYING: c_int = 0;
pub const FMOD_STUDIO_PLAYBACK_SUSTAINING: c_int = 1;
pub const FMOD_STUDIO_PLAYBACK_STOPPED: c_int = 2;
pub const FMOD_STUDIO_PLAYBACK_STARTING: c_int = 3;
pub const FMOD_STUDIO_PLAYBACK_STOPPING: c_int = 4;
pub const FMOD_STUDIO_PLAYBACK_FORCEINT: c_int = 65536;
pub const enum_FMOD_STUDIO_PLAYBACK_STATE = c_uint;
pub const FMOD_STUDIO_PLAYBACK_STATE = enum_FMOD_STUDIO_PLAYBACK_STATE;
pub const FMOD_STUDIO_STOP_ALLOWFADEOUT: c_int = 0;
pub const FMOD_STUDIO_STOP_IMMEDIATE: c_int = 1;
pub const FMOD_STUDIO_STOP_FORCEINT: c_int = 65536;
pub const enum_FMOD_STUDIO_STOP_MODE = c_uint;
pub const FMOD_STUDIO_STOP_MODE = enum_FMOD_STUDIO_STOP_MODE;
pub const FMOD_STUDIO_INSTANCETYPE_NONE: c_int = 0;
pub const FMOD_STUDIO_INSTANCETYPE_SYSTEM: c_int = 1;
pub const FMOD_STUDIO_INSTANCETYPE_EVENTDESCRIPTION: c_int = 2;
pub const FMOD_STUDIO_INSTANCETYPE_EVENTINSTANCE: c_int = 3;
pub const FMOD_STUDIO_INSTANCETYPE_PARAMETERINSTANCE: c_int = 4;
pub const FMOD_STUDIO_INSTANCETYPE_BUS: c_int = 5;
pub const FMOD_STUDIO_INSTANCETYPE_VCA: c_int = 6;
pub const FMOD_STUDIO_INSTANCETYPE_BANK: c_int = 7;
pub const FMOD_STUDIO_INSTANCETYPE_COMMANDREPLAY: c_int = 8;
pub const FMOD_STUDIO_INSTANCETYPE_FORCEINT: c_int = 65536;
pub const enum_FMOD_STUDIO_INSTANCETYPE = c_uint;
pub const FMOD_STUDIO_INSTANCETYPE = enum_FMOD_STUDIO_INSTANCETYPE;
pub const struct_FMOD_STUDIO_BANK_INFO = extern struct {
    size: c_int,
    userdata: ?*c_void,
    userdatalength: c_int,
    opencallback: FMOD_FILE_OPEN_CALLBACK,
    closecallback: FMOD_FILE_CLOSE_CALLBACK,
    readcallback: FMOD_FILE_READ_CALLBACK,
    seekcallback: FMOD_FILE_SEEK_CALLBACK,
};
pub const FMOD_STUDIO_BANK_INFO = struct_FMOD_STUDIO_BANK_INFO;
pub const struct_FMOD_STUDIO_PARAMETER_ID = extern struct {
    data1: c_uint,
    data2: c_uint,
};
pub const FMOD_STUDIO_PARAMETER_ID = struct_FMOD_STUDIO_PARAMETER_ID;
pub const struct_FMOD_STUDIO_PARAMETER_DESCRIPTION = extern struct {
    name: [*c]const u8,
    id: FMOD_STUDIO_PARAMETER_ID,
    minimum: f32,
    maximum: f32,
    defaultvalue: f32,
    type: FMOD_STUDIO_PARAMETER_TYPE,
    flags: FMOD_STUDIO_PARAMETER_FLAGS,
};
pub const FMOD_STUDIO_PARAMETER_DESCRIPTION = struct_FMOD_STUDIO_PARAMETER_DESCRIPTION;
const union_unnamed_2 = extern union {
    intvalue: c_int,
    boolvalue: FMOD_BOOL,
    floatvalue: f32,
    stringvalue: [*c]const u8,
};
pub const struct_FMOD_STUDIO_USER_PROPERTY = extern struct {
    name: [*c]const u8,
    type: FMOD_STUDIO_USER_PROPERTY_TYPE,
    unnamed_0: union_unnamed_2,
};
pub const FMOD_STUDIO_USER_PROPERTY = struct_FMOD_STUDIO_USER_PROPERTY;
pub const struct_FMOD_STUDIO_PROGRAMMER_SOUND_PROPERTIES = extern struct {
    name: [*c]const u8,
    sound: ?*FMOD_SOUND,
    subsoundIndex: c_int,
};
pub const FMOD_STUDIO_PROGRAMMER_SOUND_PROPERTIES = struct_FMOD_STUDIO_PROGRAMMER_SOUND_PROPERTIES;
pub const struct_FMOD_STUDIO_PLUGIN_INSTANCE_PROPERTIES = extern struct {
    name: [*c]const u8,
    dsp: ?*FMOD_DSP,
};
pub const FMOD_STUDIO_PLUGIN_INSTANCE_PROPERTIES = struct_FMOD_STUDIO_PLUGIN_INSTANCE_PROPERTIES;
pub const struct_FMOD_STUDIO_TIMELINE_MARKER_PROPERTIES = extern struct {
    name: [*c]const u8,
    position: c_int,
};
pub const FMOD_STUDIO_TIMELINE_MARKER_PROPERTIES = struct_FMOD_STUDIO_TIMELINE_MARKER_PROPERTIES;
pub const struct_FMOD_STUDIO_TIMELINE_BEAT_PROPERTIES = extern struct {
    bar: c_int,
    beat: c_int,
    position: c_int,
    tempo: f32,
    timesignatureupper: c_int,
    timesignaturelower: c_int,
};
pub const FMOD_STUDIO_TIMELINE_BEAT_PROPERTIES = struct_FMOD_STUDIO_TIMELINE_BEAT_PROPERTIES;
pub const struct_FMOD_STUDIO_TIMELINE_NESTED_BEAT_PROPERTIES = extern struct {
    eventid: FMOD_GUID,
    properties: FMOD_STUDIO_TIMELINE_BEAT_PROPERTIES,
};
pub const FMOD_STUDIO_TIMELINE_NESTED_BEAT_PROPERTIES = struct_FMOD_STUDIO_TIMELINE_NESTED_BEAT_PROPERTIES;
pub const struct_FMOD_STUDIO_ADVANCEDSETTINGS = extern struct {
    cbsize: c_int,
    commandqueuesize: c_uint,
    handleinitialsize: c_uint,
    studioupdateperiod: c_int,
    idlesampledatapoolsize: c_int,
    streamingscheduledelay: c_uint,
    encryptionkey: [*c]const u8,
};
pub const FMOD_STUDIO_ADVANCEDSETTINGS = struct_FMOD_STUDIO_ADVANCEDSETTINGS;
pub const struct_FMOD_STUDIO_CPU_USAGE = extern struct {
    dspusage: f32,
    streamusage: f32,
    geometryusage: f32,
    updateusage: f32,
    studiousage: f32,
};
pub const FMOD_STUDIO_CPU_USAGE = struct_FMOD_STUDIO_CPU_USAGE;
pub const struct_FMOD_STUDIO_BUFFER_INFO = extern struct {
    currentusage: c_int,
    peakusage: c_int,
    capacity: c_int,
    stallcount: c_int,
    stalltime: f32,
};
pub const FMOD_STUDIO_BUFFER_INFO = struct_FMOD_STUDIO_BUFFER_INFO;
pub const struct_FMOD_STUDIO_BUFFER_USAGE = extern struct {
    studiocommandqueue: FMOD_STUDIO_BUFFER_INFO,
    studiohandle: FMOD_STUDIO_BUFFER_INFO,
};
pub const FMOD_STUDIO_BUFFER_USAGE = struct_FMOD_STUDIO_BUFFER_USAGE;
pub const struct_FMOD_STUDIO_SOUND_INFO = extern struct {
    name_or_data: [*c]const u8,
    mode: FMOD_MODE,
    exinfo: FMOD_CREATESOUNDEXINFO,
    subsoundindex: c_int,
};
pub const FMOD_STUDIO_SOUND_INFO = struct_FMOD_STUDIO_SOUND_INFO;
pub const struct_FMOD_STUDIO_COMMAND_INFO = extern struct {
    commandname: [*c]const u8,
    parentcommandindex: c_int,
    framenumber: c_int,
    frametime: f32,
    instancetype: FMOD_STUDIO_INSTANCETYPE,
    outputtype: FMOD_STUDIO_INSTANCETYPE,
    instancehandle: c_uint,
    outputhandle: c_uint,
};
pub const FMOD_STUDIO_COMMAND_INFO = struct_FMOD_STUDIO_COMMAND_INFO;
pub const struct_FMOD_STUDIO_MEMORY_USAGE = extern struct {
    exclusive: c_int,
    inclusive: c_int,
    sampledata: c_int,
};
pub const FMOD_STUDIO_MEMORY_USAGE = struct_FMOD_STUDIO_MEMORY_USAGE;
pub const FMOD_STUDIO_SYSTEM_CALLBACK = ?fn (?*FMOD_STUDIO_SYSTEM, FMOD_STUDIO_SYSTEM_CALLBACK_TYPE, ?*c_void, ?*c_void) callconv(.C) FMOD_RESULT;
pub const FMOD_STUDIO_EVENT_CALLBACK = ?fn (FMOD_STUDIO_EVENT_CALLBACK_TYPE, ?*FMOD_STUDIO_EVENTINSTANCE, ?*c_void) callconv(.C) FMOD_RESULT;
pub const FMOD_STUDIO_COMMANDREPLAY_FRAME_CALLBACK = ?fn (?*FMOD_STUDIO_COMMANDREPLAY, c_int, f32, ?*c_void) callconv(.C) FMOD_RESULT;
pub const FMOD_STUDIO_COMMANDREPLAY_LOAD_BANK_CALLBACK = ?fn (?*FMOD_STUDIO_COMMANDREPLAY, c_int, [*c]const FMOD_GUID, [*c]const u8, FMOD_STUDIO_LOAD_BANK_FLAGS, [*c]?*FMOD_STUDIO_BANK, ?*c_void) callconv(.C) FMOD_RESULT;
pub const FMOD_STUDIO_COMMANDREPLAY_CREATE_INSTANCE_CALLBACK = ?fn (?*FMOD_STUDIO_COMMANDREPLAY, c_int, ?*FMOD_STUDIO_EVENTDESCRIPTION, [*c]?*FMOD_STUDIO_EVENTINSTANCE, ?*c_void) callconv(.C) FMOD_RESULT;
pub extern fn FMOD_Studio_ParseID(idstring: [*c]const u8, id: [*c]FMOD_GUID) FMOD_RESULT;
pub extern fn FMOD_Studio_System_Create(system: [*c]?*FMOD_STUDIO_SYSTEM, headerversion: c_uint) FMOD_RESULT;
pub extern fn FMOD_Studio_System_IsValid(system: ?*FMOD_STUDIO_SYSTEM) FMOD_BOOL;
pub extern fn FMOD_Studio_System_SetAdvancedSettings(system: ?*FMOD_STUDIO_SYSTEM, settings: [*c]FMOD_STUDIO_ADVANCEDSETTINGS) FMOD_RESULT;
pub extern fn FMOD_Studio_System_GetAdvancedSettings(system: ?*FMOD_STUDIO_SYSTEM, settings: [*c]FMOD_STUDIO_ADVANCEDSETTINGS) FMOD_RESULT;
pub extern fn FMOD_Studio_System_Initialize(system: ?*FMOD_STUDIO_SYSTEM, maxchannels: c_int, studioflags: FMOD_STUDIO_INITFLAGS, flags: FMOD_INITFLAGS, extradriverdata: ?*c_void) FMOD_RESULT;
pub extern fn FMOD_Studio_System_Release(system: ?*FMOD_STUDIO_SYSTEM) FMOD_RESULT;
pub extern fn FMOD_Studio_System_Update(system: ?*FMOD_STUDIO_SYSTEM) FMOD_RESULT;
pub extern fn FMOD_Studio_System_GetCoreSystem(system: ?*FMOD_STUDIO_SYSTEM, coresystem: [*c]?*FMOD_SYSTEM) FMOD_RESULT;
pub extern fn FMOD_Studio_System_GetEvent(system: ?*FMOD_STUDIO_SYSTEM, pathOrID: [*c]const u8, event: [*c]?*FMOD_STUDIO_EVENTDESCRIPTION) FMOD_RESULT;
pub extern fn FMOD_Studio_System_GetBus(system: ?*FMOD_STUDIO_SYSTEM, pathOrID: [*c]const u8, bus: [*c]?*FMOD_STUDIO_BUS) FMOD_RESULT;
pub extern fn FMOD_Studio_System_GetVCA(system: ?*FMOD_STUDIO_SYSTEM, pathOrID: [*c]const u8, vca: [*c]?*FMOD_STUDIO_VCA) FMOD_RESULT;
pub extern fn FMOD_Studio_System_GetBank(system: ?*FMOD_STUDIO_SYSTEM, pathOrID: [*c]const u8, bank: [*c]?*FMOD_STUDIO_BANK) FMOD_RESULT;
pub extern fn FMOD_Studio_System_GetEventByID(system: ?*FMOD_STUDIO_SYSTEM, id: [*c]const FMOD_GUID, event: [*c]?*FMOD_STUDIO_EVENTDESCRIPTION) FMOD_RESULT;
pub extern fn FMOD_Studio_System_GetBusByID(system: ?*FMOD_STUDIO_SYSTEM, id: [*c]const FMOD_GUID, bus: [*c]?*FMOD_STUDIO_BUS) FMOD_RESULT;
pub extern fn FMOD_Studio_System_GetVCAByID(system: ?*FMOD_STUDIO_SYSTEM, id: [*c]const FMOD_GUID, vca: [*c]?*FMOD_STUDIO_VCA) FMOD_RESULT;
pub extern fn FMOD_Studio_System_GetBankByID(system: ?*FMOD_STUDIO_SYSTEM, id: [*c]const FMOD_GUID, bank: [*c]?*FMOD_STUDIO_BANK) FMOD_RESULT;
pub extern fn FMOD_Studio_System_GetSoundInfo(system: ?*FMOD_STUDIO_SYSTEM, key: [*c]const u8, info: [*c]FMOD_STUDIO_SOUND_INFO) FMOD_RESULT;
pub extern fn FMOD_Studio_System_GetParameterDescriptionByName(system: ?*FMOD_STUDIO_SYSTEM, name: [*c]const u8, parameter: [*c]FMOD_STUDIO_PARAMETER_DESCRIPTION) FMOD_RESULT;
pub extern fn FMOD_Studio_System_GetParameterDescriptionByID(system: ?*FMOD_STUDIO_SYSTEM, id: FMOD_STUDIO_PARAMETER_ID, parameter: [*c]FMOD_STUDIO_PARAMETER_DESCRIPTION) FMOD_RESULT;
pub extern fn FMOD_Studio_System_GetParameterByID(system: ?*FMOD_STUDIO_SYSTEM, id: FMOD_STUDIO_PARAMETER_ID, value: [*c]f32, finalvalue: [*c]f32) FMOD_RESULT;
pub extern fn FMOD_Studio_System_SetParameterByID(system: ?*FMOD_STUDIO_SYSTEM, id: FMOD_STUDIO_PARAMETER_ID, value: f32, ignoreseekspeed: FMOD_BOOL) FMOD_RESULT;
pub extern fn FMOD_Studio_System_SetParametersByIDs(system: ?*FMOD_STUDIO_SYSTEM, ids: [*c]const FMOD_STUDIO_PARAMETER_ID, values: [*c]f32, count: c_int, ignoreseekspeed: FMOD_BOOL) FMOD_RESULT;
pub extern fn FMOD_Studio_System_GetParameterByName(system: ?*FMOD_STUDIO_SYSTEM, name: [*c]const u8, value: [*c]f32, finalvalue: [*c]f32) FMOD_RESULT;
pub extern fn FMOD_Studio_System_SetParameterByName(system: ?*FMOD_STUDIO_SYSTEM, name: [*c]const u8, value: f32, ignoreseekspeed: FMOD_BOOL) FMOD_RESULT;
pub extern fn FMOD_Studio_System_LookupID(system: ?*FMOD_STUDIO_SYSTEM, path: [*c]const u8, id: [*c]FMOD_GUID) FMOD_RESULT;
pub extern fn FMOD_Studio_System_LookupPath(system: ?*FMOD_STUDIO_SYSTEM, id: [*c]const FMOD_GUID, path: [*c]u8, size: c_int, retrieved: [*c]c_int) FMOD_RESULT;
pub extern fn FMOD_Studio_System_GetNumListeners(system: ?*FMOD_STUDIO_SYSTEM, numlisteners: [*c]c_int) FMOD_RESULT;
pub extern fn FMOD_Studio_System_SetNumListeners(system: ?*FMOD_STUDIO_SYSTEM, numlisteners: c_int) FMOD_RESULT;
pub extern fn FMOD_Studio_System_GetListenerAttributes(system: ?*FMOD_STUDIO_SYSTEM, index: c_int, attributes: [*c]FMOD_3D_ATTRIBUTES, attenuationposition: [*c]FMOD_VECTOR) FMOD_RESULT;
pub extern fn FMOD_Studio_System_SetListenerAttributes(system: ?*FMOD_STUDIO_SYSTEM, index: c_int, attributes: [*c]const FMOD_3D_ATTRIBUTES, attenuationposition: [*c]const FMOD_VECTOR) FMOD_RESULT;
pub extern fn FMOD_Studio_System_GetListenerWeight(system: ?*FMOD_STUDIO_SYSTEM, index: c_int, weight: [*c]f32) FMOD_RESULT;
pub extern fn FMOD_Studio_System_SetListenerWeight(system: ?*FMOD_STUDIO_SYSTEM, index: c_int, weight: f32) FMOD_RESULT;
pub extern fn FMOD_Studio_System_LoadBankFile(system: ?*FMOD_STUDIO_SYSTEM, filename: [*c]const u8, flags: FMOD_STUDIO_LOAD_BANK_FLAGS, bank: [*c]?*FMOD_STUDIO_BANK) FMOD_RESULT;
pub extern fn FMOD_Studio_System_LoadBankMemory(system: ?*FMOD_STUDIO_SYSTEM, buffer: [*c]const u8, length: c_int, mode: FMOD_STUDIO_LOAD_MEMORY_MODE, flags: FMOD_STUDIO_LOAD_BANK_FLAGS, bank: [*c]?*FMOD_STUDIO_BANK) FMOD_RESULT;
pub extern fn FMOD_Studio_System_LoadBankCustom(system: ?*FMOD_STUDIO_SYSTEM, info: [*c]const FMOD_STUDIO_BANK_INFO, flags: FMOD_STUDIO_LOAD_BANK_FLAGS, bank: [*c]?*FMOD_STUDIO_BANK) FMOD_RESULT;
pub extern fn FMOD_Studio_System_RegisterPlugin(system: ?*FMOD_STUDIO_SYSTEM, description: [*c]const FMOD_DSP_DESCRIPTION) FMOD_RESULT;
pub extern fn FMOD_Studio_System_UnregisterPlugin(system: ?*FMOD_STUDIO_SYSTEM, name: [*c]const u8) FMOD_RESULT;
pub extern fn FMOD_Studio_System_UnloadAll(system: ?*FMOD_STUDIO_SYSTEM) FMOD_RESULT;
pub extern fn FMOD_Studio_System_FlushCommands(system: ?*FMOD_STUDIO_SYSTEM) FMOD_RESULT;
pub extern fn FMOD_Studio_System_FlushSampleLoading(system: ?*FMOD_STUDIO_SYSTEM) FMOD_RESULT;
pub extern fn FMOD_Studio_System_StartCommandCapture(system: ?*FMOD_STUDIO_SYSTEM, filename: [*c]const u8, flags: FMOD_STUDIO_COMMANDCAPTURE_FLAGS) FMOD_RESULT;
pub extern fn FMOD_Studio_System_StopCommandCapture(system: ?*FMOD_STUDIO_SYSTEM) FMOD_RESULT;
pub extern fn FMOD_Studio_System_LoadCommandReplay(system: ?*FMOD_STUDIO_SYSTEM, filename: [*c]const u8, flags: FMOD_STUDIO_COMMANDREPLAY_FLAGS, replay: [*c]?*FMOD_STUDIO_COMMANDREPLAY) FMOD_RESULT;
pub extern fn FMOD_Studio_System_GetBankCount(system: ?*FMOD_STUDIO_SYSTEM, count: [*c]c_int) FMOD_RESULT;
pub extern fn FMOD_Studio_System_GetBankList(system: ?*FMOD_STUDIO_SYSTEM, array: [*c]?*FMOD_STUDIO_BANK, capacity: c_int, count: [*c]c_int) FMOD_RESULT;
pub extern fn FMOD_Studio_System_GetParameterDescriptionCount(system: ?*FMOD_STUDIO_SYSTEM, count: [*c]c_int) FMOD_RESULT;
pub extern fn FMOD_Studio_System_GetParameterDescriptionList(system: ?*FMOD_STUDIO_SYSTEM, array: [*c]FMOD_STUDIO_PARAMETER_DESCRIPTION, capacity: c_int, count: [*c]c_int) FMOD_RESULT;
pub extern fn FMOD_Studio_System_GetCPUUsage(system: ?*FMOD_STUDIO_SYSTEM, usage: [*c]FMOD_STUDIO_CPU_USAGE) FMOD_RESULT;
pub extern fn FMOD_Studio_System_GetBufferUsage(system: ?*FMOD_STUDIO_SYSTEM, usage: [*c]FMOD_STUDIO_BUFFER_USAGE) FMOD_RESULT;
pub extern fn FMOD_Studio_System_ResetBufferUsage(system: ?*FMOD_STUDIO_SYSTEM) FMOD_RESULT;
pub extern fn FMOD_Studio_System_SetCallback(system: ?*FMOD_STUDIO_SYSTEM, callback: FMOD_STUDIO_SYSTEM_CALLBACK, callbackmask: FMOD_STUDIO_SYSTEM_CALLBACK_TYPE) FMOD_RESULT;
pub extern fn FMOD_Studio_System_SetUserData(system: ?*FMOD_STUDIO_SYSTEM, userdata: ?*c_void) FMOD_RESULT;
pub extern fn FMOD_Studio_System_GetUserData(system: ?*FMOD_STUDIO_SYSTEM, userdata: [*c]?*c_void) FMOD_RESULT;
pub extern fn FMOD_Studio_System_GetMemoryUsage(system: ?*FMOD_STUDIO_SYSTEM, memoryusage: [*c]FMOD_STUDIO_MEMORY_USAGE) FMOD_RESULT;
pub extern fn FMOD_Studio_EventDescription_IsValid(eventdescription: ?*FMOD_STUDIO_EVENTDESCRIPTION) FMOD_BOOL;
pub extern fn FMOD_Studio_EventDescription_GetID(eventdescription: ?*FMOD_STUDIO_EVENTDESCRIPTION, id: [*c]FMOD_GUID) FMOD_RESULT;
pub extern fn FMOD_Studio_EventDescription_GetPath(eventdescription: ?*FMOD_STUDIO_EVENTDESCRIPTION, path: [*c]u8, size: c_int, retrieved: [*c]c_int) FMOD_RESULT;
pub extern fn FMOD_Studio_EventDescription_GetParameterDescriptionCount(eventdescription: ?*FMOD_STUDIO_EVENTDESCRIPTION, count: [*c]c_int) FMOD_RESULT;
pub extern fn FMOD_Studio_EventDescription_GetParameterDescriptionByIndex(eventdescription: ?*FMOD_STUDIO_EVENTDESCRIPTION, index: c_int, parameter: [*c]FMOD_STUDIO_PARAMETER_DESCRIPTION) FMOD_RESULT;
pub extern fn FMOD_Studio_EventDescription_GetParameterDescriptionByName(eventdescription: ?*FMOD_STUDIO_EVENTDESCRIPTION, name: [*c]const u8, parameter: [*c]FMOD_STUDIO_PARAMETER_DESCRIPTION) FMOD_RESULT;
pub extern fn FMOD_Studio_EventDescription_GetParameterDescriptionByID(eventdescription: ?*FMOD_STUDIO_EVENTDESCRIPTION, id: FMOD_STUDIO_PARAMETER_ID, parameter: [*c]FMOD_STUDIO_PARAMETER_DESCRIPTION) FMOD_RESULT;
pub extern fn FMOD_Studio_EventDescription_GetUserPropertyCount(eventdescription: ?*FMOD_STUDIO_EVENTDESCRIPTION, count: [*c]c_int) FMOD_RESULT;
pub extern fn FMOD_Studio_EventDescription_GetUserPropertyByIndex(eventdescription: ?*FMOD_STUDIO_EVENTDESCRIPTION, index: c_int, property: [*c]FMOD_STUDIO_USER_PROPERTY) FMOD_RESULT;
pub extern fn FMOD_Studio_EventDescription_GetUserProperty(eventdescription: ?*FMOD_STUDIO_EVENTDESCRIPTION, name: [*c]const u8, property: [*c]FMOD_STUDIO_USER_PROPERTY) FMOD_RESULT;
pub extern fn FMOD_Studio_EventDescription_GetLength(eventdescription: ?*FMOD_STUDIO_EVENTDESCRIPTION, length: [*c]c_int) FMOD_RESULT;
pub extern fn FMOD_Studio_EventDescription_GetMinimumDistance(eventdescription: ?*FMOD_STUDIO_EVENTDESCRIPTION, distance: [*c]f32) FMOD_RESULT;
pub extern fn FMOD_Studio_EventDescription_GetMaximumDistance(eventdescription: ?*FMOD_STUDIO_EVENTDESCRIPTION, distance: [*c]f32) FMOD_RESULT;
pub extern fn FMOD_Studio_EventDescription_GetSoundSize(eventdescription: ?*FMOD_STUDIO_EVENTDESCRIPTION, size: [*c]f32) FMOD_RESULT;
pub extern fn FMOD_Studio_EventDescription_IsSnapshot(eventdescription: ?*FMOD_STUDIO_EVENTDESCRIPTION, snapshot: [*c]FMOD_BOOL) FMOD_RESULT;
pub extern fn FMOD_Studio_EventDescription_IsOneshot(eventdescription: ?*FMOD_STUDIO_EVENTDESCRIPTION, oneshot: [*c]FMOD_BOOL) FMOD_RESULT;
pub extern fn FMOD_Studio_EventDescription_IsStream(eventdescription: ?*FMOD_STUDIO_EVENTDESCRIPTION, isStream: [*c]FMOD_BOOL) FMOD_RESULT;
pub extern fn FMOD_Studio_EventDescription_Is3D(eventdescription: ?*FMOD_STUDIO_EVENTDESCRIPTION, is3D: [*c]FMOD_BOOL) FMOD_RESULT;
pub extern fn FMOD_Studio_EventDescription_IsDopplerEnabled(eventdescription: ?*FMOD_STUDIO_EVENTDESCRIPTION, doppler: [*c]FMOD_BOOL) FMOD_RESULT;
pub extern fn FMOD_Studio_EventDescription_HasCue(eventdescription: ?*FMOD_STUDIO_EVENTDESCRIPTION, cue: [*c]FMOD_BOOL) FMOD_RESULT;
pub extern fn FMOD_Studio_EventDescription_CreateInstance(eventdescription: ?*FMOD_STUDIO_EVENTDESCRIPTION, instance: [*c]?*FMOD_STUDIO_EVENTINSTANCE) FMOD_RESULT;
pub extern fn FMOD_Studio_EventDescription_GetInstanceCount(eventdescription: ?*FMOD_STUDIO_EVENTDESCRIPTION, count: [*c]c_int) FMOD_RESULT;
pub extern fn FMOD_Studio_EventDescription_GetInstanceList(eventdescription: ?*FMOD_STUDIO_EVENTDESCRIPTION, array: [*c]?*FMOD_STUDIO_EVENTINSTANCE, capacity: c_int, count: [*c]c_int) FMOD_RESULT;
pub extern fn FMOD_Studio_EventDescription_LoadSampleData(eventdescription: ?*FMOD_STUDIO_EVENTDESCRIPTION) FMOD_RESULT;
pub extern fn FMOD_Studio_EventDescription_UnloadSampleData(eventdescription: ?*FMOD_STUDIO_EVENTDESCRIPTION) FMOD_RESULT;
pub extern fn FMOD_Studio_EventDescription_GetSampleLoadingState(eventdescription: ?*FMOD_STUDIO_EVENTDESCRIPTION, state: [*c]FMOD_STUDIO_LOADING_STATE) FMOD_RESULT;
pub extern fn FMOD_Studio_EventDescription_ReleaseAllInstances(eventdescription: ?*FMOD_STUDIO_EVENTDESCRIPTION) FMOD_RESULT;
pub extern fn FMOD_Studio_EventDescription_SetCallback(eventdescription: ?*FMOD_STUDIO_EVENTDESCRIPTION, callback: FMOD_STUDIO_EVENT_CALLBACK, callbackmask: FMOD_STUDIO_EVENT_CALLBACK_TYPE) FMOD_RESULT;
pub extern fn FMOD_Studio_EventDescription_GetUserData(eventdescription: ?*FMOD_STUDIO_EVENTDESCRIPTION, userdata: [*c]?*c_void) FMOD_RESULT;
pub extern fn FMOD_Studio_EventDescription_SetUserData(eventdescription: ?*FMOD_STUDIO_EVENTDESCRIPTION, userdata: ?*c_void) FMOD_RESULT;
pub extern fn FMOD_Studio_EventInstance_IsValid(eventinstance: ?*FMOD_STUDIO_EVENTINSTANCE) FMOD_BOOL;
pub extern fn FMOD_Studio_EventInstance_GetDescription(eventinstance: ?*FMOD_STUDIO_EVENTINSTANCE, description: [*c]?*FMOD_STUDIO_EVENTDESCRIPTION) FMOD_RESULT;
pub extern fn FMOD_Studio_EventInstance_GetVolume(eventinstance: ?*FMOD_STUDIO_EVENTINSTANCE, volume: [*c]f32, finalvolume: [*c]f32) FMOD_RESULT;
pub extern fn FMOD_Studio_EventInstance_SetVolume(eventinstance: ?*FMOD_STUDIO_EVENTINSTANCE, volume: f32) FMOD_RESULT;
pub extern fn FMOD_Studio_EventInstance_GetPitch(eventinstance: ?*FMOD_STUDIO_EVENTINSTANCE, pitch: [*c]f32, finalpitch: [*c]f32) FMOD_RESULT;
pub extern fn FMOD_Studio_EventInstance_SetPitch(eventinstance: ?*FMOD_STUDIO_EVENTINSTANCE, pitch: f32) FMOD_RESULT;
pub extern fn FMOD_Studio_EventInstance_Get3DAttributes(eventinstance: ?*FMOD_STUDIO_EVENTINSTANCE, attributes: [*c]FMOD_3D_ATTRIBUTES) FMOD_RESULT;
pub extern fn FMOD_Studio_EventInstance_Set3DAttributes(eventinstance: ?*FMOD_STUDIO_EVENTINSTANCE, attributes: [*c]FMOD_3D_ATTRIBUTES) FMOD_RESULT;
pub extern fn FMOD_Studio_EventInstance_GetListenerMask(eventinstance: ?*FMOD_STUDIO_EVENTINSTANCE, mask: [*c]c_uint) FMOD_RESULT;
pub extern fn FMOD_Studio_EventInstance_SetListenerMask(eventinstance: ?*FMOD_STUDIO_EVENTINSTANCE, mask: c_uint) FMOD_RESULT;
pub extern fn FMOD_Studio_EventInstance_GetProperty(eventinstance: ?*FMOD_STUDIO_EVENTINSTANCE, index: FMOD_STUDIO_EVENT_PROPERTY, value: [*c]f32) FMOD_RESULT;
pub extern fn FMOD_Studio_EventInstance_SetProperty(eventinstance: ?*FMOD_STUDIO_EVENTINSTANCE, index: FMOD_STUDIO_EVENT_PROPERTY, value: f32) FMOD_RESULT;
pub extern fn FMOD_Studio_EventInstance_GetReverbLevel(eventinstance: ?*FMOD_STUDIO_EVENTINSTANCE, index: c_int, level: [*c]f32) FMOD_RESULT;
pub extern fn FMOD_Studio_EventInstance_SetReverbLevel(eventinstance: ?*FMOD_STUDIO_EVENTINSTANCE, index: c_int, level: f32) FMOD_RESULT;
pub extern fn FMOD_Studio_EventInstance_GetPaused(eventinstance: ?*FMOD_STUDIO_EVENTINSTANCE, paused: [*c]FMOD_BOOL) FMOD_RESULT;
pub extern fn FMOD_Studio_EventInstance_SetPaused(eventinstance: ?*FMOD_STUDIO_EVENTINSTANCE, paused: FMOD_BOOL) FMOD_RESULT;
pub extern fn FMOD_Studio_EventInstance_Start(eventinstance: ?*FMOD_STUDIO_EVENTINSTANCE) FMOD_RESULT;
pub extern fn FMOD_Studio_EventInstance_Stop(eventinstance: ?*FMOD_STUDIO_EVENTINSTANCE, mode: FMOD_STUDIO_STOP_MODE) FMOD_RESULT;
pub extern fn FMOD_Studio_EventInstance_GetTimelinePosition(eventinstance: ?*FMOD_STUDIO_EVENTINSTANCE, position: [*c]c_int) FMOD_RESULT;
pub extern fn FMOD_Studio_EventInstance_SetTimelinePosition(eventinstance: ?*FMOD_STUDIO_EVENTINSTANCE, position: c_int) FMOD_RESULT;
pub extern fn FMOD_Studio_EventInstance_GetPlaybackState(eventinstance: ?*FMOD_STUDIO_EVENTINSTANCE, state: [*c]FMOD_STUDIO_PLAYBACK_STATE) FMOD_RESULT;
pub extern fn FMOD_Studio_EventInstance_GetChannelGroup(eventinstance: ?*FMOD_STUDIO_EVENTINSTANCE, group: [*c]?*FMOD_CHANNELGROUP) FMOD_RESULT;
pub extern fn FMOD_Studio_EventInstance_Release(eventinstance: ?*FMOD_STUDIO_EVENTINSTANCE) FMOD_RESULT;
pub extern fn FMOD_Studio_EventInstance_IsVirtual(eventinstance: ?*FMOD_STUDIO_EVENTINSTANCE, virtualstate: [*c]FMOD_BOOL) FMOD_RESULT;
pub extern fn FMOD_Studio_EventInstance_GetParameterByName(eventinstance: ?*FMOD_STUDIO_EVENTINSTANCE, name: [*c]const u8, value: [*c]f32, finalvalue: [*c]f32) FMOD_RESULT;
pub extern fn FMOD_Studio_EventInstance_SetParameterByName(eventinstance: ?*FMOD_STUDIO_EVENTINSTANCE, name: [*c]const u8, value: f32, ignoreseekspeed: FMOD_BOOL) FMOD_RESULT;
pub extern fn FMOD_Studio_EventInstance_GetParameterByID(eventinstance: ?*FMOD_STUDIO_EVENTINSTANCE, id: FMOD_STUDIO_PARAMETER_ID, value: [*c]f32, finalvalue: [*c]f32) FMOD_RESULT;
pub extern fn FMOD_Studio_EventInstance_SetParameterByID(eventinstance: ?*FMOD_STUDIO_EVENTINSTANCE, id: FMOD_STUDIO_PARAMETER_ID, value: f32, ignoreseekspeed: FMOD_BOOL) FMOD_RESULT;
pub extern fn FMOD_Studio_EventInstance_SetParametersByIDs(eventinstance: ?*FMOD_STUDIO_EVENTINSTANCE, ids: [*c]const FMOD_STUDIO_PARAMETER_ID, values: [*c]f32, count: c_int, ignoreseekspeed: FMOD_BOOL) FMOD_RESULT;
pub extern fn FMOD_Studio_EventInstance_TriggerCue(eventinstance: ?*FMOD_STUDIO_EVENTINSTANCE) FMOD_RESULT;
pub extern fn FMOD_Studio_EventInstance_SetCallback(eventinstance: ?*FMOD_STUDIO_EVENTINSTANCE, callback: FMOD_STUDIO_EVENT_CALLBACK, callbackmask: FMOD_STUDIO_EVENT_CALLBACK_TYPE) FMOD_RESULT;
pub extern fn FMOD_Studio_EventInstance_GetUserData(eventinstance: ?*FMOD_STUDIO_EVENTINSTANCE, userdata: [*c]?*c_void) FMOD_RESULT;
pub extern fn FMOD_Studio_EventInstance_SetUserData(eventinstance: ?*FMOD_STUDIO_EVENTINSTANCE, userdata: ?*c_void) FMOD_RESULT;
pub extern fn FMOD_Studio_EventInstance_GetCPUUsage(eventinstance: ?*FMOD_STUDIO_EVENTINSTANCE, exclusive: [*c]c_uint, inclusive: [*c]c_uint) FMOD_RESULT;
pub extern fn FMOD_Studio_EventInstance_GetMemoryUsage(eventinstance: ?*FMOD_STUDIO_EVENTINSTANCE, memoryusage: [*c]FMOD_STUDIO_MEMORY_USAGE) FMOD_RESULT;
pub extern fn FMOD_Studio_Bus_IsValid(bus: ?*FMOD_STUDIO_BUS) FMOD_BOOL;
pub extern fn FMOD_Studio_Bus_GetID(bus: ?*FMOD_STUDIO_BUS, id: [*c]FMOD_GUID) FMOD_RESULT;
pub extern fn FMOD_Studio_Bus_GetPath(bus: ?*FMOD_STUDIO_BUS, path: [*c]u8, size: c_int, retrieved: [*c]c_int) FMOD_RESULT;
pub extern fn FMOD_Studio_Bus_GetVolume(bus: ?*FMOD_STUDIO_BUS, volume: [*c]f32, finalvolume: [*c]f32) FMOD_RESULT;
pub extern fn FMOD_Studio_Bus_SetVolume(bus: ?*FMOD_STUDIO_BUS, volume: f32) FMOD_RESULT;
pub extern fn FMOD_Studio_Bus_GetPaused(bus: ?*FMOD_STUDIO_BUS, paused: [*c]FMOD_BOOL) FMOD_RESULT;
pub extern fn FMOD_Studio_Bus_SetPaused(bus: ?*FMOD_STUDIO_BUS, paused: FMOD_BOOL) FMOD_RESULT;
pub extern fn FMOD_Studio_Bus_GetMute(bus: ?*FMOD_STUDIO_BUS, mute: [*c]FMOD_BOOL) FMOD_RESULT;
pub extern fn FMOD_Studio_Bus_SetMute(bus: ?*FMOD_STUDIO_BUS, mute: FMOD_BOOL) FMOD_RESULT;
pub extern fn FMOD_Studio_Bus_StopAllEvents(bus: ?*FMOD_STUDIO_BUS, mode: FMOD_STUDIO_STOP_MODE) FMOD_RESULT;
pub extern fn FMOD_Studio_Bus_LockChannelGroup(bus: ?*FMOD_STUDIO_BUS) FMOD_RESULT;
pub extern fn FMOD_Studio_Bus_UnlockChannelGroup(bus: ?*FMOD_STUDIO_BUS) FMOD_RESULT;
pub extern fn FMOD_Studio_Bus_GetChannelGroup(bus: ?*FMOD_STUDIO_BUS, group: [*c]?*FMOD_CHANNELGROUP) FMOD_RESULT;
pub extern fn FMOD_Studio_Bus_GetCPUUsage(bus: ?*FMOD_STUDIO_BUS, exclusive: [*c]c_uint, inclusive: [*c]c_uint) FMOD_RESULT;
pub extern fn FMOD_Studio_Bus_GetMemoryUsage(bus: ?*FMOD_STUDIO_BUS, memoryusage: [*c]FMOD_STUDIO_MEMORY_USAGE) FMOD_RESULT;
pub extern fn FMOD_Studio_VCA_IsValid(vca: ?*FMOD_STUDIO_VCA) FMOD_BOOL;
pub extern fn FMOD_Studio_VCA_GetID(vca: ?*FMOD_STUDIO_VCA, id: [*c]FMOD_GUID) FMOD_RESULT;
pub extern fn FMOD_Studio_VCA_GetPath(vca: ?*FMOD_STUDIO_VCA, path: [*c]u8, size: c_int, retrieved: [*c]c_int) FMOD_RESULT;
pub extern fn FMOD_Studio_VCA_GetVolume(vca: ?*FMOD_STUDIO_VCA, volume: [*c]f32, finalvolume: [*c]f32) FMOD_RESULT;
pub extern fn FMOD_Studio_VCA_SetVolume(vca: ?*FMOD_STUDIO_VCA, volume: f32) FMOD_RESULT;
pub extern fn FMOD_Studio_Bank_IsValid(bank: ?*FMOD_STUDIO_BANK) FMOD_BOOL;
pub extern fn FMOD_Studio_Bank_GetID(bank: ?*FMOD_STUDIO_BANK, id: [*c]FMOD_GUID) FMOD_RESULT;
pub extern fn FMOD_Studio_Bank_GetPath(bank: ?*FMOD_STUDIO_BANK, path: [*c]u8, size: c_int, retrieved: [*c]c_int) FMOD_RESULT;
pub extern fn FMOD_Studio_Bank_Unload(bank: ?*FMOD_STUDIO_BANK) FMOD_RESULT;
pub extern fn FMOD_Studio_Bank_LoadSampleData(bank: ?*FMOD_STUDIO_BANK) FMOD_RESULT;
pub extern fn FMOD_Studio_Bank_UnloadSampleData(bank: ?*FMOD_STUDIO_BANK) FMOD_RESULT;
pub extern fn FMOD_Studio_Bank_GetLoadingState(bank: ?*FMOD_STUDIO_BANK, state: [*c]FMOD_STUDIO_LOADING_STATE) FMOD_RESULT;
pub extern fn FMOD_Studio_Bank_GetSampleLoadingState(bank: ?*FMOD_STUDIO_BANK, state: [*c]FMOD_STUDIO_LOADING_STATE) FMOD_RESULT;
pub extern fn FMOD_Studio_Bank_GetStringCount(bank: ?*FMOD_STUDIO_BANK, count: [*c]c_int) FMOD_RESULT;
pub extern fn FMOD_Studio_Bank_GetStringInfo(bank: ?*FMOD_STUDIO_BANK, index: c_int, id: [*c]FMOD_GUID, path: [*c]u8, size: c_int, retrieved: [*c]c_int) FMOD_RESULT;
pub extern fn FMOD_Studio_Bank_GetEventCount(bank: ?*FMOD_STUDIO_BANK, count: [*c]c_int) FMOD_RESULT;
pub extern fn FMOD_Studio_Bank_GetEventList(bank: ?*FMOD_STUDIO_BANK, array: [*c]?*FMOD_STUDIO_EVENTDESCRIPTION, capacity: c_int, count: [*c]c_int) FMOD_RESULT;
pub extern fn FMOD_Studio_Bank_GetBusCount(bank: ?*FMOD_STUDIO_BANK, count: [*c]c_int) FMOD_RESULT;
pub extern fn FMOD_Studio_Bank_GetBusList(bank: ?*FMOD_STUDIO_BANK, array: [*c]?*FMOD_STUDIO_BUS, capacity: c_int, count: [*c]c_int) FMOD_RESULT;
pub extern fn FMOD_Studio_Bank_GetVCACount(bank: ?*FMOD_STUDIO_BANK, count: [*c]c_int) FMOD_RESULT;
pub extern fn FMOD_Studio_Bank_GetVCAList(bank: ?*FMOD_STUDIO_BANK, array: [*c]?*FMOD_STUDIO_VCA, capacity: c_int, count: [*c]c_int) FMOD_RESULT;
pub extern fn FMOD_Studio_Bank_GetUserData(bank: ?*FMOD_STUDIO_BANK, userdata: [*c]?*c_void) FMOD_RESULT;
pub extern fn FMOD_Studio_Bank_SetUserData(bank: ?*FMOD_STUDIO_BANK, userdata: ?*c_void) FMOD_RESULT;
pub extern fn FMOD_Studio_CommandReplay_IsValid(replay: ?*FMOD_STUDIO_COMMANDREPLAY) FMOD_BOOL;
pub extern fn FMOD_Studio_CommandReplay_GetSystem(replay: ?*FMOD_STUDIO_COMMANDREPLAY, system: [*c]?*FMOD_STUDIO_SYSTEM) FMOD_RESULT;
pub extern fn FMOD_Studio_CommandReplay_GetLength(replay: ?*FMOD_STUDIO_COMMANDREPLAY, length: [*c]f32) FMOD_RESULT;
pub extern fn FMOD_Studio_CommandReplay_GetCommandCount(replay: ?*FMOD_STUDIO_COMMANDREPLAY, count: [*c]c_int) FMOD_RESULT;
pub extern fn FMOD_Studio_CommandReplay_GetCommandInfo(replay: ?*FMOD_STUDIO_COMMANDREPLAY, commandindex: c_int, info: [*c]FMOD_STUDIO_COMMAND_INFO) FMOD_RESULT;
pub extern fn FMOD_Studio_CommandReplay_GetCommandString(replay: ?*FMOD_STUDIO_COMMANDREPLAY, commandindex: c_int, buffer: [*c]u8, length: c_int) FMOD_RESULT;
pub extern fn FMOD_Studio_CommandReplay_GetCommandAtTime(replay: ?*FMOD_STUDIO_COMMANDREPLAY, time: f32, commandindex: [*c]c_int) FMOD_RESULT;
pub extern fn FMOD_Studio_CommandReplay_SetBankPath(replay: ?*FMOD_STUDIO_COMMANDREPLAY, bankPath: [*c]const u8) FMOD_RESULT;
pub extern fn FMOD_Studio_CommandReplay_Start(replay: ?*FMOD_STUDIO_COMMANDREPLAY) FMOD_RESULT;
pub extern fn FMOD_Studio_CommandReplay_Stop(replay: ?*FMOD_STUDIO_COMMANDREPLAY) FMOD_RESULT;
pub extern fn FMOD_Studio_CommandReplay_SeekToTime(replay: ?*FMOD_STUDIO_COMMANDREPLAY, time: f32) FMOD_RESULT;
pub extern fn FMOD_Studio_CommandReplay_SeekToCommand(replay: ?*FMOD_STUDIO_COMMANDREPLAY, commandindex: c_int) FMOD_RESULT;
pub extern fn FMOD_Studio_CommandReplay_GetPaused(replay: ?*FMOD_STUDIO_COMMANDREPLAY, paused: [*c]FMOD_BOOL) FMOD_RESULT;
pub extern fn FMOD_Studio_CommandReplay_SetPaused(replay: ?*FMOD_STUDIO_COMMANDREPLAY, paused: FMOD_BOOL) FMOD_RESULT;
pub extern fn FMOD_Studio_CommandReplay_GetPlaybackState(replay: ?*FMOD_STUDIO_COMMANDREPLAY, state: [*c]FMOD_STUDIO_PLAYBACK_STATE) FMOD_RESULT;
pub extern fn FMOD_Studio_CommandReplay_GetCurrentCommand(replay: ?*FMOD_STUDIO_COMMANDREPLAY, commandindex: [*c]c_int, currenttime: [*c]f32) FMOD_RESULT;
pub extern fn FMOD_Studio_CommandReplay_Release(replay: ?*FMOD_STUDIO_COMMANDREPLAY) FMOD_RESULT;
pub extern fn FMOD_Studio_CommandReplay_SetFrameCallback(replay: ?*FMOD_STUDIO_COMMANDREPLAY, callback: FMOD_STUDIO_COMMANDREPLAY_FRAME_CALLBACK) FMOD_RESULT;
pub extern fn FMOD_Studio_CommandReplay_SetLoadBankCallback(replay: ?*FMOD_STUDIO_COMMANDREPLAY, callback: FMOD_STUDIO_COMMANDREPLAY_LOAD_BANK_CALLBACK) FMOD_RESULT;
pub extern fn FMOD_Studio_CommandReplay_SetCreateInstanceCallback(replay: ?*FMOD_STUDIO_COMMANDREPLAY, callback: FMOD_STUDIO_COMMANDREPLAY_CREATE_INSTANCE_CALLBACK) FMOD_RESULT;
pub extern fn FMOD_Studio_CommandReplay_GetUserData(replay: ?*FMOD_STUDIO_COMMANDREPLAY, userdata: [*c]?*c_void) FMOD_RESULT;
pub extern fn FMOD_Studio_CommandReplay_SetUserData(replay: ?*FMOD_STUDIO_COMMANDREPLAY, userdata: ?*c_void) FMOD_RESULT;
pub const FMOD_PRESET_OFF = @compileError("unable to translate C expr: unexpected token .LBrace"); // ../../core/inc/fmod_common.h:269:9
pub const FMOD_PRESET_GENERIC = @compileError("unable to translate C expr: unexpected token .LBrace"); // ../../core/inc/fmod_common.h:270:9
pub const FMOD_PRESET_PADDEDCELL = @compileError("unable to translate C expr: unexpected token .LBrace"); // ../../core/inc/fmod_common.h:271:9
pub const FMOD_PRESET_ROOM = @compileError("unable to translate C expr: unexpected token .LBrace"); // ../../core/inc/fmod_common.h:272:9
pub const FMOD_PRESET_BATHROOM = @compileError("unable to translate C expr: unexpected token .LBrace"); // ../../core/inc/fmod_common.h:273:9
pub const FMOD_PRESET_LIVINGROOM = @compileError("unable to translate C expr: unexpected token .LBrace"); // ../../core/inc/fmod_common.h:274:9
pub const FMOD_PRESET_STONEROOM = @compileError("unable to translate C expr: unexpected token .LBrace"); // ../../core/inc/fmod_common.h:275:9
pub const FMOD_PRESET_AUDITORIUM = @compileError("unable to translate C expr: unexpected token .LBrace"); // ../../core/inc/fmod_common.h:276:9
pub const FMOD_PRESET_CONCERTHALL = @compileError("unable to translate C expr: unexpected token .LBrace"); // ../../core/inc/fmod_common.h:277:9
pub const FMOD_PRESET_CAVE = @compileError("unable to translate C expr: unexpected token .LBrace"); // ../../core/inc/fmod_common.h:278:9
pub const FMOD_PRESET_ARENA = @compileError("unable to translate C expr: unexpected token .LBrace"); // ../../core/inc/fmod_common.h:279:9
pub const FMOD_PRESET_HANGAR = @compileError("unable to translate C expr: unexpected token .LBrace"); // ../../core/inc/fmod_common.h:280:9
pub const FMOD_PRESET_CARPETTEDHALLWAY = @compileError("unable to translate C expr: unexpected token .LBrace"); // ../../core/inc/fmod_common.h:281:9
pub const FMOD_PRESET_HALLWAY = @compileError("unable to translate C expr: unexpected token .LBrace"); // ../../core/inc/fmod_common.h:282:9
pub const FMOD_PRESET_STONECORRIDOR = @compileError("unable to translate C expr: unexpected token .LBrace"); // ../../core/inc/fmod_common.h:283:9
pub const FMOD_PRESET_ALLEY = @compileError("unable to translate C expr: unexpected token .LBrace"); // ../../core/inc/fmod_common.h:284:9
pub const FMOD_PRESET_FOREST = @compileError("unable to translate C expr: unexpected token .LBrace"); // ../../core/inc/fmod_common.h:285:9
pub const FMOD_PRESET_CITY = @compileError("unable to translate C expr: unexpected token .LBrace"); // ../../core/inc/fmod_common.h:286:9
pub const FMOD_PRESET_MOUNTAINS = @compileError("unable to translate C expr: unexpected token .LBrace"); // ../../core/inc/fmod_common.h:287:9
pub const FMOD_PRESET_QUARRY = @compileError("unable to translate C expr: unexpected token .LBrace"); // ../../core/inc/fmod_common.h:288:9
pub const FMOD_PRESET_PLAIN = @compileError("unable to translate C expr: unexpected token .LBrace"); // ../../core/inc/fmod_common.h:289:9
pub const FMOD_PRESET_PARKINGLOT = @compileError("unable to translate C expr: unexpected token .LBrace"); // ../../core/inc/fmod_common.h:290:9
pub const FMOD_PRESET_SEWERPIPE = @compileError("unable to translate C expr: unexpected token .LBrace"); // ../../core/inc/fmod_common.h:291:9
pub const FMOD_PRESET_UNDERWATER = @compileError("unable to translate C expr: unexpected token .LBrace"); // ../../core/inc/fmod_common.h:292:9
pub const FMOD_DSP_INIT_PARAMDESC_FLOAT = @compileError("unable to translate C expr: unexpected token .Semicolon"); // ../../core/inc/fmod_dsp.h:310:9
pub const FMOD_DSP_INIT_PARAMDESC_FLOAT_WITH_MAPPING = @compileError("unable to translate C expr: unexpected token .Semicolon"); // ../../core/inc/fmod_dsp.h:321:9
pub const FMOD_DSP_INIT_PARAMDESC_INT = @compileError("unable to translate C expr: unexpected token .Semicolon"); // ../../core/inc/fmod_dsp.h:335:9
pub const FMOD_DSP_INIT_PARAMDESC_INT_ENUMERATED = @compileError("unable to translate C expr: unexpected token .Semicolon"); // ../../core/inc/fmod_dsp.h:347:9
pub const FMOD_DSP_INIT_PARAMDESC_BOOL = @compileError("unable to translate C expr: unexpected token .Semicolon"); // ../../core/inc/fmod_dsp.h:359:9
pub const FMOD_DSP_INIT_PARAMDESC_DATA = @compileError("unable to translate C expr: unexpected token .Semicolon"); // ../../core/inc/fmod_dsp.h:368:9
pub const FMOD_DSP_LOG = @compileError("unable to translate C expr: expected ')'"); // ../../core/inc/fmod_dsp.h:382:9
pub const FMOD_OUTPUT_LOG = @compileError("unable to translate C expr: expected ')'"); // ../../core/inc/fmod_output.h:122:9
// pub const __llvm__ = @as(c_int, 1);
// pub const __clang__ = @as(c_int, 1);
// pub const __clang_major__ = @as(c_int, 12);
// pub const __clang_minor__ = @as(c_int, 0);
// pub const __clang_patchlevel__ = @as(c_int, 1);
// pub const __clang_version__ = "12.0.1 (https://github.com/llvm/llvm-project 328a6ec955327c6d56b6bc3478c723dd3cd468ef)";
// pub const __GNUC__ = @as(c_int, 4);
// pub const __GNUC_MINOR__ = @as(c_int, 2);
// pub const __GNUC_PATCHLEVEL__ = @as(c_int, 1);
// pub const __GXX_ABI_VERSION = @as(c_int, 1002);
// pub const __ATOMIC_RELAXED = @as(c_int, 0);
// pub const __ATOMIC_CONSUME = @as(c_int, 1);
// pub const __ATOMIC_ACQUIRE = @as(c_int, 2);
// pub const __ATOMIC_RELEASE = @as(c_int, 3);
// pub const __ATOMIC_ACQ_REL = @as(c_int, 4);
// pub const __ATOMIC_SEQ_CST = @as(c_int, 5);
// pub const __OPENCL_MEMORY_SCOPE_WORK_ITEM = @as(c_int, 0);
// pub const __OPENCL_MEMORY_SCOPE_WORK_GROUP = @as(c_int, 1);
// pub const __OPENCL_MEMORY_SCOPE_DEVICE = @as(c_int, 2);
// pub const __OPENCL_MEMORY_SCOPE_ALL_SVM_DEVICES = @as(c_int, 3);
// pub const __OPENCL_MEMORY_SCOPE_SUB_GROUP = @as(c_int, 4);
// pub const __PRAGMA_REDEFINE_EXTNAME = @as(c_int, 1);
// pub const __VERSION__ = "Clang 12.0.1 (https://github.com/llvm/llvm-project 328a6ec955327c6d56b6bc3478c723dd3cd468ef)";
// pub const __OBJC_BOOL_IS_BOOL = @as(c_int, 0);
// pub const __CONSTANT_CFSTRINGS__ = @as(c_int, 1);
// pub const __SEH__ = @as(c_int, 1);
// pub const __OPTIMIZE__ = @as(c_int, 1);
// pub const __ORDER_LITTLE_ENDIAN__ = @as(c_int, 1234);
// pub const __ORDER_BIG_ENDIAN__ = @as(c_int, 4321);
// pub const __ORDER_PDP_ENDIAN__ = @as(c_int, 3412);
// pub const __BYTE_ORDER__ = __ORDER_LITTLE_ENDIAN__;
// pub const __LITTLE_ENDIAN__ = @as(c_int, 1);
// pub const __CHAR_BIT__ = @as(c_int, 8);
// pub const __SCHAR_MAX__ = @as(c_int, 127);
// pub const __SHRT_MAX__ = @as(c_int, 32767);
// pub const __INT_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
// pub const __LONG_MAX__ = @as(c_long, 2147483647);
// pub const __LONG_LONG_MAX__ = @as(c_longlong, 9223372036854775807);
// pub const __WCHAR_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 65535, .decimal);
// pub const __WINT_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 65535, .decimal);
// pub const __INTMAX_MAX__ = @as(c_longlong, 9223372036854775807);
// pub const __SIZE_MAX__ = @as(c_ulonglong, 18446744073709551615);
// pub const __UINTMAX_MAX__ = @as(c_ulonglong, 18446744073709551615);
// pub const __PTRDIFF_MAX__ = @as(c_longlong, 9223372036854775807);
// pub const __INTPTR_MAX__ = @as(c_longlong, 9223372036854775807);
// pub const __UINTPTR_MAX__ = @as(c_ulonglong, 18446744073709551615);
// pub const __SIZEOF_DOUBLE__ = @as(c_int, 8);
// pub const __SIZEOF_FLOAT__ = @as(c_int, 4);
// pub const __SIZEOF_INT__ = @as(c_int, 4);
// pub const __SIZEOF_LONG__ = @as(c_int, 4);
// pub const __SIZEOF_LONG_DOUBLE__ = @as(c_int, 16);
// pub const __SIZEOF_LONG_LONG__ = @as(c_int, 8);
// pub const __SIZEOF_POINTER__ = @as(c_int, 8);
// pub const __SIZEOF_SHORT__ = @as(c_int, 2);
// pub const __SIZEOF_PTRDIFF_T__ = @as(c_int, 8);
// pub const __SIZEOF_SIZE_T__ = @as(c_int, 8);
// pub const __SIZEOF_WCHAR_T__ = @as(c_int, 2);
// pub const __SIZEOF_WINT_T__ = @as(c_int, 2);
// pub const __SIZEOF_INT128__ = @as(c_int, 16);
// pub const __INTMAX_TYPE__ = c_longlong;
// pub const __INTMAX_FMTd__ = "lld";
// pub const __INTMAX_FMTi__ = "lli";
// pub const __INTMAX_C_SUFFIX__ = LL;
// pub const __UINTMAX_TYPE__ = c_ulonglong;
// pub const __UINTMAX_FMTo__ = "llo";
// pub const __UINTMAX_FMTu__ = "llu";
// pub const __UINTMAX_FMTx__ = "llx";
// pub const __UINTMAX_FMTX__ = "llX";
// pub const __UINTMAX_C_SUFFIX__ = ULL;
// pub const __INTMAX_WIDTH__ = @as(c_int, 64);
// pub const __PTRDIFF_TYPE__ = c_longlong;
// pub const __PTRDIFF_FMTd__ = "lld";
// pub const __PTRDIFF_FMTi__ = "lli";
// pub const __PTRDIFF_WIDTH__ = @as(c_int, 64);
// pub const __INTPTR_TYPE__ = c_longlong;
// pub const __INTPTR_FMTd__ = "lld";
// pub const __INTPTR_FMTi__ = "lli";
// pub const __INTPTR_WIDTH__ = @as(c_int, 64);
// pub const __SIZE_TYPE__ = c_ulonglong;
// pub const __SIZE_FMTo__ = "llo";
// pub const __SIZE_FMTu__ = "llu";
// pub const __SIZE_FMTx__ = "llx";
// pub const __SIZE_FMTX__ = "llX";
// pub const __SIZE_WIDTH__ = @as(c_int, 64);
// pub const __WCHAR_TYPE__ = c_ushort;
// pub const __WCHAR_WIDTH__ = @as(c_int, 16);
// pub const __WINT_TYPE__ = c_ushort;
// pub const __WINT_WIDTH__ = @as(c_int, 16);
// pub const __SIG_ATOMIC_WIDTH__ = @as(c_int, 32);
// pub const __SIG_ATOMIC_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
// pub const __CHAR16_TYPE__ = c_ushort;
// pub const __CHAR32_TYPE__ = c_uint;
// pub const __UINTMAX_WIDTH__ = @as(c_int, 64);
// pub const __UINTPTR_TYPE__ = c_ulonglong;
// pub const __UINTPTR_FMTo__ = "llo";
// pub const __UINTPTR_FMTu__ = "llu";
// pub const __UINTPTR_FMTx__ = "llx";
// pub const __UINTPTR_FMTX__ = "llX";
// pub const __UINTPTR_WIDTH__ = @as(c_int, 64);
// pub const __FLT_DENORM_MIN__ = @as(f32, 1.40129846e-45);
// pub const __FLT_HAS_DENORM__ = @as(c_int, 1);
// pub const __FLT_DIG__ = @as(c_int, 6);
// pub const __FLT_DECIMAL_DIG__ = @as(c_int, 9);
// pub const __FLT_EPSILON__ = @as(f32, 1.19209290e-7);
// pub const __FLT_HAS_INFINITY__ = @as(c_int, 1);
// pub const __FLT_HAS_QUIET_NAN__ = @as(c_int, 1);
// pub const __FLT_MANT_DIG__ = @as(c_int, 24);
// pub const __FLT_MAX_10_EXP__ = @as(c_int, 38);
// pub const __FLT_MAX_EXP__ = @as(c_int, 128);
// pub const __FLT_MAX__ = @as(f32, 3.40282347e+38);
// pub const __FLT_MIN_10_EXP__ = -@as(c_int, 37);
// pub const __FLT_MIN_EXP__ = -@as(c_int, 125);
// pub const __FLT_MIN__ = @as(f32, 1.17549435e-38);
// pub const __DBL_DENORM_MIN__ = 4.9406564584124654e-324;
// pub const __DBL_HAS_DENORM__ = @as(c_int, 1);
// pub const __DBL_DIG__ = @as(c_int, 15);
// pub const __DBL_DECIMAL_DIG__ = @as(c_int, 17);
// pub const __DBL_EPSILON__ = 2.2204460492503131e-16;
// pub const __DBL_HAS_INFINITY__ = @as(c_int, 1);
// pub const __DBL_HAS_QUIET_NAN__ = @as(c_int, 1);
// pub const __DBL_MANT_DIG__ = @as(c_int, 53);
// pub const __DBL_MAX_10_EXP__ = @as(c_int, 308);
// pub const __DBL_MAX_EXP__ = @as(c_int, 1024);
// pub const __DBL_MAX__ = 1.7976931348623157e+308;
// pub const __DBL_MIN_10_EXP__ = -@as(c_int, 307);
// pub const __DBL_MIN_EXP__ = -@as(c_int, 1021);
// pub const __DBL_MIN__ = 2.2250738585072014e-308;
// pub const __LDBL_DENORM_MIN__ = @as(c_longdouble, 3.64519953188247460253e-4951);
// pub const __LDBL_HAS_DENORM__ = @as(c_int, 1);
// pub const __LDBL_DIG__ = @as(c_int, 18);
// pub const __LDBL_DECIMAL_DIG__ = @as(c_int, 21);
// pub const __LDBL_EPSILON__ = @as(c_longdouble, 1.08420217248550443401e-19);
// pub const __LDBL_HAS_INFINITY__ = @as(c_int, 1);
// pub const __LDBL_HAS_QUIET_NAN__ = @as(c_int, 1);
// pub const __LDBL_MANT_DIG__ = @as(c_int, 64);
// pub const __LDBL_MAX_10_EXP__ = @as(c_int, 4932);
// pub const __LDBL_MAX_EXP__ = @as(c_int, 16384);
// pub const __LDBL_MAX__ = @as(c_longdouble, 1.18973149535723176502e+4932);
// pub const __LDBL_MIN_10_EXP__ = -@as(c_int, 4931);
// pub const __LDBL_MIN_EXP__ = -@as(c_int, 16381);
// pub const __LDBL_MIN__ = @as(c_longdouble, 3.36210314311209350626e-4932);
// pub const __POINTER_WIDTH__ = @as(c_int, 64);
// pub const __BIGGEST_ALIGNMENT__ = @as(c_int, 16);
// pub const __WCHAR_UNSIGNED__ = @as(c_int, 1);
// pub const __WINT_UNSIGNED__ = @as(c_int, 1);
// pub const __INT8_TYPE__ = i8;
// pub const __INT8_FMTd__ = "hhd";
// pub const __INT8_FMTi__ = "hhi";
// pub const __INT16_TYPE__ = c_short;
// pub const __INT16_FMTd__ = "hd";
// pub const __INT16_FMTi__ = "hi";
// pub const __INT32_TYPE__ = c_int;
// pub const __INT32_FMTd__ = "d";
// pub const __INT32_FMTi__ = "i";
// pub const __INT64_TYPE__ = c_longlong;
// pub const __INT64_FMTd__ = "lld";
// pub const __INT64_FMTi__ = "lli";
// pub const __INT64_C_SUFFIX__ = LL;
// pub const __UINT8_TYPE__ = u8;
// pub const __UINT8_FMTo__ = "hho";
// pub const __UINT8_FMTu__ = "hhu";
// pub const __UINT8_FMTx__ = "hhx";
// pub const __UINT8_FMTX__ = "hhX";
// pub const __UINT8_MAX__ = @as(c_int, 255);
// pub const __INT8_MAX__ = @as(c_int, 127);
// pub const __UINT16_TYPE__ = c_ushort;
// pub const __UINT16_FMTo__ = "ho";
// pub const __UINT16_FMTu__ = "hu";
// pub const __UINT16_FMTx__ = "hx";
// pub const __UINT16_FMTX__ = "hX";
// pub const __UINT16_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 65535, .decimal);
// pub const __INT16_MAX__ = @as(c_int, 32767);
// pub const __UINT32_TYPE__ = c_uint;
// pub const __UINT32_FMTo__ = "o";
// pub const __UINT32_FMTu__ = "u";
// pub const __UINT32_FMTx__ = "x";
// pub const __UINT32_FMTX__ = "X";
// pub const __UINT32_C_SUFFIX__ = U;
// pub const __UINT32_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_uint, 4294967295, .decimal);
// pub const __INT32_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
// pub const __UINT64_TYPE__ = c_ulonglong;
// pub const __UINT64_FMTo__ = "llo";
// pub const __UINT64_FMTu__ = "llu";
// pub const __UINT64_FMTx__ = "llx";
// pub const __UINT64_FMTX__ = "llX";
// pub const __UINT64_C_SUFFIX__ = ULL;
// pub const __UINT64_MAX__ = @as(c_ulonglong, 18446744073709551615);
// pub const __INT64_MAX__ = @as(c_longlong, 9223372036854775807);
// pub const __INT_LEAST8_TYPE__ = i8;
// pub const __INT_LEAST8_MAX__ = @as(c_int, 127);
// pub const __INT_LEAST8_FMTd__ = "hhd";
// pub const __INT_LEAST8_FMTi__ = "hhi";
// pub const __UINT_LEAST8_TYPE__ = u8;
// pub const __UINT_LEAST8_MAX__ = @as(c_int, 255);
// pub const __UINT_LEAST8_FMTo__ = "hho";
// pub const __UINT_LEAST8_FMTu__ = "hhu";
// pub const __UINT_LEAST8_FMTx__ = "hhx";
// pub const __UINT_LEAST8_FMTX__ = "hhX";
// pub const __INT_LEAST16_TYPE__ = c_short;
// pub const __INT_LEAST16_MAX__ = @as(c_int, 32767);
// pub const __INT_LEAST16_FMTd__ = "hd";
// pub const __INT_LEAST16_FMTi__ = "hi";
// pub const __UINT_LEAST16_TYPE__ = c_ushort;
// pub const __UINT_LEAST16_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 65535, .decimal);
// pub const __UINT_LEAST16_FMTo__ = "ho";
// pub const __UINT_LEAST16_FMTu__ = "hu";
// pub const __UINT_LEAST16_FMTx__ = "hx";
// pub const __UINT_LEAST16_FMTX__ = "hX";
// pub const __INT_LEAST32_TYPE__ = c_int;
// pub const __INT_LEAST32_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
// pub const __INT_LEAST32_FMTd__ = "d";
// pub const __INT_LEAST32_FMTi__ = "i";
// pub const __UINT_LEAST32_TYPE__ = c_uint;
// pub const __UINT_LEAST32_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_uint, 4294967295, .decimal);
// pub const __UINT_LEAST32_FMTo__ = "o";
// pub const __UINT_LEAST32_FMTu__ = "u";
// pub const __UINT_LEAST32_FMTx__ = "x";
// pub const __UINT_LEAST32_FMTX__ = "X";
// pub const __INT_LEAST64_TYPE__ = c_longlong;
// pub const __INT_LEAST64_MAX__ = @as(c_longlong, 9223372036854775807);
// pub const __INT_LEAST64_FMTd__ = "lld";
// pub const __INT_LEAST64_FMTi__ = "lli";
// pub const __UINT_LEAST64_TYPE__ = c_ulonglong;
// pub const __UINT_LEAST64_MAX__ = @as(c_ulonglong, 18446744073709551615);
// pub const __UINT_LEAST64_FMTo__ = "llo";
// pub const __UINT_LEAST64_FMTu__ = "llu";
// pub const __UINT_LEAST64_FMTx__ = "llx";
// pub const __UINT_LEAST64_FMTX__ = "llX";
// pub const __INT_FAST8_TYPE__ = i8;
// pub const __INT_FAST8_MAX__ = @as(c_int, 127);
// pub const __INT_FAST8_FMTd__ = "hhd";
// pub const __INT_FAST8_FMTi__ = "hhi";
// pub const __UINT_FAST8_TYPE__ = u8;
// pub const __UINT_FAST8_MAX__ = @as(c_int, 255);
// pub const __UINT_FAST8_FMTo__ = "hho";
// pub const __UINT_FAST8_FMTu__ = "hhu";
// pub const __UINT_FAST8_FMTx__ = "hhx";
// pub const __UINT_FAST8_FMTX__ = "hhX";
// pub const __INT_FAST16_TYPE__ = c_short;
// pub const __INT_FAST16_MAX__ = @as(c_int, 32767);
// pub const __INT_FAST16_FMTd__ = "hd";
// pub const __INT_FAST16_FMTi__ = "hi";
// pub const __UINT_FAST16_TYPE__ = c_ushort;
// pub const __UINT_FAST16_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 65535, .decimal);
// pub const __UINT_FAST16_FMTo__ = "ho";
// pub const __UINT_FAST16_FMTu__ = "hu";
// pub const __UINT_FAST16_FMTx__ = "hx";
// pub const __UINT_FAST16_FMTX__ = "hX";
// pub const __INT_FAST32_TYPE__ = c_int;
// pub const __INT_FAST32_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
// pub const __INT_FAST32_FMTd__ = "d";
// pub const __INT_FAST32_FMTi__ = "i";
// pub const __UINT_FAST32_TYPE__ = c_uint;
// pub const __UINT_FAST32_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_uint, 4294967295, .decimal);
// pub const __UINT_FAST32_FMTo__ = "o";
// pub const __UINT_FAST32_FMTu__ = "u";
// pub const __UINT_FAST32_FMTx__ = "x";
// pub const __UINT_FAST32_FMTX__ = "X";
// pub const __INT_FAST64_TYPE__ = c_longlong;
// pub const __INT_FAST64_MAX__ = @as(c_longlong, 9223372036854775807);
// pub const __INT_FAST64_FMTd__ = "lld";
// pub const __INT_FAST64_FMTi__ = "lli";
// pub const __UINT_FAST64_TYPE__ = c_ulonglong;
// pub const __UINT_FAST64_MAX__ = @as(c_ulonglong, 18446744073709551615);
// pub const __UINT_FAST64_FMTo__ = "llo";
// pub const __UINT_FAST64_FMTu__ = "llu";
// pub const __UINT_FAST64_FMTx__ = "llx";
// pub const __UINT_FAST64_FMTX__ = "llX";
// pub const __FINITE_MATH_ONLY__ = @as(c_int, 0);
// pub const __GNUC_STDC_INLINE__ = @as(c_int, 1);
// pub const __GCC_ATOMIC_TEST_AND_SET_TRUEVAL = @as(c_int, 1);
// pub const __CLANG_ATOMIC_BOOL_LOCK_FREE = @as(c_int, 2);
// pub const __CLANG_ATOMIC_CHAR_LOCK_FREE = @as(c_int, 2);
// pub const __CLANG_ATOMIC_CHAR16_T_LOCK_FREE = @as(c_int, 2);
// pub const __CLANG_ATOMIC_CHAR32_T_LOCK_FREE = @as(c_int, 2);
// pub const __CLANG_ATOMIC_WCHAR_T_LOCK_FREE = @as(c_int, 2);
// pub const __CLANG_ATOMIC_SHORT_LOCK_FREE = @as(c_int, 2);
// pub const __CLANG_ATOMIC_INT_LOCK_FREE = @as(c_int, 2);
// pub const __CLANG_ATOMIC_LONG_LOCK_FREE = @as(c_int, 2);
// pub const __CLANG_ATOMIC_LLONG_LOCK_FREE = @as(c_int, 2);
// pub const __CLANG_ATOMIC_POINTER_LOCK_FREE = @as(c_int, 2);
// pub const __GCC_ATOMIC_BOOL_LOCK_FREE = @as(c_int, 2);
// pub const __GCC_ATOMIC_CHAR_LOCK_FREE = @as(c_int, 2);
// pub const __GCC_ATOMIC_CHAR16_T_LOCK_FREE = @as(c_int, 2);
// pub const __GCC_ATOMIC_CHAR32_T_LOCK_FREE = @as(c_int, 2);
// pub const __GCC_ATOMIC_WCHAR_T_LOCK_FREE = @as(c_int, 2);
// pub const __GCC_ATOMIC_SHORT_LOCK_FREE = @as(c_int, 2);
// pub const __GCC_ATOMIC_INT_LOCK_FREE = @as(c_int, 2);
// pub const __GCC_ATOMIC_LONG_LOCK_FREE = @as(c_int, 2);
// pub const __GCC_ATOMIC_LLONG_LOCK_FREE = @as(c_int, 2);
// pub const __GCC_ATOMIC_POINTER_LOCK_FREE = @as(c_int, 2);
// pub const __PIC__ = @as(c_int, 2);
// pub const __pic__ = @as(c_int, 2);
// pub const __FLT_EVAL_METHOD__ = @as(c_int, 0);
// pub const __FLT_RADIX__ = @as(c_int, 2);
// pub const __DECIMAL_DIG__ = __LDBL_DECIMAL_DIG__;
// pub const __SSP_STRONG__ = @as(c_int, 2);
// pub const __GCC_ASM_FLAG_OUTPUTS__ = @as(c_int, 1);
// pub const __code_model_small__ = @as(c_int, 1);
// pub const __amd64__ = @as(c_int, 1);
// pub const __amd64 = @as(c_int, 1);
// pub const __x86_64 = @as(c_int, 1);
// pub const __x86_64__ = @as(c_int, 1);
// pub const __SEG_GS = @as(c_int, 1);
// pub const __SEG_FS = @as(c_int, 1);
// pub const __seg_gs = __attribute__(address_space(@as(c_int, 256)));
// pub const __seg_fs = __attribute__(address_space(@as(c_int, 257)));
// pub const __corei7 = @as(c_int, 1);
// pub const __corei7__ = @as(c_int, 1);
// pub const __tune_corei7__ = @as(c_int, 1);
// pub const __NO_MATH_INLINES = @as(c_int, 1);
// pub const __AES__ = @as(c_int, 1);
// pub const __PCLMUL__ = @as(c_int, 1);
// pub const __LAHF_SAHF__ = @as(c_int, 1);
// pub const __LZCNT__ = @as(c_int, 1);
// pub const __RDRND__ = @as(c_int, 1);
// pub const __FSGSBASE__ = @as(c_int, 1);
// pub const __BMI__ = @as(c_int, 1);
// pub const __BMI2__ = @as(c_int, 1);
// pub const __POPCNT__ = @as(c_int, 1);
// pub const __RTM__ = @as(c_int, 1);
// pub const __PRFCHW__ = @as(c_int, 1);
// pub const __RDSEED__ = @as(c_int, 1);
// pub const __ADX__ = @as(c_int, 1);
// pub const __MOVBE__ = @as(c_int, 1);
// pub const __FMA__ = @as(c_int, 1);
// pub const __F16C__ = @as(c_int, 1);
// pub const __FXSR__ = @as(c_int, 1);
// pub const __XSAVE__ = @as(c_int, 1);
// pub const __XSAVEOPT__ = @as(c_int, 1);
// pub const __XSAVEC__ = @as(c_int, 1);
// pub const __XSAVES__ = @as(c_int, 1);
// pub const __CLFLUSHOPT__ = @as(c_int, 1);
// pub const __SGX__ = @as(c_int, 1);
// pub const __INVPCID__ = @as(c_int, 1);
// pub const __AVX2__ = @as(c_int, 1);
// pub const __AVX__ = @as(c_int, 1);
// pub const __SSE4_2__ = @as(c_int, 1);
// pub const __SSE4_1__ = @as(c_int, 1);
// pub const __SSSE3__ = @as(c_int, 1);
// pub const __SSE3__ = @as(c_int, 1);
// pub const __SSE2__ = @as(c_int, 1);
// pub const __SSE2_MATH__ = @as(c_int, 1);
// pub const __SSE__ = @as(c_int, 1);
// pub const __SSE_MATH__ = @as(c_int, 1);
// pub const __MMX__ = @as(c_int, 1);
// pub const __GCC_HAVE_SYNC_COMPARE_AND_SWAP_1 = @as(c_int, 1);
// pub const __GCC_HAVE_SYNC_COMPARE_AND_SWAP_2 = @as(c_int, 1);
// pub const __GCC_HAVE_SYNC_COMPARE_AND_SWAP_4 = @as(c_int, 1);
// pub const __GCC_HAVE_SYNC_COMPARE_AND_SWAP_8 = @as(c_int, 1);
// pub const __GCC_HAVE_SYNC_COMPARE_AND_SWAP_16 = @as(c_int, 1);
// pub const __SIZEOF_FLOAT128__ = @as(c_int, 16);
// pub const _WIN32 = @as(c_int, 1);
// pub const _WIN64 = @as(c_int, 1);
// pub const WIN32 = @as(c_int, 1);
// pub const __WIN32 = @as(c_int, 1);
// pub const __WIN32__ = @as(c_int, 1);
// pub const WINNT = @as(c_int, 1);
// pub const __WINNT = @as(c_int, 1);
// pub const __WINNT__ = @as(c_int, 1);
// pub const WIN64 = @as(c_int, 1);
// pub const __WIN64 = @as(c_int, 1);
// pub const __WIN64__ = @as(c_int, 1);
// pub const __MINGW64__ = @as(c_int, 1);
// pub const __MSVCRT__ = @as(c_int, 1);
// pub const __MINGW32__ = @as(c_int, 1);
//  const _cdecl = __attribute__(__cdecl__);
//  const __cdecl = __attribute__(__cdecl__);
//  const _stdcall = __attribute__(__stdcall__);
//  const _fastcall = __attribute__(__fastcall__);
//  const __fastcall = __attribute__(__fastcall__);
//  const _thiscall = __attribute__(__thiscall__);
//  const __thiscall = __attribute__(__thiscall__);
//  const _pascal = __attribute__(__pascal__);
//  const __pascal = __attribute__(__pascal__);
//  const __STDC__ = @as(c_int, 1);
//  const __STDC_HOSTED__ = @as(c_int, 1);
//  const __STDC_VERSION__ = @as(c_long, 201710);
//  const __STDC_UTF_16__ = @as(c_int, 1);
//  const __STDC_UTF_32__ = @as(c_int, 1);
//  const _DEBUG = @as(c_int, 1);
pub const FMOD_VERSION = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00020110, .hexadecimal);
pub const FMOD_DEBUG_LEVEL_NONE = @as(c_int, 0x00000000);
pub const FMOD_DEBUG_LEVEL_ERROR = @as(c_int, 0x00000001);
pub const FMOD_DEBUG_LEVEL_WARNING = @as(c_int, 0x00000002);
pub const FMOD_DEBUG_LEVEL_LOG = @as(c_int, 0x00000004);
pub const FMOD_DEBUG_TYPE_MEMORY = @as(c_int, 0x00000100);
pub const FMOD_DEBUG_TYPE_FILE = @as(c_int, 0x00000200);
pub const FMOD_DEBUG_TYPE_CODEC = @as(c_int, 0x00000400);
pub const FMOD_DEBUG_TYPE_TRACE = @as(c_int, 0x00000800);
pub const FMOD_DEBUG_DISPLAY_TIMESTAMPS = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00010000, .hexadecimal);
pub const FMOD_DEBUG_DISPLAY_LINENUMBERS = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00020000, .hexadecimal);
pub const FMOD_DEBUG_DISPLAY_THREAD = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00040000, .hexadecimal);
pub const FMOD_MEMORY_NORMAL = @as(c_int, 0x00000000);
pub const FMOD_MEMORY_STREAM_FILE = @as(c_int, 0x00000001);
pub const FMOD_MEMORY_STREAM_DECODE = @as(c_int, 0x00000002);
pub const FMOD_MEMORY_SAMPLEDATA = @as(c_int, 0x00000004);
pub const FMOD_MEMORY_DSP_BUFFER = @as(c_int, 0x00000008);
pub const FMOD_MEMORY_PLUGIN = @as(c_int, 0x00000010);
pub const FMOD_MEMORY_PERSISTENT = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00200000, .hexadecimal);
pub const FMOD_MEMORY_ALL = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0xFFFFFFFF, .hexadecimal);
pub const FMOD_INIT_NORMAL = @as(c_int, 0x00000000);
pub const FMOD_INIT_STREAM_FROM_UPDATE = @as(c_int, 0x00000001);
pub const FMOD_INIT_MIX_FROM_UPDATE = @as(c_int, 0x00000002);
pub const FMOD_INIT_3D_RIGHTHANDED = @as(c_int, 0x00000004);
pub const FMOD_INIT_CHANNEL_LOWPASS = @as(c_int, 0x00000100);
pub const FMOD_INIT_CHANNEL_DISTANCEFILTER = @as(c_int, 0x00000200);
pub const FMOD_INIT_PROFILE_ENABLE = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00010000, .hexadecimal);
pub const FMOD_INIT_VOL0_BECOMES_VIRTUAL = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00020000, .hexadecimal);
pub const FMOD_INIT_GEOMETRY_USECLOSEST = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00040000, .hexadecimal);
pub const FMOD_INIT_PREFER_DOLBY_DOWNMIX = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00080000, .hexadecimal);
pub const FMOD_INIT_THREAD_UNSAFE = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00100000, .hexadecimal);
pub const FMOD_INIT_PROFILE_METER_ALL = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00200000, .hexadecimal);
pub const FMOD_INIT_MEMORY_TRACKING = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00400000, .hexadecimal);
pub const FMOD_DRIVER_STATE_CONNECTED = @as(c_int, 0x00000001);
pub const FMOD_DRIVER_STATE_DEFAULT = @as(c_int, 0x00000002);
pub const FMOD_TIMEUNIT_MS = @as(c_int, 0x00000001);
pub const FMOD_TIMEUNIT_PCM = @as(c_int, 0x00000002);
pub const FMOD_TIMEUNIT_PCMBYTES = @as(c_int, 0x00000004);
pub const FMOD_TIMEUNIT_RAWBYTES = @as(c_int, 0x00000008);
pub const FMOD_TIMEUNIT_PCMFRACTION = @as(c_int, 0x00000010);
pub const FMOD_TIMEUNIT_MODORDER = @as(c_int, 0x00000100);
pub const FMOD_TIMEUNIT_MODROW = @as(c_int, 0x00000200);
pub const FMOD_TIMEUNIT_MODPATTERN = @as(c_int, 0x00000400);
pub const FMOD_SYSTEM_CALLBACK_DEVICELISTCHANGED = @as(c_int, 0x00000001);
pub const FMOD_SYSTEM_CALLBACK_DEVICELOST = @as(c_int, 0x00000002);
pub const FMOD_SYSTEM_CALLBACK_MEMORYALLOCATIONFAILED = @as(c_int, 0x00000004);
pub const FMOD_SYSTEM_CALLBACK_THREADCREATED = @as(c_int, 0x00000008);
pub const FMOD_SYSTEM_CALLBACK_BADDSPCONNECTION = @as(c_int, 0x00000010);
pub const FMOD_SYSTEM_CALLBACK_PREMIX = @as(c_int, 0x00000020);
pub const FMOD_SYSTEM_CALLBACK_POSTMIX = @as(c_int, 0x00000040);
pub const FMOD_SYSTEM_CALLBACK_ERROR = @as(c_int, 0x00000080);
pub const FMOD_SYSTEM_CALLBACK_MIDMIX = @as(c_int, 0x00000100);
pub const FMOD_SYSTEM_CALLBACK_THREADDESTROYED = @as(c_int, 0x00000200);
pub const FMOD_SYSTEM_CALLBACK_PREUPDATE = @as(c_int, 0x00000400);
pub const FMOD_SYSTEM_CALLBACK_POSTUPDATE = @as(c_int, 0x00000800);
pub const FMOD_SYSTEM_CALLBACK_RECORDLISTCHANGED = @as(c_int, 0x00001000);
pub const FMOD_SYSTEM_CALLBACK_BUFFEREDNOMIX = @as(c_int, 0x00002000);
pub const FMOD_SYSTEM_CALLBACK_DEVICEREINITIALIZE = @as(c_int, 0x00004000);
pub const FMOD_SYSTEM_CALLBACK_OUTPUTUNDERRUN = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00008000, .hexadecimal);
pub const FMOD_SYSTEM_CALLBACK_ALL = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0xFFFFFFFF, .hexadecimal);
pub const FMOD_DEFAULT = @as(c_int, 0x00000000);
pub const FMOD_LOOP_OFF = @as(c_int, 0x00000001);
pub const FMOD_LOOP_NORMAL = @as(c_int, 0x00000002);
pub const FMOD_LOOP_BIDI = @as(c_int, 0x00000004);
pub const FMOD_2D = @as(c_int, 0x00000008);
pub const FMOD_3D = @as(c_int, 0x00000010);
pub const FMOD_CREATESTREAM = @as(c_int, 0x00000080);
pub const FMOD_CREATESAMPLE = @as(c_int, 0x00000100);
pub const FMOD_CREATECOMPRESSEDSAMPLE = @as(c_int, 0x00000200);
pub const FMOD_OPENUSER = @as(c_int, 0x00000400);
pub const FMOD_OPENMEMORY = @as(c_int, 0x00000800);
pub const FMOD_OPENMEMORY_POINT = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x10000000, .hexadecimal);
pub const FMOD_OPENRAW = @as(c_int, 0x00001000);
pub const FMOD_OPENONLY = @as(c_int, 0x00002000);
pub const FMOD_ACCURATETIME = @as(c_int, 0x00004000);
pub const FMOD_MPEGSEARCH = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00008000, .hexadecimal);
pub const FMOD_NONBLOCKING = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00010000, .hexadecimal);
pub const FMOD_UNIQUE = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00020000, .hexadecimal);
pub const FMOD_3D_HEADRELATIVE = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00040000, .hexadecimal);
pub const FMOD_3D_WORLDRELATIVE = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00080000, .hexadecimal);
pub const FMOD_3D_INVERSEROLLOFF = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00100000, .hexadecimal);
pub const FMOD_3D_LINEARROLLOFF = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00200000, .hexadecimal);
pub const FMOD_3D_LINEARSQUAREROLLOFF = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00400000, .hexadecimal);
pub const FMOD_3D_INVERSETAPEREDROLLOFF = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00800000, .hexadecimal);
pub const FMOD_3D_CUSTOMROLLOFF = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x04000000, .hexadecimal);
pub const FMOD_3D_IGNOREGEOMETRY = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x40000000, .hexadecimal);
pub const FMOD_IGNORETAGS = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x02000000, .hexadecimal);
pub const FMOD_LOWMEM = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x08000000, .hexadecimal);
pub const FMOD_VIRTUAL_PLAYFROMSTART = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x80000000, .hexadecimal);
pub const FMOD_CHANNELMASK_FRONT_LEFT = @as(c_int, 0x00000001);
pub const FMOD_CHANNELMASK_FRONT_RIGHT = @as(c_int, 0x00000002);
pub const FMOD_CHANNELMASK_FRONT_CENTER = @as(c_int, 0x00000004);
pub const FMOD_CHANNELMASK_LOW_FREQUENCY = @as(c_int, 0x00000008);
pub const FMOD_CHANNELMASK_SURROUND_LEFT = @as(c_int, 0x00000010);
pub const FMOD_CHANNELMASK_SURROUND_RIGHT = @as(c_int, 0x00000020);
pub const FMOD_CHANNELMASK_BACK_LEFT = @as(c_int, 0x00000040);
pub const FMOD_CHANNELMASK_BACK_RIGHT = @as(c_int, 0x00000080);
pub const FMOD_CHANNELMASK_BACK_CENTER = @as(c_int, 0x00000100);
pub const FMOD_CHANNELMASK_MONO = FMOD_CHANNELMASK_FRONT_LEFT;
pub const FMOD_CHANNELMASK_STEREO = FMOD_CHANNELMASK_FRONT_LEFT | FMOD_CHANNELMASK_FRONT_RIGHT;
pub const FMOD_CHANNELMASK_LRC = (FMOD_CHANNELMASK_FRONT_LEFT | FMOD_CHANNELMASK_FRONT_RIGHT) | FMOD_CHANNELMASK_FRONT_CENTER;
pub const FMOD_CHANNELMASK_QUAD = ((FMOD_CHANNELMASK_FRONT_LEFT | FMOD_CHANNELMASK_FRONT_RIGHT) | FMOD_CHANNELMASK_SURROUND_LEFT) | FMOD_CHANNELMASK_SURROUND_RIGHT;
pub const FMOD_CHANNELMASK_SURROUND = (((FMOD_CHANNELMASK_FRONT_LEFT | FMOD_CHANNELMASK_FRONT_RIGHT) | FMOD_CHANNELMASK_FRONT_CENTER) | FMOD_CHANNELMASK_SURROUND_LEFT) | FMOD_CHANNELMASK_SURROUND_RIGHT;
pub const FMOD_CHANNELMASK_5POINT1 = ((((FMOD_CHANNELMASK_FRONT_LEFT | FMOD_CHANNELMASK_FRONT_RIGHT) | FMOD_CHANNELMASK_FRONT_CENTER) | FMOD_CHANNELMASK_LOW_FREQUENCY) | FMOD_CHANNELMASK_SURROUND_LEFT) | FMOD_CHANNELMASK_SURROUND_RIGHT;
pub const FMOD_CHANNELMASK_5POINT1_REARS = ((((FMOD_CHANNELMASK_FRONT_LEFT | FMOD_CHANNELMASK_FRONT_RIGHT) | FMOD_CHANNELMASK_FRONT_CENTER) | FMOD_CHANNELMASK_LOW_FREQUENCY) | FMOD_CHANNELMASK_BACK_LEFT) | FMOD_CHANNELMASK_BACK_RIGHT;
pub const FMOD_CHANNELMASK_7POINT0 = (((((FMOD_CHANNELMASK_FRONT_LEFT | FMOD_CHANNELMASK_FRONT_RIGHT) | FMOD_CHANNELMASK_FRONT_CENTER) | FMOD_CHANNELMASK_SURROUND_LEFT) | FMOD_CHANNELMASK_SURROUND_RIGHT) | FMOD_CHANNELMASK_BACK_LEFT) | FMOD_CHANNELMASK_BACK_RIGHT;
pub const FMOD_CHANNELMASK_7POINT1 = ((((((FMOD_CHANNELMASK_FRONT_LEFT | FMOD_CHANNELMASK_FRONT_RIGHT) | FMOD_CHANNELMASK_FRONT_CENTER) | FMOD_CHANNELMASK_LOW_FREQUENCY) | FMOD_CHANNELMASK_SURROUND_LEFT) | FMOD_CHANNELMASK_SURROUND_RIGHT) | FMOD_CHANNELMASK_BACK_LEFT) | FMOD_CHANNELMASK_BACK_RIGHT;
pub const FMOD_THREAD_PRIORITY_PLATFORM_MIN = -@as(c_int, 32) * @as(c_int, 1024);
pub const FMOD_THREAD_PRIORITY_PLATFORM_MAX = @as(c_int, 32) * @as(c_int, 1024);
pub const FMOD_THREAD_PRIORITY_DEFAULT = FMOD_THREAD_PRIORITY_PLATFORM_MIN - @as(c_int, 1);
pub const FMOD_THREAD_PRIORITY_LOW = FMOD_THREAD_PRIORITY_PLATFORM_MIN - @as(c_int, 2);
pub const FMOD_THREAD_PRIORITY_MEDIUM = FMOD_THREAD_PRIORITY_PLATFORM_MIN - @as(c_int, 3);
pub const FMOD_THREAD_PRIORITY_HIGH = FMOD_THREAD_PRIORITY_PLATFORM_MIN - @as(c_int, 4);
pub const FMOD_THREAD_PRIORITY_VERY_HIGH = FMOD_THREAD_PRIORITY_PLATFORM_MIN - @as(c_int, 5);
pub const FMOD_THREAD_PRIORITY_EXTREME = FMOD_THREAD_PRIORITY_PLATFORM_MIN - @as(c_int, 6);
pub const FMOD_THREAD_PRIORITY_CRITICAL = FMOD_THREAD_PRIORITY_PLATFORM_MIN - @as(c_int, 7);
pub const FMOD_THREAD_PRIORITY_MIXER = FMOD_THREAD_PRIORITY_EXTREME;
pub const FMOD_THREAD_PRIORITY_FEEDER = FMOD_THREAD_PRIORITY_CRITICAL;
pub const FMOD_THREAD_PRIORITY_STREAM = FMOD_THREAD_PRIORITY_VERY_HIGH;
pub const FMOD_THREAD_PRIORITY_FILE = FMOD_THREAD_PRIORITY_HIGH;
pub const FMOD_THREAD_PRIORITY_NONBLOCKING = FMOD_THREAD_PRIORITY_HIGH;
pub const FMOD_THREAD_PRIORITY_RECORD = FMOD_THREAD_PRIORITY_HIGH;
pub const FMOD_THREAD_PRIORITY_GEOMETRY = FMOD_THREAD_PRIORITY_LOW;
pub const FMOD_THREAD_PRIORITY_PROFILER = FMOD_THREAD_PRIORITY_MEDIUM;
pub const FMOD_THREAD_PRIORITY_STUDIO_UPDATE = FMOD_THREAD_PRIORITY_MEDIUM;
pub const FMOD_THREAD_PRIORITY_STUDIO_LOAD_BANK = FMOD_THREAD_PRIORITY_MEDIUM;
pub const FMOD_THREAD_PRIORITY_STUDIO_LOAD_SAMPLE = FMOD_THREAD_PRIORITY_MEDIUM;
pub const FMOD_THREAD_PRIORITY_CONVOLUTION1 = FMOD_THREAD_PRIORITY_VERY_HIGH;
pub const FMOD_THREAD_PRIORITY_CONVOLUTION2 = FMOD_THREAD_PRIORITY_VERY_HIGH;
pub const FMOD_THREAD_STACK_SIZE_DEFAULT = @as(c_int, 0);
pub const FMOD_THREAD_STACK_SIZE_MIXER = @as(c_int, 80) * @as(c_int, 1024);
pub const FMOD_THREAD_STACK_SIZE_FEEDER = @as(c_int, 16) * @as(c_int, 1024);
pub const FMOD_THREAD_STACK_SIZE_STREAM = @as(c_int, 96) * @as(c_int, 1024);
pub const FMOD_THREAD_STACK_SIZE_FILE = @as(c_int, 48) * @as(c_int, 1024);
pub const FMOD_THREAD_STACK_SIZE_NONBLOCKING = @as(c_int, 112) * @as(c_int, 1024);
pub const FMOD_THREAD_STACK_SIZE_RECORD = @as(c_int, 16) * @as(c_int, 1024);
pub const FMOD_THREAD_STACK_SIZE_GEOMETRY = @as(c_int, 48) * @as(c_int, 1024);
pub const FMOD_THREAD_STACK_SIZE_PROFILER = @as(c_int, 128) * @as(c_int, 1024);
pub const FMOD_THREAD_STACK_SIZE_STUDIO_UPDATE = @as(c_int, 96) * @as(c_int, 1024);
pub const FMOD_THREAD_STACK_SIZE_STUDIO_LOAD_BANK = @as(c_int, 96) * @as(c_int, 1024);
pub const FMOD_THREAD_STACK_SIZE_STUDIO_LOAD_SAMPLE = @as(c_int, 96) * @as(c_int, 1024);
pub const FMOD_THREAD_STACK_SIZE_CONVOLUTION1 = @as(c_int, 16) * @as(c_int, 1024);
pub const FMOD_THREAD_STACK_SIZE_CONVOLUTION2 = @as(c_int, 16) * @as(c_int, 1024);
pub const FMOD_THREAD_AFFINITY_GROUP_DEFAULT = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x8000000000000000, .hexadecimal);
pub const FMOD_THREAD_AFFINITY_GROUP_A = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x8000000000000001, .hexadecimal);
pub const FMOD_THREAD_AFFINITY_GROUP_B = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x8000000000000002, .hexadecimal);
pub const FMOD_THREAD_AFFINITY_GROUP_C = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x8000000000000003, .hexadecimal);
pub const FMOD_THREAD_AFFINITY_MIXER = FMOD_THREAD_AFFINITY_GROUP_A;
pub const FMOD_THREAD_AFFINITY_FEEDER = FMOD_THREAD_AFFINITY_GROUP_C;
pub const FMOD_THREAD_AFFINITY_STREAM = FMOD_THREAD_AFFINITY_GROUP_C;
pub const FMOD_THREAD_AFFINITY_FILE = FMOD_THREAD_AFFINITY_GROUP_C;
pub const FMOD_THREAD_AFFINITY_NONBLOCKING = FMOD_THREAD_AFFINITY_GROUP_C;
pub const FMOD_THREAD_AFFINITY_RECORD = FMOD_THREAD_AFFINITY_GROUP_C;
pub const FMOD_THREAD_AFFINITY_GEOMETRY = FMOD_THREAD_AFFINITY_GROUP_C;
pub const FMOD_THREAD_AFFINITY_PROFILER = FMOD_THREAD_AFFINITY_GROUP_C;
pub const FMOD_THREAD_AFFINITY_STUDIO_UPDATE = FMOD_THREAD_AFFINITY_GROUP_B;
pub const FMOD_THREAD_AFFINITY_STUDIO_LOAD_BANK = FMOD_THREAD_AFFINITY_GROUP_C;
pub const FMOD_THREAD_AFFINITY_STUDIO_LOAD_SAMPLE = FMOD_THREAD_AFFINITY_GROUP_C;
pub const FMOD_THREAD_AFFINITY_CONVOLUTION1 = FMOD_THREAD_AFFINITY_GROUP_C;
pub const FMOD_THREAD_AFFINITY_CONVOLUTION2 = FMOD_THREAD_AFFINITY_GROUP_C;
pub const FMOD_THREAD_AFFINITY_CORE_ALL = @as(c_int, 0);
pub const FMOD_THREAD_AFFINITY_CORE_0 = @as(c_int, 1) << @as(c_int, 0);
pub const FMOD_THREAD_AFFINITY_CORE_1 = @as(c_int, 1) << @as(c_int, 1);
pub const FMOD_THREAD_AFFINITY_CORE_2 = @as(c_int, 1) << @as(c_int, 2);
pub const FMOD_THREAD_AFFINITY_CORE_3 = @as(c_int, 1) << @as(c_int, 3);
pub const FMOD_THREAD_AFFINITY_CORE_4 = @as(c_int, 1) << @as(c_int, 4);
pub const FMOD_THREAD_AFFINITY_CORE_5 = @as(c_int, 1) << @as(c_int, 5);
pub const FMOD_THREAD_AFFINITY_CORE_6 = @as(c_int, 1) << @as(c_int, 6);
pub const FMOD_THREAD_AFFINITY_CORE_7 = @as(c_int, 1) << @as(c_int, 7);
pub const FMOD_THREAD_AFFINITY_CORE_8 = @as(c_int, 1) << @as(c_int, 8);
pub const FMOD_THREAD_AFFINITY_CORE_9 = @as(c_int, 1) << @as(c_int, 9);
pub const FMOD_THREAD_AFFINITY_CORE_10 = @as(c_int, 1) << @as(c_int, 10);
pub const FMOD_THREAD_AFFINITY_CORE_11 = @as(c_int, 1) << @as(c_int, 11);
pub const FMOD_THREAD_AFFINITY_CORE_12 = @as(c_int, 1) << @as(c_int, 12);
pub const FMOD_THREAD_AFFINITY_CORE_13 = @as(c_int, 1) << @as(c_int, 13);
pub const FMOD_THREAD_AFFINITY_CORE_14 = @as(c_int, 1) << @as(c_int, 14);
pub const FMOD_THREAD_AFFINITY_CORE_15 = @as(c_int, 1) << @as(c_int, 15);
pub const FMOD_MAX_CHANNEL_WIDTH = @as(c_int, 32);
pub const FMOD_MAX_SYSTEMS = @as(c_int, 8);
pub const FMOD_MAX_LISTENERS = @as(c_int, 8);
pub const FMOD_REVERB_MAXINSTANCES = @as(c_int, 4);
pub const FMOD_PORT_INDEX_NONE = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0xFFFFFFFFFFFFFFFF, .hexadecimal);
pub const FMOD_CODEC_WAVEFORMAT_VERSION = @as(c_int, 3);
pub const FMOD_DSP_LOUDNESS_METER_HISTOGRAM_SAMPLES = @as(c_int, 66);
pub const FMOD_PLUGIN_SDK_VERSION = @as(c_int, 110);
pub const FMOD_DSP_GETPARAM_VALUESTR_LENGTH = @as(c_int, 32);
// pub inline fn FMOD_DSP_ALLOC(_state: anytype, _size: anytype) @TypeOf(_state.*.functions.*.alloc(_size, FMOD_MEMORY_NORMAL, __FILE__)) {
//     return _state.*.functions.*.alloc(_size, FMOD_MEMORY_NORMAL, __FILE__);
// }
// pub inline fn FMOD_DSP_REALLOC(_state: anytype, _ptr: anytype, _size: anytype) @TypeOf(_state.*.functions.*.realloc(_ptr, _size, FMOD_MEMORY_NORMAL, __FILE__)) {
//     return _state.*.functions.*.realloc(_ptr, _size, FMOD_MEMORY_NORMAL, __FILE__);
// }
// pub inline fn FMOD_DSP_FREE(_state: anytype, _ptr: anytype) @TypeOf(_state.*.functions.*.free(_ptr, FMOD_MEMORY_NORMAL, __FILE__)) {
//     return _state.*.functions.*.free(_ptr, FMOD_MEMORY_NORMAL, __FILE__);
// }
// pub inline fn FMOD_DSP_GETSAMPLERATE(_state: anytype, _rate: anytype) @TypeOf(_state.*.functions.*.getsamplerate(_state, _rate)) {
//     return _state.*.functions.*.getsamplerate(_state, _rate);
// }
// pub inline fn FMOD_DSP_GETBLOCKSIZE(_state: anytype, _blocksize: anytype) @TypeOf(_state.*.functions.*.getblocksize(_state, _blocksize)) {
//     return _state.*.functions.*.getblocksize(_state, _blocksize);
// }
// pub inline fn FMOD_DSP_GETSPEAKERMODE(_state: anytype, _speakermodemix: anytype, _speakermodeout: anytype) @TypeOf(_state.*.functions.*.getspeakermode(_state, _speakermodemix, _speakermodeout)) {
//     return _state.*.functions.*.getspeakermode(_state, _speakermodemix, _speakermodeout);
// }
// pub inline fn FMOD_DSP_GETCLOCK(_state: anytype, _clock: anytype, _offset: anytype, _length: anytype) @TypeOf(_state.*.functions.*.getclock(_state, _clock, _offset, _length)) {
//     return _state.*.functions.*.getclock(_state, _clock, _offset, _length);
// }
// pub inline fn FMOD_DSP_GETLISTENERATTRIBUTES(_state: anytype, _numlisteners: anytype, _attributes: anytype) @TypeOf(_state.*.functions.*.getlistenerattributes(_state, _numlisteners, _attributes)) {
//     return _state.*.functions.*.getlistenerattributes(_state, _numlisteners, _attributes);
// }
// pub inline fn FMOD_DSP_GETUSERDATA(_state: anytype, _userdata: anytype) @TypeOf(_state.*.functions.*.getuserdata(_state, _userdata)) {
//     return _state.*.functions.*.getuserdata(_state, _userdata);
// }
// pub inline fn FMOD_DSP_DFT_FFTREAL(_state: anytype, _size: anytype, _signal: anytype, _dft: anytype, _window: anytype, _signalhop: anytype) @TypeOf(_state.*.functions.*.dft.*.fftreal(_state, _size, _signal, _dft, _window, _signalhop)) {
//     return _state.*.functions.*.dft.*.fftreal(_state, _size, _signal, _dft, _window, _signalhop);
// }
// pub inline fn FMOD_DSP_DFT_IFFTREAL(_state: anytype, _size: anytype, _dft: anytype, _signal: anytype, _window: anytype, _signalhop: anytype) @TypeOf(_state.*.functions.*.dft.*.inversefftreal(_state, _size, _dft, _signal, _window, _signalhop)) {
//     return _state.*.functions.*.dft.*.inversefftreal(_state, _size, _dft, _signal, _window, _signalhop);
// }
// pub inline fn FMOD_DSP_PAN_SUMMONOMATRIX(_state: anytype, _sourcespeakermode: anytype, _lowfrequencygain: anytype, _overallgain: anytype, _matrix: anytype) @TypeOf(_state.*.functions.*.pan.*.summonomatrix(_state, _sourcespeakermode, _lowfrequencygain, _overallgain, _matrix)) {
//     return _state.*.functions.*.pan.*.summonomatrix(_state, _sourcespeakermode, _lowfrequencygain, _overallgain, _matrix);
// }
// pub inline fn FMOD_DSP_PAN_SUMSTEREOMATRIX(_state: anytype, _sourcespeakermode: anytype, _pan: anytype, _lowfrequencygain: anytype, _overallgain: anytype, _matrixhop: anytype, _matrix: anytype) @TypeOf(_state.*.functions.*.pan.*.sumstereomatrix(_state, _sourcespeakermode, _pan, _lowfrequencygain, _overallgain, _matrixhop, _matrix)) {
//     return _state.*.functions.*.pan.*.sumstereomatrix(_state, _sourcespeakermode, _pan, _lowfrequencygain, _overallgain, _matrixhop, _matrix);
// }
// pub inline fn FMOD_DSP_PAN_SUMSURROUNDMATRIX(_state: anytype, _sourcespeakermode: anytype, _targetspeakermode: anytype, _direction: anytype, _extent: anytype, _rotation: anytype, _lowfrequencygain: anytype, _overallgain: anytype, _matrixhop: anytype, _matrix: anytype, _flags: anytype) @TypeOf(_state.*.functions.*.pan.*.sumsurroundmatrix(_state, _sourcespeakermode, _targetspeakermode, _direction, _extent, _rotation, _lowfrequencygain, _overallgain, _matrixhop, _matrix, _flags)) {
//     return _state.*.functions.*.pan.*.sumsurroundmatrix(_state, _sourcespeakermode, _targetspeakermode, _direction, _extent, _rotation, _lowfrequencygain, _overallgain, _matrixhop, _matrix, _flags);
// }
// pub inline fn FMOD_DSP_PAN_SUMMONOTOSURROUNDMATRIX(_state: anytype, _targetspeakermode: anytype, _direction: anytype, _extent: anytype, _lowfrequencygain: anytype, _overallgain: anytype, _matrixhop: anytype, _matrix: anytype) @TypeOf(_state.*.functions.*.pan.*.summonotosurroundmatrix(_state, _targetspeakermode, _direction, _extent, _lowfrequencygain, _overallgain, _matrixhop, _matrix)) {
//     return _state.*.functions.*.pan.*.summonotosurroundmatrix(_state, _targetspeakermode, _direction, _extent, _lowfrequencygain, _overallgain, _matrixhop, _matrix);
// }
// pub inline fn FMOD_DSP_PAN_SUMSTEREOTOSURROUNDMATRIX(_state: anytype, _targetspeakermode: anytype, _direction: anytype, _extent: anytype, _rotation: anytype, _lowfrequencygain: anytype, _overallgain: anytype, matrixhop: anytype, _matrix: anytype) @TypeOf(_state.*.functions.*.pan.*.sumstereotosurroundmatrix(_state, _targetspeakermode, _direction, _extent, _rotation, _lowfrequencygain, _overallgain, matrixhop, _matrix)) {
//     return _state.*.functions.*.pan.*.sumstereotosurroundmatrix(_state, _targetspeakermode, _direction, _extent, _rotation, _lowfrequencygain, _overallgain, matrixhop, _matrix);
// }
// pub inline fn FMOD_DSP_PAN_GETROLLOFFGAIN(_state: anytype, _rolloff: anytype, _distance: anytype, _mindistance: anytype, _maxdistance: anytype, _gain: anytype) @TypeOf(_state.*.functions.*.pan.*.getrolloffgain(_state, _rolloff, _distance, _mindistance, _maxdistance, _gain)) {
//     return _state.*.functions.*.pan.*.getrolloffgain(_state, _rolloff, _distance, _mindistance, _maxdistance, _gain);
// }
pub const FMOD_OUTPUT_PLUGIN_VERSION = @as(c_int, 4);
pub const FMOD_OUTPUT_METHOD_MIX_DIRECT = @as(c_int, 0);
pub const FMOD_OUTPUT_METHOD_POLLING = @as(c_int, 1);
pub const FMOD_OUTPUT_METHOD_MIX_BUFFERED = @as(c_int, 2);
// pub inline fn FMOD_OUTPUT_READFROMMIXER(_state: anytype, _buffer: anytype, _length: anytype) @TypeOf(_state.*.readfrommixer(_state, _buffer, _length)) {
//     return _state.*.readfrommixer(_state, _buffer, _length);
// }
// pub inline fn FMOD_OUTPUT_ALLOC(_state: anytype, _size: anytype, _align: anytype) @TypeOf(_state.*.alloc(_size, _align, __FILE__, __LINE__)) {
//     return _state.*.alloc(_size, _align, __FILE__, __LINE__);
// }
// pub inline fn FMOD_OUTPUT_FREE(_state: anytype, _ptr: anytype) @TypeOf(_state.*.free(_ptr, __FILE__, __LINE__)) {
//     return _state.*.free(_ptr, __FILE__, __LINE__);
// }
// pub inline fn FMOD_OUTPUT_COPYPORT(_state: anytype, _id: anytype, _buffer: anytype, _length: anytype) @TypeOf(_state.*.copyport(_state, _id, _buffer, _length)) {
//     return _state.*.copyport(_state, _id, _buffer, _length);
// }
// pub inline fn FMOD_OUTPUT_REQUESTRESET(_state: anytype) @TypeOf(_state.*.requestreset(_state)) {
//     return _state.*.requestreset(_state);
// }
pub const FMOD_STUDIO_LOAD_MEMORY_ALIGNMENT = @as(c_int, 32);
pub const FMOD_STUDIO_INIT_NORMAL = @as(c_int, 0x00000000);
pub const FMOD_STUDIO_INIT_LIVEUPDATE = @as(c_int, 0x00000001);
pub const FMOD_STUDIO_INIT_ALLOW_MISSING_PLUGINS = @as(c_int, 0x00000002);
pub const FMOD_STUDIO_INIT_SYNCHRONOUS_UPDATE = @as(c_int, 0x00000004);
pub const FMOD_STUDIO_INIT_DEFERRED_CALLBACKS = @as(c_int, 0x00000008);
pub const FMOD_STUDIO_INIT_LOAD_FROM_UPDATE = @as(c_int, 0x00000010);
pub const FMOD_STUDIO_INIT_MEMORY_TRACKING = @as(c_int, 0x00000020);
pub const FMOD_STUDIO_PARAMETER_READONLY = @as(c_int, 0x00000001);
pub const FMOD_STUDIO_PARAMETER_AUTOMATIC = @as(c_int, 0x00000002);
pub const FMOD_STUDIO_PARAMETER_GLOBAL = @as(c_int, 0x00000004);
pub const FMOD_STUDIO_PARAMETER_DISCRETE = @as(c_int, 0x00000008);
pub const FMOD_STUDIO_SYSTEM_CALLBACK_PREUPDATE = @as(c_int, 0x00000001);
pub const FMOD_STUDIO_SYSTEM_CALLBACK_POSTUPDATE = @as(c_int, 0x00000002);
pub const FMOD_STUDIO_SYSTEM_CALLBACK_BANK_UNLOAD = @as(c_int, 0x00000004);
pub const FMOD_STUDIO_SYSTEM_CALLBACK_LIVEUPDATE_CONNECTED = @as(c_int, 0x00000008);
pub const FMOD_STUDIO_SYSTEM_CALLBACK_LIVEUPDATE_DISCONNECTED = @as(c_int, 0x00000010);
pub const FMOD_STUDIO_SYSTEM_CALLBACK_ALL = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0xFFFFFFFF, .hexadecimal);
pub const FMOD_STUDIO_EVENT_CALLBACK_CREATED = @as(c_int, 0x00000001);
pub const FMOD_STUDIO_EVENT_CALLBACK_DESTROYED = @as(c_int, 0x00000002);
pub const FMOD_STUDIO_EVENT_CALLBACK_STARTING = @as(c_int, 0x00000004);
pub const FMOD_STUDIO_EVENT_CALLBACK_STARTED = @as(c_int, 0x00000008);
pub const FMOD_STUDIO_EVENT_CALLBACK_RESTARTED = @as(c_int, 0x00000010);
pub const FMOD_STUDIO_EVENT_CALLBACK_STOPPED = @as(c_int, 0x00000020);
pub const FMOD_STUDIO_EVENT_CALLBACK_START_FAILED = @as(c_int, 0x00000040);
pub const FMOD_STUDIO_EVENT_CALLBACK_CREATE_PROGRAMMER_SOUND = @as(c_int, 0x00000080);
pub const FMOD_STUDIO_EVENT_CALLBACK_DESTROY_PROGRAMMER_SOUND = @as(c_int, 0x00000100);
pub const FMOD_STUDIO_EVENT_CALLBACK_PLUGIN_CREATED = @as(c_int, 0x00000200);
pub const FMOD_STUDIO_EVENT_CALLBACK_PLUGIN_DESTROYED = @as(c_int, 0x00000400);
pub const FMOD_STUDIO_EVENT_CALLBACK_TIMELINE_MARKER = @as(c_int, 0x00000800);
pub const FMOD_STUDIO_EVENT_CALLBACK_TIMELINE_BEAT = @as(c_int, 0x00001000);
pub const FMOD_STUDIO_EVENT_CALLBACK_SOUND_PLAYED = @as(c_int, 0x00002000);
pub const FMOD_STUDIO_EVENT_CALLBACK_SOUND_STOPPED = @as(c_int, 0x00004000);
pub const FMOD_STUDIO_EVENT_CALLBACK_REAL_TO_VIRTUAL = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00008000, .hexadecimal);
pub const FMOD_STUDIO_EVENT_CALLBACK_VIRTUAL_TO_REAL = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00010000, .hexadecimal);
pub const FMOD_STUDIO_EVENT_CALLBACK_START_EVENT_COMMAND = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00020000, .hexadecimal);
pub const FMOD_STUDIO_EVENT_CALLBACK_NESTED_TIMELINE_BEAT = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x00040000, .hexadecimal);
pub const FMOD_STUDIO_EVENT_CALLBACK_ALL = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0xFFFFFFFF, .hexadecimal);
pub const FMOD_STUDIO_LOAD_BANK_NORMAL = @as(c_int, 0x00000000);
pub const FMOD_STUDIO_LOAD_BANK_NONBLOCKING = @as(c_int, 0x00000001);
pub const FMOD_STUDIO_LOAD_BANK_DECOMPRESS_SAMPLES = @as(c_int, 0x00000002);
pub const FMOD_STUDIO_LOAD_BANK_UNENCRYPTED = @as(c_int, 0x00000004);
pub const FMOD_STUDIO_COMMANDCAPTURE_NORMAL = @as(c_int, 0x00000000);
pub const FMOD_STUDIO_COMMANDCAPTURE_FILEFLUSH = @as(c_int, 0x00000001);
pub const FMOD_STUDIO_COMMANDCAPTURE_SKIP_INITIAL_STATE = @as(c_int, 0x00000002);
pub const FMOD_STUDIO_COMMANDREPLAY_NORMAL = @as(c_int, 0x00000000);
pub const FMOD_STUDIO_COMMANDREPLAY_SKIP_CLEANUP = @as(c_int, 0x00000001);
pub const FMOD_STUDIO_COMMANDREPLAY_FAST_FORWARD = @as(c_int, 0x00000002);
pub const FMOD_STUDIO_COMMANDREPLAY_SKIP_BANK_LOAD = @as(c_int, 0x00000004);
