module engine.vector;

final class Vector(ubyte size) 
if(size >= 2 && size <= 4)
{
    import std.traits : allSatisfy, isFloatingPoint;
    import std.math : sqrt;
    import std.algorithm : fold;
    import std.conv : to;
    import std.format : format;

    private {
        static immutable _typeName = "Vector" ~ size.to!string;
        static immutable _props = ['x', 'y', 'z', 'w'];
        float[size] _components;
    }

    /// Construct a new vector with the given components
    this(T...)(T components) if (components.length == size && allSatisfy!(isFloatingPoint, T)) {
        _components = [components];
    }

    static foreach(i, c; _props[0..size]) {
        mixin("@property ref " ~ c ~ "() { return _components[" ~ i.stringof ~ "]; }");
    }

    
    /// Magnitude of the Vector
    @property magnitude() const {
        return this.sqrMagnitude.sqrt;
    }

    /// Magnitude of the Vector
    alias length = magnitude;

    @property sqrMagnitude() const {
        return _components.fold!((a, b) => a + b^^2)(0.0f);
    }

    /// Access x, y, z and w at indices [0], [1], [2] and [3]
    float opIndex(in size_t index) const
    in { assert(index >= 0 && index < size, _typeName ~ " index out of bounds."); }
    do {
        return _components[index];
    }

    /// Set x, y, z and w at indices [0], [1], [2] and [3]
    float opIndexAssign(in float value, in size_t index)
    in { assert(index >= 0 && index < size, _typeName ~ " index out of bounds."); }
    do {
        return _components[index] = value;
    }

    /// Unary operations on Vector such as -- and ++, ~ and * are not supported.
    Vector opUnary(string op)() {
        static assert(op != "*" && op != "~", "Operand " ~ op ~ " not supported on " ~ _typeName);
        static foreach(i; 0 .. size) {{
            enum component = "_components[" ~ i.stringof ~ "]";
            mixin(component ~ " = " ~ op ~ component ~ ";");
        }}
        return this;
    }

    /// Vector on Vector operations such as addition and subtraction, yields a new Vector instance.
    Vector opBinary(string op)(in Vector rhs) const {
        import std.range : iota;
        import std.algorithm : map;
        import std.array : array;
        static immutable args = size.iota.map!(i => "this[" ~ i.to!string ~ "] " ~ op ~ " rhs[" ~ i.to!string ~ "]").array;
        mixin("return new Vector" ~ args.format!("(%-(%s%|, %));"));
    }

    /// In-place Scalar on Vector operations such as addition and subtraction.
    Vector opOpAssign(string op)(in float scalar) {
        static foreach(i, c; _props[0..size]) {
            mixin("this." ~ c ~ " " ~ op ~ "= scalar;");
        }
        return this;
    }

    /// Sets Vector components to scalar value.
    Vector opAssign(in float scalar) {
        static foreach(i, c; _props[0..size]) {
            mixin("this." ~ c ~ " = scalar;");
        }
        return this;
    }

    /// Compute the distance between two Vector instances
    static float distance(in Vector lhs, in Vector rhs) {
        return (lhs - rhs).magnitude;
    }

    /// Return a new zero Vector (all components initialised to 0.0f)
    static Vector zero() {
        static immutable args = [0,0,0,0][0..size];
        mixin("return new Vector" ~ args.format!("(%(%s.0f%|, %))") ~ ";");
    }

    /// Return a new unit Vector (all components initialised to 1.0f)
    static Vector one() {
        static immutable args = [1,1,1,1][0..size];
        mixin("return new Vector" ~ args.format!("(%(%s.0f%|, %))") ~ ";");
    }

    override string toString() {
        return _components.format!("(%(%s, %))");
    }
}

/// 2D Vector with components x and y.
alias Vector2 = Vector!2;
/// 3D Vector with components x, y and z.
alias Vector3 = Vector!3;
/// 4D Vector with components x, y, z and w.
alias Vector4 = Vector!4;

unittest {
    import std.stdio : writeln;
    import std.math : feqrel;
    Vector2 vec2 = new Vector2(1.0f, 2.0f);
    Vector3 vec3 = new Vector3(1.0f, 2.0f, 3.0f);
    Vector4 vec4 = new Vector4(1.0f, 2.0f, 3.0f, 4.0f);
    assert(vec2.x == 1.0f);
    assert(vec3.z == 3.0f);
    assert(vec4.w == 4.0f);
    assert(vec4.length.feqrel(5.47723f));
    auto t = new Vector3(0.0f, 0.0f, 0.0f);
    t.x += 2;
    assert(t.x == 2.0f);
    auto z = t + new Vector3(0.0f, 2.0f, 4.0f);
    assert(z.y == 2.0f);
    auto vecA = new Vector3(7.0f, 4.0f, 3.0f);
    auto vecB = new Vector3(17.0f, 6.0f, 2.0f);
    assert(Vector3.distance(vecA, vecB).feqrel(10.2469));
    assert(Vector3.distance(vecB, vecA).feqrel(10.2469));
    vecA *= 2.0f;
    vecA.writeln;
    Vector2.one.writeln;
}