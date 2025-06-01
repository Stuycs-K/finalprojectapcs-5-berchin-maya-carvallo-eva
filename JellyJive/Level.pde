abstract class Level{
  public Button playButton;
  private Board board;
  private int XP;
  private int GOALXP;
  private int maxMoves;
  private int movesLeft;
  private int difficulty;
  private String goal;
  
  public Level(Button play, String goal, int goalXP, int maxMoves, Board b)
  {
    //fields
    XP = 0;
    GOALXP = goalXP;
    movesLeft = 0;
    this.maxMoves = maxMoves;
    difficulty = maxMoves;
    this.goal = goal;
    playButton = play;
    board = b;
  }
  
  void display()
  { 
  }
  
  void changeDifficulty(int dif)
  { 
    if (dif < -3)
    {
     dif = -3; 
    }
    if (dif > 3)
    {
     dif = 3; 
    }
    movesLeft-=dif * 5;
    maxMoves-=dif * 5;
  }

  int getMovesLeft()
  {
    return movesLeft;
  }
  
  void addXP(int xp)
  {
    if (xp >= 0)
    {
      XP+=xp;
    }
  }

  int calcXP(Candy[] ls)
  {
    return ls.length * 3;
  }
  
  int getXP()
  {
    return XP;
  }
  
  int getGoalXP()
  {
    return GOALXP;
  }

  void placeChocolate()
  {
   for (int i = 0; i < board.length; i++)
   {
       
   }
  }
  
  void addXP()
  {
    
  }
  
  int getXP()
  {
    return XP;
  }
  
  int getGoalXP()
  {
    return GOALXP;
  }
  
  void won()
  {
    
  }
  
  void lost()
  {
    
  }
}
