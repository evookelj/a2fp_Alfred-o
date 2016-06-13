class MainMenu implements Stage {

  private final FormerlyButton easierBtn = new FormerlyButton(width / 2, height / 2 - 10.0, 260.0, 80.0);
  private final FormerlyButton harderBtn = new FormerlyButton(width / 2, height / 2 + 120.0, 260.0, 80.0);

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
      text("Starting...", easierBtn._cx, easierBtn._cy - 5);
    } else {
      easierBtn.draw();
      harderBtn.draw();
      fill(stdPurple);
      text("Play Easy", easierBtn._cx, easierBtn._cy - 5);
      text("Play Hard", harderBtn._cx, harderBtn._cy - 5);
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
    if (easierBtn.contains(mouseX, mouseY)) {
      _play = 2;
    } else if (harderBtn.contains(mouseX, mouseY)) {
      _play = 1;
    }
  }

  public void handleKeyPressed() {
  }
}