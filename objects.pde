// Main character
/*
class MainCharacter implements GameObject, Alive, Controllable {
  
  private int health = 5;
  private int lastHitted = -1;
}

*/

class UiTitle implements UiObject {

  private int x1, y1, textWidth;
  private String title = "GAME";
  
  UiTitle(int x1, int y1) {
    this.x1 = x1;
    this.y1 = y1;
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
    textAlign(LEFT, LEFT);
    text("GAME", 0, 0);
  }
  
  @Override
  public void mousePressed() {
  }
  
  @Override
  public void mouseReleased() {
  }
  
  @Override
  public RectHitbox getClickArea() {
    return new RectHitbox(x1, y1, x1 + textWidth, y1 + 32);
  }
}

abstract class UiButton implements UiObject {
  
  private int x1, y1, x2, y2;
  private String label;
  private color bg = #009dba;
  private color textColor = #ffffff;
  UiButton(int x1, int y1, int x2, int y2, String label) {
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
    this.label = label;
  }
  
  UiButton(int x1, int y1, int x2, int y2, String label, color bg,  color textColor) {
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
    this.label = label;
    this.bg = bg;
    this.textColor = textColor;
  }
  
  public abstract void onInteract();
  
  @Override
  public void draw() {
    fill(bg);
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
    onInteract();
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



// Basic Interfaces
interface GameObject {
  
  public int getMaxAge();
  
  public boolean isExists();
  
  public long getInitTick();

  public void tick(long stageTick, double scrollSpeed);
  
  public void draw(long stageTick, double scrollSpeed);
  
  public Pair<Integer, Integer> getCoordinate();
  
}


interface Interactable {

  public Hitbox getHitbox();
  
  public void onHit(Interactable hitted);

}

interface Alive {
  
  public int getHealth();
  
  public int getMaxHealth();
  
  public int lastHitted();
  
  public int getInvinsibleTime();
  
  public void setHealth(int health);
  
}

interface Damageable {
  
  public int getDamage();
  
}

interface Controllable {}
