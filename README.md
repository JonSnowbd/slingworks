<p align="center">
  <img width="267" height="267" src="logo.png">
</p>
<h1 align="center">Slingworks <sup>0.1</sup></h1>

A simple and powerful Windows+Linux 'bring your content' engine 
built in Zig and powered by GLFW/OpenGL/ImGui. Slingworks makes no
assumptions about your games content and instead offers a framework
to organize your code into simple and fast scenes and entity collections,
all with an embedded runtime editor!

Slingworks is aimed at any scope due to its simplicity
in keeping logic contained inside their own files, while allowing your audience
access to the very same tools you used to make the games content for free!

## Whats missing?

Right now there are several pieces of Slingwork missing or lacking polish:

- Services
- Spritefonts
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

Using Slingworks is as simple as submoduling this repo into your project
and importing `build.zig` into your build file, and running
`slingBuild.link(exe)` to get everything up and running.

Lets get started in game! Slingworks has a very simple api and as a result your
main.zig will typically be less than 100 loc for medium-large projects.

The lifecycle of an application is summed up as 

1. Register static init functions with `sling.addStaticInit(yourFn)`.
The provided function is expected to have no parameters and no return type,
they are simply ran in order after imgui/glfw initialization so you're free
to load and use anything you can during game time.
2. Configure/Integrate entity types with `sling.configure(type)` and
`sling.integrate(type)` respectively. Configuring will let you configure
a type inside of main, but it instead recommended to use [integate](#)
3. Let slingwork know which entity types are allowed to be a scene with
`sling.register.scene(sceneParent, .{child,types,here})`
4. Now just `sling.run()` and let everything be handled for you!
5. Compile and run your code, providing `editor` as an argument to boot
the game up in editor like `zig build run -- editor` or `zig-out/bin/yourgame.exe editor`

Keep in mind:
1. Either provide the initial scene as a path in the distributed settings file, or in code on init check for
`sling.inEditor`, and if not, load the initial scene by code.

## But..

#### Wheres the example?

For now Slingworks will stand with basic tutorials and very very basic 
examples, but stay tuned for an all encompassing example in a separate
repo!

#### My built game requested local network permissions?

This is because debug builds initialize FMod Studio with net connection
for live audio authoring.

#### My game crashes trying to de/serialize something?

The serializer should handle every reasonable type including basic
array lists and string hashmaps, but it is unavoidable to crash if you
attempted to serialize untagged unions, opaque, or packed types in your entities.