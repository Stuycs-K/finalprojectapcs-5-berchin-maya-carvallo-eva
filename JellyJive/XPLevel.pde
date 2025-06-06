class XPLevel extends Level{
  
  public XPLevel(Button play, int goalXP, int maxMoves, Board b)
  {
    super(play, "Collect " + goalXP + " XP!", goalXP, maxMoves, b);
  }
  
  Level returnCopy() 
  {
    return new XPLevel(playButton, getGoalXP(), getMaxMoves(), board);
  }
  
  boolean fulfilledReq()
  {
     return activeLevel.getXP() >= activeLevel.getGoalXP(); 
  }

}
