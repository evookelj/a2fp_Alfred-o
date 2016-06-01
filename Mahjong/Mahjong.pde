Board b;

void setup() {
  size(100, 150);
  b = new Board(20, 30);
  b.fillBottomTiles();
  b.addLayer();
  b.addTileTopLayer(5, 3);
  b.addTileTopLayer(7, 1);
}
void draw() {
  clear();
  fill(color(255, 255, 255));
  stroke(color(0, 255, 0));
  b.jankDraw();
}