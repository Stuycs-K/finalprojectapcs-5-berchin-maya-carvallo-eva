class Candy extends Sweet
{
  
  color cColor;
  
  public Candy(int x, int y, String Ccolor, color c)
  {
     super(x, y, true, Ccolor);
     cColor = c;
  }
  
  boolean canSwap(int x, int y)
  {
    Sweet[][] board = gameBoard.board;
    int[][] directions = new int[][]{{0, 1}, {-1, 0}, {0, -1}, {1, 0}};
    boolean swap = false;
    for (int i = 0; i < directions.length; i++)
    {
      if (y + directions[i][0] >= 0 && y + directions[i][0] < GRID_LEN && x + directions[i][1] >= 0 && x + directions[i][1] < GRID_LEN && board[y + directions[i][0]][x + directions[i][1]] != null)
      {
          swap(board, board[y][x], board[y + directions[i][0]][x + directions[i][1]]);
      }
      if (gameBoard.findToBreak().size() != 0)
      {  
       swap = true;
      }
      if (y + directions[i][0] >= 0 && y + directions[i][0] < GRID_LEN && x + directions[i][1] >= 0 && x + directions[i][1] < GRID_LEN && board[y + directions[i][0]][x + directions[i][1]] != null)
      {
          swap(board, board[y][x], board[y + directions[i][0]][x + directions[i][1]]);
      }
    }
    return swap;
  }
  
   void swap(Sweet[][] board, Sweet s1, Sweet s2) 
 {
   board[s1.getY()][s1.getX()] = s2;
   board[s2.getY()][s2.getX()] = s1;
   int tempX = s1.getX();
   int tempY = s1.getY();
   s1.setX(s2.getX());
   s1.setY(s2.getY());
   s2.setX(tempX);
   s2.setY(tempY);
 }
  ArrayList<int[]> scanNeighbors(int x, int y)
  {
    Sweet[][] board = gameBoard.board;
    ArrayList<int[]>possibilities = new ArrayList<int[]>();
    int[][] directions = new int[][]{{0, 1}, {-1, 0}, {0, -1}, {1, 0}};
    int[][] directions2 = new int[][]{{0, 2}, {-2, 0}, {0, -2}, {2, 0}};
    for (int i = 0; i < directions.length; i++)
    {
      if (y + directions[i][0] >= 0 && y + directions[i][0] < GRID_LEN && x + directions[i][1] > 0 && x + directions[i][1] < GRID_LEN)
      {
        String name = board[y + directions[i][0]][x + directions[i][1]].getName();
        for (int j = 0; j < directions.length; j++)
        {
          if (j != i && y + directions[j][0] >= 0 && y + directions[j][0] < GRID_LEN && x + directions[j][1] > 0 && x + directions[j][1] < GRID_LEN && board[y + directions[j][0]][x + directions[j][1]].isSwappable() && board[y + directions[j][0]][x + directions[j][1]].getName().equals(name))
          {
            if (y + directions2[j][0] >= 0 && y + directions2[j][0] < GRID_LEN && x + directions2[j][1] > 0 && x + directions2[j][1] < GRID_LEN && board[y + directions2[j][0]][x + directions2[j][1]].isSwappable() && board[y + directions2[j][0]][x + directions2[j][1]].getName().equals(name))
            {
              possibilities.add(new int[]{y + directions[i][0], x + directions[i][1], y + directions[j][0], x + directions[j][1], y + directions2[j][0], x + directions2[j][1]});
            }
          }
        }
      }
    }
    for (int i = 0; i < directions.length; i++)
    {
      String name = board[y + directions[i][0]][x + directions[i][1]].getName();
      String side1 = board[y + directions[(i + 1) % 4][0]][x + directions[(i + 1) % 4][1]].getName();
      String side2 = board[y + directions[(i - 1 + 4) % 4][0]][x + directions[(i - 1 + 4) % 4][1]].getName();
      if ( side1.equals(name) && side2.equals(name))
      {
        possibilities.add(new int[]{y + directions[i][0], x + directions[i][1], y + directions[(i + 1) % 4][0], x + directions[(i + 1) % 4][1], y + directions[(i - 1 + 4) % 4][0], x + directions[(i - 1 + 4) % 4][1]});
      }
    }
    return possibilities;
  }
  
  color getColor() 
  {
    return cColor;
  }
  
  void display(int xPadding, int yPadding) {
    fill(this.getColor());
    //draw different shapes later
    //get coord in board, multiply by grid size to place correctly, add gridsize/2 to center, add padding so it appears on the board instead of screen edge
    circle(this.getX()*GRID_LEN+GRID_LEN/2+xPadding,this.getY()*GRID_LEN+GRID_LEN/2+yPadding,GRID_LEN*.6);
  }
  
  void displayMotion(int rawX, int rawY)
  {
    if (isInMotion())
    {
      fill(this.getColor());
      //draw different shapes later
      circle(rawX, rawY, GRID_LEN*.6);
    }
  }
  
  void animateBreak() {}
  
}
