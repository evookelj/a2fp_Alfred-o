Board b;
int layerA;
TileNode selectA;
TileNode selectB;

void setup() {
  size(600, 800);
  b = new Board(30, 20);
  b.fillBottomTiles();
  b.addLayer();
  b.addTileTopLayer(5, 3);
  b.addTileTopLayer(7, 1);
  b.addTileTopLayer(2, 11);
  b.addTileTopLayer(16, 17);
}
void draw() {
  clear();
  fill(color(255, 255, 255));
  stroke(color(0, 255, 0));
  b.jankDraw();
  if (selectA != null) {
    selectA.selectDraw();
  }
  if (selectB != null) {
    selectB.selectDraw();
  }
}

void mouseClicked() {
  int r = mouseY/b.gridCellPx;
  int c = mouseX/b.gridCellPx;
  for (int layer = b._map.size()-1; layer>=0; layer--) {
    TileNode[][] temp = b._map.get(layer);
    if ((temp != null) && 
      (temp[r][c] != null) &&
      (!(b.isSurrounded(layer, r, c))) &&
      (b._top.contains(temp[r][c]))) {
      if (selectA == null) { 
        selectA = (temp[r][c]);
        layerA = layer;
      } else { 
        if (selectA._color == temp[r][c]._color) {
          selectB = (temp[r][c]);
          b.remove(layerA, layer, selectA, selectB);
          selectA = null;
          selectB = null;
        }
      }
      return ;
    }
  }
}