class Game implements Stage {
  private Board b;
  private TileNode selectedTile;
  private int startTime;
  private int curTime;
  private boolean _randLayout;
  private boolean _quit;
  private ArrayList<ArrayList<Integer>> mapA;
  private ArrayList[][] mapB;

  private final FormerlyButton quitBtn = new FormerlyButton(width - 50, 40, 50, 35);

  public Game(boolean random) {
    _randLayout = random;
  }

  // This is run on the first frame:
  public void init() {
    b = new Board(width / Board.gridCellWidth, height / Board.gridCellHeight);
    if (_randLayout) {
      b.puzzleGen();
    } else {
      initMapB();
      //initMapA();
    }
    startTime = millis();
  }

  private int[] scrambledIndices() {
    int[] imgs = new int[36]; // 36 album covers
    for (int i = 0; i < imgs.length; i++) {
      imgs[i] = i;
    }
    for (int i = 0; i < imgs.length; i++) {
      int j = (int) (Math.random() * imgs.length);
      int tmp = imgs[i];
      imgs[i] = imgs[j];
      imgs[j] = tmp;
    }
    return imgs;
  }

  private void initMapB() {
    mapB = new ArrayList[3][12];
    for (int l=0; l<mapB.length; l++) {
      for (int r=0; r<mapB[l].length; r++) {
        mapB[l][r] = new ArrayList();
      }
    }
    for (int layer=0; layer<3; layer++) {
      if (layer<2) {
        for (int r=2; r<12; r++) {
          if (r==2 || r==10) {
            mapB[layer][r].add(2);
            mapB[layer][r].add(4);
            mapB[layer][r].add(6);
            mapB[layer][r].add(8);
            mapB[layer][r].add(10);
            mapB[layer][r].add(12);
            mapB[layer][r].add(14);
            mapB[layer][r].add(16);
            mapB[layer][r].add(18);
          }
          if (r==4 || r==8) {
            mapB[layer][r].add(2);
            mapB[layer][r].add(18);
          }
          if (r==5 || r==7) {
            mapB[layer][r].add(6);
            mapB[layer][r].add(8);
            mapB[layer][r].add(10);
            mapB[layer][r].add(12);
            mapB[layer][r].add(14);
          }
        }
      } else {
        for (int r=2; r<12; r+= 8) {
          mapB[layer][r].add(7);
          mapB[layer][r].add(9);
          mapB[layer][r].add(11);
          mapB[layer][r].add(13);
        }
      }
    }
    createMapB();
  }

  private void createMapB() {
    int l0count = 10;
    int l1count = 7;
    b.addLayer();
    int[] imgs = scrambledIndices();
    while (l0count > 0) {
      int picInd = (int)(Math.random() * imgs.length);
      int r0, c0, r1, c1;
      do {
        do {
          r0 = (int)(Math.random() * mapB[0].length);
        } while (mapB[0][r0].isEmpty());
        int c0ind = (int)(Math.random() * mapB[0][r0].size());
        c0 = (Integer)mapB[0][r0].get(c0ind);
      } while ((!b.isEmpty(0, r0) && (r0 == 4 || r0 == 8 || !b.isBlockedOneSide(0, r0, c0))) || b._map.get(0)[r0][c0] != null);

      do {
        do {
          r1 = (int)(Math.random() * mapB[0].length);
        } while (mapB[0][r1].isEmpty());
        int c1ind = (int)(Math.random() * mapB[0][r1].size());
        c1 = (Integer)mapB[0][r1].get(c1ind);
      } while ((!b.isEmpty(0, r1) && (r1 == 4 || r1 == 8 || !b.isBlockedOneSide(0, r1, c1))) || b._map.get(0)[r1][c1] != null || (r1==r0 && c1==c0));
      b.addPairTop(picInd, r0, c0, r1, c1);
      mapB[0][r0].remove(new Integer(c0));
      println("r1 " + r1 + " c1 " + c1);
      mapB[0][r1].remove(new Integer(c1));
      l0count--;
    }
    if (l1count > 0) { b.addLayer(); }
    while (l1count > 0) {
      println("onward");
      int picInd = (int)(Math.random()*imgs.length);
      int r0, c0, r1, c1;
      // The first in the pair is in the first layer
      do {
        do {
          r0 = (int)(Math.random() * mapB[0].length);
        } while (mapB[0][r0].isEmpty());
        int c0ind = (int)(Math.random() * mapB[0][r0].size());
        c0 = (Integer)mapB[0][r0].get(c0ind);
        println("trying an option (tile 0)");
      } while ((!b.isEmpty(0, r0) && (r0 == 4 || r0 == 8 || !b.isBlockedOneSide(0, r0, c0))) || b._map.get(0)[r0][c0] != null);

      do {
        do {
          r1 = (int)(Math.random() * mapB[1].length);
        } while (mapB[1][r1].isEmpty());
        int c1ind = (int)(Math.random() * mapB[1][r1].size());
        c1 = (Integer)mapB[1][r1].get(c1ind);
        println("trying an option (tile 1)");
      } while ((!b.isEmpty(1, r1) && (r1 == 4 || r1 == 8 || !b.isBlockedOneSide(0, r1, c1))) || b._map.get(1)[r1][c1] != null || !b.isFullySupported(1, r1,c1));

      b.addTileAt(new TileNode(b._top, r0, c0, 0, picInd + ".png"), r0, c0, 0);
      b.addTileTopLayer(r1, c1, picInd + ".png");
      println("added tiles"); 
      mapB[0][r0].remove(new Integer(c0));
      println("r1 " + r1 + " c1 " + c1);
      mapB[1][r1].remove(new Integer(c1));
      l1count--;
    }
  }

  private void initMapA() {
    mapA = new ArrayList<ArrayList<Integer>>();
    for (int i=0; i<b.mapGridRows; i++) { 
      mapA.add(new ArrayList<Integer>());
    }
    mapA.get(2).add(10);
    mapA.get(2).add(12);
    mapA.get(2).add(14);
    mapA.get(3).add(16);
    mapA.get(3).add(18);
    mapA.get(3).add(20);
    mapA.get(4).add(8);
    mapA.get(4).add(22);
    mapA.get(5).add(6);
    mapA.get(5).add(12);
    mapA.get(5).add(14);
    mapA.get(5).add(16);
    mapA.get(6).add(2);
    mapA.get(6).add(8);
    mapA.get(6).add(22);
    mapA.get(7).add(10);
    mapA.get(7).add(12);
    mapA.get(7).add(20);
    mapA.get(8).add(2);
    mapA.get(8).add(14);
    mapA.get(8).add(16);
    mapA.get(8).add(18);
    mapA.get(9).add(10);
    mapA.get(9).add(12);
    mapA.get(10).add(4);
    mapA.get(10).add(6);
    mapA.get(10).add(8);
    mapA.get(10).add(18);
    mapA.get(12).add(8);
    mapA.get(12).add(10);
    mapA.get(12).add(12);
    mapA.get(12).add(14);
    mapA.get(12).add(16);
    mapA.get(12).add(18);
    createMapA();
  }

  public void createMapA() {
    b.addLayer();
    int[] imgs = scrambledIndices();
    for (int i=0; i<15; i++) {
      int picInd = (int)(Math.random()*imgs.length);
      int r0, c0, r1, c1, c0ind, c1ind;
      do {
        do {
          r0 = (int)(Math.random() * mapA.size());
        } while (mapA.get(r0).isEmpty());
        c0ind = (int)(Math.random() * (mapA.get(r0).size()-1));
        c0 = mapA.get(r0).get(c0ind);
      } while (!b.isEmpty(0, r0) && b.isBlockedOnSides(0, r0, c0) || b._map.get(0)[r0][c0] != null);

      do {
        do {
          r1 = (int)(Math.random() * mapA.size());
        } while (mapA.get(r1).isEmpty());
        c1ind = (int)(Math.random() * (mapA.get(r1).size()-1));
        c1 = mapA.get(r1).get(c1ind);
      } while (!b.isEmpty(0, r0) && b.isBlockedOnSides(0, r0, c0) || b._map.get(0)[r1][c1] != null
        || (r1==r0 && c1==c0));
      mapA.get(r0).remove(c0ind);
      mapA.get(r1).remove(c1ind);
      b.addPairTop(picInd, r0, c0, r1, c1);
    }
  }

  private void setupMapA() {
    int[] imgs = scrambledIndices();
    b.addLayer();
    b.addPairTop(imgs[2], 2, 8, 6, 22);
    b.addPairTop(imgs[0], 2, 10, 6, 2);
    b.addPairTop(imgs[3], 2, 12, 5, 4);
    b.addPairTop(imgs[5], 3, 16, 7, 10);
    b.addPairTop(imgs[4], 2, 14, 5, 14);
    b.addPairTop(imgs[6], 4, 22, 5, 6);
    b.addPairTop(imgs[6], 3, 18, 12, 10);
    b.addPairTop(imgs[7], 3, 20, 12, 16);
    b.addPairTop(imgs[8], 5, 16, 8, 16);
    b.addPairTop(imgs[9], 5, 12, 4, 8);
    b.addPairTop(imgs[10], 6, 8, 10, 4);
    b.addPairTop(imgs[11], 8, 2, 12, 8);
    b.addPairTop(imgs[12], 8, 14, 10, 6);
    b.addPairTop(imgs[13], 10, 8, 9, 10);
    b.addPairTop(imgs[14], 7, 12, 9, 12);
    b.addPairTop(imgs[15], 8, 18, 12, 18);
    b.addPairTop(imgs[16], 12, 12, 12, 14);
    b.addPairTop(imgs[17], 10, 18, 7, 20);
  }

  public void drawFrame() {
    drawBackground();
    b.drawTiles();
    quitBtn.draw();
    fill(stdPurple);
    textSize(20);
    textAlign(CENTER, CENTER);
    text("Quit", quitBtn._cx, quitBtn._cy - 3);

    if (DEBUG_MODE) {
      b.drawGrid();
    }
    if (selectedTile != null) {
      selectedTile.drawSelected();
    }

    if (DEBUG_MODE) {
      fill(color(150, 0, 0));
      int r = mouseY / Board.gridCellHeight;
      int c = mouseX / Board.gridCellWidth;
      textAlign(LEFT, TOP);
      text("r" + r + "\nc" + c, c * Board.gridCellWidth, r * Board.gridCellHeight);
      fill(color(0, 0, 0));
      text("Press any letter key to toggle perspective", width / 2, 10);
    }
    fill(color(0, 0, 0));
    textSize(30.0);
    textAlign(LEFT, TOP);
    int seconds = (curTime - startTime) / 1000;
    int minutes = seconds / 60;
    seconds = seconds % 60;
    if (seconds >= 10) {
      text((minutes) + ":" + (seconds), 10, 10);
    } else {
      text((minutes) + ":0" + (seconds), 10, 10);
    }
  }

  // runFrame returns a Stage which will continue execution
  public Stage runFrame() {
    if (_quit) {
      return new MainMenu();
    }
    if (b == null) {
      init();
    }
    curTime = millis();
    drawFrame();
    if (b._top.size() == 0) {
      return new VictoryMenu(this);
    }
    return this;
  }

  public void handleKeyPressed() {
    SHIFT = !SHIFT;
  }
  public void handleMouseClicked() {
    if (quitBtn.contains(mouseX, mouseY)) {
      _quit = true;
      return;
    }
    int mY = mouseY;
    int mX = mouseX;
    for (int layerIndex = b._map.size()-1; layerIndex >= 0; layerIndex--) {
      if (SHIFT) {
        mY += 3 * layerIndex;
        mX += 3 * layerIndex;
      }
      int r = mY / Board.gridCellHeight;
      int c = mX / Board.gridCellWidth;
      TileNode[][] layerTiles = b._map.get(layerIndex);
      if (layerTiles[r][c] == null) {
        return;
      }
      TileNode curSelection = layerTiles[r][c];
      if (curSelection == selectedTile) {
        // The user clicked the same tile twice, thus deselecting it
        selectedTile = null;
      } else if (!b.isBlockedOnSides(layerIndex, curSelection.getRow(), curSelection.getCol()) &&
        b._top.contains(curSelection)) {
        // User has clicked a tile
        println(curSelection._imageName);
        if (selectedTile == null) {
          // This is the first selection in the pair
          selectedTile = curSelection;
        } else {
          // The use has requested to match the pair (selectedTile and layerTiles[r][c])
          if (selectedTile._imageName.equals(curSelection._imageName)) {
            b.removeTile(selectedTile);
            b.removeTile(curSelection);
            selectedTile = null;
          } else {
            curSelection.invalidlySelected();
          }
        }
      }
    }
  }
}