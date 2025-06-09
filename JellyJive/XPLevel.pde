class XPLevel extends Level{
  
  public XPLevel(Button play, int goalXP, int maxMoves, Board b)
  {
    super(play, "Collect " + goalXP + " XP!", goalXP, maxMoves, b);
  }
  
  Level returnCopy() 
  {
    return new XPLevel(playButton, getGoalXP(), getMaxMoves(), board.copyBoard());
  }
  
  boolean fulfilledReq()
  {
     return activeLevel.getXP() >= activeLevel.getGoalXP(); 
  }
  
  void display()
  {
    super.display();
    textAlign(CENTER);
    textSize(30);
    fill(120,150,150);
    text("Fill the xp bar!",width*.35,height*.17);
  }

}
