public class Striped extends Candy
{
  boolean vertical;
  color cColor;
  public Striped(int x, int y, color cColor, boolean vertical)
  {
    super(x, y, "striped", cColor);
    this.vertical = vertical;
  }
  
  void display(int xPadding, int yPadding)
  {
    int rawX = this.getX()*SQUARE_LEN+SQUARE_LEN/2+xPadding;
    int rawY = this.getY()*SQUARE_LEN+SQUARE_LEN/2+yPadding;
    displayRaw(rawX,rawY);
  }
  
  void displayRaw(int rawX, int rawY)
  {
    //check if in bounds
    float diameter = SQUARE_LEN*.6;
    if ((rawX-diameter/2 < gameBoard.xPadding || rawX+diameter/2 > gameBoard.xPadding + gameBoard.boardLen || rawY-diameter/2 < gameBoard.yPadding || rawY+diameter/2 > gameBoard.yPadding + gameBoard.boardLen)
       || (rawX-(getX()*SQUARE_LEN+gameBoard.xPadding) > 1.2*SQUARE_LEN || ((rawY-(getY()*SQUARE_LEN+gameBoard.yPadding) > 1.2*SQUARE_LEN))))
    {
      setStill();
      return;
    }
    super.displayRaw(rawX, rawY);
    fill(255);
    noStroke();
    float bigSide = SQUARE_LEN*.2;
    float smallSide = bigSide / 3;
    if (vertical)
      rect(rawX-smallSide/2,rawY-bigSide/2,smallSide,bigSide,5);
    else
      rect(rawX-bigSide/2,rawY-smallSide/2,bigSide,smallSide,5);
  }
  
  String getName()
  {
    String result = super.getName();
    if (vertical)
      result += "vertical";
    else
      result += "horizontal";
    return result + "striped";
  }
}
