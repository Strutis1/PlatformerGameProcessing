public int GAMESCREEN = 0;


public static final float SCALE = 1f;

public final static float gravity = 0.15f * SCALE;



public final static int MAX_SCREEN_WIDTH = 26;
public final static int MAX_SCREEN_HEIGHT = 14;
public final static int MAX_WORLD_WIDTH = 74;
public final static int MAX_WORLD_HEIGHT = 30;
public final static int TILES_SIZE = (int)(32 * SCALE);

Player player;
Fruit fruit;
LevelManager levelManager;




void setup(){
  size(832, 448);
  //fullScreen();
  frameRate(120);
  initClasses();
  windowTitle("alibaba");
  if(GAMESCREEN == 1){
    player.setSpawn(352, 288);//hardcode but whatever for now
    fruit.setSpawn(2240, 352);
  }

}

void initClasses(){
  player = new Player(200, 200);
  fruit = new Fruit();
  levelManager = new LevelManager();
}


//switch game screens
void draw(){
    switch(GAMESCREEN) { 
      case 0:
        startScreen();
        break;
      case 1:
        levelOneScreen();
        break;
      case 2:
        clearedScreen();
        break;
      case 3:
        gameOverScreen();
        break;
    }
    
    
}

void startScreen() {
  background(192, 187, 178);
  textAlign(CENTER);
  fill(0, 0, 0);
  textSize(70);
  text("BAD GAME", width/2, height/2);
  textSize(15); 
  text("Click to start", width/2, height-30);
}


  
  
  

void levelOneScreen() {
    background(192, 187, 178);
    if(!player.alive)
      gameOver();
    levelManager.draw();
    player.drawHitbox();
    player.update();
    fruit.drawFruit();
    if (fruit.collected){
      levelCleared();
    }
  }
  
void clearedScreen(){
  textAlign(CENTER);
  fill(0, 0, 0);
  textSize(70);
  text("LEVEL CLEARED!", width/2, height/2);
  textSize(15); 
  text("Click continue", width/2, height-30);
}
  
void gameOverScreen() {
  background(255,0,0);
  textAlign(CENTER);
  fill(0, 0, 0);
  textSize(70);
  text("YOU DIED!", width/2, height/2);
  textSize(15); 
  text("Click to restart", width/2, height-30);
}
void levelCleared(){
  GAMESCREEN = 2;
}

void startGame() {
  GAMESCREEN = 1;
}
void gameOver() {
  GAMESCREEN = 3;
}

void restart() {
  setup();
  GAMESCREEN = 1;
}
