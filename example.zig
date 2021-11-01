const std = @import("std");
const sling = @import("sling");

pub const Arena = struct {
    bounds:sling.math.Rect = sling.math.Rect.new(-400,-400,800,800),
    pub fn update(self:*Arena) void {
        sling.render.rectangle(self.bounds, .{
            .thickness=10.0,
            .depth=sling.Depth.init(10),
            .color=sling.math.Vec4.new(1.0,0.0,0.0,1.0),
        });
    }
    pub fn slingIntegration() void {
        var config = sling.configure(Arena);
        config.updateMethod(.update, .both);
    }
};
pub const Puck = struct {
    var rng = std.rand.DefaultPrng.init(45178534);
    position:sling.math.Vec2 = .{},
    velocity:sling.math.Vec2 = .{},
    pub fn init(self: *Puck) void {
        self.velocity.x = (rng.random.float(f32)-0.5)*450;
        self.velocity.y = (rng.random.float(f32)-0.5)*450;
    }
    pub fn update(self: *Puck, scene:*sling.Scene) void {
        self.moveAndCollide(scene);
        var rect = sling.math.Rect{.position=self.position,.size=.{.x=50,.y=50}};
        var tex = sling.asset.ensure(sling.Texture, "Avatar.png");
        sling.render.sprite(tex, rect, .{.normalizedOrigin=.{.x=0.5,.y=0.5}});
    }
    fn moveAndCollide(self: *Puck, scene:*sling.Scene) void {
        var bounds = scene.is(Arena).?.bounds;
        self.position = self.position.add(self.velocity.scale(sling.state.dt));
        if(self.position.x < bounds.left() or self.position.x > bounds.right()) {
            self.position.x = std.math.clamp(self.position.x, bounds.left()+1, bounds.right()-1);
            self.velocity.x *= -1;
        }
        if(self.position.y < bounds.top() or self.position.y > bounds.bottom()) {
            self.position.y = std.math.clamp(self.position.y, bounds.top()+1, bounds.bottom()-1);
            self.velocity.y *= -1;
        }
    }
    pub fn slingIntegration() void {
        var config = sling.configure(Puck);
        config.updateMethod(.update, .both);
        config.initMethod(.init, .both);
    }
};

pub fn main() void {
    sling.integrate(Arena);
    sling.integrate(Puck);
    sling.configureScene(Arena, .{Puck});
    sling.configureInit(init);
    sling.run(.{
        .fontBytes = @embedFile("opensans.ttf"),
    });
}

fn init() void {
    sling.imgui.config.styleColorOrangeSlate();
    sling.imgui.config.styleSizeCompact();
    sling.log("Hello world!");
}