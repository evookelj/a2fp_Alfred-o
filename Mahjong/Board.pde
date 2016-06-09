class Board {
  public static final int gridCellWidth = 20; // width of each grid
  public static final int gridCellHeight = 30; // height of each grid cell

  private ArrayList<TileNode> _top;
  private ArrayList<TileNode[][]> _map;
  private int mapGridCols;
  private int mapGridRows;

  public Board(int w, int h) {
    _top = new ArrayList<TileNode>();
    _map = new ArrayList<TileNode[][]>();
    //amount of cols/rows in grid to hold tiles (of aXb size)
    mapGridCols = w;
    mapGridRows = h;
  }

  private void removeTile(TileNode tile) {
    // Inform tiles below of `tile`'s removal
    for (TileNode t : tile.getBeneathMe()) {
      t.decAboveMe();
    }
    // We do not have to worry about tiles containing `tile` in their _beneathMe's,
    // as in that case `tile` would be covered and thus not removable.

    // Remove its references from _top and its layer in _map
    _top.remove(tile);
    TileNode[][] layer = _map.get(tile.getLayer());
    for (int i = tile.getRow(); i < tile.getRow() + TileNode.gridHeight; i++) {
      for (int j = tile.getCol(); j < tile.getCol() + TileNode.gridWidth; j++) {
        layer[i][j] = null;
      }
    }
  }

  // If a tile is adjacent (even in part) on a tile on its left and to one
  // on its right, it cannot be selected. Top and bottom do not matter.
  public boolean isBlockedOnSides(TileNode tile) {
    TileNode[][] layerTiles = _map.get(tile.getLayer());
    boolean blockedOnLeft = false;
    boolean blockedOnRight = false;
    for (int r = tile.getRow(); r < tile.getRow() + TileNode.gridHeight; r++) {
      // Does not test for out-of-bounds errors on column because no tiles should contact the edges
      if (layerTiles[r][tile.getCol() - 1] != null) {
        blockedOnLeft = true;
      }
      if (layerTiles[r][tile.getCol() + TileNode.gridWidth] != null) {
        blockedOnRight = true;
      }
    }
    return blockedOnLeft && blockedOnRight;
  }

  // Add a vertically oriented TileNode at grid position row tlRow, column tlCol
  private void addTileAt(TileNode node, int tlRow, int tlCol, int mapLayer) {
    for (int i = tlRow; i < tlRow + TileNode.gridHeight && i < mapGridRows; i++) {
      for (int j = tlCol; j < tlCol + TileNode.gridWidth && i < mapGridCols; j++) {
        _map.get(mapLayer)[i][j] = node;
      }
    }
    // Add all the tiles occupying these spaces in lower layers to _beneathMe
    for (int layer = mapLayer - 1; layer >= 0; layer--) {
      for (int i = tlRow; i < tlRow + TileNode.gridHeight; i++) {
        for (int j = tlCol; j < tlCol + TileNode.gridWidth; j++) {
          TileNode lowerTile = _map.get(layer)[i][j];
          if (lowerTile != null && !node.getBeneathMe().contains(lowerTile)) {
            node.getBeneathMe().add(lowerTile);
          }
        }
      }
    }
    // Inform all these tiles in _beneathMe that they are covered
    for (TileNode lower : node.getBeneathMe()) {
      lower.incAboveMe();
    }
  }

  public void addTileTopLayer(int tlRow, int tlCol, String p) {
    int mapLayer = _map.size() - 1;
    TileNode tile = new TileNode(_top, tlRow, tlCol, mapLayer, p);
    addTileAt(tile, tlRow, tlCol, mapLayer);
    _top.add(tile);
  }

  public void addLayer() {
    _map.add(new TileNode[mapGridRows][mapGridCols]);
  }

  public void addPairTop(int albumIndex, int r0, int c0, int r1, int c1) {
    String fileName = albumIndex + ".png";
    addTileTopLayer(r0, c0, fileName);
    addTileTopLayer(r1, c1, fileName);
  }

  public void drawTiles() {
    for (TileNode[][] layer : _map) {
      for (int i = 0; i < layer.length; i += TileNode.gridHeight) {
        for (int j = 0; j < layer[i].length; j += TileNode.gridWidth) {
          if (layer[i][j] != null) {
            layer[i][j].drawStandard();
          }
        }
      }
    }
  }
}