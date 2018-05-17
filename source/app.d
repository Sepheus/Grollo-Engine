import engine.engine;
import game.mainmenu;
import game.arena;

void main() {
    Window gameWindow = new Window();
    gameWindow.addScene(new Arena(640, 480));
    gameWindow.addScene(new MainMenu(640,480));
    while(!gameWindow.closed()) {
        if(gameWindow.cycle()) {
            gameWindow.update();
            gameWindow.render();
        }
    }
    gameWindow.destroy();
}
