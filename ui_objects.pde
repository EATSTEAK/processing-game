
class UiTitle implements UiObject {

  private int x1, y1, textWidth;
  private String title = "GAME";
  
  UiTitle(int x1, int y1, String title) {
    this.x1 = x1;
    this.y1 = y1;
    this.title = title;
    // Calculate Textwidth for correct hitbox detection.
    push();
    textSize(32);
    this.textWidth = (int) textWidth(title);
    pop();
  }
  
  @Override
  public void draw() {
    translate(x1, y1);
    fill(#00c2e9);
    textSize(32);
    textAlign(CENTER, LEFT);
    text(title, 0, 0);
  }
  
  @Override
  public void mousePressed() {
  }
  
  @Override
  public void mouseReleased() {
  }
  
  @Override
  public RectHitbox getClickArea() {
    return new RectHitbox(x1 - (textWidth / 2), y1, x1 + (textWidth / 2), y1 + 32);
  }
}

abstract class UiButton implements UiObject {
  
  private int x1, y1, x2, y2;
  private String label;
  private color bg = #009dba;
  private color pressed = #0089a1;
  private color textColor = #ffffff;
  UiButton(int x1, int x2, int y1, int y2, String label) {
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
    this.label = label;
  }
  
  UiButton(int x1, int y1, int x2, int y2, String label, color bg, color pressed, color textColor) {
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
    this.label = label;
    this.bg = bg;
    this.pressed = pressed;
    this.textColor = textColor;
  }
  
  public abstract void onInteract();
  
  @Override
  public void draw() {
    if(mousePressed && this.getClickArea().isHitted(mouseX, mouseY)) { fill(pressed); } else { fill(bg); }
    rect(x1, y1, x2 - x1, y2 - y1, 5);
    push();
    fill(textColor);
    textSize(10);
    textAlign(CENTER, CENTER);
    text(label, (x1 + x2) / 2, (y1 + y2) / 2);
    pop();
  }
  
  @Override
  public void mousePressed() {
    // Do Nothing
  }
  
  @Override
  public void mouseReleased() {
    if(getClickArea().isHitted(mouseX, mouseY)) { onInteract(); }
  }
  
  @Override
  public RectHitbox getClickArea() {
    return new RectHitbox(x1, y1, x2, y2);
  }
  
}


interface UiObject {
  
  public void draw();
  
  public void mousePressed();
  
  public void mouseReleased();
  
  public RectHitbox getClickArea();
}
