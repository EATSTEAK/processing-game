
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
  drawCharacter(mousePressed);
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

void drawCharacter(boolean isRed) {
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
  if(isRed) {
    fill(253, 41, 34);
  } else {
    fill(2, 204, 238);
  }
  beginShape();
  vertex(-15, -15);
  vertex(-20, 5);
  vertex(-15, 7);
  endShape();
  beginShape();
  vertex(15, -15);
  vertex(10, 5);
  vertex(15, 7);
  endShape();
  if(isRed) {
    fill(238, 24, 35);
  } else {
    fill(0, 195, 233);
  }
  beginShape();
  vertex(-15, -15);
  vertex(-10, 5);
  vertex(-15, 7);
  endShape();
  beginShape();
  vertex(15, -15);
  vertex(20, 5);
  vertex(15, 7);
  endShape();
  if(isRed) {
    fill(207, 0, 21);
  } else {
    fill(0, 158, 186);
  }
  beginShape();
  vertex(-20, 5);
  vertex(-15, 20);
  vertex(-15, 7);
  endShape();
  beginShape();
  vertex(10, 5);
  vertex(15, 20);
  vertex(15, 7);
  endShape();
  if(isRed) {
    fill(194, 0, 4);
  } else {
    fill(0, 138, 161);
  }
  beginShape();
  vertex(-10, 5);
  vertex(-15, 20);
  vertex(-15, 7);
  endShape();
  beginShape();
  vertex(20, 5);
  vertex(15, 20);
  vertex(15, 7);
  endShape();
  fill(79, 79, 79);
  beginShape();
  vertex(0, -5);
  vertex(2, -5);
  vertex(4, 7);
  vertex(0, 7);
  endShape();
  fill(98, 98, 98);
  beginShape();
  vertex(0, -5);
  vertex(-2, -5);
  vertex(-4, 7);
  vertex(0, 7);
  endShape();
}
