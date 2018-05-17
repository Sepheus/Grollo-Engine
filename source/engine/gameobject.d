module engine.gameobject;

interface IGameObject {
    void update();
    void render();
    void destroy();

    uint zOrder();
    void zOrder(uint zval);
}