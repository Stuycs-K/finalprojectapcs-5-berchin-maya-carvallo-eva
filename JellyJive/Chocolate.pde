class Chocolate extends Sweet{
  public Chocolate(int x, int y)
  {
     super(x, y, false, "Chocolate");
  }

  void display(int xPadding, int yPadding){
    fill (90, 60, 40);
    //noStroke();
    stroke(color(0));
    rect(xPadding + getX() * SQUARE_LEN, yPadding + getY() * SQUARE_LEN, SQUARE_LEN, SQUARE_LEN);
  }
  void animateBreak(){};
  
  String toString()
  {
    return "chocolate";
  }
 
}
