abstract class Level{
private Board boardLevel;
private int XP;
private int GOALXP;
private String goal;
private int maxMoves;
private int movesLeft;
private int difficulty;
public Button playButton;
private Button back;
private Button retry;
private Button main;
private Button cancelQuit;
public Level(String goal, int goalXP, int maxMoves)
{
  this.goal = goal;
  GOALXP = goalXP;
  this.maxMoves = maxMoves;
}

void makeNewBoard()
{
}

void display()
{ 
}

void changeDifficulty(int dif)
{ 
  if (dif < -3)
  {
   dif = -3; 
  }
  if (dif > 3)
  {
   dif = 3; 
  }
  movesLeft-=dif * 5;
  maxMoves-=dif * 5;
}

boolean areSwaps()
{
  
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
  return movesLeft;
}

void addXP(int xp)
{
  if (xp >= 0)
  {
    XP+=xp;
  }
}

int calcXP(Candy[] ls)
{
  return ls.length * 3;
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

void placeChocolate()
{
 for (int i = 0; i < board.length; i++)
 {
     
 }
}
}
