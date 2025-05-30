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
 
 ArrayList<BSweet> shuffle()
 {
    ArrayList<int[]> coordinates = new ArrayList<int[]>();
    for (int i = 0; i < GRID_SIZE; i++)
    {
       for (int j = 0; j < GRID_SIZE; j++)
       {
          coordinates.add(new int[]{1, j}); 
       }
    }
    ArrayList<int[]> switches = new ArrayList<int[]>();
    for (int i = 0; i < coordinates.size(); i++)
    {
      boolean valid = true;
      while (valid){
      int x = Math.random() * GRID_SIZE;
      boolean notDouble = true;
      for (int j = 0; j < switches.size(); j++)
      {
        if (coordinates.get(x)[0] == switches.get(j)[0] && coordinates.get(x)[1] == switches.get(j)[1])
        {
            notDouble = false;
        }
      }
      if (notDouble)
      {
         switches.add(coordinates.get(x)); 
         valid = false;
      }
      }
    }
    int ind = 0;
    for (int i = 0; i < GRID_SIZE; i++)
    {
      for (int j = 0; j < GRID_SIZE; j++)
      {
         if (!(board[i][j].getName().equals("Chocoloate")) && !(board[i][j].getName().equals("Jelly")) && ind < switches.size())
         {
           BSweet temp = board[i][j];
           board[i][j] = board[switches.get(ind)[0]][switches.get(ind)[1]];
           board[switches.get(ind)[0]][switches.get(ind)[1]] = temp;
         }
         ind++;
      }
    }
    
 }
 
}
