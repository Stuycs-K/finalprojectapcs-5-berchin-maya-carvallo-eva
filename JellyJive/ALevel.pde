abstract class Level{
private Board board;
private int XP;
private int GOALXP;
private int maxMoves;
private int movesLeft;
private int difficulty;
public Button playButton;
private Button back;
private Button retry;
private Button main;
private Button cancelQuit;
public Level(int goal, int goalXP, int maxMoves, int chocolates, int jellies)
{
  
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
