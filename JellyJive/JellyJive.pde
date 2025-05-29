
public int GRID_SIZE;
private Level[] levels;
private Level activeLevel;
private Level clickedLevel;
private Board gameBoard;
private boolean playingLevel;
private Button[] buttons;
private Button back;
private Button retry;
private Button main;
private Button cancelQuit;

public BSweet[][] board = new BSweet[GRID_SIZE][GRID_SIZE];

void setup()
{
  //set up instances of buttons
  Button credits = new Button(0,0,30,20,"CREDITS");
  Button xCredits = new Button(0,0,30,20,"XCREDITS");
  Button back = new Button(GRID_SIZE/2-40,GRID_SIZE/2,30,20,"BACK");
  Button retry = new Button(GRID_SIZE/2,GRID_SIZE/2,30,20,"RETRY");
  Button main = new Button(GRID_SIZE/2-40,GRID_SIZE/2,30,20,"MAIN");
  Button cancelQuit = new Button(GRID_SIZE/2,GRID_SIZE/2,30,20,"CANCEL");
  buttons = new Button[]{credits, xCredits, back, retry, main cancelQuit};
  size(GRID_SIZE * 30, GRID_SIZE * 30);
}

void displayMain()
{
  credits.enable();
}

void draw()
{
 background(255);
 
}

void playLevel()
{
    
}

void mouseClicked()
{
    
}

void mouseDragged()
{
  
}

void mouseReleased()
{
    
}

void keyPressed()
{
  
}

void enableButtons()
{
  
}

void disableButtons()
{
    
}

void credits()
{
  
}

void xCredits()
{
  
}
