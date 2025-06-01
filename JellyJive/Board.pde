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
 
 public ArrayList<Sweet> genNewCandy(int row, int col) {
   return genNewCandy(row, col, new ArrayList<Sweet>());
 }
 
 public ArrayList<Sweet> genNewCandy(int row, int col, ArrayList<Sweet> brokenCandies)
 {
   int colorInd = (int) (Math.random() * 3);
   board[row][col] = new Candy(col, row, "red", color(255,0,0));
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
   int sweetX = x/GRID_SIZE;
   int sweetY = y/GRID_SIZE;
   return gameBoard.board[sweetX][sweetY];
 }
 
 void display()
 {
   //account for padding later
   fill(100); //change to better color
   //make lines to separate different squares in grid
   //now display actual contents of board
   //start with jelly, since that's under the sweets
   for (Jelly j : jellies)
     j.display();
   //now the other sweets
   for (Sweet[] row : board)
     for (Sweet s : row)
       s.display();
 }
 
}
