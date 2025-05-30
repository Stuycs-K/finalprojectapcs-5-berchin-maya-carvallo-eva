
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

public Sweet[][] board = new Sweet[GRID_SIZE][GRID_SIZE];

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
  //finally, display the main menu
  displayMain();
}

void displayMain()
{
  //actually display the background
  //display the level buttons
  for (Level l : levels)
    l.enable();
  credits.enable();
  xCredits.disable();
  main.disable();
  cancelQuit.disable();
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
  if (activeLevel == null) {
    // we're on the main menu
    for (Level l : levels) 
      if (l.playButton.isEnabled() && l.playButton.wasPressed(mouseX, mouseY)) {
        playLevel(l);
        return;
      }
    //check credits button and xCredits
    if (credits.isEnabled() && credits.wasPressed(mouseX, mouseY)) 
      credits();
    if (xCredits.isEnabled() && xCredits.wasPressed(mouseX, mouseY)) 
      displayMain();
  }
  //we're not on the main menu (in a level)
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

void credits()
{
  //display/enable the correct buttons and disable others
  credits.disable();
  for (Level l : levels)
    l.disable();
  xCredits.enable();
  text("CREDITS GO HERE"); //TEMPORARY
}
