public int GRID_SIZE;
private Level[] levels;
private Level activeLevel;
private Level clickedLevel;
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
  initLevels();
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

void initLevels() {
  int bSideLen = 30;
  levels = new Level[]{
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

void playLevel(Level playL)
{
  //store values to do with the level being played
  clickedLevel = playL;
  activeLevel = playL.returnCopy();
  gameBoard = activeLevel.board;
  //display the actual level
  playL.display();
  //enable/disable the right buttons
  for (Level l: levels)
    l.playButton.disable();
  credits.disable();
  back.enable();
}

void mouseClicked()
{
  //check each level's button
  if (activeLevel == null) {
    // we're on the main menu
    for (Level l : levels) 
      if (l.playButton.wasPressed(mouseX, mouseY)) {
        playLevel(l);
        return;
      }
    //check credits button and xCredits
    else if (credits.wasPressed(mouseX, mouseY)) 
      credits();
    else if (xCredits.wasPressed(mouseX, mouseY)) 
      displayMain();
  }
  //we're not on the main menu (in a level)
  else if (back.wasPressed(mouseX, mouseY))
    displayBackConfirmation();
  else if (main.wasPressed(mouseX, mouseY))
    displayMain();
  else if (cancelQuit.wasPressed(mouseX, mouseY))
    cancelQuit();
  else if (retry.wasPressed(mouseX, mouseY))
    playLevel(clickedLevel);
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

void displayBackConfirmation() 
{
  //draw background of popup screen
  //enable/disable the right buttons
  back.disable();
  main.enable();
  cancelQuit.enable();
}

void cancelQuit()
{
  //display the level again
  activeLevel.display();
  //enable/disable the right buttons
  back.enable();
  main.disable();
  cancelQuit.disable();
}
