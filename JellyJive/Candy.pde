class Candy extends BSweet{
  public Candy(int x, int y, String Ccolor)
  {
     super(x, y, true, Ccolor);
  }
  boolean scanNeighbors(int x, int y)
  {
    int checkY = y - 1;
    String name = board[checkY][x].getName();
    if (checkY >= 0 && board[checkY][x].isSwappable())
    {
      checkY = y + 1;
      int count = 0;
      while (checkY < GRID_SIZE && checkY < y + 3 && count < 2)
      {
        if (board[checkY][x].isSwappable() && board[checkY][x].getName().equals(name))
        {
           count++; 
        }
        checkY++;
      }
      if (count == 2)
      {
        return true;
      }
    }
    checkY = y + 1;
    name = board[checkY][x].getName();
    if (checkY <= GRID_SIZE && board[checkY][x].isSwappable())
    {
      checkY = y - 1;
      int count = 0;
      while (checkY >= 0 && checkY > y - 3 && count < 2)
      {
        if (board[checkY][x].isSwappable() && board[checkY][x].getName().equals(name))
        {
           count++; 
        }
        checkY--;
      }
      if (count == 2)
      {
        return true;
      }
    }
    int checkX = x + 1;
    name = board[y][checkX].getName();
    if (checkX <= GRID_SIZE && board[y][checkX].isSwappable())
    {
      checkX = x - 1;
      int count = 0;
      while (checkX >= 0 && checkX > x - 3 && count < 2)
      {
        if (board[y][checkX].isSwappable() && board[y][checkX].getName().equals(name))
        {
           count++; 
        }
        checkY--;
      }
      if (count == 2)
      {
        return true;
      }
    }
    checkX = y - 1;
    name = board[y][checkX].getName();
    if (checkX >= 0 && board[y][checkX].isSwappable())
    {
      checkX = x + 1;
      int count = 0;
      while (checkX < GRID_SIZE && checkX < x + 3 && count < 2)
      {
        if (board[y][checkX].isSwappable() && board[y][checkX].getName().equals(name))
        {
           count++; 
        }
        else
        {
         count = 5; 
        }
        checkX++;
      }
      if (count == 2)
      {
        return true;
      }
    }
    int[][] directions = new int[][]{{0, 1}, {-1, 0}, {0, -1}, {1, 0}};
    for (int i = 0; i < directions.length; i++)
    {
       name = board[y + directions[i][0]][x + directions[i][1]].getName();
       String side1 = board[y + directions[(i + 1) % 4][0]][x + directions[(i + 1) % 4][1]].getName();
       String side2 = board[y + directions[(i - 1 + 4) % 4][0]][x + directions[(i - 1 + 4) % 4][1]].getName();
       if ( side1.equals(name) && side2.equals(name))
       {
           return true;
       }
    }
    return false;
  }
  
}
