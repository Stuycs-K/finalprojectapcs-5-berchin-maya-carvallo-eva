public class Bomb extends Candy
{
  color cColor;
  public Bomb(int x, int y, color cColor)
  {
    super(x, y, "bomb", cColor);
  }
  
  void display(int xPadding, int yPadding)
  {
    int rawX = this.getX()*SQUARE_LEN+SQUARE_LEN/2+xPadding;
    int rawY = this.getY()*SQUARE_LEN+SQUARE_LEN/2+yPadding;
    displayRaw(rawX,rawY);
  }
  
  void displayRaw(int rawX, int rawY)
  {
    super.displayRaw(rawX,rawY);
    fill(255);
    noStroke();
    float squareSide = SQUARE_LEN*.2;
    square(rawX-(squareSide/2),rawY-(squareSide/2),squareSide);
  }
  
  String getName()
  {
    return super.getName() + "bomb";
  }
  
}
