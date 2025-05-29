
public int GRID_SIZE;
private Level[] levels;
private Level activeLevel;
private Level clickedLevel;
private boolean playingLevel;
private Board gameBoard;
private Button back;
private Button retry;
private Button main;
private Button cancelQuit;

public BSweet[][] board = new BSweet[GRID_SIZE][GRID_SIZE];

void setup()
{
  size(GRID_SIZE * 30, GRID_SIZE * 30);
  //set up instances of buttons
  Button credits = new Button(0,0,30,20,"CREDITS");
  Button xCredits = new Button(0,0,30,20,"XCREDITS");
  Button back = new Button(GRID_SIZE/2-40,GRID_SIZE/2,30,20,"BACK");
  Button retry = new Button(GRID_SIZE/2,GRID_SIZE/2,30,20,"RETRY");
  Button main = new Button(GRID_SIZE/2-40,GRID_SIZE/2,30,20,"MAIN");
  Button cancelQuit = new Button(GRID_SIZE/2,GRID_SIZE/2,30,20,"CANCEL");
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
  //check each level's button
  if (activeLevel == null)  // we're on the main menu
    for (Level l : levels) 
      if (l.playButton.isEnabled() && l.playButton.wasPressed(mouseX, mouseY)) {
        playLevel(l);
        return;
      }
  //check credits button and xCredits
  if (credits.isEnabled() && credits.wasPressed(mouseX, mouseY)) 
    credits();
  if (xCredits.isEnabled() && xCredits.wasPressed(mouseX, mouseY)) 
    xCredits();
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
