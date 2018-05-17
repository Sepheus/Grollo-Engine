module engine.compositeobject;
import engine.gameobject : IGameObject;
import engine.vector2 : Vector2;

abstract class CompositeGameObject : IGameObject {

    private {
        Vector2 _position;
        IGameObject[] _gameObjects;
        uint _zOrder;
    }

    this(float x, float y) {
        _position = new Vector2(x,y);
        _zOrder = 1;
    }

    @property IGameObject[] gameObjects() { return _gameObjects; }

    void addObject(IGameObject gameObject) {
        _gameObjects ~= gameObject;
    }

    void update()  { 
        foreach(ref gameObject; _gameObjects) { 
            gameObject.update(); 
        } 
    }

    void render()  { 
        foreach(ref gameObject; _gameObjects) { 
            gameObject.render(); 
        } 
    }

    void destroy()  { 
        foreach(ref gameObject; _gameObjects) { 
            gameObject.destroy(); 
        } 
    }

    uint zOrder() { return _zOrder; }
    void zOrder(uint zval) { this._zOrder = zval; }
}