void setup() {
  size(300, 400);
}

void draw() {
  clear();
  background(100);
  push();
  translate(mouseX, mouseY);
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
  pop();
}
