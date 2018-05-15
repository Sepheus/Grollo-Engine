module grollo.mainmenu;
import grollo.engine : GameScene;

class MainMenu : GameScene {
    import allegro5.allegro;
    import grollo.gameobject;
    import grollo.utility;
    private {
        ALLEGRO_BITMAP *background = null;
        ALLEGRO_BITMAP *sceneDisplay = null;
        ALLEGRO_DISPLAY *display = null;
    }

    this(int width=640, int height=480) {
        sceneDisplay = al_create_bitmap(320,240);
        background = al_load_bitmap("assets/images/backgrounds/background.png");
        assert(background, "Unable to load background.");
        this.addObject(new Framerate(20,20));
    }

    override void render() {
        al_draw_bitmap(background, 0, 0, 0);
        GameScene.render();
    }

    ~this() {
        al_destroy_bitmap(background);
        al_destroy_bitmap(sceneDisplay);
    }
}