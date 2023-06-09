public class Board {
  public Cell[][] gameBoard = new Cell[6][7];
  private final int rows = 6;
  private final int columns = 7;

  public Board() {
    for (int rowNum = 0; rowNum < rows; rowNum++) {
      for (int colNum = 0; colNum < columns; colNum++) {
        gameBoard[rowNum][colNum] = new Cell(rowNum, colNum);
      }
    }
  }

  public int findEmptyRow(int column) {
    for (int row = rows - 1; row >= 0; row--) {
      if (!gameBoard[row][column].isOccupied()) {
        return row;
      }
    }
    return -1;
  }

  public void setCellOccupied(int row, int column) {
    gameBoard[row][column].setOccupied();
  }
  
    public Cell getCell(int row, int col) {
    return gameBoard[row][col];
  }
  
  public int getRows() {
    return rows;
  }
  
  public int getColumns() {
    return columns;
  }

  public int checkDir(int xDir, int yDir, int row, int column, int piecesToCheck){
    if(piecesToCheck == 0) return 0;
    if((row < 0 || row >= rows) || (column < 0 || column >= columns) || gameBoard[row][column].getCellColor() == 0) return -10;
    return gameBoard[row][column].getCellColor() + checkDir(xDir, yDir, row + xDir, column + yDir, piecesToCheck - 1);
  }

  public int checkWin(){
    int win = 0;
    for(int row = 0; row < rows; row++){
      for(int column = 0; column < columns; column++){
        if(checkDir(0, 1, row, column, 4) == 4 || checkDir(0, 1, row, column, 4) == 8) win = checkDir(0, 1, row, column, 4);
        if(checkDir(1, 0, row, column, 4) == 4 || checkDir(1, 0, row, column, 4) == 8) win = checkDir(1, 0, row, column, 4);
        if(checkDir(1, 1, row, column, 4) == 4 || checkDir(1, 1, row, column, 4) == 8) win = checkDir(1, 1, row, column, 4);
        if(checkDir(-1, 1, row, column, 4) == 4 || checkDir(-1, 1, row, column, 4) == 8) win = checkDir(-1, 1, row, column, 4);
      }
    }
    return win/4;
  }

  public boolean isFull(){
    for(int row = 0; row < rows; row++){
      for(int column = 0; column < columns; column++){
        if(!gameBoard[row][column].isOccupied()) return false;
      }
    }
    return true;
  }

  public void updateBoard(int xCor, int colorNum) {
    int column = xCor / 94 - 1; // determine what column piece goes in based on mouse xCor
    int emptyRow = findEmptyRow(column); // find first empty row in given column
  
    if (emptyRow != -1) {
      gameBoard[emptyRow][column].setOccupied();
      gameBoard[emptyRow][column].setCellColor(colorNum);
    }
  }

  public String toString(){
     String arrString = "";
      for(int i = 0; i < gameBoard.length; i++) {
          for(int j = 0; j < gameBoard[i].length; j++) {
              arrString += gameBoard[i][j].getCellColor() + " ";
          }
          arrString += "\n";
      }
      return arrString;
  }  
}
