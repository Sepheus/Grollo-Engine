module grollo.sprite;
import grollo.gameobject : IGameObject; 
abstract class Sprite : IGameObject {
    import grollo.vector2 : Vector2;

    union {
        private Vector2 _position;
        public const Vector2 position;
    }

    union {
        private Vector2 _velocity;
        public const Vector2 velocity;
    }

    private {
        float _width, _height;
        uint _zOrder;
    }

    this(float x, float y, float width, float height) {
        _position = new Vector2(x, y);
        _velocity = new Vector2(0.5f, 0.0f);
        _width = width;
        _height = height;
        _zOrder = 0;
    }

    @property float width() const { return _width; }
    @property float height() const { return _height; }


    void move(float x, float y) {
        _position.x += x;
        _position.y += y;
    }

    void move(Vector2 velocity) {
        _position += velocity;
    }

    void setPosition(Vector2 position) {
        _position = position;
    }

    void render() { }
    void update() { }
    void destroy() { }
    @property uint zOrder() const { return this._zOrder; }
    @property void zOrder(uint zval) { this._zOrder = zval; }

}