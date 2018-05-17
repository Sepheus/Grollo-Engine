module game.loginbox;
import engine.engine : IGameObject, Vector2, IClickable;

class LoginBox : IGameObject, IClickable {
    import allegro5.allegro : al_map_rgb;
    import allegro5.allegro_font : ALLEGRO_ALIGN_CENTER, ALLEGRO_FONT, al_load_font, al_draw_text, al_destroy_font;
    import allegro5.allegro_ttf : ALLEGRO_TTF_MONOCHROME;
    import allegro5.allegro_primitives : al_draw_filled_rectangle;
    private {
        ALLEGRO_FONT *font;
        bool _loggedIn;
        uint z;
    }

    this() {
        this.font = al_load_font("assets/fonts/AtariClassic-Regular.ttf", 20, ALLEGRO_TTF_MONOCHROME);
    }

    void onClick(string msg, Vector2 pos) {
        _loggedIn = true;
    }

    override void update() { }

    override void render() {
        al_draw_filled_rectangle(15,20,625,180, al_map_rgb(102, 102, 102));
        al_draw_filled_rectangle(15,70,625,140, al_map_rgb(0, 0 ,0));
        al_draw_text(this.font, al_map_rgb(255,255,255), 320, 35, ALLEGRO_ALIGN_CENTER, "Please enter OP id to log in:");
        al_draw_text(this.font, al_map_rgb(255,255,0), 320, 150, ALLEGRO_ALIGN_CENTER, "...");
    }

    @property loggedIn() const { return this._loggedIn; }

    @property override uint zOrder() const { return this.z;  }
    @property override void zOrder(uint zval) { this.z = zval; }

    override void destroy() {
        al_destroy_font(this.font);
    }
}