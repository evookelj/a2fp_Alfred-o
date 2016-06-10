class MainMenu implements Stage {
  private final float btnW = 140.0;
  private final float btnH = 80.0;
  private final float btnCX = width / 2;
  private final float btnCY = height / 2;
  private final float btnX = btnCX - btnW / 2;
  private final float btnY = btnCY - btnH / 2;

  private boolean _play;

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

    textSize(50.0);
    if (_play) {
      fill(stdPurple);
      text("Starting...", btnCX, btnCY - 7);
    } else {
      stroke(stdPurple);
      fill(bgDarker);
      rect(btnX, btnY, btnW, btnH, 10.0);
      fill(stdPurple);
      text("Play", btnCX, btnCY - 7);
    }
  }

  public Stage runFrame() {
    drawFrame();
    if (_play) {
      return new Game();
    }
    return this;
  }

  public void handleMouseClicked() {
    println("Handling mouse click");
    if (mouseX > btnX && mouseY > btnY &&
        mouseX < btnX + btnW && mouseY < btnY + btnH) {
      _play = true;
      println("Playing");
    }
  }

  public void handleKeyPressed() {
  }
}