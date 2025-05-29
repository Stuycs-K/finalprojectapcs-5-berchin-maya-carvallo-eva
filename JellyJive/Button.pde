public class Button{
 private int x;
 private int y;
 private int b;
 private int h;
 private String text;
 private boolean enabled;
 
 public Button(int x, int y, int b, int h, String text)
 {
   this.x = x;
   this.y = y;
   this.b = b;
   this.h = h;
   this.text = text;
   enabled = false;
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
 
 boolean wasPressed(int mx, int my)
 {
   return mx >= x && mx <= x+b && my >= y && my <= y+h;
 }
}
