
abstract class BSweet{

  private int x;
  private int y;
  private boolean swappable;
  private String name;
  
  public BSweet(int X, int Y, boolean swappable, String name)
  {
   x = X;
   y = Y;
   this.swappable = swappable;
   this.name = name;
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
  
  abstract void display();
  abstract void animateBreak();
  
}
