class Chocolate extends Sweet{
  public Chocolate(int x, int y)
  {
     super(x, y, false, "Chocolate");
  }

  void display(int xPadding, int yPadding){
   for (int i = 0; i < GRID_SIZE; i++)
    {
      for (int j = 0; j < GRID_SIZE; j++)
      {
        fill (90, 60, 40);
        noStroke();
        rect(xPadding + i * SQUARE_LEN, yPadding + j * SQUARE_LEN, SQUARE_LEN, SQUARE_LEN);
      }
    }
  }
  void animateBreak(){};
 
}
