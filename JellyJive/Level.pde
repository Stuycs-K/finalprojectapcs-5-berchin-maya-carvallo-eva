abstract class Level{
  public Button playButton;
  private Board board;
  private int XP;
  private int GOALXP;
  private int maxMoves;
  private int movesLeft;
  private int difficulty;
  private String goal;
  
  public Level(String goal, int goalXP, int maxMoves, int[][]chocCoords, int[][]jellyCoords)
  {
    //fields
    XP = 0;
    GOALXP = goalXP;
    movesLeft = 0;
    this.maxMoves = maxMoves;
    difficulty = maxMoves;
    this.goal = goal;
    //MUST BE OVERWRITTEN IN CHILD CLASSES
    playButton = null;
    board = null;
  }
  
  void makeNewBoard()
  {
  }
  
  void display()
  { 
  }
  
  void changeDifficulty()
  { 
  }
  
  boolean areSwaps()
  {
    return false; //COMPILATION
  }
  private void animateSwap()
  {
    
  }
  
  private void genNewcandy()
  {
    
  }
  
  private void animateCandyFall()
  {
    
  }
  
  
  void shuffle()
  {
    
  }
  
  void swap()
  {
    
  }  
  
  int getMovesLeft()
  {
    return 0; //COMPILATION
  }
  
  void addXP()
  {
    
  }
  
  int getXP()
  {
    return XP;
  }
  
  int getGoalXP()
  {
    return GOALXP;
  }
  
  void won()
  {
    
  }
  
  void lost()
  {
    
  }
}
