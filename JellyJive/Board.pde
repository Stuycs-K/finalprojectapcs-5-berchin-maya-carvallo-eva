public class Board
{
  
 public Sweet[][] board = new Sweet[GRID_SIZE][GRID_SIZE];
 public ArrayList<Chocolate> chocolates;
 public ArrayList<Jelly> jellies;
 private int gridLen;
 
 public Board(ArrayList<Chocolate> Cs, ArrayList<Jelly> Js) 
 {
   gridLen = 30;
   chocolates = Cs;
   jellies = Js;
   //actually initialize the board with candies and stuff here
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
 
 Sweet hoveringOver(int x, int y) {
   //return the sweet the mouse is hovering over
   //account for borders between board and the background
   //then use int division to find right indices of board[][]
 }
 
}
