class StageUi implements Ui {
  
  private long initTime = -1;
  private Stage stage;
  public StageUi(Stage stage) {
    this.stage = stage;
    this.initTime = GameVariables.getGameDelta();
  }
  
  @Override
  public void draw() {
    // Do background tasks first.
    stage.tick();
    background(stage.backgroundColor);
    long stageTick = GameVariables.getGameDelta() - this.initTime;
    
    long position = (long) ((double) stageTick * stage.getScrollSpeed());
    
    // Draw background objects.
    for(Map.Entry<Long, GameObject> entry : stage.getBackgroundObjects().entrySet()) {
      long startPosition = (long) ((double) entry.getKey() * stage.getScrollSpeed());
      push();
      translate(entry.getValue().getCoordinate().getFirst(), entry.getValue().getCoordinate().getSecond() + (entry.getValue().isScrolling() ? position - startPosition : 0));
      entry.getValue().draw(stageTick, stage.getScrollSpeed());
      pop();
    }
    
    // Draw tracked objects.
    for(Pair<Long, GameObject> objData : stage.getTrackedObjects()) {
      long startPosition = (long) ((double) objData.getFirst() * stage.getScrollSpeed());
      GameObject obj = objData.getSecond();
      push();
      translate(obj.getCoordinate().getFirst(), obj.getCoordinate().getSecond() + (obj.isScrolling() ? position - startPosition : 0));
      obj.draw(stageTick, stage.getScrollSpeed());
      pop();
      if(GameVariables.hitboxDebug && obj instanceof Interactable) {
        push();
        noFill();
        stroke(#FF0000);
        Hitbox hitbox = ((Interactable) obj).getHitbox();
        if(hitbox instanceof RectHitbox) {
          RectHitbox rHitbox = (RectHitbox) hitbox;
          if(obj.isScrolling()) rHitbox.shift(0, (int) (position - startPosition));
          rect(rHitbox.x1, rHitbox.y1, rHitbox.x2 - rHitbox.x1, rHitbox.y2 - rHitbox.y1);
        }
        pop();
      }
    }
    // Draw score and time, health indicators.
    int time = (int) stageTick / 1000;
    int lengthIndicator = (int) (((double) stageTick / (double) stage.getStageLength()) * 300.0);
    push();
    noStroke();
    fill(#006674);
    rect(0, 0, lengthIndicator, 5);
    pop();
    push();
    fill(#006674);
    textSize(10);
    text("Time:" + time, 10, 20);
    text("Health:" + stage.getHealth(), 100, 20);
    pop();
  }
  
  @Override
  public long getUiTick() {
    return GameVariables.getGameDelta() - this.initTime;
  }
  
  @Override
  public void mousePressed() {
    stage.mousePressed();
  }
  
  @Override
  public void mouseReleased() {
    stage.mouseReleased();
  }

}

class MainUi implements Ui {
  
  private long initTime = -1;
  private ArrayList<UiObject> objects = new ArrayList<UiObject>();
  public MainUi() {
    this.initTime = GameVariables.getGameDelta();
    objects.add(new UiTitle(150, 100, "GAME"));
    objects.add(new UiButton(100, 200, 250, 300, "GAME START") {
      @Override
      public void onInteract() {
        GameVariables.currentUi = new StageUi(new Stage());
      }
    });
  }
  
  @Override
  public void draw() {
    for(UiObject obj : objects) {
      push();
      obj.draw();
      pop();
    }
  }
  
  @Override
  public long getUiTick() {
    return GameVariables.getGameDelta() - this.initTime;
  }
  
  @Override
  public void mousePressed() {
    for(UiObject obj : objects) {
      obj.mousePressed();
    }
  }
  
  @Override
  public void mouseReleased() {
    for(UiObject obj : objects) {
      obj.mouseReleased();
    }
  }
}

class GameOverUi implements Ui {
  
  private long initTime = -1;
  private ArrayList<UiObject> objects = new ArrayList<UiObject>();
  public GameOverUi() {
    this.initTime = GameVariables.getGameDelta();
    objects.add(new UiTitle(150, 100, "GAME OVER"));
    objects.add(new UiButton(100, 200, 250, 300, "RESTART") {
      @Override
      public void onInteract() {
        GameVariables.currentUi = new StageUi(new Stage());
      }
    });
  }
  
  @Override
  public void draw() {
    for(UiObject obj : objects) {
      push();
      obj.draw();
      pop();
    }
  }
  
  @Override
  public long getUiTick() {
    return GameVariables.getGameDelta() - this.initTime;
  }
  
  @Override
  public void mousePressed() {
    for(UiObject obj : objects) {
      obj.mousePressed();
    }
  }
  
  @Override
  public void mouseReleased() {
    for(UiObject obj : objects) {
      obj.mouseReleased();
    }
  }
}

class ClearedUi implements Ui {
  
  private long initTime = -1;
  private ArrayList<UiObject> objects = new ArrayList<UiObject>();
  public ClearedUi() {
    this.initTime = GameVariables.getGameDelta();
    objects.add(new UiTitle(150, 100, "CLEARED"));
    objects.add(new UiButton(100, 200, 250, 300, "RESTART") {
      @Override
      public void onInteract() {
        GameVariables.currentUi = new StageUi(new Stage());
      }
    });
  }
  
  @Override
  public void draw() {
    for(UiObject obj : objects) {
      push();
      obj.draw();
      pop();
    }
  }
  
  @Override
  public long getUiTick() {
    return GameVariables.getGameDelta() - this.initTime;
  }
  
  @Override
  public void mousePressed() {
    for(UiObject obj : objects) {
      obj.mousePressed();
    }
  }
  
  @Override
  public void mouseReleased() {
    for(UiObject obj : objects) {
      obj.mouseReleased();
    }
  }
}



interface Ui {
  
  public void draw();
  
  public long getUiTick();
  
  public void mousePressed();
  
  public void mouseReleased();
}
