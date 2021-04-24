
static class GameVariables {
  
  private static long initTime = 0;
  private static long lastTick = -1;
  private static Ui currentUi;
  private static boolean hitboxDebug = true;
  
  public static long getGameDelta() {
    return System.currentTimeMillis() - initTime;
  }
  
  public static long getLastTick() {
    return lastTick;
  }
  
  public static void setLastTick(long gameDelta) {
    lastTick = gameDelta;
  }
  
  public static Ui getCurrentUi() {
    return currentUi;
  }
  
}

void setup() {
  GameVariables.initTime = System.currentTimeMillis();
  GameVariables.currentUi = new MainUi();
  size(300, 400);
}

void draw() {
  clear();
  background(100);
  // Draws Ui.
  push();
  GameVariables.getCurrentUi().draw();
  pop();
  // FPS Indicator
  push();
  fill(#4caf50);
  textSize(10);
  textAlign(RIGHT, TOP);
  text((1000 / (int)(GameVariables.getGameDelta() - GameVariables.getLastTick())), 300, 0);
  pop();
  // set lastTick for calculate tickDelta.
  GameVariables.setLastTick(GameVariables.getGameDelta());
}

void mousePressed() {
  GameVariables.getCurrentUi().mousePressed();
}

void mouseReleased() {
  GameVariables.getCurrentUi().mouseReleased();
}
