class Fruit{//level clear requirement
  PImage idle;
  PImage[] idleFrames;
  int idleFCount = 17;
  Boolean collected;
  PImage poof;
  PImage[] poofFrames;
  int poofCounter;
  int poofFCount = 6;
  int idleCount = 17;//different fruit sprites
  int w = 50,h = 50;
  float x = 0,y = 0;
  int animationSpeed = 5;
  
  
  Fruit(){
    collected = false;
    idle = loadImage("Fruits/Melon.png");
    poof = loadImage("Fruits/Collected.png");
    idleFrames = new PImage[idleFCount];
    poofFrames = new PImage[poofFCount];
    
    for (int i = 0; i < idleFrames.length; i++) {
      idleFrames[i] = idle.get(i *TILES_SIZE, 0,TILES_SIZE,TILES_SIZE);
    }
    for (int i = 0; i < poofFrames.length; i++) {
      poofFrames[i] = poof.get(i *TILES_SIZE, 0,TILES_SIZE,TILES_SIZE);
    }
  }
  
  void check() {
    if (player.worldX < x + w && 
        player.worldX + player.hitbox.width > x && 
        player.worldY < y + h && 
        player.worldY + player.hitbox.height > y) {
      collected = true;
    }
  }
  
  void drawFruit() {
    check();  // Collision logic remains the same

    // Use player's screenX and screenY variables for fruit drawing
    if (!collected) {
        image(idleFrames[(frameCount / animationSpeed) % idleFCount], x + player.screenX, y + player.screenY, w, h);
    } else if (collected && poofCounter < poofFCount) {
        image(poofFrames[poofCounter], x + player.screenX, y + player.screenY, w, h);
        if (frameCount % animationSpeed == 0) {
            poofCounter++;
        }
    }
}

  
  public void setSpawn(int x, int y){
    this.x = x;
    this.y = y;
  }
  
}


    
      
