class Cell {
  float position_X;
  float position_Y;
  int numberInside;
  float size;
  color fill;
  boolean original;
  Cell(float pX, float pY, int number, float size) {


    position_X = pX;
    position_Y = pY;
    numberInside = number;
    this.size = size;
    fill =color(0);
    original = false;
  }
  void setOriginal(boolean original) {
    this.original = original;
  }

  boolean getOriginal() {
    return this.original;
  }
  void display() {
    fill(255);
    rect(position_X, position_Y, size, size);
    fill(fill);

    textAlign(CENTER);
    textSize(size/3);
    if (numberInside > 0) {
      text(numberInside, (position_X + size) - size/2, (position_Y + size)-size/2 + 10);
    }
    fill(0);

    strokeWeight(3);
    line(0, size*3, height-7, size*3);
    line(0, size*6, height-7, size*6);
    line(size*3, 0, size*3, width-7);
    line(size*6, 0, size*6, width-7);
    strokeWeight(1);
  }

  void setColor(color c) {
    fill = c;
  }
  float get_PX() {
    return position_X;
  }

  void set_PX(float pos) {
    position_X = pos;
  }

  float get_PY() {
    return position_Y;
  }

  void set_PY(float pos) {
    position_Y = pos;
  }

  int get_num() {
    return numberInside;
  }

  void set_num(int newNum) {
    numberInside = newNum;
  }
}
