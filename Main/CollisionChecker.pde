public boolean canMoveHere(float nextX, float nextY, int playerW, int playerH) {
    // Determine the range of tiles to check based on player's next position and size
    int leftTile = (int)(nextX /TILES_SIZE);
    int rightTile = (int)((nextX + playerW) /TILES_SIZE);
    int topTile = (int)(nextY /TILES_SIZE);
    int bottomTile = (int)((nextY + playerH) /TILES_SIZE);

    // Loop through only the relevant tiles near the player's position
    for (int row = topTile; row <= bottomTile; row++) {
        for (int col = leftTile; col <= rightTile; col++) {
            // Ensure that the row and column indices are within the map bounds
            if (row >= 0 && row < levelManager.getCurrentLevel().terrain.length &&
                col >= 0 && col < levelManager.getCurrentLevel().terrain[row].length) {

                // Check if the tile at this position has a collision
                if (levelManager.getCurrentLevel().checkCollision(row, col)) {
                    return false;  // A collision is detected
                }
            }
        }
    }

    return true;  // No collisions detected, player can move
}
