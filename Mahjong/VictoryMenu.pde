class VictoryMenu implements Stage {
  private Game _game;
  private boolean _exit;

  public VictoryMenu(Game g) {
    _game = g;
    _exit = false;
  }

  public void drawFrame() {
    _game.drawFrame();
    pushStyle();
    fill(bgColor);
    stroke(color(150, 0, 150));
    strokeWeight(5);
    float msgW = width / 4;
    float msgH = height / 4;
    float msgX = width / 2 - msgW / 2;
    float msgY = height / 2 - msgH / 2;
    rect(msgX, msgY, msgW, msgH, 10.0);
    popStyle();
    fill(color(150, 0, 150));
    textAlign(CENTER, CENTER);
    textSize(40.0);
    text("You've won!", width / 2, height / 2 - 30);
    textSize(20.0);
    text("Click to continue", width / 2, height / 2 + 10);
  }

  public Stage runFrame() {
    drawFrame();
    if (_exit) {
      return new Game();
    }
    return this;
  }

  public void handleMouseClicked() {
    _exit = true;
  }

  public void handleKeyPressed() {
  }
}