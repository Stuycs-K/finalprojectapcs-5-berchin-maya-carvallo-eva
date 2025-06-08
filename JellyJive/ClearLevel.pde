class ClearLevel extends Level{
  Sweet cGoal;
  boolean jellyGoal;
  boolean chocolateGoal;
  public ClearLevel(Button play, int goalXP, int maxMoves, Board b, Sweet cGoal, boolean goalj, boolean goalC)
  {
    super(play, "Clear all the " + cGoal.getName() + "!", goalXP, maxMoves, b);
    jellyGoal = goalj;
    chocolateGoal = goalC;
  }
  
  Level returnCopy() 
  {
    return new ClearLevel(playButton, getGoalXP(), getMaxMoves(), board, cGoal, jellyGoal, chocolateGoal);
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
