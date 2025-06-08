class Jelly extends Sweet{
  
  private int layers;
  
  public Jelly(int x, int y)
  {
     super(x, y, false, "Jelly");
     layers = 3;
  }
  
  void display(int xPadding, int yPadding){
    fill (173, 216, 230, 100);
    noStroke();
    rect(xPadding + getX() * SQUARE_LEN, yPadding + getY() * SQUARE_LEN, SQUARE_LEN, SQUARE_LEN);
  }
  
  void sublayer()
  {
    layers--;
  }
  
  int getLayers()
  {
    return layers;
  }
  
  void animateBreak(){}

}
