module grollo.utility;
import grollo.engine : IGameObject;

class Framerate : IGameObject {

    import allegro5.allegro;
    import allegro5.allegro_font;

    private {
        int x = 0;
        int y = 0;
        int z = 100;
        int frames_done = 0;
        double fps = 0.0;
        double game_time = 0.0;
        double old_time = 0.0;
        ALLEGRO_FONT *font = null;
    }

    this(int x, int y) {
        this.x = x;
        this.y = y;
        this.old_time = al_get_time();
        this.font = al_create_builtin_font();
    }


    override void update() {
        this.game_time = al_get_time();
        if(this.game_time - this.old_time >= 1.0) {
            this.fps = this.frames_done / (this.game_time - this.old_time);
            this.frames_done = 0;
            this.old_time = this.game_time;
        }
        this.frames_done++;
    }

    override void render() { al_draw_textf(this.font, al_map_rgb(0,255,0), this.x, this.y, ALLEGRO_ALIGN_LEFT, "FPS: %f", this.fps); }
    override void destroy() { al_destroy_font(this.font); }

    @property override uint zOrder() const {
        return this.z;
    }

    @property override void zOrder(uint zval) { this.z = zval; }

}