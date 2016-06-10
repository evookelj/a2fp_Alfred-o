class FormerlyButton {
  float _cx;
  float _cy;
  float _w;
  float _h;
  float x() {
    return _cx - _w / 2;
  }
  float y() {
    return _cy - _h / 2;
  }
  boolean contains(float mx, float my) {
    return mx >= x() && mx <= x() + _w && my >= y() && my <= y() + _h;
  }
  void draw() {
    stroke(stdPurple);
    fill(bgDarker);
    rect(x(), y(), _w, _h, 10.0);
  }
  FormerlyButton(float cx, float cy, float w, float h) {
    _cx = cx;
    _cy = cy;
    _w = w;
    _h = h;
  }
}