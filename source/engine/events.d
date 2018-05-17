module engine.events;

interface IClickable {
    import engine.vector2 : Vector2;
    void onClick(string msg, Vector2 pos);
}

interface IMoveable {
    import engine.vector2 : Vector2;
    void onMove(string msg, Vector2 pos);
}