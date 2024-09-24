public void mousePressed() {
  if (GAMESCREEN == 0) { 
    startGame();
  }
  if (GAMESCREEN == 2) {
    restart();
  }
}

public void keyPressed(){
    if (GAMESCREEN == 1) {
        player.handleKeyPressed();
    }
    if(key == 'r'){
      restart();
    }
  }
  
  public void keyReleased() {
    if (GAMESCREEN == 1){
      player.handleKeyReleased();
    }
  }
