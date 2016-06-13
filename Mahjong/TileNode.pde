class TileNode {
  public static final int gridWidth = 2; //width it takes up in grid
  public static final int gridHeight = 2; //height it takes up in grid

  private ArrayList<TileNode> _top; 
  private ArrayList<TileNode> _beneathMe;
  private int _aboveMe;
  private String _imageName;
  private PImage _image;
  private int _tlRow; //row of topleft corner
  private int _tlCol; //col of topleft corner
  private int _layer; //index of occupying layer in _map

  private static final long displayInvalidDuration = 100;
  private long _displayInvalidTimeStop; //system time at which color should return from red (for invalid selection) to black

  public TileNode(ArrayList<TileNode> top, int tlRow, int tlCol, int layer, String p) {
    _top = top;
    _tlRow = tlRow;
    _tlCol = tlCol;
    _layer = layer;
    _imageName = p;
    _image = loadImage(p);
    _beneathMe = new ArrayList<TileNode>();
  }

  private void drawForm() {
    float x = (float)Board.gridCellWidth * _tlCol;
    float y = (float)Board.gridCellHeight * _tlRow;
    float w = (float)Board.gridCellWidth * gridWidth;
    float h = (float) Board.gridCellHeight * gridHeight;
    if (SHIFT) {
      x -= SHIFT_AMT * _layer;
      y -= SHIFT_AMT * _layer;
    }

    // Right and lower sides of the tile, for perspective:
    pushStyle();
    stroke(color(100, 100, 150));
    fill(color(145, 145, 200));
    rect(x + SHIFT_AMT, y + SHIFT_AMT, w, h, 8.0);
    popStyle();

    // Tile top face (shape and album cover):
    pushStyle();
    noStroke();
    rect(x, y, w, h, 8.0);
    popStyle();
    image(_image, x + (float)Board.gridCellWidth * 0.06, y + (float)Board.gridCellHeight * 0.25, (float)Board.gridCellWidth * 1.9, (float) Board.gridCellWidth * 1.9);
    pushStyle();
    noFill();
    rect(x, y, w, h, 8.0);
    popStyle();
  }

  private void drawPlain() {
    fill(color(255,255,255));
    stroke(color(0, 0, 0));
    drawForm();
  }

  private void drawInvalidChoice() {
    strokeWeight(4);
    stroke(color(255, 0, 0));
    drawForm();
    strokeWeight(1);
  }

  public void drawStandard() {
    if (_displayInvalidTimeStop > System.currentTimeMillis()) {
      drawInvalidChoice();
    } else {
      drawPlain();
    }
  }

  public void drawSelected() {
    strokeWeight(4);
    drawStandard();
    strokeWeight(1);
  }

  public void invalidlySelected() {
    _displayInvalidTimeStop = System.currentTimeMillis() + displayInvalidDuration;
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