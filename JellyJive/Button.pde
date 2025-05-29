public class Button{
 private int x;
 private int y;
 private int b;
 private int h;
 private String text;
 private boolean enabled;
 
 public Button(int x, int y, int b, int h)
 {
   this.x = x;
   this.y = y;
   this.b = b;
   this.h = h;
 }
 
 void displayButton()
 {
   
 }
 
 boolean isEnabled()
 {
    return enabled; 
 }
 
 void enable()
 {
    enabled = true; 
 }
 
 void disable()
 {
    enabled = false; 
 }
 
 boolean wasPressed()
 {
   return true;
 }
}
