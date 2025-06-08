class ClearLevel extends Level{
  boolean jellyMode;
  public ClearLevel(Button play, int goalXP, int maxMoves, Board b, boolean jellyMode)
  {
    super(play, "Clears!", goalXP, maxMoves, b);
    this.jellyMode = jellyMode;
  }
  
  Level returnCopy() 
  {
    return new ClearLevel(playButton, getGoalXP(), getMaxMoves(), board, jellyMode);
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
    if (jellyMode)
    {
      text("Clear jellies", 650, 50); 
    }
    else
    {
      text("Clear chocolates", 650, 50);
    }
    text("Goal XP: " + activeLevel.getGoalXP(), 650, 100); 
    text("Current XP: " + activeLevel.getXP(), 650, 150); 
    text("Moves left: " + activeLevel.getMovesLeft(), 650, 200); 
  }

}
