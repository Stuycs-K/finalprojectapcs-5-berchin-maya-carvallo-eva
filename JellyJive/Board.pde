public class Board
{
 public BSweet[][] board = new BSweet[GRID_SIZE][GRID_SIZE];
 public ArrayList<Chocolate> chcolates;
 
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
 }
 
  
}
