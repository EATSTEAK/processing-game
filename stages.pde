import java.util.*;

class Stage {
  
  // Theme
  private int backgroundColor;
  private int foregroundColor;
  private int accentColor;
  
  // Settings
  private long stageLength;
  private double scrollSpeed;
  private HashMap<Long, GameObject> backgroundObjects;
  private HashMap<Long, GameObject> foregroundObjects;
  
  // Data
  private long initTick;
  private LinkedList<GameObject> trackedObjects;
  
  
  // tick method for internal processing.
  public void tick() {
    // TODO: Spawning background and foreground objects by scrollSpeed
    long stageTick = GameVariables.getGameDelta() - initTick;
    LinkedList<Integer> removedObjects = new LinkedList<Integer>();
    int i = 0;
    for(GameObject gameObj: trackedObjects) {
      gameObj.tick(stageTick, scrollSpeed);
      if(!gameObj.isExists()) removedObjects.add(i);
      i++;
    }
    
  }
  
  // get initiation tick on gametick for tracking stageTick.
  public long getInitTick() {
    return initTick;
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
  
  public HashMap<Long, GameObject> getBackgroundObjects() {
    return new HashMap<Long, GameObject>();
  }
  
  public HashMap<Long, GameObject> getForegroundObjects() {
    return new HashMap<Long, GameObject>();
  }
 
}
