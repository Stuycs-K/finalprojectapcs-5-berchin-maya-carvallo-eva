class Jelly extends Sweet{
  
  private int layers;
  
  public Jelly(int x, int y)
  {
     super(x, y, false, "jelly",color(173, 216, 230));
     layers = 3;
  }
  
  void display(int xPadding, int yPadding){
    fill (getColor(), 100);
    noStroke();
    for (int l = 0; l < layers; l++)
      rect(xPadding + getX() * SQUARE_LEN, yPadding + getY() * SQUARE_LEN, SQUARE_LEN, SQUARE_LEN,10);
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
