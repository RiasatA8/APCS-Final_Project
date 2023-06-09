PImage board;
PImage spare;
PImage save;
PVector holes[] = new PVector[6];
PVector coord;
int size;
int column;
boolean done;
int start;
color pieceColor;
int colorNum;
int targetY;
int targetRow;
int targetX;
int updated;
Board gameBoard;

void setup() {
  colorNum = 1;
  pieceColor = color(0, 0, 255);
  start = 2;
  updated = 0;
  targetY = 770;
  targetRow = 5;
  size(792, 770);
  text(mouseX, 10, 10);
  text(mouseY, 10, 30);
  
  gameBoard = new Board();
  board = loadImage("board.png");
  spare = board.copy();
  save = board.copy();
  size = 42; // Updated size to half of the desired diameter (75 pixels)
  column = 0;
  coord = new PVector(column * 94 + 118, 55); // Adjusted y-coordinate to position the initial game piece above the first column
  done = false;
}

public int findTargetYCor(int xCor) {
  int column = xCor / 94 - 1; // Calculate the column based on xCor (adjust the values according to your specific layout)
  if (column >= 0 && column < gameBoard.getColumns()) {
    for (int row = gameBoard.getRows() - 1; row >= 0; row--) {
      if (!gameBoard.getCell(row, column).isOccupied()) {
        targetRow = row;
        return gameBoard.getCell(row, column).getYCor();
      }
    }
  }
  return -1; // Indicates that no empty cell was found in the column
}

void draw() {
  if(start == 2){ // TITLE SCREEN
    fill(48, 124, 238);
    rect(0, 0, 792, 770);
    
    fill(255,255,255);
    textSize(100);
    text("Connect", 175, 275);
    
    fill(255,0,0);
    textSize(150);
    text("4", 550, 285);
    
    fill(255, 216, 1);
    rect(215, 325, 375, 75);
    
    fill(0,0,0);
    textSize(50);
    text("Click To Start", 263, 380);
    
    fill(255, 0, 0);
    textSize(25);
    text("Directions: Take turns (2 Players) dropping discs into the board. Win\nby connecting four discs in a line in any direction, including diagonal.", 50, 500);
  }
  if(start == 0 || start == 1){ // DURING GAME
    targetX = mouseX;
    if(targetX < 118) targetX = 118;
    if(targetX > 718) targetX = 718;
    if (coord.y <= 55) column = targetX / 94 - 1;
    coord.x = column * 94 + 118;
    for (int i = 0; i < 6; i++) holes[i] = new PVector(column * 94 + 118, 178 + 94 * i);
  
    image(board, 0, 0); 
    if (coord.y < targetY && start == 1) coord.y += (coord.y-39) / 9;
    else if (coord.y > targetY) coord.y = targetY;
    
    if(coord.y == targetY) updated = 1;
    if(updated > 0) updated++;

    board.loadPixels();
    for (int y = 0; y < board.height; y++) {
      for (int x = 0; x < board.width; x++) {
  
        boolean withinHoles = false;
        for (int i = 0; i < 6; i++) {
          if (sqrt(pow((x - holes[i].x), 2) + pow((y - holes[i].y), 2)) <= size) {
            withinHoles = true;
            break;
          }
        }
  
        boolean withinCoord = sqrt(pow((coord.x - x), 2) + pow((coord.y - y), 2)) <= size;

        if ((withinHoles || y < 114) && withinCoord) {
          board.set(x, y, pieceColor);
          if (sqrt(pow((x - holes[targetRow].x), 2) + pow((y - holes[targetRow].y), 2)) <= size) {
            save.set(x, y, board.get(x, y));
          }
        } else {
          board.set(x, y, save.get(x, y));
        }
      }
    }
    board.updatePixels();
    
    if(coord.y == targetY){
      start = 0;
      coord.y = 55;
      if(pieceColor == color(0, 0, 255)){
        pieceColor = color(255, 0, 0);
        colorNum = 2;
      }
      else{
        pieceColor = color(0, 0, 255);
        colorNum = 1;
      }
    }
    if((gameBoard.checkWin() != 0 || gameBoard.isFull()) && updated == 50) start = 3;
  }
  
  if(start == 3){ // AFTER GAME
  
    if(gameBoard.checkWin() == 1) fill(0, 0, 255);
    else if(gameBoard.checkWin() == 2) fill(255, 0, 0);
    else fill(255, 255, 255);
    rect(0, 0, 792, 770);
    
    textSize(100);
    if(gameBoard.checkWin() == 1){
      fill(255, 0, 0);
      text("Blue Wins!", 185, 281);
    }
    else if(gameBoard.checkWin() == 2){
      fill(0, 0, 255);
      text("Red Wins!", 192, 281);
    }
    
    else{
      fill(0, 0, 0);
      text("Draw!", 268, 281);
    }
    
    fill(255, 216, 1);
    rect(215, 325, 375, 75);
    
    fill(0,0,0);
    textSize(50);
    text("Play  Again", 287, 380);
  }
}


void mousePressed(){
  if(start == 0 && gameBoard.findEmptyRow(column) != -1 && ((gameBoard.checkWin() != 1) && (gameBoard.checkWin() != 2))){
      updated = 0;
      start = 1;
      targetY = findTargetYCor(targetX);
      gameBoard.updateBoard(targetX, colorNum);
      println(gameBoard);
      println(gameBoard.checkWin());
  }
  
  if(start == 2){
    if(mouseX > 215 && mouseX < 590 && mouseY > 325 && mouseY < 400) start = 0;
  }
  
  if(start == 3){
    if(mouseX > 215 && mouseX < 590 && mouseY > 325 && mouseY < 400){
      setup();
      start = 0;
    }
  }
}
