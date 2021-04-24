int frames = 0;
MainCharacter[] mChars;
void setup() {
  mChars = new MainCharacter[]{ 
    new MainCharacter(150, 500, -100, 180),
    new MainCharacter(100, 550, -50, 180),
    new MainCharacter(200, 550, -50, 180),
    new MainCharacter(150, 600, -200, 360),
    new MainCharacter(50, 600, -300, 720),
    new MainCharacter(250, 400, 200, 180)
  };
  size(300, 400);
}

void draw() {
  frames++;
  clear();
  background(100);
  for(MainCharacter mChar : mChars) {
    mChar.draw();
  }
}

class MainCharacter {

  int x, start, end, duration;

  MainCharacter(int x, int start, int end, int duration) {
    this.x = x;
    this.start = start;
    this.end = end;
    this.duration = duration;
  }

  public void draw() {
    float p = (frames % duration) / (float) duration;
    float ease = p * p * p * p;
    int position = (int)((end - start) * ease);
    for (int i = start; i >= start + position; i -= 10) {
      push();
      translate(x - 10, i);
      drawFire();
      pop();
      push();
      translate(x + 10, i);
      drawFire();
      pop();
    }
    push();
    translate(x, start + position);
    // translate(mouseX, mouseY);
    drawCharater(mousePressed);
    pop();
  }

  void drawFire() {
    color[] colors = new color[] {
      #D70000,
      #FF6140,
      #FFED00,
      #FFA700
    };
    color c = colors[(int) random(0, colors.length)];
    float rotation = random(0, TWO_PI);
    rotate(rotation);
    noStroke();
    fill(c);
    triangle(0, -5, 5, 5, -5, 5);
  }

  void drawCharater(boolean isRed) {
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
    if (isRed) {
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
    if (isRed) {
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
    if (isRed) {
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
    if (isRed) {
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
}
