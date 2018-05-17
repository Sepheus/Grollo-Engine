module game.mainmenu;
import engine.engine : GameScene;

class MainMenu : GameScene {
    import game.loginbox;
    private {
        LoginBox _loginBox;
    }

    this(int width=640, int height=480) {
        _loginBox = new LoginBox();
        this.addObject(_loginBox);
        
    }

    override void update() {
        if(_loginBox.loggedIn) { this.finished = true; }
        GameScene.update();
    }

    override void render() {
        import allegro5.allegro : al_clear_to_color, al_map_rgb;
        al_clear_to_color(al_map_rgb(51, 51, 51));
        GameScene.render();
    }
}