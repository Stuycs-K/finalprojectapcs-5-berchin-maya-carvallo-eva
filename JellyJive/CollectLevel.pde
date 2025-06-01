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
}
