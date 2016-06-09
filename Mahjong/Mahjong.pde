Board b;
int layerA;
TileNode selectA;
TileNode selectB;

void setup() {
  size(600, 420);
  b = new Board(width / 20, height / 20);
  //b.fillBottomTiles();
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
  int r = mouseY / b.gridCellPx;
  int c = mouseX / b.gridCellPx;
  for (int layer = b._map.size()-1; layer>=0; layer--) {
    TileNode[][] temp = b._map.get(layer);
    if (temp != null &&
      temp[r][c] != null &&
      !b.isSurrounded(layer, r, c) &&
      b._top.contains(temp[r][c])) {
      if (selectA == null) {
        // This is the first selection in the pair
        selectA = temp[r][c];
        layerA = layer;
      } else {
        if (temp[r][c] == selectA) { 
          // The user clicked the same tile twice, thus deselecting it
          selectA = null;
        } else {
          // The use has requested to match a pair
          if (selectA._imageName.equals(temp[r][c]._imageName)) {
            selectB = temp[r][c];
            b.remove(layerA, layer, selectA, selectB);
            selectA = null;
            selectB = null;
          } else {
            temp[r][c].invalidDraw();
          }
        }
      }
      return;
    }
  }
}