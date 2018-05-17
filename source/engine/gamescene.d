module engine.gamescene;
import engine.gameobject;
import engine.events;

interface IGameScene {
    
    void render();
    void update();
    void destroy();

    void addObject(IGameObject gameObject);

    bool visible();
    void visible(bool visible);

    bool finished();
    void finished(bool finished);
}

abstract class GameScene : IGameScene {
    import engine.gameobject: IGameObject;
    import std.algorithm: sort;
    import engine.vector2 : Vector2;
    import std.signals;

    private {
        IGameObject[] gameObjects;
        bool _visible = true;
        bool _finished = false;
    }

    void addObject(IGameObject gameObject) {
        import std.stdio : writeln;
        if((cast(IClickable)gameObject)) { this.connect(&(cast(IClickable)gameObject).onClick); }
        //writeln(typeid((cast(Object)gameObject)).interfaces);
        gameObjects ~= gameObject;
        gameObjects.sort!((ref x, ref y) => x.zOrder() < y.zOrder());
    }

    @property int objectCount() const {
        return gameObjects.length;
    }

    @property bool visible() const { 
        return _visible;
    }

    @property void visible(bool visible) { 
        _visible = visible;
    }

    bool finished() {
        return _finished;
    }
    void finished(bool finished) {
        _finished = finished;
    }

    void watch(string msg, Vector2 pos) { 
        //emit(msg, pos);
        import std.algorithm;
        import std.range;
        final switch(msg) {
            case "mouseDown":
                gameObjects
                    .filter!((ref x) => cast(IClickable)x)
                    .each!((ref x) => (cast(IClickable)x).onClick(msg, pos));
                break;
            case "mouseUp":
                gameObjects
                    .filter!((ref x) => cast(IClickable)x)
                    .each!((ref x) => (cast(IClickable)x).onClick(msg, pos));
                break;
            case "mouseMove":
                gameObjects
                    .filter!((ref x) => cast(IMoveable)x)
                    .each!((ref x) => (cast(IMoveable)x).onMove(msg, pos));
                break;
        }
    }

    void update() {
        foreach(ref gameObject; gameObjects) {
            gameObject.update();
        }
    }

    void render() {
        foreach(ref gameObject; gameObjects) {
            gameObject.render();
        }
    }

    void destroy() {
        foreach(ref gameObject; gameObjects) {
            gameObject.destroy();
        }
    }

    mixin Signal!(string, Vector2);
}