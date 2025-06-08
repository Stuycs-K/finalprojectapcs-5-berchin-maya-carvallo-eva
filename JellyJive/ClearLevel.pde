class ClearLevel extends Level{
  Sweet clearGoal; //CAN EITHER BE CHOCOLATE OR JELLY, NOT ANYTHING ELSE
  int goalCount;
  public ClearLevel(Button play, int goalXP, int maxMoves, Board b, Sweet cGoal, int goalC)
  {
    super(play, "Clear all the " + cGoal + "!", goalXP, maxMoves, b);
    clearGoal = cGoal;
    goalCount = goalC;
  }
  
  Level returnCopy() 
  {
    return new ClearLevel(playButton, getGoalXP(), getMaxMoves(), board, clearGoal, goalCount);
  }
  boolean fulfilledReq()
  {
    return goalCount == 0;
  }
  
  ArrayList<int[]> coordinatesClear(int goalCount)
  {
    ArrayList<int[]> coordinates = new ArrayList<int[]>();
    while (coordinates.size() < goalCount)
    {
     int x = (int)Math.random() * GRID_SIZE;
     int y = (int)Math.random() * GRID_SIZE;
     
     boolean duplicate =  false;
     for (int i = 0; i < coordinates.size(); i++)
     {
       if (coordinates.get(i)[0] == x && coordinates.get(i)[1] == y)
       {
        duplicate = true; 
       }
     }
     if (!duplicate)
     {
         coordinates.add(new int[]{x, y});
     }
    }
    return coordinates;
  }
  
}
