abstract class Level{
  public Button playButton;
  public Board board;
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
  
  void keepPlaying(ArrayList<Sweet> brokenBySwap)
  {
    //loop:
    while (brokenBySwap.size() > 0)
    {
      board.animateAllBreaking(brokenBySwap);
      for (Sweet s: brokenBySwap)
      {
        //check if this sweet is a jelly
        if (board.jellies.indexOf(s) != -1)
        {
          Jelly thisSweet = board.jellies.get(board.jellies.indexOf(s));
          thisSweet.sublayer();
          if (thisSweet.getLayers() == 0)
          {
            board.jellies.remove(thisSweet);
            board.board[s.getY()][s.getX()] = null;
          }
        }
        else
          board.board[s.getY()][s.getX()] = null;
      }
      brokenBySwap = new ArrayList<Sweet>();
      brokenBySwap.addAll(board.genNewCandy());
      board.display();
      if (! board.areSwaps())
      {
        //board.shuffle();
        brokenBySwap.addAll(board.findToBreak());
      }
    }
    //moves--, check if fulfilledReq(), win/lose
    //later (NOT for Monday), add a way to placeChocolate if none broken this round
  }
  
  void display()
  { 
    //display background of level
    background(255);
    //display goal and difficulty on top
    //display board
    board.display();
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
  
  int getMaxMoves() 
  {
    return maxMoves;
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
   for (int i = 0; i < board.board.length; i++)
   {
       
   }
  }
  
  void addXP()
  {
    
  }
  
  void won()
  {
    
  }
  
  void lost()
  {
    
  }
  
  abstract Level returnCopy();
}
