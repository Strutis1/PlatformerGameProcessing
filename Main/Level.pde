class Level {
    private Tile[][] terrain;      
    private Tile[][] background; 

    Level(Tile[][] terrain, Tile[][] background) {
        this.terrain = terrain;
        this.background = background;
    }
  

    public void drawBackground(int TILES_SIZE) {
        for (int row = 0; row < background.length; row++) {
            for (int col = 0; col < background[row].length; col++) {
                Tile tile = background[row][col];
                if (tile != null && tile.img != null) {
                    image(tile.img, col * TILES_SIZE, row * TILES_SIZE);
                }
            }
        }
    }

    public void drawTerrain(int TILES_SIZE) {
        for (int row = 0; row < terrain.length; row++) {
            for (int col = 0; col < terrain[row].length; col++) {
                Tile tile = terrain[row][col];
                if (tile != null && tile.img != null) {
                    // Use player's screenX and screenY variables
                    image(tile.img, col * TILES_SIZE + player.screenX, row * TILES_SIZE + player.screenY, TILES_SIZE, TILES_SIZE);
                }
            }
        }
    }


    // Check for collision at a given tile position
    public boolean checkCollision(int row, int col) {
        Tile tile = terrain[row][col];
        return tile != null && tile.collision;  // Return true if the tile has collision
    }
    
    
}
