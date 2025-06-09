class Candy extends Sweet
{

  public Candy(int x, int y, String colorName, color c)
  {
     super(x, y, true, colorName,c);
  }
  
  boolean canSwap()
  {
    int x = this.getX();
    int y = this.getY();
    if (scanNeighbors(x, y).size() == 0)
    {
      return false;
    }
    return true;
  }
  
  ArrayList<int[]> scanNeighbors(int x, int y)
  {
    Sweet[][] board = gameBoard.board;
    ArrayList<int[]>possibilities = new ArrayList<int[]>();
    int[][] directions = new int[][]{{0, 1}, {-1, 0}, {0, -1}, {1, 0}};
    int[][] directions2 = new int[][]{{0, 2}, {-2, 0}, {0, -2}, {2, 0}};
    for (int i = 0; i < directions.length; i++)
    {
      if (y + directions[i][0] >= 0 && y + directions[i][0] < GRID_SIZE && x + directions[i][1] >= 0 && x + directions[i][1] < GRID_SIZE)
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
      if (y + directions[i][0] >= 0 && y + directions[i][0] < GRID_SIZE && x + directions[i][1] >= 0 && x + directions[i][1] < GRID_SIZE && y + directions[(i + 1) % 4][0] >= 0 && y + directions[(i + 1) % 4][0] < GRID_SIZE && x + directions[(i + 1) % 4][1] >= 0 && x + directions[(i + 1) % 4][1] < GRID_SIZE && y + directions[(i - 1 + 4) % 4][0] >= 0 && y + directions[(i - 1 + 4) % 4][0] < GRID_SIZE && x + directions[(i - 1 + 4) % 4][1] >= 0 && x + directions[(i - 1 + 4) % 4][1] < GRID_SIZE)
      {
        String name = board[y + directions[i][0]][x + directions[i][1]].getName();
        String side1 = board[y + directions[(i + 1) % 4][0]][x + directions[(i + 1) % 4][1]].getName();
        String side2 = board[y + directions[(i - 1 + 4) % 4][0]][x + directions[(i - 1 + 4) % 4][1]].getName();
      if ( side1.equals(name) && side2.equals(name))
      {
        possibilities.add(new int[]{y + directions[i][0], x + directions[i][1], y + directions[(i + 1) % 4][0], x + directions[(i + 1) % 4][1], y + directions[(i - 1 + 4) % 4][0], x + directions[(i - 1 + 4) % 4][1]});
      }
      }
    }
    return possibilities;
  }
  
  void display(int xPadding, int yPadding) {
    int rawX = this.getX()*SQUARE_LEN+SQUARE_LEN/2+xPadding;
    int rawY = this.getY()*SQUARE_LEN+SQUARE_LEN/2+yPadding;
    displayRaw(rawX,rawY);
  }
  
  
  void displayRaw(int rawX, int rawY)
  {
    //check if in bounds
    float diameter = SQUARE_LEN*.6;
    if ((rawX-diameter/2 < gameBoard.xPadding || rawX+diameter/2 > gameBoard.xPadding + gameBoard.boardLen || rawY-diameter/2 < gameBoard.yPadding || rawY+diameter/2 > gameBoard.yPadding + gameBoard.boardLen)
       || (rawX-(getX()*SQUARE_LEN+gameBoard.xPadding) > 1.2*SQUARE_LEN || ((rawY-(getY()*SQUARE_LEN+gameBoard.yPadding) > 1.2*SQUARE_LEN))))
    {
      setStill();
      return;
    }
    color baseColor = this.getColor();
    color darkColor = lerpColor(baseColor, color(0), .05);
    color darkestColor = lerpColor(baseColor, color(0), .3);
    color lightColor = lerpColor(baseColor, color(255), .3);
    //base circle
    stroke(darkestColor);
    fill(baseColor);
    circle(rawX,rawY,diameter);
    //shading
    diameter *= .65;
    stroke(lightColor);
    fill(darkColor);
    circle(rawX,rawY,diameter);
  }
  
}
