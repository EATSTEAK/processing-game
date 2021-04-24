// Main character, not alive(player's health is handled by stage object).
class MainCharacter implements GameObject, Controllable, Interactable {
  
  private long initTick, lastHitted = -1;
  private int invincibleTime = 1000 * 2;
  
  MainCharacter(long initTick) {
    this.initTick = initTick;
  }
  
  // Undestructable
  @Override public boolean isExists() { return true; }
  
  @Override public long getInitTick() { return initTick; }
  
  @Override
  public void tick(long stageTick, double scrollSpeed) {
  }
  
  public boolean isScrolling() { return false; }
  
  @Override
  public void draw(long stageTick, double scrollSpeed) {
    boolean isRed = mousePressed;
    int hitOverlay = lastHitted > 0 && (stageTick - lastHitted) < invincibleTime && ((stageTick - lastHitted) / 200) % 2 == 0 ? 100 : 0;
    noStroke();
    fill(128 + hitOverlay, 128, 128);
    triangle(0, -40, 10, 0, 0, 20);
    new VertexBuilder().add(5, -10).add(20, 10).add(40, 15).add(20, 15).add(-5, 10).build();
    fill(156 + hitOverlay, 156, 156);
    triangle(0, -40, -10, 0, 0, 20);
    new VertexBuilder().add(-5, -10).add(-20, 10).add(-40, 15).add(-20, 15).add(5, 10).build();
    if(isRed) {
      fill(253, 41, 34);
    } else {
      fill(2, 204, 238);
    }
    new VertexBuilder().add(-15, -15).add(-20, 5).add(-15, 7).build();
    new VertexBuilder().add(15, -15).add(10, 5).add(15, 7).build();
    if(isRed) {
      fill(238, 24, 35);
    } else {
      fill(0, 195, 233);
    }
    new VertexBuilder().add(-15, -15).add(-10, 5).add(-15, 7).build();
    new VertexBuilder().add(15, -15).add(20, 5).add(15, 7).build();
    if(isRed) {
      fill(207, 0, 21);
    } else {
      fill(0, 158, 186);
    }
    new VertexBuilder().add(-20, 5).add(-15, 20).add(-15, 7).build();
    new VertexBuilder().add(10, 5).add(15, 20).add(15, 7).build();
    if(isRed) {
      fill(194, 0, 4);
    } else {
      fill(0, 138, 161);
    }
    new VertexBuilder().add(-10, 5).add(-15, 20).add(-15, 7).build();
    new VertexBuilder().add(20, 5).add(15, 20).add(15, 7).build();
    fill(79 + hitOverlay, 79, 79);
    new VertexBuilder().add(0, -5).add(2, -5).add(4, 7).add(0, 7).build();
    fill(98 + hitOverlay, 98, 98);
    new VertexBuilder().add(0, -5).add(-2, -5).add(-4, 7).add(0, 7).build();
    push();
    translate(-15, 20);
    drawFire();
    translate(0, 5);
    drawFire();
    pop();
    push();
    translate(15, 20);
    drawFire();
    translate(0, 5);
    drawFire();
    pop();
  }
  
  void drawFire() {
    color[] colors = new color[]{ #D70000, #FF6140, #FFED00, #FFA700 };
    color c = colors[(int) random(0, colors.length)];
    float rotation = random(0, TWO_PI);
    rotate(rotation);
    noStroke();
    fill(c);
    triangle(0, -5, 5, 5, -5, 5);
  }
  
  @Override
  public Pair<Integer, Integer> getCoordinate() {
    return new Pair<Integer, Integer>(mouseX, mouseY);
  }
  
  @Override
  public Hitbox getHitbox() {
    return new RectHitbox(mouseX - 40, mouseY - 15, mouseX + 40, mouseY + 15);
  }
  
  @Override
  public void onHit(long stageTick, Interactable hitted) {
  }
  
  @Override public long getLastHitted() { return lastHitted; }
  
  @Override public void setLastHitted(long lastHitted) { this.lastHitted = lastHitted; }
  
}

class BasicBlock implements GameObject, Interactable, Hostile, Damageable, Alive {
  
  private long initTick;
  private int x1, y1, x2, y2;
  private long lastHitted = -1;
  private boolean isExists = true;
  private int health = 3;
  
  BasicBlock(long initTick, int x1, int y1, int x2, int y2) {
    this.initTick = initTick;
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
  }
  
  @Override public boolean isExists() { return isExists; }
  
  @Override public long getInitTick() { return initTick; }
  
  @Override public void tick(long stageTick, double scrollSpeed) {
    long position = (long) ((double) stageTick * scrollSpeed);
    long startPosition = (long) ((double) initTick * scrollSpeed);
    if(position - startPosition + y1 > 400) isExists = false;
  }
  
  @Override public boolean isScrolling() { return true; }
  
  @Override
  public void draw(long stageTick, double scrollSpeed) {
    noStroke();
    fill(health == 2 ? #776666 : health == 1 ? #ee6666 : #666666);
    rect(0, 0, x2 - x1, y2 - y1);
  }
  
  @Override
  public Pair<Integer, Integer> getCoordinate() {
    return new Pair<Integer, Integer>(x1, y1);
  }
  
  @Override
  public Hitbox getHitbox() {
    return new RectHitbox(x1, y1, x2, y2);
  }
  
  @Override
  public void onHit(long stageTick, Interactable hitted) {
    if(!(hitted instanceof BasicBlock)) {
      if(hitted instanceof Damageable) {
        lastHitted = stageTick;
        this.health -= ((Damageable) hitted).getDamage();
        if(health <= 0) isExists = false;
      }
    }
  }
  
  @Override public long getLastHitted() { return lastHitted; }
  
  @Override public void setLastHitted(long lastHitted) { this.lastHitted = lastHitted; }
  
  @Override public int getDamage() { return 1; }
  
  @Override public int getHealth() { return health; }
  
  @Override public int getMaxHealth() { return 2; }
  
  @Override public int getInvinsibleTime() { return 1000 * 2; }
  
  @Override public void setHealth(int health) { this.health = health; }
  
}

class Cloud implements GameObject {
  
  private long initTick;
  private int x, y, size;
  
  Cloud(long initTick, int x, int y, int size) {
    this.initTick = initTick;
    this.x = x;
    this.y = y;
    this.size = size;
  }
  
  public boolean isExists() { return true; }
  
  public long getInitTick() { return initTick; }
  
  public void tick(long stageTick, double scrollSpeed) {}
  
  public boolean isScrolling() { return true; }
  
  public void draw(long stageTick, double scrollSpeed) {
    noStroke();
    fill(#e1f8fe);
    circle(x, y + (size / 2), size);
    circle(x + (size / 2), y + (size / 2), size);
    circle(x + size, y + (size / 2), size);
    circle(x + (size / 3), y, size);
    circle(x + ((size / 3) * 2), y, size);
  }
  
  @Override
  public Pair<Integer, Integer> getCoordinate() {
    return new Pair<Integer, Integer>(x, y);
  }
  
}

class Bullet implements GameObject, Interactable, Damageable {
  
  private long initTick;
  private int x, y;
  private long lastHitted = -1;
  
  Bullet(long initTick, int x, int y) {
    this.initTick = initTick;
    this.x = x;
    this.y = y;
  }
  
  @Override public boolean isExists() { return (lastHitted < 0 && y > 0 && y < 400); }
  
  @Override public long getInitTick() { return this.initTick; }
  
  @Override
  public void tick(long stageTick, double scrollSpeed) {
    y -= 4;
  }
  
  @Override
  public void draw(long stageTick, double scrollSpeed) {
    noStroke();
    fill(#000000);
    circle(0, 0, 4);
  }
  
  @Override
  public Pair<Integer, Integer> getCoordinate() {
    return new Pair<Integer, Integer>(x, y);
  }
  
  @Override public boolean isScrolling() { return false; }
  
  @Override
  public Hitbox getHitbox() {
    return new RectHitbox(x - 2, y - 2, x + 2, y + 2);
  }
  
  @Override
  public void onHit(long stageTick, Interactable hitted) {
    if(!(hitted instanceof Controllable) && !(hitted instanceof Bullet)) {
      lastHitted = stageTick;
    }
  }
  
  @Override public long getLastHitted() { return lastHitted; }
  
  @Override public void setLastHitted(long lastHitted) { this.lastHitted = lastHitted; }
  
  @Override public int getDamage() { return 1; }
}



// Basic Interfaces
interface GameObject {
  
  public boolean isExists();
  
  public long getInitTick();

  public void tick(long stageTick, double scrollSpeed);
  
  public void draw(long stageTick, double scrollSpeed);
  
  public Pair<Integer, Integer> getCoordinate();
  
  public boolean isScrolling();
  
}


interface Interactable {

  public Hitbox getHitbox();
  
  public void onHit(long stageTick, Interactable hitted);
  
  public long getLastHitted();
  
  public void setLastHitted(long lastHitted);

}

interface Alive {
  
  public int getHealth();
  
  public int getMaxHealth();
  
  public int getInvinsibleTime();
  
  public void setHealth(int health);
  
}

interface Damageable {
  
  public int getDamage();
  
}

interface Controllable {}

interface Hostile {}
