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
    super.display();
    textAlign(CENTER);
    textSize(30);
    fill(120,150,150);
    text("Collect " + goalSs + " pink candies!", width*.38, height*.15); 
    text("# collected: " + numSs, width*.38, height*.19); 
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
