module game.arena;
import engine.engine : GameScene;

class Arena : GameScene {
    import allegro5.allegro : ALLEGRO_BITMAP, al_load_bitmap, al_draw_bitmap, al_destroy_bitmap;
    import game.utility : Framerate;
    import game.player : Player;
    
    private {
        ALLEGRO_BITMAP *_background;
    }

    this(int width=640, int height=480) {
        _background = al_load_bitmap("assets/images/backgrounds/background.png");
        assert(_background, "Unable to load background.");
        this.addObject(new Framerate(20,20));
        this.addObject(new Player(160,100, 304, 410));  
    }

    override void render() {
        al_draw_bitmap(_background, 0, 0, 0);
        GameScene.render();
    }

    ~this() {
        al_destroy_bitmap(_background);
    }
}