//display fields
public int GRID_LEN; //LATER, CUSTOMIZE PER LEVEL
public int GRID_SIZE;
public color[] candyColors = new color[]{color(255,0,0), color(255,120,0), color(255,255,0), color(0,255,0), color(0,0,255)};
public String[] candyNames = new String[]{"red", "orange", "yellow", "green", "blue"};
//level and board
private Level[] levels;
private Level activeLevel;
private Level clickedLevel;
private Board gameBoard;
public Sweet target1;
public Sweet target2;
public boolean targetsSwapped;
//buttons
private Button credits;
private Button xCredits;
private Button back;
private Button retry;
private Button main;
private Button cancelQuit;

void setup()
{
  size(1000, 1000);
  GRID_LEN = 80;
  GRID_SIZE = 6; //LATER, CUSTOMIZE PER LEVEL
  
  //initialize certain vars to match up with main menu
  initLevels();
  candyColors = new color[]{color(255,0,0), color(255,120,0), color(255,255,0), color(0,255,0), color(0,0,255)};
  candyNames = new String[]{"red", "orange", "yellow", "green", "blue"};
  //make certain vars null, to be modified later in program
  activeLevel = null;
  clickedLevel = null;
  target1 = null;
  target2 = null;
  targetsSwapped = false;
  
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
  //clear bad settings
  clickedLevel = null;
  activeLevel = null;
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
  if (activeLevel != null && back.isEnabled()) //level is actively being played
  {
    //select the candy being dragged
    if (target1 == null) 
      target1 = gameBoard.hoveringOver(mouseX, mouseY);
    //select the candy that it's being swapped with
    if (target2 == null)
    {
      target2 = gameBoard.hoveringOver(mouseX, mouseY);
      //can't be the same as target1
      if (target1 == target2) {
        target2 = null;
      }
      //check if target is a valid neighbor
      if (target2 != null) 
      {
        boolean isValidTarget = false;
        int[][] options = new int[][]{{1,0},{-1,0},{0,1},{0,-1}};
        for (int[] neighborCoords : options) 
          if (target2.getX() == target1.getX()+neighborCoords[0] && target2.getY() == target1.getX()+neighborCoords[1])
            isValidTarget = true;
        if (! isValidTarget)
          target2 = null;
      }
    }
    //can we swap?
    if (! targetsSwapped && gameBoard.animateSwap(target1, target2, mouseX, mouseY))
    {
      //swap
      gameBoard.swap(target1, target2);
      targetsSwapped = true;
    }
    //give the option to choose a new target2
    if (targetsSwapped && gameBoard.hoveringOver(mouseX, mouseY).equals(target1)) 
    {
      gameBoard.swap(target1, target2);
      targetsSwapped = false;
      target2 = null;
    }
  }
}

void mouseReleased()
{
  if (target1 != null && target2 != null)
  {
    int tempX = target1.getX();
    int tempY = target2.getY();
    target1.setX(target2.getX());
    target1.setY(target2.getY());
    target2.setX(tempX);
    target2.setY(tempY);
    gameBoard.display();
    target1 = null;
    target2 = null;
    targetsSwapped = false;
  }
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
