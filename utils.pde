interface Hitbox {

  public boolean isHitted(int x, int y);
  
  public boolean isHitted(Hitbox hitbox);
  
  public void shift(int x, int y);
}


class VertexBuilder {
  
  private ArrayList<Pair<Integer, Integer>> vertexes = new ArrayList<Pair<Integer, Integer>>();
  
  public VertexBuilder add(int x, int y) {
    vertexes.add(new Pair<Integer, Integer>(x, y));
    return this;
  }
  
  public void build() {
    beginShape();
    for(Pair<Integer, Integer> coord : vertexes) {
      vertex(coord.first, coord.second);
    }
    endShape();
  }
}

class RectHitbox implements Hitbox {
  
  private int x1;
  private int x2;
  private int y1;
  private int y2;
  
  public RectHitbox(int x1, int y1, int x2, int y2) {
    if(x1 > x2 || y1 > y2) throw new IllegalArgumentException("First coordinate is must be smaller than second coordinate");
    this.x1 = x1;
    this.x2 = x2;
    this.y1 = y1;
    this.y2 = y2;
  }
  
  @Override
  public boolean isHitted(int x, int y) {
    if(x1 <= x && x2 >= x && y1 <= y && y2 >= y) return true;
    return false;
  }
  
  
  @Override
  public boolean isHitted(Hitbox hitbox) {
    // Implemented RectHitbox only.
    if(hitbox instanceof RectHitbox) {
      RectHitbox rectHitbox = (RectHitbox) hitbox;
      boolean isHitted = false;
      for(int i=rectHitbox.x1;i<=rectHitbox.x2;i++) {
        for(int j=rectHitbox.y1;j<=rectHitbox.y2;j++) {
          if(this.isHitted(i, j)) isHitted = true;
        }
      }
      return isHitted;
    }
    return false;
  }
  
  @Override
  public void shift(int x, int y) {
    this.x1 += x;
    this.x2 += x;
    this.y1 += y;
    this.y2 += y;
  }

}

class Pair<T, R> {
  private T first;
  private R second;
  
  public Pair(T f, R s) {
    this.first = f;
    this.second = s;
  }
  
  public T getFirst() {
    return first;
  }
  
  public R getSecond() {
    return second;
  }
}
