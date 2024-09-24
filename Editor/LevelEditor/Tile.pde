class Tile {
    PImage img;
    boolean collision = false;  // Default to no collision

    Tile(PImage img, boolean collision) {
        this.img = img;
        this.collision = collision;
    }
}
