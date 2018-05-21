module engine.vector;

class Vector(size_t size) {
    float[size] components;
    this(T...)(T args) if (args.length == size && allSatisfy!(isFloatingPoint, T)) {
        components = [args];
    }
}