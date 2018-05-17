module engine.texturedsprite;
import engine.sprite;

abstract class TexturedSprite : Sprite {

    import allegro5.allegro : ALLEGRO_BITMAP, al_load_bitmap,al_destroy_bitmap, al_draw_scaled_bitmap;

    private {
        ALLEGRO_BITMAP *_texture;
        float _texWidth;
        float _texHeight;
    }

    this(float x, float y, float width, float height, string assetName) {
        super(x, y, width, height);
        _texWidth = width;
        _texHeight = height;
        _texture = al_load_bitmap(cast(char*)("assets/images/" ~ assetName));
        assert(_texture, "Failed to load texture.");
    }

    override void render() { 
        al_draw_scaled_bitmap(_texture, 0, 0, _texWidth, _texHeight, position.x, position.y, width, height, 0); 
    }
    
    override void destroy() { al_destroy_bitmap(_texture); }
}