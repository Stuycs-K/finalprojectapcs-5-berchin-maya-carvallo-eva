public int GRID_SIZE;
private Level[] levels;
private Level activeLevel;
private Level clickedLevel;
private boolean playingLevel;
private Board gameBoard;
private Button credits;
private Button xCredits;
private Button back;
private Button retry;
private Button main;
private Button cancelQuit;

void setup()
{
  size(GRID_SIZE * 30, GRID_SIZE * 30);
  
  //initialize certain vars to match up with main menu
  initLevels(levels);
  playingLevel = false;
  //make certain vars null, to be modified later in program
  activeLevel = null;
  clickedLevel = null;
  
  //set up instances of buttons
  credits = new Button(0,0,30,20,"CREDITS");
  xCredits = new Button(0,0,30,20,"XCREDITS");
  back = new Button(GRID_SIZE/2-40,GRID_SIZE/2,30,20,"BACK");
  retry = new Button(GRID_SIZE/2,GRID_SIZE/2,30,20,"RETRY");
  main = new Button(GRID_SIZE/2-40,GRID_SIZE/2,30,20,"MAIN");
  cancelQuit = new Button(GRID_SIZE/2,GRID_SIZE/2,30,20,"CANCEL");
  
  //finally, display the main menu
  background(255);
  displayMain();
}

void initLevels(Level[] Ls) {
  int bSideLen = 30;
  Ls = new Level[]{
  new XPLevel(new Button(height - bSideLen, width/2, bSideLen, bSideLen, "L1"), 500, 15, new Board(new ArrayList<Chocolate>(), new ArrayList<Jelly>()))
  };
}

void displayMain()
{
  //actually display the background
  //display the level buttons
  for (Level l : levels)
    l.playButton.enable();
  credits.enable();
  xCredits.disable();
  main.disable();
  cancelQuit.disable();
}

void draw()
{
 
}

void playLevel(Level l)
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
    l.playButton.disable();
  xCredits.enable();
  text("CREDITS GO HERE", width/2, height/2); //TEMPORARY
}
