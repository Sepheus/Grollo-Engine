module grollo.loginbox;
import grollo.engine : IGameObject, Vector2;
import grollo.events;

class LoginBox : IGameObject, IClickable {
    import allegro5.allegro;
    import allegro5.allegro_font;
    import allegro5.allegro_ttf;
    import allegro5.allegro_primitives;
    private {
        ALLEGRO_FONT *font;
        bool _loggedIn = false;
        uint z = 0;
    }

    this() {
        this.font = al_load_ttf_font("assets/fonts/AtariClassic-Regular.ttf", 20, ALLEGRO_TTF_MONOCHROME);
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