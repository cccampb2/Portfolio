//Sudoku Solver (non-recursive) by Caleb C Campbell
//March 30, 2022
//I wanted to create a different sudoku solving 'algorithm' compared to the rest. I did not want any recursion. I want to use PVectors to keep track of the previous location(s).
//I know this should and can be optimized. This was my first attempt.
//*********************************

//Declare global variables that are needed in the execution
int start;
int prevCoorX = -1;
int prevCoorY = -1;
int[] find = new int[2];

float boxSize;

boolean found;
boolean needsSolving = false;

ArrayList<PVector> prev = new ArrayList<PVector>();

int[][] sBoard = {
  {7, 8, 0, 4, 0, 0, 1, 2, 0},
  {6, 0, 0, 0, 7, 5, 0, 0, 9},
  {0, 0, 0, 6, 0, 1, 0, 7, 8},
  {0, 0, 7, 0, 4, 0, 2, 6, 0},
  {0, 0, 1, 0, 5, 0, 9, 3, 0},
  {9, 0, 4, 0, 6, 0, 0, 0, 5},
  {0, 7, 0, 3, 0, 0, 0, 1, 2},
  {1, 2, 0, 0, 0, 7, 4, 0, 0},
  {0, 4, 9, 2, 0, 6, 0, 0, 7}
};

int[][] blank = {
  {0, 0, 0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0, 0, 0}
};

Cell[][] sudokuBoard = new Cell[9][9];

void setup() {
  background(255);
  size(800, 800);
  stroke(0);
  boxSize = height / 9;
  for (int i = 0; i < sudokuBoard.length; i++) {
    for (int j = 0; j < sudokuBoard.length; j++) {
      sudokuBoard[j][i] = new Cell(i*boxSize, j*boxSize, sBoard[j][i], boxSize);
      if (sudokuBoard[j][i].get_num() != 0) {
        sudokuBoard[j][i].setOriginal(true);
      }
    }
  }
}

//if key 's' is pressed start the draw loop (start the solve)
void keyPressed() {

  if (key == 's') {
    prev.clear();

    needsSolving = true;
    fill(0, 0, 255);
  } else if (key == 'r') {
    prev.clear();
    needsSolving = false;
    background(255);
    for (int i = 0; i < sudokuBoard.length; i++) {
      for (int j = 0; j < sudokuBoard.length; j++) {
        if (!sudokuBoard[j][i].getOriginal()) {
          sudokuBoard[j][i].set_num(0);
          sudokuBoard[j][i].setColor(color(0));
          sBoard[j][i] = 0;
        }
      }
    }
    for (int i = 0; i < sudokuBoard.length; i++) {
      for (int j = 0; j < sudokuBoard.length; j++) {
        sudokuBoard[i][j].display();
      }
    }
  }
}

void draw() {


  //loop through the 2d array of Cells and display it on the canvas
  for (int i = 0; i < sudokuBoard.length; i++) {
    for (int j = 0; j < sudokuBoard.length; j++) {
      sudokuBoard[i][j].display();
    }
  }
  if (needsSolving) {


    //Checking if we are using a previous location. if not find an empty cell.
    if (prevCoorX == -1 && prevCoorY == -1) {

      //find empty cell
      find = findEmptyCell(sBoard);

      //if find returns null then the puzzle is solved
      if (find == null) {
        needsSolving = false;
        prev.clear();
      }
    } else {
      //if we are using a previous location then assign the values to the find array
      find[0] = prevCoorX;
      find[1] = prevCoorY;
    }
    //if find is NOT null continue solve
    if (find != null) {

      if (prevCoorX != -1) {

        //if this is a previous location start with the number of where we left off plus 1
        start = sBoard[find[0]][find[1]] + 1;
      } else {

        //if at new empty location start looking for valid number starting at 1 (beginning)
        start = 1;
      }
      //Look for a valid number at the location we are currently at in the 2d array.
      //If we find a valid number set the found variable to true and put that valid number in the array
      //Set the color to blue of the new number that is put into the puzzle. (visual purposes)
      for (int i = start; i < 10; i++) {
        found = false;
        if (isValid(sBoard, i, find) && start == 1) {

          found = true;
          sBoard[find[0]][find[1]] = i;
          sudokuBoard[find[0]][find[1]].set_num(i);
          sudokuBoard[find[0]][find[1]].setColor(color(0, 0, 255));
          prev.add(new PVector(find[0], find[1]));
          break;
        } else if (isValid(sBoard, i, find) && start > 1 && prevCoorX != -1) {
          found = true;
          sBoard[find[0]][find[1]] = i;
          sudokuBoard[find[0]][find[1]].set_num(i);
          sudokuBoard[find[0]][find[1]].setColor(color(0, 0, 255));

          prevCoorX = -1;
          prevCoorY = -1;
          prev.add(new PVector(find[0], find[1]));
          break;
        }
      }

      if (!found && prev.size() > 0) {

        prevCoorX = int(prev.get(prev.size()-1).x);
        prevCoorY= int(prev.get(prev.size()-1).y);
        sBoard[find[0]][find[1]] = 0;
        sudokuBoard[find[0]][find[1]].set_num(0);
        prev.remove(prev.size()-1);
      }
    }
  }
}


//Print the 2d array (for debugging if needed)
void print_board(int[][]board) {
  for (int i = 0; i < board.length; i++) {
    if ( i % 3 == 0 && i != 0) {
      println("- - - - - - - - - - - - - ");
    }

    for (int j = 0; j < board.length; j++) {
      if ( j % 3 == 0 && j != 0) {
        print(" | ");
      }

      if (j == 8) {
        println(board[i][j]);
      } else {
        print(str(board[i][j]) + " ");
      }
    }
  }
}



//Check the row, the column and the box if the given number is valid and can be placed at that location
boolean isValid(int[][] board, int numberToValidate, int[] position) {

  //Check row
  for (int i = 0; i < board[0].length; i++) {
    if (board[position[0]][i] == numberToValidate && position[1] != i) {
      return false;
    }
  }
  //Check column
  for (int j = 0; j < board.length; j++) {

    if (board[j][position[1]] == numberToValidate && position[0] != j) {
      return false;
    }
  }
  // Check box
  int box_x = (floor(position[1])/ 3);
  int box_y = (floor(position[0])/ 3);
  for (int i = box_y*3; i<box_y*3+3; i++) {
    for (int j = box_x*3; j<box_x*3+3; j++) {

      if (board[i][j] == numberToValidate && i != position[0] && j != position[1]) {
        return false;
      }
    }
  }
  return true;
}



//find empty cell in the 2d array (having a zero in the location means 'empty')
int[] findEmptyCell(int[][] board) {
  int[] temp = new int[2];
  for (int i = 0; i < board.length; i++) {

    for (int j = 0; j < board[0].length; j++) {
      if (board[i][j] == 0) {
        temp[0] = i;
        temp[1] = j;
        return temp;
      }
    }
  }
  return null;
}
