boolean DEBUG_MODE = true;
boolean SHIFT = false;
Board b;
TileNode selectedTile;
int startTime;

void setup() {
  size(900, 675);
  b = new Board(width / Board.gridCellWidth, height / Board.gridCellHeight);
  //b.puzzleGen();
  //setupMapA();
  startTime = millis();
}

int[] scrambledIndices() {
  int[] imgs = new int[36]; // 36 album covers
  for (int i = 0; i < imgs.length; i++) {
    imgs[i] = i;
  }
  for (int i = 0; i < imgs.length; i++) {
    int j = (int) (Math.random() * imgs.length);
    int tmp = imgs[i];
    imgs[i] = imgs[j];
    imgs[j] = tmp;
  }
  return imgs;
}

void setupMapA() {
  int[] imgs = scrambledIndices();
  b.addLayer();
  b.addPairTop(imgs[2], 2, 8, 6, 22);
  b.addPairTop(imgs[0], 2, 10, 6, 2);
  b.addPairTop(imgs[3], 2, 12, 5, 4);
  b.addPairTop(imgs[5], 3, 16, 7, 10);
  b.addPairTop(imgs[4], 2, 14, 5, 14);
  b.addPairTop(imgs[6], 4, 22, 5, 6);
  b.addPairTop(imgs[6], 3, 18, 12, 10);
  b.addPairTop(imgs[7], 3, 20, 12, 16);
  b.addPairTop(imgs[8], 5, 16, 8, 16);
  b.addPairTop(imgs[9], 5, 12, 4, 8);
  b.addPairTop(imgs[10], 6, 8, 10, 4);
  b.addPairTop(imgs[11], 8, 2, 12, 8);
  b.addPairTop(imgs[12], 8, 14, 10, 6);
  b.addPairTop(imgs[13], 10, 8, 9, 10);
  b.addPairTop(imgs[14], 7, 12, 9, 12);
  b.addPairTop(imgs[15], 8, 18, 12, 18);
  b.addPairTop(imgs[16], 12, 12, 12, 14);
  b.addPairTop(imgs[17], 10, 18, 7, 20);
}

void draw() {
  fill(color(245, 245, 220));
  noStroke();
  rect(0, 0, width, height);
  stroke(color(0, 0, 0));
  fill(color(255, 255, 255));
  b.drawTiles();
  if (DEBUG_MODE) {
    b.drawGrid();
  }
  if (selectedTile != null) {
    selectedTile.drawSelected();
  }
  if (DEBUG_MODE) {
    fill(color(150, 0, 0));
    int r = mouseY / Board.gridCellHeight;
    int c = mouseX / Board.gridCellWidth;
    textAlign(LEFT, TOP);
    text("r" + r + "\nc" + c, c * Board.gridCellWidth, r * Board.gridCellHeight);
  }
  fill(color(0, 0, 0));
  text("Press any letter key to toggle perspective", 10 / 2, 10);
  int seconds = (millis() - startTime) / 1000;
  int minutes = seconds/60;
  seconds = seconds%60;
  if (seconds>=10) {
    text((minutes) + ":" + (seconds), 10/2, 40);
  } else {
    text((minutes) + ":0" + (seconds), 10/2, 40);
  }
  if (b._top.size() == 0) { b.victory(); }
}
void keyPressed() {
  SHIFT = !SHIFT;
}
void mouseClicked() {
  int mY = mouseY;
  int mX = mouseX;
  for (int layerIndex = b._map.size()-1; layerIndex >= 0; layerIndex--) {
    if (SHIFT) {
      mY += 3 * layerIndex;
      mX += 3 * layerIndex;
    }
    int r = (mY + 3 * layerIndex) / Board.gridCellHeight;
    int c = (mX + 3 * layerIndex) / Board.gridCellWidth;
    TileNode[][] layerTiles = b._map.get(layerIndex);
    if (layerTiles[r][c] != null &&
      !b.isBlockedOnSides(layerTiles[r][c]) &&
      b._top.contains(layerTiles[r][c])) {
      if (selectedTile == null) {
        // This is the first selection in the pair
        selectedTile = layerTiles[r][c];
      } else {
        if (layerTiles[r][c] == selectedTile) {
          // The user clicked the same tile twice, thus deselecting it
          selectedTile = null;
        } else {
          // The use has requested to match the pair (selectedTile and layerTiles[r][c])
          if (selectedTile._imageName.equals(layerTiles[r][c]._imageName)) {
            b.removeTile(selectedTile);
            b.removeTile(layerTiles[r][c]);
            selectedTile = null;
          } else {
            layerTiles[r][c].invalidlySelected();
          }
        }
      }
      return;
    }
  }
}