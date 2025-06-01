public class Board
{
  
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
         genNewCandy(row, col);
 }
 
 ArrayList<Sweet> findToBreak()
 {
   ArrayList<Sweet> result = new ArrayList<Sweet>();
   //loop through rows
   for (int i = 0; i < GRID_SIZE; i++)
   {
     //keep track of same-type candies in a row
     int count = 1;
     for (int j = 1; j < GRID_SIZE; j++)
     {
       if (board[i][j].getName().equals(board[i][j - 1].getName()) && !(board[i][j].getName().equals("Chocolate"))) //chocolates don't count
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
         result.add(board[i][board[i].length - x]);
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
       if (board[j][i].getName().equals(board[j - 1][i].getName()) && !(board[j][i].getName().equals("Chocolate"))) //chocolates don't count
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
         result.add(board[board.length - x][i]);
       }
     }
   }
   return result;
 }
 
 public ArrayList<Sweet> genNewCandy(int row, int col) {
   return genNewCandy(row, col, new ArrayList<Sweet>());
 }
 
 public ArrayList<Sweet> genNewCandy(int row, int col, ArrayList<Sweet> brokenCandies)
 {
   int colorInd = (int) (Math.random() * candyColors.length);
   board[row][col] = new Candy(col, row, candyNames[colorInd], candyColors[colorInd]);
   //later, validate to make sure this didn't form any candy that could break
   return brokenCandies;
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
   //return the sweet the mouse is hovering over
   //account for borders between board and the background
   //then use int division to find right indices of board[][]
   //FOR NOW pretending board starts at the top left corner
   int sweetX = x/GRID_LEN;
   int sweetY = y/GRID_LEN;
   return gameBoard.board[sweetX][sweetY];
 }
 
 void display()
 {
   //account for padding later
   fill(color(120,215,225)); //change to better color
   int boardLen = GRID_LEN * GRID_SIZE;
   int xPadding = (width-boardLen)/2;
   int yPadding = (height-boardLen)/2;
   rect(xPadding, yPadding, boardLen, boardLen, 20);
   //make lines to separate different squares in grid
   //now display actual contents of board
   //start with jelly, since that's under the sweets
   for (Jelly j : jellies)
     j.display(xPadding, yPadding);
   //now the other sweets
   for (Sweet[] row : board)
     for (Sweet s : row)
       s.display(xPadding, yPadding);
 }
 
}
