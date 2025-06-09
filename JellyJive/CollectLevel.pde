class CollectLevel extends Level {

  Sweet sType;
  int goalSs;
  int numSs;
  
  public CollectLevel(Button play, int goalXP, int maxMoves, Board b, Sweet s, int goalCollect)
  {
    super(play, "Collect " + goalCollect + " " + s + "s!", goalXP, maxMoves, b);
    goalSs = goalCollect;
    numSs = 0;
  }
  
  Level returnCopy() 
  {
    return new CollectLevel(playButton, getGoalXP(), getMaxMoves(), board.copyBoard(), sType, goalSs);
  }
  
  int getGoalSs()
  {
    return goalSs;
  }
  
  int getNumSs()
  {
     return numSs; 
  }
  
  void addSs(int Ss)
  {
    numSs += Ss * 5;
  }
  
  Sweet getSweetType()
  {
     return sType; 
  }
  
  boolean fulfilledReq()
  {
     return numSs >= goalSs; 
  }
  
    void display()
  { 
    //display background of level
    background(255);
    //display goal and difficulty on top
    //display board
    board.display();
    back.displayButton();
    textSize(40);
    fill(0, 0, 0);
    text("Collect " + goalSs + " pink candies", 550, 50); 
    text("# collected: " + numSs, 550, 100); 
        text("Goal XP: " + activeLevel.getGoalXP(), 270, 50); 
    text("Current XP: " + activeLevel.getXP(), 270, 100); 
    text("Moves left: " + activeLevel.getMovesLeft(), 270, 150); 
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
    for (Sweet can: brokenBySwap)
    {
      if (can.getName().equals("pink"))
      {
        numSs++;
      }
    }
    activeLevel.addXP(brokenBySwap.size());
    activeLevel.subMovesLeft();
    if (fulfilledReq())
    {
       win(); 
    }
    else if (activeLevel.getMovesLeft() <= 0)
    {
       lose(); 
    }
    display();
  }
}
