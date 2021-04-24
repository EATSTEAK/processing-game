import java.util.*;

class Stage {
  
  // Theme
  private color backgroundColor = #83e1f8;
  private color foregroundColor;
  private color accentColor;
  
  // Settings
  private long stageLength = 1000 * 60;
  private double scrollSpeed = 0.3;
  private long invincibleTime = 500 * 3;
  private HashMap<Long, GameObject> backgroundObjects = new HashMap<Long, GameObject>();
  private HashMap<Long, GameObject> foregroundObjects = new HashMap<Long, GameObject>();
  
  // Data
  private long initTick;
  private LinkedList<Pair<Long, GameObject>> trackedObjects = new LinkedList<Pair<Long, GameObject>>();
  private long lastShooted = -1;
  private int health = 5;
  private long lastHitted = -1;
  
  Stage() {
    this(GameVariables.getGameDelta());
  }
  
  Stage(long initTick) {
    this.initTick = initTick;
    for(long i = 0;i<stageLength;i += random(stageLength / 800, stageLength / 100)) {
      backgroundObjects.put(i, new Cloud(i, (int) random(0, 300), (int) random(0, 400), (int) random(25, 50)));
    }
    
    for(long i = 0;i<stageLength;i += random((stageLength - (i / 2))  / 200, (stageLength - (i / 2)) / 100)) {
      int x1 = (int) random(0, 300);
      int y1 = 0;
      int x2 = (int) random(20, 40);
      int y2 = (int) random(20, 40);
      foregroundObjects.put(i, new BasicBlock(i, x1, y1, x1 + x2, y1 + y2));
    }
    foregroundObjects.put(0l, new MainCharacter(0l));
    
  }
  
  // tick method for internal processing.
  public void tick() {
    // Handle object's lifecycle.
    long stageTick = GameVariables.getGameDelta() - initTick;
    long lastTick = GameVariables.getLastTick() - initTick;
    for(long i=lastTick;i<stageTick;i++) {
      if(foregroundObjects.containsKey(i)) {
        trackedObjects.add(new Pair<Long, GameObject>(i, foregroundObjects.get(i)));
      }
    }
    
    Iterator<Pair<Long, GameObject>> iter = trackedObjects.iterator();
    ArrayList<Pair<Long, GameObject>> addedObjects = new ArrayList<Pair<Long, GameObject>>();
    boolean isStageControllable = false;
    while (iter.hasNext()) {
      GameObject gameObj = iter.next().getSecond();
      gameObj.tick(stageTick, scrollSpeed);
      if(!gameObj.isExists()) { 
        iter.remove();
      } else if(gameObj instanceof Controllable) {
        if(mousePressed && stageTick - lastShooted > 100) {
          addedObjects.add(new Pair<Long, GameObject>(stageTick, new Bullet(stageTick, gameObj.getCoordinate().first, gameObj.getCoordinate().second - 40)));
          lastShooted = stageTick;
        }
        isStageControllable = true;
      }
    }
    for(Pair<Long, GameObject> obj : addedObjects) {
      trackedObjects.add(obj);
    }
    
    
    // Hit detection.
    long position = (long) ((double) stageTick * getScrollSpeed());
    for(int i=0;i<trackedObjects.size();i++) {
      Pair<Long, GameObject> tracked = trackedObjects.get(i);
      GameObject obj = tracked.getSecond();
      if(obj instanceof Interactable) {
        Interactable iObj = (Interactable) obj;
        for(int j=i;j<trackedObjects.size();j++) {
          Pair<Long, GameObject> target = trackedObjects.get(j);
          if(target.getSecond() instanceof Interactable) {
            Interactable targetObj = (Interactable) target.getSecond();
            long firstPosition = (long) ((double) tracked.getFirst() * getScrollSpeed());
            long secondPosition = (long) ((double) target.getFirst() * getScrollSpeed());
            Hitbox firstHitbox = iObj.getHitbox();
            Hitbox secondHitbox = targetObj.getHitbox();
            if(((GameObject)iObj).isScrolling()) firstHitbox.shift(0, (int) (position - firstPosition));
            if(((GameObject)targetObj).isScrolling()) secondHitbox.shift(0, (int) (position - secondPosition));
            if(firstHitbox.isHitted(secondHitbox)) {
              iObj.onHit(stageTick, targetObj);
              targetObj.onHit(stageTick, iObj);
              if(tracked.getSecond() instanceof Controllable && !(target.getSecond() instanceof Controllable)) {
                onHit(targetObj);
              }
              if(target.getSecond() instanceof Controllable && !(tracked.getSecond() instanceof Controllable)) {
                onHit(iObj);
              }
            }
          }
        }
      }
    }
    
    // Stage End.
    if(stageTick > stageLength || !isStageControllable) {
      endStage(true);
    }
    
  }
  
  public void onHit(Interactable obj) {
    long stageTick = GameVariables.getGameDelta() - initTick;
    if(stageTick - this.lastHitted < this.invincibleTime || !(obj instanceof Hostile)) return;
    if(obj instanceof Damageable) {
      Damageable dObj = (Damageable) obj;
      health -= dObj.getDamage();
      if(health <= 0) endStage(false);
      this.lastHitted = stageTick;
    }
    for(Pair<Long, GameObject> tracked : trackedObjects) {
      if(tracked.getSecond() instanceof Controllable && tracked.getSecond() instanceof Interactable) {
        Interactable iObj = (Interactable) tracked.getSecond();
        iObj.setLastHitted(stageTick);
      }
    }
  }
  
  public void endStage(boolean success) {
    GameVariables.currentUi = success ? new ClearedUi() : new GameOverUi();
  }
  
  public void mousePressed() {
  }
  
  public void mouseReleased() {
  }
  
  // get initiation tick on gametick for tracking stageTick.
  public long getInitTick() {
    return initTick;
  }
  
  public double getScrollSpeed() {
    return this.scrollSpeed;
  }
  
  public int getBackgroundColor() {
    return backgroundColor;
  }
  
  public int getForegroundColor() {
    return foregroundColor;
  }
  
  public int getAccentColor() {
    return accentColor;
  }
  
  public long getStageLength() {
    return stageLength;
  }
  
  public int getHealth() {
    return health;
  }
  
  public HashMap<Long, GameObject> getBackgroundObjects() {
    return backgroundObjects;
  }
  
  public HashMap<Long, GameObject> getForegroundObjects() {
    return foregroundObjects;
  }
  
  public List<Pair<Long, GameObject>> getTrackedObjects() {
    return trackedObjects;
  }
}
