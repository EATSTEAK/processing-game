
static class GameVariables {
  
  private static long initTime = 0;
  private static long lastTick = -1;
  
  public static long getGameDelta() {
    return System.currentTimeMillis() - initTime;
  }
  
  public static long getLastTick() {
    return lastTick;
  }
  
  public static void setLastTick(long gameDelta) {
    lastTick = gameDelta;
  }
  
}

void setup() {
  GameVariables.initTime = System.currentTimeMillis();
  size(300, 400);
}

void draw() {
  clear();
  background(100);
  push();
  translate(mouseX, mouseY);
  drawCharacter();
  pop();
  
  
  // FPS Indicator
  push();
  textSize(10);
  textAlign(RIGHT, TOP);
  text("FPS:" + (1000 / (int)(GameVariables.getGameDelta() - GameVariables.getLastTick())), 300, 0);
  pop();
  // set lastTick for calculate tickDelta.
  GameVariables.setLastTick(GameVariables.getGameDelta());
}

void drawCharacter() {
  
  noStroke();
  fill(128);
  triangle(0, -40, 10, 0, 0, 20);
  beginShape();
  vertex(5, -10);
  vertex(20, 10);
  vertex(40, 15);
  vertex(20, 15);
  vertex(-5, 10);
  endShape();
  fill(156);
  triangle(0, -40, -10, 0, 0, 20);
  beginShape();
  vertex(-5, -10);
  vertex(-20, 10);
  vertex(-40, 15);
  vertex(-20, 15);
  vertex(5, 10);
  endShape();
}
