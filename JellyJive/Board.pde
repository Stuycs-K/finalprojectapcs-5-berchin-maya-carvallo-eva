public class Board
{
 public BSweet[][] board = new BSweet[GRID_SIZE][GRID_SIZE];
 public ArrayList<Chocolate> chcolates;
 public ArrayList<Jelly> jellies;
 
 public Board()
 {
   
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
 }
 
 void shuffle()
 {
    ArrayList<int[]> coordinates = new ArrayList<int[]>();
    for (int i = 0; i < GRID_SIZE; i++)
    {
       for (int j = 0; j < GRID_SIZE; j++)
       {
           if (!(board[i][j].getName().equals("Chocoloate")) && !(board[i][j].getName().equals("Jelly")))
           {
             coordinates.add(new int[]{i, j}); 
           }
       }
    }
    
    for (int i = coordinates.size() - 1; i > 0; i--)
    {
       int x = (int)(Math.random() * (i + 1));
       BSweet temp = board[coordinates.get(i)[0]][coordinates.get(i)[1]];
       board[coordinates.get(i)[0]][coordinates.get(i)[1]] = board[coordinates.get(x)[0]][coordinates.get(x)[1]];
       board[coordinates.get(x)[0]][coordinates.get(x)[1]] = temp;

      }
    }

 
 ArrayList<BSweet> swap()
 {
   
 }
 
 ArrayList<BSweet> findToBreak()
 {
   ArrayList<BSweet> result = new ArrayList<BSweet>();
   for (int i = 0; i < GRID_SIZE; i++)
   {
      int count = 1;
      for (int j = 1; j < GRID_SIZE; j++)
      {
         if (board[i][j].getName().equals(board[i][j - 1].getName()) && !(board[i][j].getName().equals("Chocolate")) && !(board[i][j].getName().equals("Jelly")) && !(board[i][j - 1].getName().equals("Chocolate")) && !(board[i][j - 1].getName().equals("Jelly")))
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
     
   }
   for (int i = 0; i < GRID_SIZE; i++)
   {
      int count = 1;
      for (int j = 1; j < GRID_SIZE; j++)
      {
         if (board[j][i].getName().equals(board[j - 1][i].getName()) && !(board[j][i].getName().equals("Chocolate")) && !(board[j][i].getName().equals("Jelly")) && !(board[j - 1][i].getName().equals("Chocolate")) && !(board[j - 1][i].getName().equals("Jelly")))
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
     
   }
 }
 
 void animateSwap()
 {
   
 }
 
 void animateFail()
 {
   
 }
 
 ArrayList<BSweet> genNewCandy()
 {
   
 }
 
 void animateCandyFall()
 {
   
 }
 
 ArrayList<BSweet> explodeAgain()
 {
   
 }
 
}
