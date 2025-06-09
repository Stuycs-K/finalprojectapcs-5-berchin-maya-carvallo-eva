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
    movesLeft = maxMoves;
    this.maxMoves = maxMoves;
    difficulty = maxMoves;
    this.goal = goal;
    playButton = play;
    board = b;
  }
  
  void keepPlaying(ArrayList<Sweet> brokenBySwap)
  {
    //later (NOT for Monday), add a way to placeChocolate if none broken this round
    addXP(brokenBySwap.size());
    movesLeft--;
    if (fulfilledReq())
    {
       win(); 
    }
    else if (movesLeft <= 0)
    {
       lose(); 
    }
    display();
  }
  
  void display()
  { 
    if (! gameEnded)
    {
      //display background of level
      background(255);
      //display goal and difficulty on top
      displayTop();
      //display board
      board.display();
      back.displayButton();
      textSize(40);
      fill(0, 0, 0);
      text("Moves left: " + movesLeft, 650, 150); 
    }
  }
  
  void displayTop()
  {
    //xp bar
    color xpBase = color(220,200,210);
    fill(xpBase);
    stroke(lerpColor(xpBase,0,.3));
    rect((width-getGoalXP())/2,height*.2,getGoalXP(),50,10);
    fill(lerpColor(xpBase,color(255,0,0),.2));
    rect((width-getGoalXP())/2,height*.2,min(getXP(),getGoalXP()),50,10);
    fill(255);
    textAlign(CENTER);
    textSize(24);
    text(getXP()+"XP / "+getGoalXP()+"XP",width/2,height*.238);
  }

  
  void changeDifficulty(int plus)
  { 
    if (plus > 0 && maxMoves < 30 || plus < 0 && maxMoves > 5)
    {
      maxMoves += plus;
      movesLeft += plus;
      display();
    }
  }

  int getMovesLeft()
  {
    return movesLeft;
  }
  
  void subMovesLeft()
  {
    movesLeft--;
  }
  int getMaxMoves() 
  {
    return maxMoves;
  }
  
  void addXP(int xp)
  {
    if (xp >= 0)
    {
      XP= XP + (xp * 5);
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
    XP+=5;
  }
  
  abstract Level returnCopy();
  
  boolean fulfilledReq()
  {
   return XP >= GOALXP; 
  }
}
