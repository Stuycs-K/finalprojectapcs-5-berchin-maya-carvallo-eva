class ClearLevel extends Level{
  boolean jellyGoal;
  boolean chocolateGoal;
  public ClearLevel(Button play, int goalXP, int maxMoves, Board b, boolean goalj, boolean goalC)
  {
    super(play, "Clears!", goalXP, maxMoves, b);

    jellyGoal = goalj;
    chocolateGoal = goalC;
  }
  
  Level returnCopy() 
  {
    return new ClearLevel(playButton, getGoalXP(), getMaxMoves(), board, jellyGoal, chocolateGoal);
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
