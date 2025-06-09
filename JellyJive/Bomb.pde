public class Bomb extends Sweet
{
  color cColor;
  public Bomb(int x, int y, color cColor)
  {
    super(x, y, true, "Bomb", cColor);
  }
  
  void display(int xPadding, int yPadding)
  {
    int rawX = this.getX()*SQUARE_LEN+SQUARE_LEN/2+xPadding;
    int rawY = this.getY()*SQUARE_LEN+SQUARE_LEN/2+yPadding;
    displayRaw(rawX,rawY);
  }
    void displayRaw(int rawX, int rawY)
  {
    //set up display vars
    float radius = SQUARE_LEN*.6;
    color baseColor = this.getColor();
    color darkColor = lerpColor(baseColor, color(0), .05);
    color darkestColor = lerpColor(baseColor, color(0), .3);
    color lightColor = lerpColor(baseColor, color(255), .3);
    //base circle
    stroke(darkestColor);
    fill(baseColor);
    circle(rawX,rawY,radius);
    //shading
    radius *= .65;
    stroke(lightColor);
    fill(darkColor);
    circle(rawX,rawY,radius);
    stroke(255);
    strokeWeight(3);
    line(rawX + 5, rawY + SQUARE_LEN/2, rawX + SQUARE_LEN - 5, rawY + SQUARE_LEN/2);
    strokeWeight(1);
    noStroke();
  }
  
  void animateBreak()
  {
    
  }
  
}
