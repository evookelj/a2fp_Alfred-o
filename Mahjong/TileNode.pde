public class TileNode {
  public static final int gridWidth = 2;
  public static final int gridHeight = 3;

  private ArrayList<TileNode> _top;
  private ArrayList<TileNode> _beneathMe;
  private int _aboveMe;
  private PImage _pic;

  private int _tlRow;
  private int _tlCol;

  public TileNode(PImage pic, ArrayList<TileNode> top) {
    _pic = pic;
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
    rect((float) Board.gridCellPx * _tlCol, (float) Board.gridCellPx * _tlRow, (float) Board.gridCellPx * 2, (float) Board.gridCellPx * 3);
  }

  public void incAboveMe() {
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
}