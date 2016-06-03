public class TileNode {
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

  public TileNode(ArrayList<TileNode> top, int tlRow, int tlCol) {
    _top = top;
    _tlRow = tlRow;
    _tlCol = tlCol;
    _beneathMe = new ArrayList<TileNode>();
  }

  public void jankDraw() {
    rect((float)Board.gridCellPx * _tlCol, (float)Board.gridCellPx * _tlRow, (float)Board.gridCellPx * 2, (float) Board.gridCellPx * 3);
  }

  public void incAboveMe() { _aboveMe += 1; }

  public void decAboveMe() {
    _aboveMe -= 1;
    if (_aboveMe <= 0) {
      _top.add(this);
    }
  }

  public ArrayList<TileNode> getBeneathMe() { return _beneathMe; }
}