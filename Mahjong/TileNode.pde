class TileNode {
  public static final int gridWidth = 2; //width it takes up in grid
  public static final int gridHeight = 3; //height it takes up in grid

  private ArrayList<TileNode> _top; 
  private ArrayList<TileNode> _beneathMe;
  private int _aboveMe;
  private color _color;
  private int _tlRow; //row of topleft corner
  private int _tlCol; //col of topleft corner

  public TileNode(color c, ArrayList<TileNode> top) {
    _color = c;
    _top = top;
    _beneathMe = new ArrayList<TileNode>();
  }

  public TileNode(ArrayList<TileNode> top, int tlRow, int tlCol, color c) {
    _top = top;
    _tlRow = tlRow;
    _tlCol = tlCol;
    _color = c;
    _beneathMe = new ArrayList<TileNode>();
  }

  public void jankDraw() {
    fill(_color);
    rect((float)Board.gridCellPx * _tlCol, (float)Board.gridCellPx * _tlRow, (float)Board.gridCellPx * 2, (float) Board.gridCellPx * 3, 8.0);
  }

  public void selectDraw() {
    stroke(color(0, 0, 225));
    strokeWeight(4);
    this.jankDraw();
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
}