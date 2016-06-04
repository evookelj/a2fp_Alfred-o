Board b;
TileNode selected;

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
  if (selected != null) {
    selected.selectDraw();
  }
}

void mouseClicked() {
  int r = mouseY/b.gridCellPx;
  int c = mouseX/b.gridCellPx;
  for (int layer = b._map.size()-2; layer>=0; layer++) {
    if (b._map.get(layer)[r][c] != null) {
      selected = (b._map.get(layer)[r][c]);
      return ;
    }
  }
}