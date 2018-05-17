module engine.vector2;

/// Vector2 class
class Vector2 {
    import std.math : sqrt;

    float x, y;

    this(const float x = 0.0f, const float y = 0.0f) {
        this.x = x;
        this.y = y;
    }

    this(const Vector2 vec) {
        this.x = vec.x;
        this.y = vec.y;
    }

    /// Return the length of the Vector2.
    @property float length() const {
        return sqrt(this.x^^2 + this.y^^2);
    }

    /// Return the magnitude of the Vector2.
    @property float magnitude() const {
        return this.length();
    }

    /// Return the squared magnitude of the Vector2.
    @property float sqrMagnitude() const {
        return (this.x^^2 + this.y^^2);
    }


    /// Compute the distance between two Vector2 instances.
    static double distance(in Vector2 lhs, in Vector2 rhs) {
        immutable float v0 = rhs.x - lhs.x;
        immutable float v1 = rhs.y - lhs.y;
        return sqrt(v0^^2 + v1^^2);
    }

    /// In-place normalize the Vector2.
    void normalize() {
        immutable double length = sqrt(this.x^^2 + this.y^^2);
        if(length > 0.00001f) {
            this /= length;
        }
        else { this.x = this.y = 0.0f; }
    }

    /// Create a unit vector from the input vector.
    static Vector2 normalize(in Vector2 vec) {
        auto normalized = new Vector2(vec);
        normalized.normalize;
        return normalized;
    }

    /// Return a new Vector2 with the minimum values from both Vector2 instances.
    static Vector2 min(in Vector2 lhs, in Vector2 rhs) {
        return new Vector2(lhs.x < rhs.x ? lhs.x : rhs.x, lhs.y < rhs.y ? lhs.y : rhs.y);
    }

    /// Return a new Vector2 with the maximum values from both Vector2 instances.
    static Vector2 max(in Vector2 lhs, in Vector2 rhs) {
        return new Vector2(lhs.x > rhs.x ? lhs.x : rhs.x, lhs.y > rhs.y ? lhs.y : rhs.y);
    }

    /// Return a new Vector2 with all values initialised to 0.0f
    static Vector2 zero() {
        return new Vector2(0.0f, 0.0f);
    }

    /// Return a new Vector2 with all values initialised to 1.0f
    static Vector2 one() {
        return new Vector2(1.0f, 1.0f);
    }

    /// Unary operations on Vector2 such as -- and ++, ~ and * are not supported.
    Vector2 opUnary(string op)() {
        static assert(op != "*" && op != "~", "Operand " ~ op ~ " not supported on Vector2.");
        mixin("this.x = " ~ op ~ "this.x; 
               this.y = " ~ op ~ "this.y;");
        return this;
    }

    /// Vector2 on Vector2 operations such as addition and subtraction, yields a new Vector2 instance.
    Vector2 opBinary(string op)(in Vector2 rhs) const {
        return mixin("new Vector2(this.x " ~ op ~ " rhs.x, this.y " ~ op ~ " rhs.y)");
    }


    /// Scalar on Vector2 operations such as addition and subtraction, yields a new Vector2 instance.
    Vector2 opBinary(string op)(in float scalar) {
        return mixin("new Vector2(this.x " ~ op ~ " scalar, this.y " ~ op ~ " scalar)");
    }

    /// In-place Vector2 on Vector2 operations such as addition and subtraction.
    Vector2 opOpAssign(string op)(in Vector2 rhs) {
        mixin("this.x " ~ op ~ "= rhs.x; 
               this.y " ~ op ~ "= rhs.y;");
        return this;
    }

    /// In-place Scalar on Vector2 operations such as addition and subtraction.
    Vector2 opOpAssign(string op)(in float scalar) {
        mixin("this.x " ~ op ~ "= scalar;
               this.y " ~ op ~ "= scalar;");
        return this;
    }


    /// Sets Vector2 X and Y to a Scalar.
    Vector2 opAssign(in float scalar) {
        this.x = this.y = scalar;
        return this;
    }


    /// Test equality between two Vector2 instances.
    override bool opEquals(in Object o) const {
        auto rhs = cast(immutable Vector2)o;
        return (this.x == rhs.x && this.y == rhs.y);
    }


    /// Test equality between Vector2 and scalar.
    bool opEquals(in float scalar) const {
        return (this.x == scalar && this.y == scalar);
    }
}

unittest {
    /// Vector Operations
    static assert(new Vector2(1.0f, 1.0f) == new Vector2(1.0f, 1.0f));
    static assert(new Vector2(1.0f, 1.0f) != new Vector2(1.0f, 2.0f));
    static assert(new Vector2(1.0f, 1.0f) + new Vector2(1.0f, -1.0f) == new Vector2(2.0f, 0.0f));
    static assert((new Vector2(1.0f, 1.0f) += new Vector2(1.0f, -1.0f)) == new Vector2(2.0f, 0.0f));
    static assert(new Vector2(1.0f, 1.0f) - new Vector2(1.0f, -1.0f) == new Vector2(0.0f, 2.0f));
    static assert((new Vector2(1.0f, 1.0f) -= new Vector2(1.0f, -1.0f)) == new Vector2(0.0f, 2.0f));
    static assert(new Vector2(1.0f, 1.0f) * new Vector2(3.0f, -1.0f) == new Vector2(3.0f, -1.0f));
    static assert((new Vector2(1.0f, 1.0f) *= new Vector2(3.0f, -1.0f)) == new Vector2(3.0f, -1.0f));
    static assert(new Vector2(8.0f, 2.0f) / new Vector2(2.0f, -1.0f) == new Vector2(4.0f, -2.0f));
    static assert((new Vector2(8.0f, 2.0f) /= new Vector2(2.0f, -1.0f)) == new Vector2(4.0f, -2.0f));

    /// Scalar Operations
    static assert(new Vector2(1.0f, 1.0f) == 1.0);
    static assert((new Vector2(2.0f, 2.0f) = 3.0) == new Vector2(3.0f, 3.0f));
    static assert((new Vector2(1.0f, 2.0f) + 3.0) ==  new Vector2(4.0f, 5.0f));
    static assert((new Vector2(1.0f, 2.0f) += 3.0) ==  new Vector2(4.0f, 5.0f));
    static assert((new Vector2(1.0f, 2.0f) - 3.0) ==  new Vector2(-2.0f, -1.0f));
    static assert((new Vector2(1.0f, -1.0f) -= 3.0) ==  new Vector2(-2.0f, -4.0f));
    static assert((new Vector2(1.0f, 3.0f) * 4.0) == new Vector2(4.0f, 12.0f));
    static assert((new Vector2(1.0f, 3.0f) *= 4.0) == new Vector2(4.0f, 12.0f));
    static assert((new Vector2(4.0f, 12.0f) / 4.0) == new Vector2(1.0f, 3.0f));
    static assert((new Vector2(4.0f, 12.0f) /= 4.0) == new Vector2(1.0f, 3.0f));

    /// Static Methods
    static assert(Vector2.distance(new Vector2(0.0f, -1.0f), new Vector2(0.0f, 2.0f)) == 3.0f);
    static assert(Vector2.min(new Vector2(3.0f, 8.0f), new Vector2(5.0f, 2.0f)) == new Vector2(3.0f, 2.0f));
    static assert(Vector2.max(new Vector2(3.0f, 8.0f), new Vector2(5.0f, 2.0f)) == new Vector2(5.0f, 8.0f));

    /// Mutation
    auto normalized = new Vector2(42.0f, 0.0f);
    normalized.normalize();
    assert(normalized == new Vector2(1.0f, 0.0f));
}