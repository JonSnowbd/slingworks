const std = @import("std");

/// Formula is `degrees = radians * sling.math.RAD_2_DEG`
pub const RAD_2_DEG = 57.2958;
/// Formula is `radians = degrees * sling.math.DEG_2_RAD`
pub const DEG_2_RAD = 0.0174533;

fn Int(comptime signedness: std.builtin.Signedness, comptime bit_count: u16) type {
    return @Type(std.builtin.TypeInfo{
        .Int = .{
            .signedness = signedness,
            .bits = bit_count,
        },
    });
}
fn Float(comptime bit_count: u16) type {
    return @Type(std.builtin.TypeInfo{
        .Float = .{
            .bits = bit_count,
        },
    });
}
inline fn divide(comptime Real: type, lhs: anytype, rhs: anytype) Real {
    var leftOperand = convertTo(Real, lhs);
    var rightOperand = convertTo(Real, rhs);

    return std.math.divFloor(Real, leftOperand, rightOperand) catch return 0;
}
inline fn convertTo(comptime T: type, value: anytype) T {
    if (@TypeOf(value) == T) {
        return value;
    }
    switch (@typeInfo(@TypeOf(value))) {
        .Float => {
            switch (@typeInfo(@TypeOf(T))) {
                .Int => |destInt| {
                    const conv = std.math.round(value);
                    return @floatToInt(Int(destInt.signedness, destInt.bits), conv);
                },
                .Float => |destFloat| {
                    return @floatCast(Float(destFloat.bits), value);
                },
                else => @compileError("Conversion can only happen with floats and ints"),
            }
        },
        .Int => {
            switch (@typeInfo(@TypeOf(T))) {
                .Int => |destInt| {
                    return @intCast(Int(destInt.signedness, destInt.bits), value);
                },
                .Float => |destFloat| {
                    return @intToFloat(Float(destFloat.bits), value);
                },
                else => @compileError("Conversion can only happen with floats and ints"),
            }
        },
        else => @compileError("Conversion can only happen with floats and ints"),
    }
}

fn Fns(comptime Self: type, comptime Real: type, comptime axes: usize) type {
    return struct {
        /// Does not mutate `this`, returns a copy of `this` with the sum of it equalling 1.
        pub fn normalize(this: Self) Self {
            var len = this.length();
            if (len != 0.0) {
                return this.scale(1.0 / len);
            } else {
                var empty: Self = undefined;
                inline for (@typeInfo(Self).Struct.fields) |fld| {
                    @field(empty, fld.name) = 0;
                }
                return empty;
            }
        }
        /// Does not mutate `this` or `other`, returns the dot product of the two vectors.
        /// Returns the sum of products of all components.
        pub fn dot(this: Self, other: Self) Real {
            var result: Real = 0;
            inline for (@typeInfo(Self).Struct.fields) |fld| {
                result += @field(this, fld.name) * @field(other, fld.name);
            }
            return result;
        }

        /// returns the magnitude of the vector.
        pub fn length(this: Self) Real {
            return std.math.sqrt(this.length2());
        }

        /// returns the squared magnitude of the vector.
        pub fn length2(this: Self) Real {
            return Self.dot(this, this);
        }
        /// Does not mutate `this`, returns a copy of `this` with each of `other`'s fields
        /// added.
        pub fn add(this: Self, other: Self) Self {
            var result: Self = undefined;
            inline for (@typeInfo(Self).Struct.fields) |field| {
                @field(result, field.name) = @field(this, field.name) + @field(other, field.name);
            }
            return result;
        }
        /// Mutates `this`, adding all the fields from `other` into `this`.
        pub fn addMut(this: *Self, other: Self) void {
            inline for (@typeInfo(Self).Struct.fields) |field| {
                @field(this, field.name) += @field(other, field.name);
            }
        }
        /// Does not mutate `this`, returns a copy of `this` with each of `other`'s fields
        /// subtracted.
        pub fn sub(this: Self, other: Self) Self {
            var result: Self = undefined;
            inline for (@typeInfo(Self).Struct.fields) |field| {
                @field(result, field.name) = @field(this, field.name) - @field(other, field.name);
            }
            return result;
        }
        /// Mutates `this`, subtracting all the fields from `other` from `this`.
        pub fn subMut(this: *Self, other: Self) void {
            inline for (@typeInfo(Self).Struct.fields) |field| {
                @field(this, field.name) -= @field(other, field.name);
            }
        }
        /// Does not mutate `this`, returns a copy of `this` with each of `other`'s fields
        /// subtracted.
        pub fn scale(this: Self, scalar: Real) Self {
            var result: Self = undefined;
            inline for (@typeInfo(Self).Struct.fields) |field| {
                @field(result, field.name) = @field(this, field.name) * scalar;
            }
            return result;
        }
        /// Does not mutate `this`, returns a copy of `this` with each of `other`'s fields
        /// subtracted.
        pub fn round(this: Self) Self {
            var result: Self = undefined;
            inline for (@typeInfo(Self).Struct.fields) |field| {
                @field(result, field.name) = std.math.round(@field(this, field.name));
            }
            return result;
        }
        /// Mutates `this`, subtracting all the fields from `other` from `this`.
        pub fn scaleMut(this: *Self, scalar: Real) void {
            inline for (@typeInfo(Self).Struct.fields) |field| {
                @field(this, field.name) = @field(this, field.name) * scalar;
            }
        }
        /// Does not mutate `this`, returns a copy of `this` with each of `other`'s fields
        /// subtracted.
        pub fn scaleDiv(this: Self, scalar: Real) Self {
            var result: Self = undefined;
            inline for (@typeInfo(Self).Struct.fields) |field| {
                if (@typeInfo(Real) == .Int) {
                    @field(result, field.name) = std.math.divFloor(Real, @field(this, field.name), scalar) catch 0;
                } else {
                    if (@field(result, field.name) == 0 or scalar == 0) {
                        @field(result, field.name) = 0;
                    } else {
                        @field(result, field.name) = @field(this, field.name) / scalar;
                    }
                }
            }
            return result;
        }
        /// Mutates `this`, subtracting all the fields from `other` from `this`.
        pub fn scaleDivMut(this: *Self, scalar: Real) void {
            inline for (@typeInfo(Self).Struct.fields) |field| {
                @field(this, field.name) = std.math.divFloor(Real, @field(this, field.name), scalar) catch 0;
            }
        }
        /// Converts this vector into a new vector type, for example from f32 to i32 or f64.
        pub fn convert(this: Self, comptime NewReal: type) GenerateVectorType(NewReal, axes) {
            const NewVector = GenerateVectorType(NewReal, axes);
            var result: NewVector = undefined;
            inline for (@typeInfo(Self).Struct.fields) |field| {
                @field(result, field.name) = convertTo(NewReal, @field(this, field.name));
            }
            return result;
        }
    };
}

pub fn GenerateVectorType(comptime Real: type, comptime axes: usize) type {
    switch (axes) {
        1 => return extern struct {
            value: Real = 0,
            pub fn new(val: Real) @This() {
                return .{ .value = val };
            }
            pub usingnamespace Fns(@This(), Real, axes);
        },
        2 => return extern struct {
            x: Real = 0,
            y: Real = 0,
            pub fn new(x: Real, y: Real) @This() {
                return .{ .x = x, .y = y };
            }
            pub usingnamespace Fns(@This(), Real, axes);
        },
        3 => return extern struct {
            x: Real = 0,
            y: Real = 0,
            z: Real = 0,
            pub fn new(x: Real, y: Real, z: Real) @This() {
                return .{ .x = x, .y = y, .z = z };
            }
            pub usingnamespace Fns(@This(), Real, axes);
        },
        4 => return extern struct {
            x: Real = 0,
            y: Real = 0,
            z: Real = 0,
            w: Real = 0,
            pub fn new(x: Real, y: Real, z: Real, w: Real) @This() {
                return .{ .x = x, .y = y, .z = z, .w = w };
            }
            /// val = 0 means unchanged, val = 1 means full white, val = -1 means full black
            /// Values are clamped between 0 and 1 to maintain valid normalized color, and alpha is unchanged.
            pub fn brighten(self: @This(), val: f32) @This() {
                return .{ .x = std.math.clamp(self.x * (1.0 + val), 0.0, 1.0), .y = std.math.clamp(self.y * (1.0 + val), 0.0, 1.0), .z = std.math.clamp(self.z * (1.0 + val), 0.0, 1.0), .w = self.w };
            }
            pub usingnamespace Fns(@This(), Real, axes);
        },
        5 => return extern struct {
            x: Real = 0,
            y: Real = 0,
            z: Real = 0,
            w: Real = 0,
            r: Real = 0,
            pub fn new(x: Real, y: Real, z: Real, w: Real, r: Real) @This() {
                return .{ .x = x, .y = y, .z = z, .w = w, .r = r };
            }
            pub usingnamespace Fns(@This(), Real, axes);
        },
        else => @compileError(@compileLog("Cannot have a vector with {any} axes.", .{axes})),
    }
}

pub const IntegerSettings = struct {};
pub const FloatSettings = struct {};
pub const Scalar = GenerateVectorType(f32, 1);
pub const Vec2 = GenerateVectorType(f32, 2);
pub const Vec3 = GenerateVectorType(f32, 3);
pub const Vec4 = GenerateVectorType(f32, 4);

pub const ScalarDouble = GenerateVectorType(f64, 1);
pub const Vec2Double = GenerateVectorType(f64, 2);
pub const Vec3Double = GenerateVectorType(f64, 3);
pub const Vec4Double = GenerateVectorType(f64, 4);

pub const Integer = GenerateVectorType(i32, 1);
pub const Point2 = GenerateVectorType(i32, 2);
pub const Point3 = GenerateVectorType(i32, 3);
pub const Point4 = GenerateVectorType(i32, 4);

pub const IntegerDouble = GenerateVectorType(i64, 1);
pub const Point2Double = GenerateVectorType(i64, 2);
pub const Point3Double = GenerateVectorType(i64, 3);
pub const Point4Double = GenerateVectorType(i64, 4);

// Modified ZLM Mat4
pub const Matrix = extern struct {
    fields: [4][4]f32, // [row][col]

    /// zero matrix.
    pub const zero = Matrix{
        .fields = [4][4]f32{
            [4]f32{ 0, 0, 0, 0 },
            [4]f32{ 0, 0, 0, 0 },
            [4]f32{ 0, 0, 0, 0 },
            [4]f32{ 0, 0, 0, 0 },
        },
    };

    /// identitiy matrix
    pub const identity = Matrix{
        .fields = [4][4]f32{
            [4]f32{ 1, 0, 0, 0 },
            [4]f32{ 0, 1, 0, 0 },
            [4]f32{ 0, 0, 1, 0 },
            [4]f32{ 0, 0, 0, 1 },
        },
    };

    pub fn format(value: Matrix, comptime fmt: []const u8, options: std.fmt.FormatOptions, stream: anytype) !void {
        _ = options;
        _ = fmt;
        try stream.writeAll("Matrix{");

        inline for ([_]comptime_int{ 0, 1, 2, 3 }) |i| {
            const row = value.fields[i];
            try stream.print(" ({d:.2} {d:.2} {d:.2} {d:.2})", .{ row[0], row[1], row[2], row[3] });
        }

        try stream.writeAll(" }");
    }

    /// performs matrix multiplication of a*b
    pub fn mul(a: Matrix, b: Matrix) Matrix {
        var result: Matrix = undefined;
        inline for ([_]comptime_int{ 0, 1, 2, 3 }) |row| {
            inline for ([_]comptime_int{ 0, 1, 2, 3 }) |col| {
                var sum: f32 = 0.0;
                inline for ([_]comptime_int{ 0, 1, 2, 3 }) |i| {
                    sum += a.fields[row][i] * b.fields[i][col];
                }
                result.fields[row][col] = sum;
            }
        }
        return result;
    }

    /// transposes the matrix.
    /// this will swap columns with rows.
    pub fn transpose(a: Matrix) Matrix {
        var result: Matrix = undefined;
        inline for ([_]comptime_int{ 0, 1, 2, 3 }) |row| {
            inline for ([_]comptime_int{ 0, 1, 2, 3 }) |col| {
                result.fields[row][col] = a.fields[col][row];
            }
        }
        return result;
    }

    // taken from GLM implementation

    /// Creates a look-at matrix.
    /// The matrix will create a transformation that can be used
    /// as a camera transform.
    /// the camera is located at `eye` and will look into `direction`.
    /// `up` is the direction from the screen center to the upper screen border.
    pub fn createLook(eye: Vec3, direction: Vec3, up: Vec3) Matrix {
        const f = direction.normalize();
        const s = Vec3.cross(up, f).normalize();
        const u = Vec3.cross(f, s);

        var result = Matrix.identity;
        result.fields[0][0] = s.x;
        result.fields[1][0] = s.y;
        result.fields[2][0] = s.z;
        result.fields[0][1] = u.x;
        result.fields[1][1] = u.y;
        result.fields[2][1] = u.z;
        result.fields[0][2] = f.x;
        result.fields[1][2] = f.y;
        result.fields[2][2] = f.z;
        result.fields[3][0] = -Vec3.dot(s, eye);
        result.fields[3][1] = -Vec3.dot(u, eye);
        result.fields[3][2] = -Vec3.dot(f, eye);
        return result;
    }

    /// Creates a look-at matrix.
    /// The matrix will create a transformation that can be used
    /// as a camera transform.
    /// the camera is located at `eye` and will look at `center`.
    /// `up` is the direction from the screen center to the upper screen border.
    pub fn createLookAt(eye: Vec3, center: Vec3, up: Vec3) Matrix {
        return createLook(eye, Vec3.sub(center, eye), up);
    }

    // taken from GLM implementation

    /// creates a perspective transformation matrix.
    /// `fov` is the field of view in radians,
    /// `aspect` is the screen aspect ratio (width / height)
    /// `near` is the distance of the near clip plane, whereas `far` is the distance to the far clip plane.
    pub fn createPerspective(fov: f32, aspect: f32, near: f32, far: f32) Matrix {
        std.debug.assert(std.math.fabs(aspect - 0.001) > 0);

        const tanHalfFovy = std.math.tan(fov / 2);

        var result = Matrix.zero;
        result.fields[0][0] = 1.0 / (aspect * tanHalfFovy);
        result.fields[1][1] = 1.0 / (tanHalfFovy);
        result.fields[2][2] = far / (far - near);
        result.fields[2][3] = 1;
        result.fields[3][2] = -(far * near) / (far - near);
        return result;
    }

    /// creates a rotation matrix around a certain axis.
    pub fn createAngleAxis(axis: Vec3, angle: f32) Matrix {
        var cos = std.math.cos(angle);
        var sin = std.math.sin(angle);
        var x = axis.x;
        var y = axis.y;
        var z = axis.z;

        return Matrix{
            .fields = [4][4]f32{
                [4]f32{ cos + x * x * (1 - cos), x * y * (1 - cos) - z * sin, x * z * (1 - cos) + y * sin, 0 },
                [4]f32{ y * x * (1 - cos) + z * sin, cos + y * y * (1 - cos), y * z * (1 - cos) - x * sin, 0 },
                [4]f32{ z * x * (1 * cos) - y * sin, z * y * (1 - cos) + x * sin, cos + z * z * (1 - cos), 0 },
                [4]f32{ 0, 0, 0, 1 },
            },
        };
    }

    pub fn createZRotation(radians: f32) Matrix {
        var result = Matrix.identity;

        var val1 = @cos(radians);
        var val2 = @sin(radians);
        result.fields[0][0] = val1;
        result.fields[0][1] = val2;
        result.fields[1][0] = -val2;
        result.fields[1][1] = val1;

        return result;
    }

    /// creates matrix that will scale a homogeneous matrix.
    pub fn createUniformScale(scale: f32) Matrix {
        return createScale(scale, scale, scale);
    }

    /// Creates a non-uniform scaling matrix
    pub fn createScale(x: f32, y: f32, z: f32) Matrix {
        return Matrix{
            .fields = [4][4]f32{
                [4]f32{ x, 0, 0, 0 },
                [4]f32{ 0, y, 0, 0 },
                [4]f32{ 0, 0, z, 0 },
                [4]f32{ 0, 0, 0, 1 },
            },
        };
    }

    /// creates matrix that will translate a homogeneous matrix.
    pub fn createTranslationXYZ(x: f32, y: f32, z: f32) Matrix {
        return Matrix{
            .fields = [4][4]f32{
                [4]f32{ 1, 0, 0, 0 },
                [4]f32{ 0, 1, 0, 0 },
                [4]f32{ 0, 0, 1, 0 },
                [4]f32{ x, y, z, 1 },
            },
        };
    }

    /// creates matrix that will scale a homogeneous matrix.
    pub fn createTranslation(v: Vec3) Matrix {
        return Matrix{
            .fields = [4][4]f32{
                [4]f32{ 1, 0, 0, 0 },
                [4]f32{ 0, 1, 0, 0 },
                [4]f32{ 0, 0, 1, 0 },
                [4]f32{ v.x, v.y, v.z, 1 },
            },
        };
    }

    /// creates an orthogonal projection matrix.
    /// `left`, `right`, `bottom` and `top` are the borders of the screen whereas `near` and `far` define the
    /// distance of the near and far clipping planes.
    pub fn createOrthogonal(left: f32, right: f32, bottom: f32, top: f32, near: f32, far: f32) Matrix {
        var result = Matrix.identity;
        result.fields[0][0] = 2 / (right - left);
        result.fields[1][1] = 2 / (top - bottom);
        result.fields[2][2] = 1 / (far - near);
        result.fields[3][0] = -(right + left) / (right - left);
        result.fields[3][1] = -(top + bottom) / (top - bottom);
        result.fields[3][2] = -near / (far - near);
        return result;
    }

    pub fn inlined(self: Matrix) [16]f32 {
        return @bitCast([16]f32, self.fields);
    }

    /// Batch matrix multiplication. Will multiply all matrices from "first" to "last".
    pub fn batchMul(items: []const Matrix) Matrix {
        if (items.len == 0)
            return Matrix.identity;
        if (items.len == 1)
            return items[0];
        var value = items[0];
        var i: usize = 1;
        while (i < items.len) : (i += 1) {
            value = value.mul(items[i]);
        }
        return value;
    }

    pub fn transformVec2(mat: Matrix, vec: Vec2) Vec2 {
        return Vec2.new(
            // (position.X * matrix.M11) + (position.Y * matrix.M21) + matrix.M41
            (vec.x * mat.fields[0][0]) + (vec.y * mat.fields[1][0]) + mat.fields[3][0],
            // (position.X * matrix.M12) + (position.Y * matrix.M22) + matrix.M42
            (vec.x * mat.fields[0][1]) + (vec.y * mat.fields[1][1]) + mat.fields[3][1],
        );
    }

    pub fn invert(src: Matrix) ?Matrix {
        // https://github.com/stackgl/gl-Matrix/blob/master/invert.js
        const a = @bitCast([16]f32, src.fields);

        const a00 = a[0];
        const a01 = a[1];
        const a02 = a[2];
        const a03 = a[3];
        const a10 = a[4];
        const a11 = a[5];
        const a12 = a[6];
        const a13 = a[7];
        const a20 = a[8];
        const a21 = a[9];
        const a22 = a[10];
        const a23 = a[11];
        const a30 = a[12];
        const a31 = a[13];
        const a32 = a[14];
        const a33 = a[15];

        const b00 = a00 * a11 - a01 * a10;
        const b01 = a00 * a12 - a02 * a10;
        const b02 = a00 * a13 - a03 * a10;
        const b03 = a01 * a12 - a02 * a11;
        const b04 = a01 * a13 - a03 * a11;
        const b05 = a02 * a13 - a03 * a12;
        const b06 = a20 * a31 - a21 * a30;
        const b07 = a20 * a32 - a22 * a30;
        const b08 = a20 * a33 - a23 * a30;
        const b09 = a21 * a32 - a22 * a31;
        const b10 = a21 * a33 - a23 * a31;
        const b11 = a22 * a33 - a23 * a32;

        // Calculate the determinant
        var det = b00 * b11 - b01 * b10 + b02 * b09 + b03 * b08 - b04 * b07 + b05 * b06;

        if (std.math.approxEqAbs(f32, det, 0, 1e-8)) {
            return null;
        }
        det = 1.0 / det;

        const out = [16]f32{
            (a11 * b11 - a12 * b10 + a13 * b09) * det, // 0
            (a02 * b10 - a01 * b11 - a03 * b09) * det, // 1
            (a31 * b05 - a32 * b04 + a33 * b03) * det, // 2
            (a22 * b04 - a21 * b05 - a23 * b03) * det, // 3
            (a12 * b08 - a10 * b11 - a13 * b07) * det, // 4
            (a00 * b11 - a02 * b08 + a03 * b07) * det, // 5
            (a32 * b02 - a30 * b05 - a33 * b01) * det, // 6
            (a20 * b05 - a22 * b02 + a23 * b01) * det, // 7
            (a10 * b10 - a11 * b08 + a13 * b06) * det, // 8
            (a01 * b08 - a00 * b10 - a03 * b06) * det, // 9
            (a30 * b04 - a31 * b02 + a33 * b00) * det, // 10
            (a21 * b02 - a20 * b04 - a23 * b00) * det, // 11
            (a11 * b07 - a10 * b09 - a12 * b06) * det, // 12
            (a00 * b09 - a01 * b07 + a02 * b06) * det, // 13
            (a31 * b01 - a30 * b03 - a32 * b00) * det, // 14
            (a20 * b03 - a21 * b01 + a22 * b00) * det, // 15
        };
        return Matrix{
            .fields = @bitCast([4][4]f32, out),
        };
    }
};
pub const Rect = extern struct {
    position: Vec2 = .{},
    size: Vec2 = .{},

    pub inline fn left(self: Rect) f32 {
        return self.position.x;
    }
    pub inline fn top(self: Rect) f32 {
        return self.position.y;
    }
    pub inline fn right(self: Rect) f32 {
        return self.position.x + self.size.x;
    }
    pub inline fn bottom(self: Rect) f32 {
        return self.position.y + self.size.y;
    }
    pub inline fn newVec(pos: Vec2, size: Vec2) Rect {
        return new(pos.x, pos.y, size.x, size.y);
    }
    pub fn new(x: f32, y: f32, width: f32, height: f32) Rect {
        return .{ .position = .{ .x = x, .y = y }, .size = .{ .x = width, .y = height } };
    }
    pub fn containsPoint(self: Rect, point: Vec2) bool {
        return point.x >= self.position.x and point.y >= self.position.y and
            point.x <= self.position.x + self.size.x and point.y <= self.position.y + self.size.y;
    }
    pub fn containsRect(self: Rect, other: Rect) bool {
        return ((((self.position.x <= other.position.x) and ((other.position.x + other.size.x) <= (self.position.x + self.size.x))) and (self.position.y <= other.position.y)) and ((other.position.y + other.size.y) <= (self.position.y + self.size.y)));
    }
    pub fn intersectsRect(self: Rect, other: Rect) bool {
        return other.position.x < self.position.x + self.size.x and
            self.position.x < other.position.x + other.size.x and
            other.position.y < self.position.y + self.size.y and
            self.position.y < other.position.y + other.size.y;
    }
    pub fn moved(self: Rect, position: Vec2) Rect {
        return new(self.position.x + position.x, self.position.y + position.y, self.size.x, self.size.y);
    }
    pub fn inset(self: Rect, amount: f32) Rect {
        return new(self.position.x + amount, self.position.y + amount, self.size.x - (amount * 2), self.size.y - (amount * 2));
    }
    /// Returns how much the two rectangles intersect on each axis, if they do.
    pub fn intersection(self: Rect, other: Rect) ?Vec2 {
        if (self.intersectsRect(other)) {
            var val: Vec2 = .{};
            val.x = std.math.min(self.right(), other.right()) - std.math.max(self.left(), other.left());
            val.y = std.math.min(self.bottom(), other.bottom()) - std.math.max(self.top(), other.top());
            return val;
        } else {
            return null;
        }
    }
    /// negative expansion moves the left/top bounds, positive moves the bottom/right bounds.
    /// Use this to get the total aabb of a rectangle thats moving by passing in the velocity
    /// as the expansion factor.
    pub fn expand(self: Rect, expansion: Vec2) Rect {
        var copy = self;
        if (expansion.x < 0) {
            copy.position.x += expansion.x;
            copy.size.x -= expansion.x;
        } else {
            copy.position.x += expansion.x;
        }
        if (expansion.y < 0) {
            copy.position.y += expansion.y;
            copy.size.y -= expansion.y;
        } else {
            copy.position.y += expansion.y;
        }
        return copy;
    }
};

// TODO:
// Pass in a formula and the numbered members inside of it, and have code generated
// automatically to perform it.
//
// An example formula is `0 + 1`, which will add the first and second member
// inside of members. Standard mathematical order will be resolved (BIDMAS/PEMDAS).
//
// Vector(and scalar) literals can be expressed with `{n}` form, for example to write a 2D
// Vector literal, it would be `{1,3}`. If the Vector is based on Integers, you can
// still use floating point numbers, and they will respect your `IntegerSettings` to
// be converted into integers.
//
// You may prefix vector literals and values with ~ to normalize them.
// Supported operators: `() * / + - ~`
// Supported types: Any type generated by `GenerateVectorTypes`, Any mathematical(non-matrix)
// type from this library, Any number literal from zig, Any number type from
// fn calculate(comptime Target: type, comptime formula: []const u8, members: anytype) Target {
//     _ = formula;
//     _ = members;
//     var result: Target = .{};
//     return result;
// }

test "Basic Addition" {
    const testing = @import("std").testing;
    const point: Vec2 = Vec2{ .x = 10, .y = 10 };

    try testing.expect(point.x == 10);
}

// test "Formulae" {
//     const testing = @import("std").testing;
//     var origin = Vec2{};
//     var stride = Vec2{.x=10};
//     var wind = Vec2{.x=-3};

//     // Formula style
//     var form = calculate(Vec2, "(~(0+1) * {2} - 3) * {5}", .{origin,stride,wind});

//     // Traditional style
//     var trad = origin.add(stride).normalize().scale(2.0).sub(wind).scale(5.0);

//     testing.expectEqual(trad, form);
// }
