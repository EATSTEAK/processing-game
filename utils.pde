interface Hitbox {

  public boolean isHitted(int x, int y);
  
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
  
  public RectHitbox(int x1, int x2, int y1, int y2) {
    if(x1 > x2 || y1 > y2) throw new IllegalArgumentException("First coordinate is must be smaller than second coordinate");
    this.x1 = x1;
    this.x2 = x2;
    this.y1 = y1;
    this.y2 = y2;
  }
  
  @Override
  public boolean isHitted(int x, int y) {
    if(x1 <= x && x2 >= x && y1 <= y && y2 <= y) return true;
    return false;
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
