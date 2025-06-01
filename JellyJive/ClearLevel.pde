class ClearLevel extends Level{
  Sweet clearGoal; //CAN EITHER BE CHOCOLATE OR JELLY, NOT ANYTHING ELSE
  
  public ClearLevel(Button play, int goalXP, int maxMoves, Board b, Sweet cGoal)
  {
    super(play, "Clear all the " + cGoal + "!", goalXP, maxMoves, b);
    clearGoal = cGoal;
  }
}
