Board b;
TileNode selectedTile;

void setup() {
  size(600, 420);
  b = new Board(width / 20, height / 20);
  b.addLayer();

  b.addTileTopLayer(5, 3, "0.png");
  b.addTileTopLayer(7, 1, "0.png");
  b.addTileTopLayer(7, 5, "0.png");
  b.addTileTopLayer(8, 3, "0.png");
  b.addTileTopLayer(2, 11, "1.png");
  b.addTileTopLayer(16, 17, "1.png");
}

void draw() {
  fill(color(245, 245, 220));
  stroke(color(0, 0, 0));
  rect(0, 0, width, height);
  fill(color(255, 255, 255));
  b.drawTiles();
  if (selectedTile != null) {
    selectedTile.drawSelected();
  }
}

void mouseClicked() {
  int r = mouseY / Board.gridCellPx;
  int c = mouseX / Board.gridCellPx;
  for (int layerIndex = b._map.size()-1; layerIndex >= 0; layerIndex--) {
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