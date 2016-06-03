class Board {
  public static final int gridCellPx = 20; //Size of grid cells

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

  public void fillBottomTiles() {
    if (_map.isEmpty()) {
      _map.add(new TileNode[mapGridRows][mapGridCols]);
    }
    int mapLayer = 0;
    for (int i = 0; i < mapGridRows / TileNode.gridWidth; i += TileNode.gridHeight) {
      for (int j = 0; j < mapGridCols / TileNode.gridHeight; j += TileNode.gridWidth) {
        TileNode tile = new TileNode(_top, i, j);
        addTileAt(tile, i, j, mapLayer);
        _top.add(tile);
      }
    }
    
  }

  // Add a vertically oriented TileNode at grid position row tlRow, column tlCol
  private void addTileAt(TileNode node, int tlRow, int tlCol, int mapLayer) {
    for (int i = tlRow; i < tlRow + TileNode.gridWidth; i++) {
      for (int j = tlCol; j < tlCol + TileNode.gridHeight; j++) {
        _map.get(mapLayer)[i][j] = node;
      }
    }
    // Inform all the tiles occupying these spaces in lower layers that
    // they've been covered:
    for (int layer = mapLayer - 1; layer >= 0; layer--) {
      for (int i = tlRow; i < tlRow + TileNode.gridWidth; i++) {
        for (int j = tlCol; j < tlCol + TileNode.gridHeight; j++) {
          TileNode lowerTile = _map.get(mapLayer)[i][j];
          lowerTile.incAboveMe();
          _top.remove(lowerTile);
          node.getBeneathMe().add(lowerTile);
        }
      }
    }
  }

  public void addTileTopLayer(int tlRow, int tlCol) {
    int mapLayer = _map.size() - 1;
    TileNode tile = new TileNode(_top, tlRow, tlCol);
    addTileAt(tile, tlRow, tlCol, mapLayer);
    _top.add(tile);
  }

  public void addLayer() {
    _map.add(new TileNode[mapGridRows][mapGridCols]);
  }

  public void jankDraw() {
    for (TileNode tile: _top) {
      tile.jankDraw();
    }
  }
}