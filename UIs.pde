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



interface Ui {
  
  public void draw();
  
  public long getUiTick();
}
