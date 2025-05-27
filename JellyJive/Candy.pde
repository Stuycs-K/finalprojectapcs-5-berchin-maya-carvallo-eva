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
      while (checkY < GRID_SIZE && count < 2)
      {
        if (board[checkY][x].isSwappable() && board[checkY][x].getName().equals(name))
        {
           count++; 
        }
        else
        {
         count = 5; 
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
      while (checkY >= 0 && count < 2)
      {
        if (board[checkY][x].isSwappable() && board[checkY][x].getName().equals(name))
        {
           count++; 
        }
        else
        {
         count = 5; 
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
      while (checkX >= 0 && count < 2)
      {
        if (board[checkY][x].isSwappable() && board[checkY][x].getName().equals(name))
        {
           count++; 
        }
        else
        {
         count = 5; 
        }
        checkY--;
      }
      if (count == 2)
      {
        return true;
      }
    }
  }
  
}
