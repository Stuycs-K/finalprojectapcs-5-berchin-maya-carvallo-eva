//display fields
public int GRID_LEN; //LATER, CUSTOMIZE PER LEVEL
public int GRID_SIZE;
public color[] candyColors = new color[]{color(255,0,0), color(255,120,0), color(255,255,0), color(0,255,0), color(0,0,255)};
public String[] candyNames = new String[]{"red", "orange", "yellow", "green", "blue"};
//level and board
private Level[] levels;
private Level activeLevel;
private Level clickedLevel;
private boolean activelyPlaying;
private Board gameBoard;
public Sweet target1;
public Sweet target2;
private ArrayList<Sweet> validT2s;
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
  size(980, 980);
  GRID_LEN = 80;
  GRID_SIZE = 6; //LATER, CUSTOMIZE PER LEVEL
  
  //initialize certain vars to match up with main menu
  initLevels();
  candyColors = new color[]{color(255,0,0), color(255,120,0), color(255,255,0), color(0,255,0), color(0,0,255)};
  candyNames = new String[]{"red", "orange", "yellow", "green", "blue"};
  validT2s = new ArrayList<Sweet>();
  targetsSwapped = false;
  activelyPlaying = false;
  //make certain vars null, to be modified later in program
  activeLevel = null;
  clickedLevel = null;
  target1 = null;
  target2 = null;
  
  //set up instances of buttons
  credits = new Button(10,10,70,40,"CREDITS");
  xCredits = new Button(10,10,70,40,"XCREDITS");
  back = new Button(10,10,70,40,"BACK");
  retry = new Button((width+25)/2,height/2+30,70,40,"RETRY");
  cancelQuit = new Button((width+25)/2,height/2+30,70,40,"CANCEL");
  main = new Button(width/2-80,height/2+30,70,40,"MAIN");
  
  //finally, display the main menu
  displayMain();
}

void initLevels() {
  int bSideLen = 50;
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
  activelyPlaying = true;
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
  if (activelyPlaying) 
  {
    if (target1 == null)
      target1 = gameBoard.hoveringOver(mouseX,mouseY);
    if (target1 != null)
    {
      target1.setInMotion();
      int[][] neighbors = new int[][]{{0,1},{0,-1},{1,0},{-1,0}};
      for (int[] neighbor : neighbors)
      {
        try
        {
          validT2s.add(gameBoard.board[target1.getY()+neighbor[1]][target1.getX()+neighbor[0]]);
        }catch(ArrayIndexOutOfBoundsException e) 
        {}
      }
    }
    Sweet beingHovered = gameBoard.hoveringOver(mouseX, mouseY);
    if (target2 == null)
    {
      if (validT2s.contains(beingHovered))
        target2 = beingHovered;
    }
    if (beingHovered == null || (target2 != null && ((beingHovered != target1) || (beingHovered != target2))))
      target1.setStill();
    if (! targetsSwapped && gameBoard.animateSwap(target1, target2, mouseX, mouseY))
    {
      gameBoard.swap(target1, target2);
      targetsSwapped = true;
      target1.setStill();
    }
  }
  activeLevel.display();
  target1.displayMotion(mouseX, mouseY);
}

void mouseReleased() //handle candy swaps
{
  if (activelyPlaying)
  {
    if (target1 != null && target1.isInMotion())
      target1.setStill();
    activeLevel.display();
    ArrayList<Sweet> broken = gameBoard.findToBreak();
    if (broken.size() == 0)
      gameBoard.animateFail(target1, target2);
    else
      activeLevel.keepPlaying(broken);
    target1 = null;
    target2 = null;
    validT2s = new ArrayList<Sweet>();
    targetsSwapped = false;
  }
}

void keyPressed()
{
  
}

void credits()
{
  //display/enable the correct buttons and disable others
  background(255);
  credits.disable();
  for (Level l : levels)
    l.playButton.disable();
  xCredits.enable();
  text("CREDITS GO HERE", width/2, height/2); //TEMPORARY
}

void displayBackConfirmation() 
{
  activelyPlaying = false;
  background(255);
  fill(255, 200, 210);
  int popupWidth = 200;
  int popupHeight = 150;
  rect((width-popupWidth)/2, (height-popupHeight)/2, popupWidth, popupHeight, 30);
  fill(255);
  textSize(24);
  text("Are you sure?", (width-popupWidth)/2+35, height/2);
  //enable/disable the right buttons
  back.disable();
  main.enable();
  cancelQuit.enable();
}

void cancelQuit()
{
  activelyPlaying = true;
  //display the level again
  activeLevel.display();
  //enable/disable the right buttons
  back.enable();
  main.disable();
  cancelQuit.disable();
}
