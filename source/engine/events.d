module grollo.events;

interface IClickable {
    import grollo.vector2 : Vector2;
    void onClick(string msg, Vector2 pos);
}

interface IMoveable {
    import grollo.vector2 : Vector2;
    void onMove(string msg, Vector2 pos);
}