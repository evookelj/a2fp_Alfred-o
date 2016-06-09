Board b;
TileNode selectA;
TileNode selectB;

void setup() {
  size(600, 420);
  b = new Board(width / 20, height / 20);
  b.addLayer();

  b.addTileTopLayer(5, 3, "0.png");
  b.addTileTopLayer(7, 1, "0.png");
  b.addTileTopLayer(2, 11, "1.png");
  b.addTileTopLayer(16, 17, "1.png");
}
void draw() {
  fill(color(245, 245, 220));
  stroke(color(0, 0, 0));
  rect(0, 0, width, height);
  fill(color(255, 255, 255));
  b.drawTiles();
  if (selectA != null) {
    selectA.selectDraw();
  }
  if (selectB != null) {
    selectB.selectDraw();
  }
}

void mouseClicked() {
  int r = mouseY / Board.gridCellPx;
  int c = mouseX / Board.gridCellPx;
  for (int layerIndex = b._map.size()-1; layerIndex >= 0; layerIndex--) {
    TileNode[][] layerTiles = b._map.get(layerIndex);
    if (layerTiles[r][c] != null &&
        !b.isSurrounded(layerIndex, r, c) &&
        b._top.contains(layerTiles[r][c])) {
      if (selectA == null) {
        // This is the first selection in the pair
        selectA = layerTiles[r][c];
      } else {
        if (layerTiles[r][c] == selectA) {
          // The user clicked the same tile twice, thus deselecting it
          selectA = null;
        } else {
          // The use has requested to match a pair
          if (selectA._imageName.equals(layerTiles[r][c]._imageName)) {
            selectB = layerTiles[r][c];
            b.removeTile(selectA);
            b.removeTile(selectB);
            selectA = null;
            selectB = null;
          } else {
            layerTiles[r][c].invalidDraw();
          }
        }
      }
      return;
    }
  }
}