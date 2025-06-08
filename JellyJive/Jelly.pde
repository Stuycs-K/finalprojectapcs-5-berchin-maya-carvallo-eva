class Jelly extends Sweet{
  
  private int layers;
  
  public Jelly(int x, int y)
  {
     super(x, y, false, "Jelly");
     layers = 3;
  }
  
  void display(int xPadding, int yPadding){
    for (int i = 0; i < GRID_SIZE; i++)
    {
      for (int j = 0; j < GRID_SIZE; j++)
      {
        fill (173, 216, 230, 100);
        noStroke();
        rect(xPadding + i * SQUARE_LEN, yPadding + j * SQUARE_LEN, SQUARE_LEN, SQUARE_LEN);
      }
    }
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
