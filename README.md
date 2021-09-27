<p align="center">
  <img width="267" height="267" src="logo.png">
</p>
<h1 align="center">Slingworks <sup>0.2</sup></h1>

A simple and powerful Windows+Linux 'bring your content' engine 
built in Zig and powered by GLFW/OpenGL/ImGui.

Slingworks makes no assumptions about your games content and
instead offers a framework to organize your code into simple
and fast scenes and entity collections, all with an embedded
runtime editor and powered by flexible serialization!

Slingworks is aimed at small to medium scale 2d projects that want to allow
the fanbase to create and contribute to the game as easily as developers do.

## Whats missing?

Right now there are several pieces of Slingwork missing or lacking polish:

- Services
- Gamepad support
- Linux support

## Platform support

For now Slingworks is very early work in progress and supports Windows,
but it is very likely to be just 10-20 minutes of work to get working
on linux.

## Dependencies

Windows:
- [FMod Audio, Core and Studio APIs installed](https://www.fmod.com/download)

Linux: (wip)
- [FMod Audio, Core and Studio APIs installed](https://www.fmod.com/download)
- `sudo apt install build-essential xorg-dev`

## Getting Started

Check out the [wiki](https://github.com/JonSnowbd/slingworks/wiki) for installation and
beginner guides to how Slingworks is used.

### Wheres the example?

Check out the open source full game in development that will serve as the all encompassing example
for slingworks, named [Underburrow](https://github.com/JonSnowbd/underburrow)!

Or for more directed advice and tutorials check out the [wiki](https://github.com/JonSnowbd/slingworks/wiki)

### My built game requested local network permissions?

This is because debug builds initialize FMod Studio with net connection
for live audio authoring.

### My game crashes trying to de/serialize something?

The serializer should handle every reasonable type including basic
array lists and string hashmaps, but it is unavoidable to crash if you
attempted to serialize untagged unions, opaque, or packed types in your entities.

## Credits

Thanks to [fontawesome](https://fontawesome.com) for being a great, lean, embeddable icon font included with the editor
to make the UI as clear as it could be.