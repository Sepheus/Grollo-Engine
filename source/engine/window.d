module engine.window;

class Window {
    import allegro5.allegro;
    import allegro5.allegro_image;
    import allegro5.allegro_font;
    import allegro5.allegro_ttf;
    import allegro5.allegro_primitives;
    import engine.engine : IGameObject, GameScene, IGameScene, Vector2;
    import std.algorithm: sort, each, remove;
    import std.signals;

    private {
        ALLEGRO_DISPLAY *display;
        ALLEGRO_EVENT_QUEUE *event_queue;
        ALLEGRO_TIMER *timer;
        ALLEGRO_EVENT ev;
        bool _closed;
        IGameScene[] gameScenes;
        immutable double FPS = 60.0;
        static uint _instanceCount;
    }

    this(int width=640, int height=480) {
        al_init();
        al_install_keyboard();
        al_init_image_addon();
        al_init_primitives_addon();
        al_init_font_addon();
        al_init_ttf_addon();
        al_install_mouse();

        display = al_create_display(width, height);
        timer = al_create_timer(1.0 / FPS);
        event_queue = al_create_event_queue();

        al_register_event_source(event_queue, al_get_display_event_source(display));
        al_register_event_source(event_queue, al_get_timer_event_source(timer));
        al_register_event_source(event_queue, al_get_keyboard_event_source());
        al_register_event_source(event_queue, al_get_mouse_event_source());

        al_start_timer(timer);

        _instanceCount++;
    }

    invariant {
        //Contractually obligate that there will not be more than once instance of this entity.  Not a singleton, there is flexibility to negotiate for potential test cases.
        assert(this._instanceCount >= 0 && this._instanceCount <= 1, "Do not create more than one Window instance.");
    }

    void addScene(IGameScene gameScene) {
        gameScenes ~= gameScene;
        this.connect(&(cast(GameScene)gameScene).watch);
    }

    void removeScene(IGameScene gameScene) {
        this.disconnect(&(cast(GameScene)gameScene).watch);
        gameScene.destroy();
        gameScenes.remove!(scene => scene == gameScene);
        gameScenes.length--;
    }

    bool cycle() {
        al_wait_for_event(event_queue, &ev);
        pollKeys();
        bool cycled;
        switch(ev.type) {
            default:
                break;
            case ALLEGRO_EVENT_MOUSE_BUTTON_DOWN:
                emit("mouseDown", new Vector2(ev.mouse.x, ev.mouse.y));
                break;
            case ALLEGRO_EVENT_MOUSE_BUTTON_UP:
                emit("mouseUp", new Vector2(ev.mouse.x, ev.mouse.y));
                break;
            case ALLEGRO_EVENT_MOUSE_AXES:
                emit("mouseMove", new Vector2(ev.mouse.x, ev.mouse.y));
                break;
            case ALLEGRO_EVENT_DISPLAY_CLOSE:
                this._closed = true;
                break;
            case ALLEGRO_EVENT_TIMER:
                cycled = true;
                break;
        }
        return cycled;
    }

    ushort pollKeys() {
        if(ev.type == ALLEGRO_EVENT_KEY_DOWN) {
        }
        else if(ev.type == ALLEGRO_EVENT_KEY_UP) {
        }
        return 0;
    }

    void update() {
        IGameScene[] finishedScenes;
        foreach(ref gameScene; gameScenes) {
            gameScene.update();
            if(gameScene.finished) { finishedScenes ~= gameScene; }
        }
        finishedScenes.each!(scene => this.removeScene(scene));
    }

    void render() {
        al_clear_to_color(al_map_rgb(0,0,0));
        foreach(ref gameScene; gameScenes) {
            if(gameScene.visible) { gameScene.render(); }
        }
        al_flip_display();
    }

    void destroy() {
        foreach(ref gameScene; gameScenes) {
            gameScene.destroy();
        }
    }

    @property const bool closed() {
        return _closed;
    }

    mixin Signal!(string, Vector2);

    ~this() {
        al_destroy_timer(timer);
        al_destroy_display(display);
        al_destroy_event_queue(event_queue);
    }
}