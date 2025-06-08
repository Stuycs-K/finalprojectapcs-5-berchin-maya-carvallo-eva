//candy display fields
public color[] candyColors = new color[]{color(252,204,255), color(185,255,140), color(124,255,198), color(147,224,255), color(201,199,255)};
public String[] candyNames = new String[]{"pink", "lime", "teal", "blue", "lilac"};
//board display fields
public int SQUARE_LEN; //LATER, CUSTOMIZE PER LEVEL
public int GRID_SIZE;
//level and board
public boolean activelyPlaying;
private Level[] levels;
public Level activeLevel;
private Level clickedLevel;
private Board gameBoard;
public Sweet target1;
public Sweet target2;
private ArrayList<Sweet> validT2s = new ArrayList<Sweet>();
public boolean targetsSwapped;
//buttons
private Button credits = new Button(10,10,70,40,"CREDITS");
private Button xCredits = new Button(10,10,70,40,"XCREDITS");
private Button back = new Button(10,10,70,40,"BACK");
private Button retry = new Button((width+25)/2,height/2+30,70,40,"RETRY");
private Button cancelQuit = new Button((width+25)/2,height/2+30,70,40,"CANCEL");
private Button main = new Button(width/2-80,height/2+30,70,40,"MAIN");
//animation bools and other vars
private int animFrames;
private ArrayList<Sweet> brokenBySwapTemp = new ArrayList<Sweet>();
private ArrayList<Sweet> brokenBySwapTotal = new ArrayList<Sweet>();
private ArrayList<Sweet> toFall = new ArrayList<Sweet>();
private boolean updateCandyPos = false;
private boolean animCandiesFalling;
private boolean animCandiesBreaking;
private boolean gameWon = false;
private boolean gameLost = false;

void setup()
{
  size(980, 980);
  SQUARE_LEN = 80;
  GRID_SIZE = 6; //LATER, CUSTOMIZE PER LEVEL
  
  //initialize certain vars to match up with main menu
  initLevels();
  targetsSwapped = false;
  activelyPlaying = false;
  animFrames = 0;
  animCandiesBreaking = false;
  animCandiesFalling = false;
  
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
  displayMain(); //<>//
}
  ArrayList<int[]> coordinatesClear(int goalCount)
  {
    ArrayList<int[]> coordinates = new ArrayList<int[]>();
    while (coordinates.size() < goalCount)
    {
     int x = (int)Math.random() * GRID_SIZE;
     int y = (int)Math.random() * GRID_SIZE;
     
     boolean duplicate =  false;
     for (int i = 0; i < coordinates.size(); i++)
     {
       if (coordinates.get(i)[0] == x && coordinates.get(i)[1] == y)
       {
        duplicate = true; 
       }
     }
     if (!duplicate)
     {
         coordinates.add(new int[]{x, y});
     }
    }
    return coordinates;
  }
  
  ArrayList<Jelly> generateJellies(int goalCount)
  {
    ArrayList<int[]> coordinates = coordinatesClear(goalCount);
    ArrayList<Jelly> jellies = new ArrayList<Jelly>();
    for (int[] cor : coordinates)
    {
      jellies.add(new Jelly(cor[0], cor[1]));
    }
    return jellies;
  }
    ArrayList<Chocolate> generateChocolates(int goalCount)
  {
    ArrayList<int[]> coordinates = coordinatesClear(goalCount);
    ArrayList<Chocolate> chocolates = new ArrayList<Chocolate>();
    for (int[] cor : coordinates)
    {
      chocolates.add(new Chocolate(cor[0], cor[1]));
    }
    return chocolates;
  } 
  
void initLevels() {
  int bSideLen = 50;
  levels = new Level[]{
  new XPLevel(new Button(width/2, height - bSideLen, bSideLen, bSideLen, "L1"), 500, 15, new Board(new ArrayList<Chocolate>(), new ArrayList<Jelly>())),
  new ClearLevel(new Button(width/2, height - 300, bSideLen, bSideLen, "L2"), 500, 15, new Board(new ArrayList<Chocolate>(), new ArrayList<Jelly>()), false),
  new CollectLevel(new Button(width/2, height - 600, bSideLen, bSideLen, "L3"), 500, 15, new Board(new ArrayList<Chocolate>(), new ArrayList<Jelly>()), new Candy(0,0, candyNames[0], candyColors[0]), 50)
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
  //handle candies being broken
  if (animCandiesBreaking)
  {
    gameBoard.breakAll(brokenBySwapTemp);
    gameBoard.animateAllBreaking(brokenBySwapTemp); //expand into actual animation
    brokenBySwapTotal.addAll(brokenBySwapTemp);
    brokenBySwapTemp = new ArrayList<Sweet>();
    animCandiesBreaking = false;
    updateCandyPos = true;
    gameBoard.display();
  }
  //update candy positions
  if (updateCandyPos)
  {
    toFall = gameBoard.updateCandyPositions();
    updateCandyPos = false;
    if (toFall.size() > 0)
      animCandiesFalling = true;
    //toFall.size() == 0, nothing to fall
    else
    {
      gameBoard.display();
      brokenBySwapTemp = gameBoard.findToBreak();
      if (brokenBySwapTemp.size() > 0)
        animCandiesBreaking = true;
      else
        activeLevel.keepPlaying(brokenBySwapTotal);
    }
  }
  //handle new candies falling
  if (animCandiesFalling)
  {
    if (toFall.size() > 0)
    {
      if (animFrames*5 < SQUARE_LEN)
      {
        gameBoard.display();
        gameBoard.animateCandyFall(toFall, animFrames*5);
        animFrames++;
      }
      else
      {
        animFrames = 0;
        animCandiesFalling = false;
        updateCandyPos = true;
        for (Sweet s : toFall)
          s.setStill();
      }
    }
  }
  if (gameWon)
  {
    activeLevel.won();
    endGame();
  }
  if (gameLost)
  {
    activeLevel.lost();
    endGame();
  }
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
    activeLevel.display();
    if (target1.isInMotion())
      target1.displayRaw(mouseX, mouseY);
  }
}

void mouseReleased() //handle candy swaps
{
  if (activelyPlaying)
  {
    if (target1 != null && target1.isInMotion())
      target1.setStill();
    activeLevel.display();
    brokenBySwapTemp = gameBoard.findToBreak();
    if (brokenBySwapTemp.size() > 0)
      animCandiesBreaking = true;
    else
      gameBoard.animateFail(target1, target2);
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

void wait(int waitTime)
{
  try
  {
    Thread.sleep(waitTime);
  } catch (InterruptedException e)
  {}
}

public void win()
{
  gameWon = true;
}

public void lose()
{
  gameLost = true;
}

void endGame()
{
  activeLevel = null;
  activelyPlaying = false;
  back.disable();
  main.enable();
  retry.enable();
  updateCandyPos = false;
  animCandiesFalling = false;
  animCandiesBreaking = false;
  gameWon = false;
  gameLost = false;
}
