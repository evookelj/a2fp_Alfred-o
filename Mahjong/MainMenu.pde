class MainMenu implements Stage {

  private final FormerlyButton playBtn = new FormerlyButton(width / 2, height / 2 - 10.0, 260.0, 80.0);
  private final FormerlyButton randomBtn = new FormerlyButton(width / 2, height / 2 + 120.0, 260.0, 80.0);

  private int _play;

  public void drawFrame() {
    drawBackground();
    fill(stdPurple);
    textSize(40.0);
    textAlign(CENTER, CENTER);
    float titleX = width / 2;
    float titleY = height / 4;
    text("The Game Formerly Known as", titleX, titleY);
    textSize(60.0);
    text("Mahjong", titleX, titleY + 55.0);

    textSize(40.0);
    if (_play > 0) {
      fill(stdPurple);
      text("Starting...", playBtn._cx, playBtn._cy - 5);
    } else {
      playBtn.draw();
      randomBtn.draw();
      fill(stdPurple);
      text("Play a Preset", playBtn._cx, playBtn._cy - 5);
      text("Play Random", randomBtn._cx, randomBtn._cy - 5);
    }
  }

  public Stage runFrame() {
    drawFrame();
    if (_play > 0) {
      return new Game(_play == 1);
    }
    return this;
  }

  public void handleMouseClicked() {
    println("Handling mouse click");
    if (playBtn.contains(mouseX, mouseY)) {
      _play = 2;
    } else if (randomBtn.contains(mouseX, mouseY)) {
      _play = 1;
    }
  }

  public void handleKeyPressed() {
  }
}