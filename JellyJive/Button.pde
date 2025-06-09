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
   int roundedCorners = 10;
   color baseColor = color(255, 100, 200);
   color shadow = lerpColor(baseColor, 0 , .3);
   stroke(shadow);
   fill(shadow);
   rect(x,y,b,h,roundedCorners);
   fill(baseColor);
   rect(x,y,b*.98,h*.98,roundedCorners);
   fill(255);
   textAlign(CENTER);
   textSize(16);
   text(text,x+b/2,y+h/1.5);
 }
 
 boolean isEnabled()
 {
    return enabled; 
 }
 
 void enable()
 {
    enabled = true; 
    displayButton();
 }
 
 void disable()
 {
    enabled = false; 
 }
 
 boolean wasPressed(int mx, int my)
 {
   return isEnabled() && mx >= x && mx <= x+b && my >= y && my <= y+h;
 }
}
