import java.util.Arrays;

public class Board
{
 
 public final int boardLen = GRID_LEN * GRID_SIZE;
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
   for (int row = board.length-1; row >= 0; row--)
     for (int col = 0; col < board[row].length; col++)
       if (board[row][col] == null)
         genNewCandy();
 }
 
 boolean animateSwap(Sweet s1, Sweet s2, int x, int y) //returns whether it's time to make the swap
 {
   if (s1 == null || ! s1.isSwappable())
     return false;
   s1.setInMotion();
   display();
   s1.displayMotion(x,y);
   if (s2 != null && ! s2.isSwappable()) 
   {
     s1.setStill();
     display();
   }
   else if (s2 != null)
     return true;
   return false;
 }
 
 void swap(Sweet s1, Sweet s2) 
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
       if (board[i][j].getName().equals(board[i][j - 1].getName()) && !(board[i][j].getName().equals("chocolate"))) //chocolates don't count
       {
         count++;
       }
       else
       {
         if (count >= 3)
         {
           for (int x = 0; x < count; x++)
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
       if (board[j][i].getName().equals(board[j - 1][i].getName()) && !(board[j][i].getName().equals("chocolate"))) //chocolates don't count
       {
         count++;
       }
       else
       {
         if (count >= 3)
         {
           for (int x = 0; x < count; x++)
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
 
 public ArrayList<Sweet> genNewCandy() //wrapper method
 {
   return genNewCandy(new ArrayList<Sweet>());
 }
 
 public ArrayList<Sweet> genNewCandy(ArrayList<Sweet> brokenCandies)
 {
   //generate new candies in empty slots
   for (int row = board.length-1; row >= 0; row--)
     for (int col = 0; col < board[row].length; col++)
       if (board[row][col] == null) 
       {
         int colorInd = (int) (Math.random() * candyColors.length);
         board[row][col] = new Candy(col, row, candyNames[colorInd], candyColors[colorInd]);
       }
   //break all candies that would be a valid swap
   ArrayList<Sweet> breakThisRound = findToBreak();
   //return if no candies broken this round (base case)
   if (breakThisRound.size() == 0)
     return brokenCandies;
   //otherwise break the candies and genNewCandy to replace them
   animateAllBreaking(breakThisRound);
   for (Sweet s : breakThisRound) {
     board[s.getY()][s.getX()] = null;
     brokenCandies.add(s);
     //LATER, USE DUPLICATES TO CHECK FOR SPECIAL CANDIES TO BE SPAWNED IN
   }
   return genNewCandy(brokenCandies);
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
   if (x < xPadding || x > xPadding + boardLen || y < yPadding || y > yPadding + boardLen)
     return null;
   int sweetY = (y-yPadding)/GRID_LEN;
   int sweetX = (x-xPadding)/GRID_LEN;
   return gameBoard.board[sweetY][sweetX];
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
     for (Sweet s : row)
       if (! s.isInMotion())
         s.display(xPadding, yPadding);
 }
 
}
