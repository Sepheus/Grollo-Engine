module grollo.texturedsprite;
import grollo.sprite;

abstract class TexturedSprite : Sprite {

    import allegro5.allegro : ALLEGRO_BITMAP, al_load_bitmap, al_draw_bitmap, al_destroy_bitmap;

    private {
        ALLEGRO_BITMAP *_texture = null;
    }

    this(float x, float y, float width, float height, string assetName) {
        super(x, y, width, height);
        _texture = al_load_bitmap(cast(char*)("assets/" ~ assetName));
        assert(_texture, "Failed to load texture.");
    }

    override void render() { al_draw_bitmap(_texture, position.x, position.y, 0); }
    override void destroy() { al_destroy_bitmap(_texture); }
}