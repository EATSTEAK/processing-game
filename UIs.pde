class StageUi implements Ui {
  
  private long initTime = -1;
  private Stage stage;
  public StageUi(Stage stage) {
    this.stage = stage;
    this.initTime = GameVariables.getGameDelta();
  }
  
  @Override
  public void draw() {
    stage.tick();
  }
  
  @Override
  public long getUiTick() {
    return GameVariables.getGameDelta() - this.initTime;
  }

}

class MainUi implements Ui {
  
  private long initTime = -1;
  private ArrayList<UiObject> objects = new ArrayList<UiObject>();
  public MainUi() {
    this.initTime = GameVariables.getGameDelta();
    objects.add(new UiTitle(50, 50));
    objects.add(new UiButton(50, 200, 150, 250, "GAME START") {
      @Override
      public void onInteract() {
        
      }
    });
  }
  
  @Override
  public void draw() {
    translate(mouseX, mouseY);
    drawCharacter(mousePressed);
  }
  
  @Override
  public long getUiTick() {
    return GameVariables.getGameDelta() - this.initTime;
  }
  
  private void drawCharacter(boolean isRed) {
    noStroke();
    fill(128);
    triangle(0, -40, 10, 0, 0, 20);
    new VertexBuilder().add(5, -10).add(20, 10).add(40, 15).add(20, 15).add(-5, 10).build();
    fill(156);
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
    fill(79, 79, 79);
    new VertexBuilder().add(0, -5).add(2, -5).add(4, 7).add(0, 7).build();
    fill(98, 98, 98);
    new VertexBuilder().add(0, -5).add(-2, -5).add(-4, 7).add(0, 7).build();
  }
}



interface Ui {
  
  public void draw();
  
  public long getUiTick();
}
