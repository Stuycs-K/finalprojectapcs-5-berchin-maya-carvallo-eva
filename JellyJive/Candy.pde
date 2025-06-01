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
    int[][] directions = new int[][]{{0, 1}, {-1, 0}, {0, -1}, {1, 0}}; //search sweets directly adjacent
    int[][] directions2 = new int[][]{{0, 2}, {-2, 0}, {0, -2}, {2, 0}}; //search sweets next to and in line with adjacent sweets
    for (int i = 0; i < directions.length; i++)
    {
      //check if there is a valid neighbor in the grid
      if (y + directions[i][0] >= 0 && y + directions[i][0] < GRID_SIZE && x + directions[i][1] > 0 && x + directions[i][1] < GRID_SIZE)
      {
        //find the sweet type of this neighbor
        String name = board[y + directions[i][0]][x + directions[i][1]].getName();
        for (int j = 0; j < directions.length; j++)
        {
          if (j != i && y + directions[j][0] >= 0 && y + directions[j][0] < GRID_SIZE && x + directions[j][1] > 0 && x + directions[j][1] < GRID_SIZE && board[y + directions[j][0]][x + directions[j][1]].isSwappable() && board[y + directions[j][0]][x + directions[j][1]].getName().equals(name))
          {
            if (y + directions2[j][0] >= 0 && y + directions2[j][0] < GRID_SIZE && x + directions2[j][1] > 0 && x + directions2[j][1] < GRID_SIZE && board[y + directions2[j][0]][x + directions2[j][1]].isSwappable() && board[y + directions2[j][0]][x + directions2[j][1]].getName().equals(name))
            {
              return true; 
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
        return true;
      }
    }
    return false;
  }
  
  ArrayList<int[]> scanNeighbors(int x, int y)
  {
    Sweet[][] board = gameBoard.board;
    ArrayList<int[]>possibilities = new ArrayList<int[]>();
    int[][] directions = new int[][]{{0, 1}, {-1, 0}, {0, -1}, {1, 0}};
    int[][] directions2 = new int[][]{{0, 2}, {-2, 0}, {0, -2}, {2, 0}};
    for (int i = 0; i < directions.length; i++)
    {
      if (y + directions[i][0] >= 0 && y + directions[i][0] < GRID_SIZE && x + directions[i][1] > 0 && x + directions[i][1] < GRID_SIZE)
      {
        String name = board[y + directions[i][0]][x + directions[i][1]].getName();
        for (int j = 0; j < directions.length; j++)
        {
          if (j != i && y + directions[j][0] >= 0 && y + directions[j][0] < GRID_SIZE && x + directions[j][1] > 0 && x + directions[j][1] < GRID_SIZE && board[y + directions[j][0]][x + directions[j][1]].isSwappable() && board[y + directions[j][0]][x + directions[j][1]].getName().equals(name))
          {
            if (y + directions2[j][0] >= 0 && y + directions2[j][0] < GRID_SIZE && x + directions2[j][1] > 0 && x + directions2[j][1] < GRID_SIZE && board[y + directions2[j][0]][x + directions2[j][1]].isSwappable() && board[y + directions2[j][0]][x + directions2[j][1]].getName().equals(name))
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
  
  void display() {
    fill(this.getColor());
    //draw different shapes later
    circle(this.getX(),this.getY(),20);
  }
  
  void animateBreak() {}
  
}
