module game.player;
import engine.engine : TexturedSprite, Vector2;
import engine.events;

class Player : TexturedSprite, IClickable {

    private {
        Vector2 _target;
        enum speed = 2.0f;
    }

    this(float x, float y, float width, float height) {
        super(x, y, width, height, "sprites/operative/op2600.png");
        _target =  new Vector2(x, y);

    }

    override void update() {
        if((this.position.x + (this.width / 2)) < _target.x) { this.move(new Vector2(speed, 0.0f)); }
        if((this.position.x + (this.width / 2)) > _target.x) { this.move(new Vector2(-speed, 0.0f)); }
        if((this.position.y + (this.height / 2)) < _target.y) { this.move(new Vector2(0.0f, speed)); }
        if((this.position.y + (this.height / 2)) > _target.y) { this.move(new Vector2(0.0f, -speed)); }
    }

    void onClick(string msg, Vector2 pos) {
        _target = pos;
    }
}