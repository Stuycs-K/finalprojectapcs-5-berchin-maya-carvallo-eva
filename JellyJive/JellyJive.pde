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
//CHEAT BUTTONS
private Button cheatShuffle = new Button(840,200,120,40,"CHEATSHUFFLE");
//animation bools and other vars
private int animFrames;
private ArrayList<Sweet> brokenBySwapTemp = new ArrayList<Sweet>();
private ArrayList<Sweet> brokenBySwapTotal = new ArrayList<Sweet>();
private ArrayList<Sweet> toFall = new ArrayList<Sweet>();
private boolean updateCandyPos = false;
private boolean animCandiesFalling;
private boolean animCandiesBreaking;
private boolean animShuffle = false;
private color popUpColor = color(255, 200, 210);
boolean gameEnded = false;
PImage mainbg;
PImage lvlbg;

void setup()
{
  size(980, 980);
  SQUARE_LEN = 80;
  GRID_SIZE = 6;
  
  mainbg = loadImage("mainbg.png");
  lvlbg = loadImage("lvlbg.png");
  
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
  displayMain(); 
} 
  ArrayList<int[]> coordinatesClear(int goalCount, int maxY) 
  {
    ArrayList<int[]> coordinates = new ArrayList<int[]>();
    while (coordinates.size() < goalCount)
    {
     int x = (int)(Math.random() * GRID_SIZE);
     int y = maxY+(int)(Math.random() * (GRID_SIZE-maxY));
     
      if (coordinates.indexOf(new int[]{x,y}) == -1)
      {
        coordinates.add(new int[]{x,y});
      }
    }
    return coordinates;
  }
  
  ArrayList<Jelly> generateJellies(int goalCount)
  {
    ArrayList<int[]> coordinates = coordinatesClear(goalCount,0);
    ArrayList<Jelly> jellies = new ArrayList<Jelly>();
    for (int[] cor : coordinates)
    {
      jellies.add(new Jelly(cor[0], cor[1]));
    }
    return jellies;
  }
    ArrayList<Chocolate> generateChocolates(int goalCount)
  {
    ArrayList<int[]> coordinates = coordinatesClear(goalCount,3);
    ArrayList<Chocolate> chocolates = new ArrayList<Chocolate>();
    for (int[] cor : coordinates)
    {
      chocolates.add(new Chocolate(cor[0], cor[1]));
      //add chocolates below each toplayer chocolate
      for (int cY = cor[1]+1; cY < GRID_SIZE; cY++)
      {
        if (coordinates.indexOf(new int[]{cor[0],cY}) == -1) //no chocolate below previous chocolate
        {
          chocolates.add(new Chocolate(cor[0],cY));
        }
      }
    }
    return chocolates;
  } 
  
void initLevels() {
  int bSideLen = 50;
  levels = new Level[]{
  new XPLevel(new Button(550, 850, bSideLen, bSideLen, "L1"), 1000, 15, new Board(new ArrayList<Chocolate>(), new ArrayList<Jelly>())),
  new ClearLevel(new Button(520, 600, bSideLen, bSideLen, "L2"), 500, 25, new Board(generateChocolates(10), new ArrayList<Jelly>()), false),
  new ClearLevel(new Button(350, 400, bSideLen, bSideLen, "L3"), 500, 25, new Board(new ArrayList<Chocolate>(), generateJellies(10)), true),
  new CollectLevel(new Button(100, 200, bSideLen, bSideLen, "L4"), 500, 15, new Board(generateChocolates(10), generateJellies(10)), new Candy(0,0, candyNames[0], candyColors[0]), 40)
  };
}


void displayMain()
{
  //actually display the background
  image(mainbg,0,0,width,height*1.2);
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
    if (animFrames < 5)
    {
      gameBoard.animateAllBreaking(brokenBySwapTemp,animFrames*2); //expand into actual animation
      animFrames++;
      //wait a minute so the user catches up with what just happened
      wait(20);
    }
    else
    {
      animCandiesBreaking = false;
      wait(40);
      updatePosMode();
    }
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
      if (! candyBreakMode())
      {
        if (! gameBoard.areSwaps())
          candyShuffleMode();
        else
        {
          activelyPlaying = true;
          activeLevel.keepPlaying(brokenBySwapTotal);
          brokenBySwapTotal = new ArrayList<Sweet>();
        }
      }
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
        updatePosMode();
        for (Sweet s : toFall)
          s.setStill();
      }
    }
  }
  if (animShuffle)
  {
    if (animFrames == 0)
    {
      wait(100);
    }
    if (animFrames < 5)
    {
      gameBoard.animateAllBreaking(toFall,animFrames*2); //expand into actual animation
      animFrames++;
      //wait a minute so the user catches up with what just happened
      wait(20);
    }
    else
    {
      animShuffle = false;
      gameBoard.shuffle();
      gameBoard.display();
      if (candyBreakMode())
      {
        for (Sweet s : toFall)
          s.setStill();
      }
      else if (! gameBoard.areSwaps())
        candyShuffleMode();
      else
      {
        for (Sweet s : toFall)
          s.setStill();
        activelyPlaying = true;
        activeLevel.keepPlaying(brokenBySwapTotal);
        brokenBySwapTotal = new ArrayList<Sweet>();
      }
    }
  }
  if (activeLevel != null && ! animCandiesBreaking && ! updateCandyPos && ! animCandiesFalling && ! animShuffle)
  {
    activelyPlaying = true;
    back.enable();
    cheatShuffle.enable(); //CHEAT
  }
}

void playLevel(Level playL)
{
  gameEnded = false;
  //store values to do with the level being played
  clickedLevel = playL;
  activeLevel = playL.returnCopy();
  gameBoard = activeLevel.board;
  activelyPlaying = true;
  //display the actual level
  image(lvlbg,0,0,width,height*1.5);
  playL.display();
  gameBoard.display();
  //enable/disable the right buttons
  for (Level l: levels)
    l.playButton.disable();
  credits.disable();
  back.enable();
  //CHEAT
  cheatShuffle.enable();
}

void mouseClicked()
{
  for (Level l : levels) 
    if (l.playButton.wasPressed(mouseX, mouseY)) {
      playLevel(l);
      return;
    }
    //check credits button and xCredits
  if (credits.wasPressed(mouseX, mouseY)) 

    credits();
  else if (xCredits.wasPressed(mouseX, mouseY)) 
    displayMain();
  //we're not on the main menu (in a level)
  else if (back.wasPressed(mouseX, mouseY))
    displayBackConfirmation();
  else if (main.wasPressed(mouseX, mouseY))
    displayMain();
  else if (cancelQuit.wasPressed(mouseX, mouseY))
    cancelQuit();
  else if (retry.wasPressed(mouseX, mouseY))
    playLevel(clickedLevel);
  else if (cheatShuffle.wasPressed(mouseX, mouseY))
    candyShuffleMode();
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
    if (target1 != null && (beingHovered == null || (target2 != null && ((beingHovered != target1) || (beingHovered != target2)))))
      target1.setStill();
    if (target1 != null && target2 != null && ! target2.isSwappable())
      target1.setStill();
    if (! targetsSwapped && gameBoard.animateSwap(target1, target2, mouseX, mouseY))
    {
      gameBoard.swap(target1, target2);
      targetsSwapped = true;
      target1.setStill();
    }
    activeLevel.display();
    if (target1 != null && target1.isInMotion())
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
    if (! candyBreakMode())
      gameBoard.animateFail(target1, target2);
    target1 = null;
    target2 = null;
    validT2s = new ArrayList<Sweet>();
    targetsSwapped = false;
  }
}

void keyPressed()
{
  if (activeLevel != null)
  {
  if (key== '+')
    activeLevel.changeDifficulty(5);
  else if (key == '-')
    activeLevel.changeDifficulty(-5);
  }
}

void popUpTab(int rectWidth, int rectHeight, String text)
{
  fill(popUpColor);
  stroke(lerpColor(popUpColor,0,.2));
  strokeWeight(5);
  rect((width-rectWidth)/2, (height-rectHeight)/2, rectWidth, rectHeight, 20);
  strokeWeight(1);
  fill(255);
  textAlign(CENTER);
  textSize(20);
  text(text,width/2,height/2);
}

void credits()
{
  //display/enable the correct buttons and disable others
  image(mainbg,0,0,width,height*1.5);
  credits.disable();
  for (Level l : levels)
    l.playButton.disable();
  xCredits.enable();
  popUpTab(400,200,"Game devs: Eva Carvallo and Maya Berchin\nInspiration: Candy Crush\nBackground images: Pinterest");
}

void displayBackConfirmation() 
{
  activelyPlaying = false;
  textSize(24);
  popUpTab(200, 150, "Are you sure?");
  //enable/disable the right buttons
  back.disable();
  main.enable();
  cancelQuit.enable();
  //CHEAT
  cheatShuffle.disable();
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
  //CHEAT
  cheatShuffle.enable();
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
  image(lvlbg,0,0,width,height*1.5);
  popUpTab(200,150,"Congratulations!!");
  endGame();
}

public void lose()
{
  image(lvlbg,0,0,width,height*1.5);
  popUpTab(200,150,"Oops, out of moves! :(");
  endGame();
}

void endGame()
{
  gameEnded = true;
  animFrames = 0;
  activeLevel = null;
  activelyPlaying = false;
  back.disable();
  cheatShuffle.disable(); //CHEAT
  main.enable();
  retry.enable();
  updateCandyPos = false;
  animCandiesFalling = false;
  animCandiesBreaking = false;
  animShuffle = false;
}

boolean candyBreakMode()
{
  activelyPlaying = false;
  animFrames = 0;
  brokenBySwapTemp = gameBoard.findToBreak();
  if (brokenBySwapTemp.size() > 0)
  {
    animCandiesBreaking = true;
    gameBoard.breakAll(brokenBySwapTemp);
    brokenBySwapTotal.addAll(brokenBySwapTemp);
  }
  return animCandiesBreaking;
}

void updatePosMode()
{
  activelyPlaying = false;
  animFrames = 0;
  gameBoard.display();
  updateCandyPos = true;
  brokenBySwapTemp = new ArrayList<Sweet>();
}

void candyShuffleMode()
{
  activelyPlaying = false;
  animFrames = 0;
  animShuffle = true;
  for (Sweet[] row : gameBoard.board)
    for (Sweet s : row)
      if (s.isSwappable())
      {
        s.setInMotion();
        toFall.add(s);
      }
}
