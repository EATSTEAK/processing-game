// Main character
/*
class MainCharacter implements GameObject, Alive, Controllable {
  
  private int health = 5;
  private int lastHitted = -1;
}

*/






// Basic Interfaces
interface GameObject {
  
  public int getMaxAge();
  
  public boolean isExists();
  
  public long getInitTick();

  public void tick(long stageTick, double scrollSpeed);
  
  public void draw(long stageTick, double scrollSpeed);
  
  public Pair<Integer, Integer> getCoordinate();
  
}

interface Interactable {

  public Hitbox getHitbox();
  
  public void onHit(Interactable hitted);

}

interface Alive {
  
  public int getHealth();
  
  public int getMaxHealth();
  
  public int lastHitted();
  
  public int getInvinsibleTime();
  
  public void setHealth(int health);
  
}

interface Damageable {
  
  public int getDamage();
  
}

interface Controllable {}
