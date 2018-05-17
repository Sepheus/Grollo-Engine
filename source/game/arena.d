module game.arena;
import engine.engine : GameScene;

class Arena : GameScene {
    import allegro5.allegro;
    import engine.gameobject;
    import game.utility : Framerate;
    import game.player : Player;
    private {
        ALLEGRO_BITMAP *background = null;
        ALLEGRO_DISPLAY *display = null;
    }

    this(int width=640, int height=480) {
        background = al_load_bitmap("assets/images/backgrounds/background.png");
        assert(background, "Unable to load background.");
        this.addObject(new Framerate(20,20));
        this.addObject(new Player(160,100, 304, 410));  
    }

    override void render() {
        al_draw_bitmap(background, 0, 0, 0);
        GameScene.render();
    }

    ~this() {
        al_destroy_bitmap(background);
    }
}