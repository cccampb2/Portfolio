//Cell class to keep track of each cell and its components

class Cell {
  float position_X; //X position
  float position_Y; //Y position
  int numberInside; //the current stored number
  float size; //how big the cell or box is going to be drawn
  color fill; //color of number
  boolean original; //if the number is an original number before the puzzle starts its solve
  
  //Constructor to set all variables
  Cell(float pX, float pY, int number, float size) {
    position_X = pX;
    position_Y = pY;
    numberInside = number;
    this.size = size;
    fill =color(0);
    original = false;
  }
  //Set the original variable
  void setOriginal(boolean original) {
    this.original = original;
  }

//Get original value
  boolean getOriginal() {
    return this.original;
  }
  //display cell on screen
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
//Set number color
  void setColor(color c) {
    fill = c;
  }
  //Get X Position
  float getPosX() {
    return position_X;
  }
//Set X Position
  void setPosX(float pos) {
    position_X = pos;
  }
//Get Y Position
  float getPosY() {
    return position_Y;
  }
//Set Y Position
  void setPosY(float pos) {
    position_Y = pos;
  }
//Get stored number
  int getNum() {
    return numberInside;
  }
//Set stored number
  void setNum(int newNum) {
    numberInside = newNum;
  }
}
