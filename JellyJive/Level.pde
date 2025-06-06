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
    //process xp from input here
    if (! board.areSwaps())
    {
      board.shuffle();
      display();
      brokenBySwap.addAll(board.findToBreak());
    }
    //moves--, check if fulfilledReq(), win/lose
    //later (NOT for Monday), add a way to placeChocolate if none broken this round
    movesLeft--;
    if (fulfilledReq())
    {
       won(); 
    }
    else if (movesLeft <= 0)
    {
       lost(); 
    }
    display();
  }
  
  void display()
  { 
    //display background of level
    background(255);
    //display goal and difficulty on top
    //display board
    board.display();
    back.displayButton();
    textSize(50);
    fill(0, 0, 0);
    text("Goal XP: " + GOALXP, 650, 100); 
    text("Current XP: " + XP, 650, 150); 
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
  
  void won()
  {
    int popupWidth = 200;
    int popupHeight = 150;
    rect((width-popupWidth)/2, (height-popupHeight)/2, popupWidth, popupHeight, 30);
    fill(255);
    textSize(24);
    text("Congratulations", (width-popupWidth)/2+35, height/2);
    //enable/disable the right buttons
    back.disable();
    main.enable();
    retry.enable();
  }
  
  void lost()
  {
    int popupWidth = 200;
    int popupHeight = 150;
    rect((width-popupWidth)/2, (height-popupHeight)/2, popupWidth, popupHeight, 30);
    fill(255);
    textSize(24);
    text("Try again", (width-popupWidth)/2+35, height/2);
    //enable/disable the right buttons
    back.disable();
    main.enable();
    retry.enable();
  }
  
  abstract Level returnCopy();
  boolean fulfilledReq()
  {
   return XP >= GOALXP; 
  }
}
