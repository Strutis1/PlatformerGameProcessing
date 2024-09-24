public static class PlayerConstants{
    public static final int IDLE = 0;
    public static final int RUNNING = 1;
    public static final int JUMPING = 2;
    public static final int DOUBLEJUMPING = 3;
    public static final int HIT = 4;
    public static final int FALLING = 5;
    public static final int WALLJUMP = 6;
    
    
    
    public static int GetSpriteAmount(int playerAction) {
      switch(playerAction) {
      case RUNNING:
        return 12;
      case IDLE:
        return 11;
      case JUMPING:
      case FALLING:
        return 1;
      case DOUBLEJUMPING:
        return 6;
      case HIT:
        return 7;
      case WALLJUMP:
        return 5;//probably not gonna use
      default:
        return 1;
      }
    }
  }
