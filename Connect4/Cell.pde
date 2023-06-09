public class Cell {
  private boolean occupied;
  private int cellColor;
  private int xCor;
  private int yCor;

  public Cell(int row, int column) {
    this.occupied = false;
    this.cellColor = 0;
    xCor = 116 + column * 94;
    yCor = 178 +row * 94;
  }
  
  public Cell(int cellColor) {
    this.cellColor = cellColor;
    this.occupied = true;
  }

  public boolean isOccupied() {
    return occupied;
  }

  public void setOccupied() {
    occupied = true;
  }
  
  public int getCellColor(){
    return cellColor;
  }
  
  public void setCellColor(int cellColor){
    this.cellColor = cellColor;
  }
  
  public int getYCor(){
    return yCor;
  }
  
  public int getXCor(){
    return xCor;
  }
}
