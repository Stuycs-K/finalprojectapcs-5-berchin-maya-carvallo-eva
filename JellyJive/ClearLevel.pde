class ClearLevel extends Level{
  boolean jellyMode;
  public ClearLevel(Button play, int goalXP, int maxMoves, Board b, boolean jellyMode)
  {
    super(play, goalXP, maxMoves, b);
    this.jellyMode = jellyMode;
  }
  
  Level returnCopy() 
  {
    return new ClearLevel(playButton, getGoalXP(), getMaxMoves(), board.copyBoard(), jellyMode);
  }
  
  int getJellyLeft()
  {
     return board.jellies.size(); 
  }
  
  int getChocolatesLeft()
  {
    return board.chocolates.size();
  }
  
  boolean fulfilledReq()
  {
    if (jellyMode)
      return getJellyLeft() == 0;
    return getChocolatesLeft() == 0;
  }
  
  void display()
  { 
    if (! gameEnded)
    {
      super.display();
      textAlign(CENTER);
      textSize(30);
      fill(120,150,150);
      if (jellyMode)
      {
        text("Clear all the jellies!", width*.36, height*.17); 
      }
      else
      {
        text("Clear all the chocolates!", width*.39, height*.17);
      }
    }
  }

}
