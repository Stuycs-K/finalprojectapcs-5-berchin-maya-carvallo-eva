abstract class Sweet{

  private int x;
  private int y;
  private boolean swappable;
  private boolean inMotion;
  private String name;
  
  public Sweet(int X, int Y, boolean swappable, String name)
  {
   x = X;
   y = Y;
   this.swappable = swappable;
   this.name = name;
   inMotion = false;
  }
  
  int getX()
  {
   return x; 
  }
  
  int getY()
  {
   return y; 
  }
  
  boolean isSwappable()
  {
    return swappable;
  }
  
  boolean canSwap() 
  {
    return false; //overridden in candy class
  }
  
  String getName()
  {
    return name;
  }
  
  void setX(int x)
  {
     this.x = x;
  }
  
  void setY(int y)
  {
     this.y = y; 
  }
  
  String toString() 
  {
    return getName();
  }
  
  boolean isInMotion()
  {
    return inMotion;
  }
  
  void setInMotion()
  {
    if (isSwappable())
      inMotion = true;
  }
  
  void setStill()
  {
    inMotion = false;
  }
  
  //OVERRIDE IN CANDY
  void displayRaw(int rawX, int rawY){}
  abstract void display(int xPadding, int yPadding);
  abstract void animateBreak();
  
}
