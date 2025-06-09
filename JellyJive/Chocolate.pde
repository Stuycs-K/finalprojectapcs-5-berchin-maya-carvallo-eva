class Chocolate extends Sweet{
  public Chocolate(int x, int y)
  {
     super(x, y, false, "chocolate",color(90, 60, 40));
  }

  void display(int xPadding, int yPadding){
    displayRaw(xPadding + getX() * SQUARE_LEN, yPadding + getY() * SQUARE_LEN);
  }
  
  void displayRaw(int rawX, int rawY)
  {
    fill(getColor());
    stroke(color(0));
    rect(rawX+SQUARE_LEN*.05, rawY+SQUARE_LEN*.05, SQUARE_LEN*.9, SQUARE_LEN*.9,10);
  }
 
}
