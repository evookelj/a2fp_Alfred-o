class TileNode {
  public static final int gridWidth = 2; //width it takes up in grid
  public static final int gridHeight = 3; //height it takes up in grid

  private ArrayList<TileNode> _top; 
  private ArrayList<TileNode> _beneathMe;
  private int _aboveMe;
  private String _imageName;
  private PImage _image;
  private int _tlRow; //row of topleft corner
  private int _tlCol; //col of topleft corner
  private int _layer; //index of occupying layer in _map

  public TileNode(ArrayList<TileNode> top, int tlRow, int tlCol, int layer, String p) {
    _top = top;
    _tlRow = tlRow;
    _tlCol = tlCol;
    _layer = layer;
    _imageName = p;
    _image = loadImage(p);
    _beneathMe = new ArrayList<TileNode>();
  }

  private void cooooolDraw() {
    rect((float)Board.gridCellPx * _tlCol, (float)Board.gridCellPx * _tlRow, (float)Board.gridCellPx * 2, (float) Board.gridCellPx * 3, 8.0);
    image(_image, (float)Board.gridCellPx * (_tlCol + 0.06), (float)Board.gridCellPx * (_tlRow + 0.25), (float)Board.gridCellPx * 1.9, (float) Board.gridCellPx * 1.9);
  }

  public void jankDraw() {
    fill(color(255,255,255));
    stroke(color(0, 0, 0));
    cooooolDraw();
  }

  public void selectDraw() {
    strokeWeight(4);
    jankDraw();
    strokeWeight(1);
  }
  
  public void invalidDraw() {
    strokeWeight(4);
    stroke(color(255, 0, 0));
    cooooolDraw();
    strokeWeight(1);
  }

  public void incAboveMe() {
    if (_aboveMe == 0) {
      _top.remove(this);
    }
    _aboveMe += 1;
  }

  public void decAboveMe() {
    _aboveMe -= 1;
    if (_aboveMe <= 0) {
      _top.add(this);
    }
  }

  public ArrayList<TileNode> getBeneathMe() { 
    return _beneathMe;
  }
  
  public int getRow() { return _tlRow; }
  public int getCol() { return _tlCol; }
  public int getLayer() { return _layer; }
}