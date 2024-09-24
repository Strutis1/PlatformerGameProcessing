class Tile {
    PImage img;
    boolean collision;
    int x, y;  

    Tile(PImage img, boolean collision, int x, int y) {
        this.img = img;
        this.collision = collision;
        this.x = x;
        this.y = y;
    }

    //public boolean intersects(float playerX, float playerY, int playerW, int playerH) {
    //    return playerX < x + TILES_SIZE && 
    //           playerX + playerW > x &&
    //           playerY < y + TILES_SIZE && 
    //           playerY + playerH > y;
    //}
}
