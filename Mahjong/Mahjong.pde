boolean DEBUG_MODE = false;
boolean SHIFT = false;

Stage stage;

color bgColor = color(245, 245, 220);

void drawBackground() {
  pushStyle();
  fill(bgColor);
  noStroke();
  rect(0, 0, width, height);
  popStyle();
}

void setup() {
  size(900, 675);
  stage = new Game();
}

void draw() {
  stage = stage.runFrame();
}

void keyPressed() {
  stage.handleKeyPressed();
}

void mouseClicked() {
  stage.handleMouseClicked();
}