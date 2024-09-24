import java.awt.Rectangle;

public abstract class Entity{
  protected boolean alive;
  protected int w = 32, h = 32;
  protected float worldX, worldY;
  protected float speedX, speedY;
  protected boolean grounded;
  protected boolean inAir;
  protected Rectangle hitbox;
  protected boolean collisionOn;
  
  
  public Entity(float x, float y){
    alive = true;
    worldX = x;
    worldY = y;
  }
  
  protected void drawHitbox(){
    noFill();
    stroke(255, 0, 0);
    rect(hitbox.x, hitbox.y, hitbox.width, hitbox.height);
  }
  
  protected void initHitbox(int x, int y, int width, int height) {
    hitbox = new Rectangle(x, y, width, height);
  }


  public Rectangle getHitbox(){
     return hitbox; 
  }
  
}
  
