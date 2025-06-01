public int GRID_SIZE;
public int numSqrsPerSide; //LATER, CUSTOMIZE PER LEVEL
private Level[] levels;
private Level activeLevel;
private Level clickedLevel;
private Board gameBoard;
public color[] candyColors = new color[]{color(255,0,0), color(0,255,0), color(0,0,255)}; //add more colors later;
public String[] candyNames = new String[]{"red", "green", "blue"};
private Button credits;
private Button xCredits;
private Button back;
private Button retry;
private Button main;
private Button cancelQuit;

void setup()
{
  size(1000, 1000);
  GRID_SIZE = 80;
  numSqrsPerSide = 6; //LATER, CUSTOMIZE PER LEVEL
  
  //initialize certain vars to match up with main menu
  initLevels();
  candyColors = new color[]{color(255,0,0), color(0,255,0), color(0,0,255)}; //add more colors later
  candyNames = new String[]{"red", "green", "blue"};
  //make certain vars null, to be modified later in program
  activeLevel = null;
  clickedLevel = null;
  
  //set up instances of buttons
  credits = new Button(0,0,50,20,"CREDITS");
  xCredits = new Button(0,0,50,20,"XCREDITS");
  back = new Button(10,10,30,20,"BACK");
  retry = new Button((width+100)/2,height/2,30,20,"RETRY");
  cancelQuit = new Button((width+100)/2,height/2,30,20,"CANCEL");
  main = new Button(width/2,height/2,30,20,"MAIN");
  
  //finally, display the main menu
  displayMain();
}

void initLevels() {
  int bSideLen = 30;
  levels = new Level[]{
  new XPLevel(new Button(width/2, height - bSideLen, bSideLen, bSideLen, "L1"), 500, 15, new Board(new ArrayList<Chocolate>(), new ArrayList<Jelly>()))
  };
}

void displayMain()
{
  //actually display the background
  background(255);
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
