class Jelly extends Sweet{
  
  private int layers;
  
  public Jelly(int x, int y)
  {
     super(x, y, false, "Jelly");
     layers = 3;
  }
  
  void display(int xPadding, int yPadding){}
  
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
