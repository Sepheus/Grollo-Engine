module engine.vector;

final class Vector(ubyte size) 
if(size >= 2 && size <= 4)
{
    import std.traits : allSatisfy, isFloatingPoint;
    import std.math : sqrt;
    import std.algorithm : fold;

    private {
        static immutable _props = ['x', 'y', 'z', 'w'];
        float[size] _components;
    }

    /// Construct a new vector with the given components
    this(T...)(T components) if (components.length == size && allSatisfy!(isFloatingPoint, T)) {
        _components = [components];
    }

    static foreach(i, c; _props[0..size]) {
        mixin("@property " ~ c ~ "() const { return _components[" ~ i.stringof ~ "]; }");
        mixin("@property " ~ c ~ "(in float value) { return _components[" ~ i.stringof ~ "] = value; }");
    }

    @property length() const {
        return this.sqrMagnitude.sqrt;
    }

    @property sqrMagnitude() const {
        return _components.fold!((a, b) => a + b^^2)(0.0f);
    }

    /// Unary operations on Vector such as -- and ++, ~ and * are not supported.
    Vector opUnary(string op)() {
        static assert(op != "*" && op != "~", "Operand " ~ op ~ " not supported on Vector3.");
        static foreach(i; 0 .. size) {{
            enum component = "_components[" ~ i.stringof ~ "]";
            mixin(component ~ " = " ~ op ~ component ~ ";");
        }}
        return this;
    }
}

alias Vector2 = Vector!2;
alias Vector3 = Vector!3;
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
    vec4.length.writeln;
    assert(vec4.length.feqrel(5.47723f));
    auto t = new Vector3(0.0f, 0.0f, 0.0f);
    (t++).writeln;
}