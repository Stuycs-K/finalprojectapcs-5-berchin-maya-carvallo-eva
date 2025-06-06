public class Board
{
 
 public final int boardLen = SQUARE_LEN * GRID_SIZE;
 public final int xPadding = (width-boardLen)/2;
 public final int yPadding = (height-boardLen)/2;
   
 public Sweet[][] board = new Sweet[GRID_SIZE][GRID_SIZE];
 public ArrayList<Chocolate> chocolates;
 public ArrayList<Jelly> jellies;
 
 public Board(ArrayList<Chocolate> Cs, ArrayList<Jelly> Js) 
 {
   chocolates = Cs;
   jellies = Js;
   //actually initialize the board with candies and stuff here
   //first, fill in the chocolates
   for (Chocolate c : chocolates) 
     board[c.getY()][c.getX()] = c;
   //now, fill in the rest with randomly generated candies
   genNewBoard();
 }
 
 boolean animateSwap(Sweet s1, Sweet s2, int x, int y) //returns whether it's time to make the swap
 {
   if (s1 == null || ! s1.isSwappable())
     return false;
   s1.setInMotion();
   activeLevel.display();
   s1.displayMotion(x,y);
   if (s2 != null && ! s2.isSwappable()) 
   {
     s1.setStill();
     activeLevel.display();
   }
   else if (s2 != null)
     return true;
   return false;
 }
 
 void swap(Sweet s1, Sweet s2) 
 {
   if (s1 != null && s2 != null)
   {
   board[s1.getY()][s1.getX()] = s2;
   board[s2.getY()][s2.getX()] = s1;
   int tempX = s1.getX();
   int tempY = s1.getY();
   s1.setX(s2.getX());
   s1.setY(s2.getY());
   s2.setX(tempX);
   s2.setY(tempY);
   display();
   }
 }
 
 void animateFail(Sweet s1, Sweet s2)
 {
   if (s1 != null && s2 != null)
     swap(s1, s2);
 }
 
 ArrayList<Sweet> findToBreak() //careful to removeAll() when removing a result in case of duplicates
 {
   ArrayList<Sweet> result = new ArrayList<Sweet>();
   //loop through rows
   for (int i = 0; i < GRID_SIZE; i++)
   {
     //keep track of same-type candies in a row
     int count = 1;
     for (int j = 1; j < GRID_SIZE; j++)
     {
       if(board[i][j] == null)
         System.out.println(j + " " + i);
       if (board[i][j].getName().equals(board[i][j - 1].getName()) && board[i][j].isSwappable()) //chocolates don't count
       {
         count++;
       }
       else
       {
         if (count >= 3)
         {
           for (int x = 1; x <= count; x++)
           {
             result.add(board[i][j - x]);
           }
         }
         count = 1;
       }
     }
     //in case there was a breakable line of candies at the end of the row
     if (count >= 3)
     {
       for (int x = 0; x < count; x++)
       {
         result.add(board[i][board[i].length-1 - x]);
       }
     }
   }
   //loop through columns
   for (int i = 0; i < GRID_SIZE; i++)
   {
     //keep track of same-type candies in a row
     int count = 1;
     for (int j = 1; j < GRID_SIZE; j++)
     {
       if(board[j][i] == null)
         System.out.println(i + " " + j);
       if (board[j][i].getName().equals(board[j - 1][i].getName()) && board[j][i].isSwappable()) //chocolates don't count
       {
         count++;
       }
       else
       {
         if (count >= 3)
         {
           for (int x = 1; x <= count; x++)
           {
             result.add(board[j - x][i]);
           }
         }
         count = 1;
       }
     }
     //in case there was a breakable line of candies at the end of the column
     if (count >= 3)
     {
       for (int x = 0; x < count; x++)
       {
         result.add(board[board.length-1 - x][i]);
       }
     }
   }
   //now search for jellies and chocolates that need to be broken
   for (Sweet s : result) 
   {
     int x = s.getX();
     int y = s.getY();
     //search through jellies
     for (Jelly j : jellies)
       if (j.getX() == x && j.getY() == y)
         result.add(j);
     //search through the chocolates
     int[][] directions = new int[][]{{0,1},{0,-1},{1,0},{-1,0}};
     for (int[] thisNeighbor : directions) 
     {
       int neighborX = x + thisNeighbor[0];
       int neighborY = y + thisNeighbor[1];
       for (Chocolate c : chocolates)
         if (c.getX() == neighborX && c.getY() == neighborY)
           result.add(c);
     }
   }
   return result;
 }
 
 public ArrayList<Sweet> genNewBoard() //wrapper method
 {
   return genNewBoard(new ArrayList<Sweet>());
 }
 
 public ArrayList<Sweet> genNewBoard(ArrayList<Sweet> brokenCandies)
 {
   //generate new candies in empty slots
   for (int row = board.length-1; row >= 0; row--)
     for (int col = 0; col < board[row].length; col++)
       if (board[row][col] == null) 
         board[row][col] = randCandy(col,row);
   //break all candies that would be a valid swap
   ArrayList<Sweet> breakThisRound = findToBreak();
   //return if no candies broken this round (base case)
   if (breakThisRound.size() == 0)
   {
     //but first, check if there are valid swaps on the board
     /*
     while (! areSwaps())
     {
       shuffle();
       breakThisRound.addAll(findToBreak());
     }
     if (breakThisRound.size() == 0) */
       return brokenCandies;
   }
   //otherwise break the candies and genNewCandy to replace them
   for (Sweet s : breakThisRound) {
     board[s.getY()][s.getX()] = null;
     brokenCandies.add(s);
     //LATER, USE DUPLICATES TO CHECK FOR SPECIAL CANDIES TO BE SPAWNED IN
   }
   return genNewBoard(brokenCandies);
 }
 
 private Candy randCandy(int x, int y)
 {
   int colorInd = (int) (Math.random() * candyColors.length);
   return new Candy(x, y, candyNames[colorInd], candyColors[colorInd]);
 }
 
 ArrayList<Sweet> genNewCandy()
 {
   ArrayList<Sweet> broken = new ArrayList<Sweet>();
   ArrayList<Sweet> newBroken = findToBreak();
   while (newBroken.size() > 0)
   {
     animateAllBreaking(newBroken);
     for (Sweet s : newBroken)
       board[s.getY()][s.getX()] = null;
     broken.addAll(newBroken);
     newBroken = findToBreak();
   }
   return broken;
 } 
  
  void animateCandyFall(ArrayList<Sweet> toFall, int frameNum)
  { 
    for (Sweet s : toFall)
    {
      int rawX = s.getX()*SQUARE_LEN+SQUARE_LEN/2+xPadding; //<>//
      int rawY = (s.getY()-1)*SQUARE_LEN+SQUARE_LEN/2+yPadding + frameNum; //<>//
      float radius = SQUARE_LEN * .3;
      if (rawY - radius > yPadding)
        s.displayMotion(rawX,rawY);
    }
  }
  //<>//
 ArrayList<Sweet> updateCandyPositions() //<>//
 { //<>//
   ArrayList<Sweet> toFall = new ArrayList<Sweet>();  //<>//
   //search for candies atop null and bring them down one slot
   for (int row = board.length-2; row >= 0; row--)
     for (int col = 0; col < board[row].length; col++) 
       if (board[row+1][col] == null && board[row][col] != null)  //<>//
       {  //<>//
         toFall.add(board[row][col]); 
         board[row][col].setInMotion(); //<>//
         board[row][col].setY(board[row][col].getY()+1);  
         board[row+1][col] = board[row][col]; 
         board[row][col] = null; 
       } 
   //gen new candies for row 0 
   for (int col = 0; col < board[0].length; col++)  
     if (board[0][col] == null)  //<>//
     {
       board[0][col] = randCandy(col,0); 
       board[0][col].setInMotion();
       toFall.add(board[0][col]); 
     }
   return toFall;
 }
 
 void shuffle() //<>//
 {
    ArrayList<int[]> coordinates = new ArrayList<int[]>();
    for (int i = 0; i < GRID_SIZE; i++)
    {
      for (int j = 0; j < GRID_SIZE; j++)
      {
        if (board[i][j].isSwappable())
        {
          coordinates.add(new int[]{i, j}); 
        }
      }
    }
    for (int i = coordinates.size() - 1; i > 0; i--)
    {
      int x = (int)(Math.random() * (i + 1));
      Sweet temp = board[coordinates.get(i)[0]][coordinates.get(i)[1]];
      board[coordinates.get(i)[0]][coordinates.get(i)[1]] = board[coordinates.get(x)[0]][coordinates.get(x)[1]];
      board[coordinates.get(x)[0]][coordinates.get(x)[1]] = temp;
      int tempX = board[coordinates.get(i)[0]][coordinates.get(i)[1]].getX();
      int tempY = board[coordinates.get(i)[0]][coordinates.get(i)[1]].getY();
      board[coordinates.get(i)[0]][coordinates.get(i)[1]].setX(board[coordinates.get(x)[0]][coordinates.get(x)[1]].getX());
      board[coordinates.get(i)[0]][coordinates.get(i)[1]].setY(board[coordinates.get(x)[0]][coordinates.get(x)[1]].getY());
      board[coordinates.get(x)[0]][coordinates.get(x)[1]].setX(tempX);
      board[coordinates.get(x)[0]][coordinates.get(x)[1]].setY(tempY);
    }
    genNewBoard();
  }
  
  void breakAll(ArrayList<Sweet> toBreak)
  {
    for (Sweet s : toBreak)
    {
      //check if this sweet is a jelly
      if (jellies.indexOf(s) != -1)
      {
        Jelly thisSweet = jellies.get(jellies.indexOf(s));
        thisSweet.sublayer();
        if (thisSweet.getLayers() == 0)
        {
          jellies.remove(thisSweet);
          board[s.getY()][s.getX()] = null;
        }
      }
      //regular sweet (candy, chocolate, etc)
      else
        gameBoard.board[s.getY()][s.getX()] = null;
    }
  }
 
  void animateAllBreaking(ArrayList<Sweet> toBreak)
  {
    //code
    //loop through all sweets, break by ticks
  }

  boolean areSwaps()
  {
    for (int i = 0; i < board.length; i++)
      {
        for (int j = 0; j < board[i].length; j++)
        {
          if (board[i][j].canSwap())
          {
            return true; 
          }
        }
      }
    return false;
  }
 
  Sweet hoveringOver(int x, int y) 
  {
    int sweetY = (y-yPadding)/SQUARE_LEN;
    int sweetX = (x-xPadding)/SQUARE_LEN;
    if (sweetX < GRID_SIZE && sweetX >= 0 && sweetY < GRID_SIZE && sweetY >= 0)
      return gameBoard.board[sweetY][sweetX];
    return null;
  }
  
  void display()
  {
    //account for padding later
    fill(color(120,215,225)); //change to better color
    rect(xPadding, yPadding, boardLen, boardLen, 20);
    //make lines to separate different squares in grid
    //now display actual contents of board
    //start with jelly, since that's under the sweets
    for (Jelly j : jellies)
      j.display(xPadding, yPadding);
    //now the other sweets
    for (Sweet[] row : board)
    {
      for (Sweet s : row)
        if (s != null && ! s.isInMotion())
          s.display(xPadding, yPadding); 
    }
  }
 
}
