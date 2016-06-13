boolean DEBUG_MODE = false;
boolean SHIFT = true; // Shift tiles in upper layers for perspective effect
int SHIFT_AMT = 4;

Stage stage;

color bgColor = color(245, 245, 220);
color bgDarker = color(225, 225, 200);
color stdPurple = color(150, 0, 150);

void drawBackground() {
  pushStyle();
  fill(bgColor);
  stroke(stdPurple);
  strokeWeight(10.0);
  rect(3.0, 3.0, width - 6.0, height - 6.0);
  popStyle();
}

void setup() {
  size(900, 675);
  stage = new MainMenu();
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