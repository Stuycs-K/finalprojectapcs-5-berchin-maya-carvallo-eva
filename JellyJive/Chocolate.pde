class Chocolate extends Sweet{
  public Chocolate(int x, int y)
  {
     super(x, y, false, "Chocolate");
  }

  void display(int xPadding, int yPadding){
    displayRaw(xPadding + getX() * SQUARE_LEN, yPadding + getY() * SQUARE_LEN);
  }
  
  void displayRaw(int rawX, int rawY)
  {
    fill (90, 60, 40);
    stroke(color(0));
    rect(rawX, rawY, SQUARE_LEN, SQUARE_LEN);
  }
  void animateBreak(){};
 
}
