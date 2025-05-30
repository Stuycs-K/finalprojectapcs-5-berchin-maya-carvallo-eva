
# Technical Details:


Maya Berchin, Eva Carvallo---Period 5

Jelly Jive

Candy crush: a popular puzzle game. Goals vary by level: collect x candy, clear the board, get n XP in x moves, etc.
All goals are achieved through the core gameplay: swiping candies with their neighbors (diagonals excluded).
3+ candies of the same type in a row vanish and give XP; if more than 3 candies of the same type are lined up so that
they are all touching (again, diagonals don't count), a special candy will be spawned in, and special candies are
good will clear more candies, either as a bomb, which clears surrounding 3x3, or row and column clearing candies. The one you get will be random when you swipe the normal candies that spawned the special one.

This will be done in Processing.


Expanded Description:

Critical features (Minimum Viable Product) - After 1.5 weeks, we must have the following:
 - At least 1 working level that has the same goal but randomized starting boards each time it is played
 - Decent graphics (some shading, some animation)
 - Play Again or Retry feature
 - A basic way of changing the difficulty (will get replaced if we make multiple levels)

Nice to have features - By the end it would be nice to have:
 - Multiple levels and a main menu
 - More detailed graphics and an interesting background
 - Different goals in different levels
 - POSSIBLY game sounds and/or music
 - At least 1 working level that has the same goal but randomized starting boards each time it is played
 - Decent graphics (some shading, some animation)
 - Play Again or Retry feature with failure
 - change difficulty based on swaps

Nice to have features - By the end it would be nice to have:
 - Multiple levels and a main menu with instructions 
 - More detailed graphics and an interesting background
 - Different goals in different levels
 - POSSIBLY game sounds and/or music

Topics covered in class that we will be using:
 - Processing
 - Classes, class hierarchy/inheritance, abstract classes
 - Random

# Project Design

![Alt text](uml.png?raw=true "Class hierarchy diagram" )

OUTLINE: 

-----------------------------
***JELLYJIVE***
 - **Level[] levels**: Keep track of all levels  
 - **Level activeLevel**: Keep track of the level we’re playing  
 - **Level clickedLevel**: Keep track of the level we copied from  
 - **boolean playingLevel**: Keep track of whether a level is being played  
 - **Board gameBoard**: Reference to the board being used in the game  
 - **Button credits**: Show game credits  
 - **Button xCredits**: Go back to main menu after looking at credits  
 - **Button back**: Brings a player back to the main menu  
 - **Buttons retry, main, cancelQuit**: UI for retrying a level or going back to the main menu or for deciding not to quit  
 - **Sweet target1**: The target the mouse is dragging  
 - **Sweet target2**: The sweet the mouse is dragging towards  
. . . . . . . .
 - **void setup()**: Set up the main menu area and display everything  
 - **void draw()**: Does nothing  
 - **void mouseClicked()**: Check if a button has been pressed  
 - **void mouseDragged()**: Move a candy with the mouse  
 - **void mouseReleased()**: See if the swap is viable.  
 - **void keyPressed()**: Update a level’s difficulty  
 - **void displayMain()**: Displays main menu  
 - **void playLevel()**: Plays a level  
 - **void credits()**: Displays credits  
 - **void displayBackConfirmation()**: Display “Are you sure” screen when user wants to quit the level  
 - **void mainMenu()**: Go back to the main menu after pressing main  
 - **void cancelQuit()**: Goes back to the level being played  
 - **void retry()**: Makes a new copy of the level that was attempted 
-----------------------------
***BUTTON***
 - **int x, int y**: Button top left coordinates  
 - **int b, int h**: Base and height  
 - **String text**: What the button should display  
 - **boolean enabled**: Keeps track of whether the button is enabled  
. . . . . . . .
 - **Button()**: constructor  
 - **boolean isEnabled()**: Returns enabled  
 - **void enable()**: Sets enable to true  
 - **void disable()**: Sets enable to false  
 - **boolean wasPressed()**: Return whether or not this button has been pressed  
 - **void displayButton()**: Draws the button in the right place and displays the right text 
-----------------------------
***BOARD***
 - **Sweet[][] board**: The actual board  
 - **ArrayList<Chocolate> chocolates**: Level may contain chocolate  
 - **ArrayList<Chocolate> jellies**: Level may contain jellies  
. . . . . . . .
 - **Board()**: constructor  
 - **boolean areSwaps()**: Decide if there are swaps left on the board  
 - **ArrayList<Sweet> shuffle()**: Shuffle the contents of the board (candy only; chocolate and jellies stay where they are). Returns a list of sweets that were broken by the shuffle.  
 - **ArrayList<Sweet> swap()**: Swap two candies on the board  
 - **ArrayList<Sweet> findToBreak()**: Helper for swap(): find the candy that needs to be broken and return it  
 - **void animateSwap()**: Animate the 2 candies swapping.  
 - **void animateFail()**: Animate a failed swap.  
 - **ArrayList<Sweet> genNewCandy()**: Generate new candy to fill in all empty spots. Return a list of sweets broken by the generation of this new candy.  
 - **void animateCandyFall()**: Animate candy falling down one layer into an empty space.  
 - **ArrayList<explodeAgain()**: Explode bombs again. (Bombs explode twice)  
-----------------------------
***LEVEL***
 - **Button playButton**: Used in main tab to be the button that causes this level to be played  
 - **Board board**: Board which the level is played on  
 - **int difficulty**: difficulty (based on number of moves)
 - **String goal**: Will be displayed to the user
 - **int XP**: xp
 - **int goalXP**: xp for 3 stars (or win in XP level)
 - **int maxMoves**: max # of moves
 - **int movesLeft**: self explanatory
 - **int[][] chocCoords**: So that we can set up board with the same placement of chocolates each time we make a copy  
 - **int[][] jellyCoords**: So that we can set up board with the same placement of jellies each time we make a copy 
 . . . . . . . .
 - **Level()**: constructor  
 - **Level copyLevel()**: Returns a deep copy of a level to be stored and modified in activeLevel.  
 - **void display()**: Displays the level  
 - **void changeDifficulty()**: Changes the difficulty  
 - **int getMovesLeft()**: Return movesLeft  
 - **int getXP()**: Return XP  
 - **int addXP()**: Adds int param to XP (provided param >= 0)  
 - **int calcXP()**: Takes a list of candy that was broken in a swap and calculate the XP that should be added from the swap  
 - **int getGoalXP()**: Return goalXP  
 - **void placeChocolate()**: Place a new chocolate next to an existing one  
 - **void keepPlaying()**: Decide whether the game is over  
 - **boolean fulfilledReq()**: Checks if the requirement to win has been fulfilled  
 - **void win()**: Win the game!  
 - **void lose()**: Lose the game :(  
-----------------------------
***XPLEVEL***
 . . . . . . . .
 - **XPLevel()**: constructor  
 - **XPLevel copyLevel()**: see super
 - **boolean fulfilledReq()**: Return XP >= goalXP  
-----------------------------
***CLEARLEVEL***
 - **Sweet clearGoal**: The sweet that needs to be wiped from the board  
 . . . . . . . .
 - **ClearLevel()**: constructor  
 - **ClearLevel copyLevel()**: see super
 - **boolean fulfilledReq()**: Return the count of clearGoal on the board == 0  
-----------------------------
***COLLECTLEVEL***
 - **Sweet sType**: The sweet that needs to be collected  
 - **int goalSs**: The goal number of sweets we’re trying to collect  
 - **int numSs**: The number of goal sweets we currently have  
 . . . . . . . .
 - **CollectLevel()**: constructor  
 - **CollectLevel copyLevel()**: see super
 - **int getGoalSs()**: Returns goalSs  
 - **int getNumSs()**: Returns numSs  
 - **void addSs()**: After each swap, adds the number of sTypes broken to numSs  
 - **Sweet getSweetType()**: Returns sType  
 - **boolean fulfilledReq()**: Return the count of clearGoal on the board == 0  
-----------------------------
***SWEET***
 - **int x, int y**: Location of the candy on the board  
 - **boolean swappable**: Can the sweet be moved by mouseDragged()?  
 . . . . . . . .
 - **Sweet()**: constructor  
 - **int getX(), getY()**: Return x / y  
 - **void setX(), setY()**: Set x and y  
 - **boolean isSwappable()**: Return swappable  
 - **void display()**: Display the sweet  
 - **void animateBreak()**: Animate the candy breaking  
-----------------------------
***CHOCOLATE***
 . . . . . . . .
 - **Chocolate()**: Constructor  
 - **void display()**: see super
 - **void animateBreak()**: see super
-----------------------------
***JELLY***
 - **int layers**: Number of layers of jelly on this square  
 . . . . . . . .
 - **Jelly()**: Constructor  
 - **int getLayers()**: Return layers  
 - **void subLayer()**: layers– after a swap  
 - **void display()**: Display the jelly  
 - **void animateBreak()**: see super
-----------------------------
***CANDY***
 - **Color cColor**: Color of the candy  
 . . . . . . . . 
 - **Candy()**: constructor  
 - **void display()**: see super
 - **void animateBreak()**: see super
-----------------------------
***COLORBOMB***
 . . . . . . . . 
 - **colorBomb()**: constructor  
 - **void display()**: see super
 - **void animateBreak()**: see super
-----------------------------
***STRIPED***
 - **boolean vertical**: Will the candy break a column or row when activated?  
 . . . . . . . .
 - **Striped()**: Constructor  
 - **boolean isVertical()**: Return vertical  
 - **void display()**: see super
 - **void animateBreak()**: see super
-----------------------------
***BOMB***
 . . . . . . . . 
 - **Bomb()**: Constructor  
 - **void display()**: see super
 - **void animateBreak()**: see super
-----------------------------
***ACTIVEBOMB***
 . . . . . . . .
 - **ActiveBomb()**: Constructor  
 - **void animateTimer()**: Animate the bomb lighting up and going back to its normal color while it waits to explode  
 - **void display()**: see super
 - **void animateBreak()**: see super
-----------------------------
 
# OUTDATED: Old project design
![Alt text](olduml.png?raw=true "Old class hierarchy diagram" )
	
~~Levels will be created in the main tab.~~  
~~The main tab is not part of the class hierarchy.~~  

~~Each level has an abstract parent level. Every level needs to do certain things, such as~~  
~~- Keeping track of/updating XP and moves left~~  
~~- Keeping track of whether you've won/lost~~  
~~- Deciding whether there are viable swaps on the board~~  

~~Key methods of the Level class:~~  
~~- **makeNewBoard()** creates a new board---LEVEL TYPE SPECIFIC~~  
~~- **genNewCandy()** generates new candy to fill in gaps left by previous moves~~  
~~- **shuffle()** shuffles the board when no viable swaps are left~~  
~~- **areSwaps()** ensures there are possible swaps left on the board~~  
~~- **swap()** swaps the positions of two candies, then commences the breaking of the candies and refilling of the board.~~  
~~Swaps can only be executed if they will result in candy breaking (3+ in a row get lined up). See canSwap() in Candy.~~  
~~- **changeDifficulty()** is a basic way of changing the difficulty by decreasing/increasing the number of moves you have.~~  
~~This function may get removed if enough unique levels are added, since they'll have varying difficulties.~~  
~~- **fulfilledReq()** is level type specific and keeps track of whether the level has been beaten.~~  
~~- If fulfilledReq(), **won()** is called to display a winning screen with stars and XP. Else if moves == 0, **lost()** is~~  
~~called to display a screen with stars and XP.~~  
~~- Everything named **get_()** is an accessor method~~  
~~- **animateSwap()** animates a swap being made, **animateCandyFall()** animates the candy falling into place to fill a gap~~  
~~- Keeping track of/updating XP and moves left~~  
~~- Keeping track of whether you've won/lost~~  
~~- Deciding whether there are viable swaps on the board so can shuffle board if needed~~  

~~Key methods of the Level class:~~  
~~- **makeNewBoard()** creates a new board---LEVEL TYPE SPECIFIC~~  
~~- **genNewCandy()** generates new candy to fill in gaps left by previous moves~~  
~~- **shuffle()** shuffles the board when no viable swaps are left~~  
~~- **areSwaps()** ensures there are possible swaps left on the board~~  
~~- **swap()** swaps the positions of two candies, then gets rid of the candies involved and refilles the board.~~  
~~Swaps can only be executed if they will result in candy breaking (variation of the 3 same candies, with one different candy. 3 possibilities. If those possibilities have more candies lined up, then special candies used). See canSwap() in Candy.~~  
~~- **changeDifficulty()** is a basic way of changing the difficulty by decreasing/increasing the number of moves you have.~~  
~~This function may get removed if enough unique levels are added, since they'll have varying difficulties.~~  
~~- **fulfilledReq()** is level type specific and keeps track of whether the level has been beaten.~~  
~~- If fulfilledReq(), **won()** is called to display a winning screen with stars and XP. Else if moves == 0, **lost()** is~~  
~~called to display a screen with stars and XP. If completed with up to 3/4 of swaps, will show 3 stars. If completed with more than 3/4 of swaps but less than max, show 2 stars. If completed with max, show 1. If not completed, show 0.~~  
~~- Everything named **get_()** is an accessor method~~  
~~- **animateSwap()** animates a swap being made, **animateCandyFall()** animates the candy falling into place from top of board through the column to fill a gap~~  
~~after a swap.~~  

~~CHILDREN OF LEVEL:~~  

~~XPLevel:~~  
~~- **fulfilledReq()** returns whether the goal XP has been reached yet.~~  

~~ClearLevel:~~  
~~- **fulfilledReq()** = clearedBoard()~~  
~~- **clearedBoard() checks whether the board has been cleared in one swap/move.**~~  
~~- **fulfilledReq()** returns whether the goal XP has been reached.~~  

~~CollectLevel:~~  
~~- **fulfilledReq()** returns whether the goal number of candy has been reached yet.~~  
~~- **getCType()**, **getGoalCs()**, and **getNumCs()** return the candy type (color) needing to be collected, the goal amount,~~  
~~		and the current amount, respectively.~~  
~~- **addCs()** adds a number of candy to the current sum.~~  
~~- **swap()** is modified to add Cs during the swap (depending on how many Cs are broken).~~  

~~JellyLevel:~~  
~~- **fulfilledReq()** returns whether all jelly has been cleared.~~  
~~- **getJellyLeft()** returns the amount of jelly left.~~  
~~- **subJelly()** subtracts the amount of jelly left according to the counter.~~  
~~- **swap()** is modified to subJelly() during swaps atop jellies.~~  

~~ChocolateLevel:~~  
~~- **fulfilledReq()** returns whether all chocolate has been cleared.~~  
~~- **getChocolateLeft()** returns the amount of jelly left.~~  
~~- **swap()** is modified to break chocolate neighbors of swaps.~~  
~~- **breakChocolate()** breaks the chocolate called to break in swap().~~  
~~- **placeChocolate()** places a chocolate next to another chocolate after each move/swap. See placeAt() in Chocolate.~~  
~~- **fulfilledReq()** returns whether all jelly has been cleared.~~  
~~- **getJellyLeft()** returns the amount of jelly left.~~  
~~- **subJelly()** subtracts the amount of jelly left according to the counter, but only if jellies are broken 2 times.~~  
~~- **isBroken()** checks if jelly is touched 2 to be broken.~~  
~~- **swap()** is modified to subJelly() during swaps with jellies.~~  

~~ChocolateLevel:~~  
~~- **fulfilledReq()** returns whether all chocolate has been cleared.~~  
~~- **getChocolateLeft()** returns the amount of jelly left.~~  
~~- **swap()** is modified to break chocolate neighbors of swaps.~~  
~~- **breakChocolate()** breaks the chocolate called to break in swap().~~  
~~- **placeChocolate()** places a chocolate next to another chocolate after each move/swap that doesn't break chocolate. See placeAt() in Chocolate.~~  

~~Sweet:~~  
~~- Candies are swappable; other sweets are not.~~  
~~- **getX()** and **getY()** return the x and y coords, respectively, of the sweet.~~  
~~- **break()** breaks the current candy and its neighbors that are lined up (if applicable).~~  
~~- **animateBreak()** animates the current sweet breaking: SWEET TYPE SPECIFIC~~  
~~- **display()** displays the sweet~~  

~~CHILDREN OF SWEET:~~  

~~Chocolate:~~  
~~- **placeAt()** returns the coordinates to place the next chocolate based on current chocolates on the board.~~  

~~Jelly:~~  
~~- **getLayers()** returns the number of layers of jelly on this square.~~  
~~- **subLayer()** subtracts a layer of jelly from this square.~~  
~~- **getLayers()** returns the number of layers of jelly on this square. Each jelly starts with 2.~~  
~~- **subLayer()** subtracts a layer of jelly from this square. When 0, fully broken and can subtract jelly from counter.~~  

~~Candy:~~  
~~- **canSwap()** determines whether a swap the user is attempting to make is viable by scanning the neighbors of the~~  
~~new x and y coords.~~  
~~- **scanNeighbors()** scans to see if a swap would be productive/a viable move based on the neighbors of the new position.~~  
~~- **setX()** and **setY()** are used when swapping a candy with its neighbor.~~  
~~- **scanNeighbors()** scans to see if a swap would be a normal or special move based on the neighbors of the new position.~~  
~~- **setX()** and **setY()** are used when swapping a candy with its neighbor.~~  

~~CHILDREN OF CANDY:~~  

~~Bomb:~~  
~~- Breaks all candy around it in a 3x3 area---it is set off twice.~~  
~~- Breaks all candy around it in a 3x3 area.~~  

~~Striped:~~  
~~- Breaks a whole row/column.~~  

~~ColorBomb:~~  
~~- Clears the whole board.~~  
~~- Clears the whole board. If completed level, will do this before showing winning screen.~~

 
# Intended pacing:

How you are breaking down the project and who is responsible for which parts.

5/26/25
 - Basic class structure outline in processing (Tweaking design = Maya, outline in processing = Eva)

5/30/25
 - Button done (Maya)
 - Sweet started (Eva)

5/31/25
 - Very basic Sweet, Candy & Candy's descdendants done (chocolate and jelly are nice to have)
  - Most functionality = Eva
  - Display and animations = Maya 

6/1/25
 - JellyJive and part of Level done
  - JellyJive: Maya
  - Level: Eva

6/2/25
 - Level done, everything functional though not pretty
  - Swap, genNewCandy, the few weird functions: Maya
  - Most smaller functions: Eva

6/3/25
 - Chocolate and jelly done
  - Display: Maya
  - Functionality: Eva

6/5/25
 - Backgrounds started on, graphics shinier
  - Basically all Maya

6/7/25
 - Great graphics, animations ok, start on sound
  - Further testing done by Eva
  - Possibly different button styles/other extra stuff done by Eva
  - Graphics and sound done by Maya

6/9/25
 - Done! With everything. MUST WORK.
  - Extensive testing: both. Plus get families involved.

~~5/25/25 - create all files and classes-both~~
~~Eva--complete candy and swap logic~~
~~Maya---start animation and displaying of first xp level for just candies~~

~~5/27/25~~
~~Eva---complete logic for special candies, and jellies~~
~~Maya---animation for bombs~~

~~5/29/25~~
~~Eva---complete/continue working on logic for chocolate/ fixing other logic if not finished~~
~~Maya---do animation and displaying of Jellies and level info~~

~~6/2/25~~
~~Eva---work on logic for goals of different difficulty~~
~~Maya---graphics, possibly sounds, main screen if possible. If not, finish graphics - we will discuss any logic not working~~