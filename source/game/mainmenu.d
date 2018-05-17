module grollo.mainmenu;
import grollo.engine : GameScene;

class MainMenu : GameScene {
    import allegro5.allegro;
    import grollo.gameobject;
    import grollo.utility;
    import grollo.loginbox;
    private {
        ALLEGRO_BITMAP *background = null;
        ALLEGRO_BITMAP *sceneDisplay = null;
        ALLEGRO_DISPLAY *display = null;
        LoginBox loginBox;
    }

    this(int width=640, int height=480) {
        sceneDisplay = al_create_bitmap(320,240);
        loginBox = new LoginBox();
        this.addObject(loginBox);
        
    }

    override void update() {
        if(loginBox.loggedIn) { this.finished = true; }
        GameScene.update();
    }

    override void render() {
        //al_draw_bitmap(background, 0, 0, 0);
        al_clear_to_color(al_map_rgb(51, 51, 51));
        GameScene.render();
    }

    ~this() {
        al_destroy_bitmap(sceneDisplay);
    }
}