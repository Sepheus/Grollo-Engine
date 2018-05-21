module engine.vector3;

/// 3D vector and points handling.
class Vector3 {
    import std.math : sqrt;
    float x, y, z;

    /// Create a new Vector3 instance from a given x, y and z.
    this(in float x = 0.0f, in float y = 0.0f, in float z = 0.0f) {
        this.x = x;
        this.y = y;
        this.z = z;
    }

    /// Create a Vector3 from another Vector3 instance.
    this(in Vector3 vec) {
        this.x = vec.x;
        this.y = vec.y;
        this.z = vec.z;
    }

    /// Return Vector3(1.0, 1.0, 1.0)
    static Vector3 one() {
        return new Vector3(1.0f, 1.0f, 1.0f);
    }

    /// Return Vector3(0.0, 0.0, 0.0)
    static Vector3 zero() {
        return new Vector3(0.0f, 0.0f, 0.0f);
    }

    /// Return Vector3(0.0, 0.0, -1.0)
    static Vector3 back() {
        return new Vector3(0.0f, 0.0f, -1.0f);
    }

    /// Return Vector3(0.0, 0.0, 1.0)
    static Vector3 forward() {
        return new Vector3(0.0f, 0.0f, 1.0f);
    }

    /// Return Vector3(0.0, 1.0, 0.0)
    static Vector3 up() {
        return new Vector3(0.0f, 1.0f, 0.0f);
    }

    /// Return Vector3(0.0, -1.0, 0.0)
    static Vector3 down() {
        return new Vector3(0.0f, -1.0f, 0.0f);
    }

    /// Return Vector3(-1.0, 0.0, 0.0)
    static Vector3 left() {
        return new Vector3(-1.0f, 0.0f, 0.0f);
    }

    /// Return Vector3(1.0, 0.0, 0.0)
    static Vector3 right() {
        return new Vector3(1.0f, 0.0f, 0.0f);
    }

    /// Return the length of the Vector3.
    @property float length() const {
        return sqrt(this.x^^2 + this.y^^2 + this.z^^2);
    }

    /// Return the magnitude of the Vector3.
    @property float magnitude() const {
        return this.length();
    }
    
    /// Return the squared magnitude of the Vector.
    @property float sqrMagnitude() const {
        return (this.x^^2 + this.y^^2 + this.z^^2);
    }

    /// Unary operations on Vector3 such as -- and ++, ~ and * are not supported.
    Vector3 opUnary(string op)() {
        static assert(op != "*" && op != "~", "Operand " ~ op ~ " not supported on Vector3.");
        mixin("this.x = " ~ op ~ "this.x; 
               this.y = " ~ op ~ "this.y;
               this.z = " ~ op ~ "this.z;");
        return this;
    }

    /// Vector3 on Vector3 operations such as addition and subtraction, yields a new Vector3 instance.
    Vector3 opBinary(string op)(in Vector3 rhs) const {
        return mixin("new Vector3(this.x " ~ op ~ " rhs.x, this.y " ~ op ~ " rhs.y, this.z " ~ op ~ " rhs.z)");
    }


    /// Scalar on Vector3 operations such as addition and subtraction, yields a new Vector3 instance.
    Vector3 opBinary(string op)(in float scalar) {
        return mixin("new Vector3(this.x " ~ op ~ " scalar, this.y " ~ op ~ " scalar, this.z " ~ op ~ " scalar)");
    }

    /// In-place Vector3 on Vector3 operations such as addition and subtraction.
    Vector3 opOpAssign(string op)(in Vector3 rhs) {
        mixin("this.x " ~ op ~ "= rhs.x; 
               this.y " ~ op ~ "= rhs.y;
               this.z " ~ op ~ "= rhs.z;");
        return this;
    }

    /// In-place Scalar on Vector3 operations such as addition and subtraction.
    Vector3 opOpAssign(string op)(in float scalar) {
        mixin("this.x " ~ op ~ "= scalar;
               this.y " ~ op ~ "= scalar;
               this.z " ~ op ~ "= scalar;");
        return this;
    }

    /// Sets Vector3 X and Y to a Scalar.
    Vector3 opAssign(in float scalar) {
        this.x = this.y = this.z = scalar;
        return this;
    }

    /// Test equality between two Vector3 instances.
    override bool opEquals(in Object o) const {
        auto rhs = cast(immutable Vector3)o;
        return (this.x == rhs.x && this.y == rhs.y && this.z == rhs.z);
    }

    /// Test equality between Vector3 and scalar.
    bool opEquals(in float scalar) const {
        return (this.x == scalar && this.y == scalar && this.z == scalar);
    }

    /// Access x, y and z at indices [0], [1] and [2]
    float opIndex(in int index) const
    in { assert(index >= 0 && index < 3, "Vector3 index out of bounds."); }
    do {
        final switch(index) {
            case 0:
                return x;
                break;
            case 1:
                return y;
                break;
            case 2:
                return z;
                break;
        }
    }

    /// Set x, y and z at indices [0], [1] and [2]
    Vector3 opIndexAssign(in float value, in int index)
    in { assert(index >= 0 && index < 3, "Vector3 index out of bounds."); }
    do {
        final switch(index) {
            case 0:
                this.x = value;
                break;
            case 1:
                this.y = value;
                break;
            case 2:
                this.z = value;
                break;
        }
        return this;
    }

}

unittest {
    Vector3 testVector = new Vector3(1.0f, 2.0f, 3.0f);
    assert(testVector.x == 1.0f);
    assert(testVector.y == 2.0f);
    assert(testVector.z == 3.0f);
    assert(testVector[0] == 1.0f);
    assert(testVector[1] == 2.0f);
    assert(testVector[2] == 3.0f);
    assert((testVector[0] = 4.0f) == new Vector3(4.0f, 2.0f, 3.0f));
}