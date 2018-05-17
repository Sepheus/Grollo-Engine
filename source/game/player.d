module game.player;
import engine.engine : TexturedSprite, Vector2;
import engine.events;

class Player : TexturedSprite, IClickable {
    import std.stdio : writeln;
    private {
        Vector2 _target;
        Vector2 _direction = Vector2.zero;
        Vector2 _heading = Vector2.one;
        Vector2 _centre;
        enum _speed = 2.0f;
        enum _scale = 0.5f;
    }

    this(float x, float y, float width, float height) {
        super(x, y, width, height, "sprites/operative/op2600.png");
        _target =  new Vector2(x, y);
        this.setScale(0.25);
        _centre = new Vector2(this.width * 0.5, this.height * 0.5);
    }

    override void update() {
        if(_heading.sqrMagnitude < 1.0f) {
        }
        else { 
            this.move(_direction * _speed);
            _heading = _target - (this.position + _centre);
        }
    }

    void onClick(string msg, Vector2 pos) {
        _target = pos;
        _heading = _target - (this.position + _centre);
        _direction = Vector2.normalize(_heading);
    }
}