boolean DEBUG_MODE = false;
boolean SHIFT = false;
Board b;
TileNode selectedTile;

void setup() {
  size(600, 450);
  b = new Board(width / Board.gridCellWidth, height / Board.gridCellHeight);
  /*
  b.addLayer();
  b.addTileTopLayer(5, 3, "0.png");
  b.addTileTopLayer(6, 1, "0.png");
  b.addTileTopLayer(6, 5, "0.png");
  b.addTileTopLayer(7, 3, "0.png");
  b.addTileTopLayer(2, 11, "1.png");
  b.addTileTopLayer(10, 17, "1.png");
  */
  b.puzzleGen();
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