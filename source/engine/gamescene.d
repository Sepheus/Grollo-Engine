module grollo.gamescene;
import grollo.gameobject;
import grollo.events;

interface IGameScene {
    
    void render();
    void update();
    void destroy();

    void addObject(IGameObject gameObject);
}

abstract class GameScene : IGameScene {
    import grollo.gameobject: IGameObject;
    import grollo.utility;
    import std.algorithm: sort;
    import grollo.vector2 : Vector2;
    import std.signals;

    private {
        IGameObject[] gameObjects;
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