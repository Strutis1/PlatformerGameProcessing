public class Player extends Entity {
  private PImage[][] animations;
  private boolean isDoubleJumping = false;
  private float legStrength = 5 * SCALE;
  private int maxJumps = 2;
  private int extraJumps;
  private int aniTick, aniIndex, animationSpeed = 5;
  private int playerAction = PlayerConstants.IDLE;
  private boolean moving = false;
  private boolean left, up, right;
  private boolean jumpPressed;
  private int hitboxWidth = 17;//by looking at sprite
  private int hitboxHeight = 20;
  private float startSpeed = 1.5f * SCALE;
  private int hitboxXOffset = (int)(((w - hitboxWidth) / 2) * SCALE);
  private int hitboxYOffset = (int)((h - hitboxHeight) * SCALE); 
  
  public int screenX, screenY;
  
  
  public Player(float x, float y) {
        super(x, y);
        screenX = (int)(width / 2 - worldX);  // Initial camera offset
        screenY = (int)(height / 2 - worldY);
        loadAnimations();
        initHitbox((int)screenX,(int)screenY, (int)(hitboxWidth), (int) (hitboxHeight));
    }
  
  public void setSpawn(int x, int y){
    this.worldX = x;
    this.worldY = y;
    hitbox.x = (int)worldX;
    hitbox.y = (int)worldY;
  }
  
  public void update() {
        screenX = (int)(width / 2 - worldX);
        screenY = (int)(height / 2 - worldY);

        render();
        updateAnimationTick();
        updatePos();
        updateHitbox();
        setAnimation();
    }
  
  public Player getPlayer() {
    return player;
  }
  
  public void render() {
    
    // Drawing the player in the center of the screen (or near-center)
    if (left && !right) {
        pushMatrix();
        translate(width / 2 + w, height / 2); // Player is centered on the screen
        scale(-1, 1);
        image(animations[playerAction][aniIndex], 0, 0, w, h); // Draw player
        popMatrix();
    } else {
        image(animations[playerAction][aniIndex], width / 2, height / 2, w, h); // Center player on the screen
    }
}

  

  
  private void updateAnimationTick() {
    aniTick++;
    if(aniTick >= animationSpeed) {
      aniTick = 0;
      aniIndex++;
      if(aniIndex >= PlayerConstants.GetSpriteAmount(playerAction))
        aniIndex = 0;
    }
  }
  
  private void updateHitbox() {
    int hitboxXOffset = (w - hitbox.width) / 2;  // Horizontally center
    int hitboxYOffset = h - hitbox.height;       // Align bottom

    // Update hitbox position relative to the player's worldX/worldY
    hitbox.x = (int)screenX + hitboxXOffset;
    hitbox.y = (int)screenY + hitboxYOffset;
}
  
  void gravityOn(){
    if (!isGrounded()) {
      inAir = true;
      speedY += gravity;
    } else {
      inAir = false;
      isDoubleJumping = false;
      extraJumps = maxJumps;
  
      if (speedY > 0) {
        speedY = 0;
      }
    }
  }
  
  
  void jump(){
      if(isGrounded()){
        speedY = -legStrength; // Jumping
      }
      else if (extraJumps > 0 && inAir){
        isDoubleJumping = true;
        speedY = -legStrength * 0.7;
        extraJumps--;
      }
  }
  
  private boolean isGrounded() {
    float nextY = worldY + hitbox.height / 1.5;  // Checking just below the player's feet 
    return !canMoveHere(worldX + speedX, nextY, hitbox.width, hitbox.height);
  }
  
  private void updatePos() {
    collisionOn = false;  // Reset collision flag
    
    // Horizontal movement
    if (!left && !right || left && right ) {
        speedX = 0;
    } else if (right) {
        speedX = startSpeed;
    } else if (left) {
        speedX = -startSpeed;
    }
    
    // Check horizontal collisions
    if (canMoveHere(worldX + speedX, worldY, hitbox.width, hitbox.height)) {
        worldX += speedX;
    } else {
        speedX = 0;  // Stop horizontal movement if blocked
    }

    // Apply gravity (vertical movement)
    gravityOn();

    // Check vertical collisions (after gravity applied)
    if (canMoveHere(worldX, worldY + speedY, hitbox.width, hitbox.height)) {
        worldY += speedY;
        grounded = false;  // The player is not on the ground if still falling
    } else {
        speedY = 0;  // Stop vertical movement if colliding
        grounded = true;  // The player is grounded if standing on a solid tile
    }

    // Check boundaries
    if (worldX < 0) {
        worldX = 0;
    }
    
    if (worldY > MAX_WORLD_HEIGHT * TILES_SIZE) {
        alive = false;
    }
    
    
    if (worldX + w > MAX_WORLD_WIDTH *TILES_SIZE) {
        worldX = MAX_WORLD_WIDTH * TILES_SIZE - w;
    }
}



  
  private void setAnimation() {
    int previousAction = playerAction;

    if (isDoubleJumping) {
        playerAction = PlayerConstants.DOUBLEJUMPING;
    } else if (speedY < 0) {
        playerAction = PlayerConstants.JUMPING;
    } else if (speedY > 0) {
        playerAction = PlayerConstants.FALLING;
    } else if (speedX != 0) {
        playerAction = PlayerConstants.RUNNING;
    } else {
        playerAction = PlayerConstants.IDLE;
    }

    // Only reset the animation index if the action has changed
    if (playerAction != previousAction) {
        aniIndex = 0;  // Reset the animation when the action changes
    }
}
  
  private void loadAnimations() {
    
   PImage img = loadImage("animations\\NinjaFrog 32x32.png");
    animations = new PImage[7][12];
    for(int j = 0; j < animations.length; ++j) {
      for(int i = 0; i < animations[j].length; ++i) {
        animations[j][i] = img.get(i *TILES_SIZE, j *TILES_SIZE,TILES_SIZE,TILES_SIZE);
      }
    }
  }
  
  
  
  
  public void handleKeyPressed() {
    switch (key) {
      case 'a':
        left = true;
        break;
      case 'd':
        right = true;
        break;
      case 'w':
      case ' ':
        if(!jumpPressed){
          jumpPressed = true;
          jump();
          break;
        }
    }
  }
  
  public void handleKeyReleased() {
    switch (key) {
      case 'a':
        left = false;
        break;
      case 'd':
        right = false;
        break;
      case 'w':
      case ' ':
        jumpPressed = false;
        break;
    }
  }
  
}
