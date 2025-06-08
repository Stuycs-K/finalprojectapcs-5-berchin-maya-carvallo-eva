class ClearLevel extends Level{
  boolean jellyMode;
  public ClearLevel(Button play, int goalXP, int maxMoves, Board b, boolean jellyMode)
  {
    super(play, "Clears!", goalXP, maxMoves, b);
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
    return getJellyLeft() == 0 && getChocolatesLeft() == 0;
  }
  

}
