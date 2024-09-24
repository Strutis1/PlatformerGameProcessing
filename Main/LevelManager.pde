public class LevelManager {
    private PImage[] levelSprite;
    private Tile[][] mapTileTerrain;
    private Tile[][] mapTileBackground;
    private Level currentLevel; 
    private int currentLevelIndex;
    
    private  String[] LEVEL_BACKGROUND_PATHS = {
        sketchPath("SavedMaps\\LevelOne_BackGround.csv")
    };
    
    private String[] LEVEL_TERRAIN_PATHS = {
        sketchPath("SavedMaps\\LevelOne_Terrain.csv")
    };
    
    public LevelManager() {
        this.currentLevelIndex = 0;
        importLevelSprites();
        loadLevelTilesFromCsv(currentLevelIndex);
        //loadLevelBackgroundFromCsv(currentLevelIndex);
         currentLevel = new Level(mapTileTerrain, mapTileBackground);
    }

    private void importLevelSprites() {
        LoadSave loadSave = new LoadSave();
        PImage img = loadSave.GetSprites(LoadSave.LevelAtlas);
        levelSprite = new PImage[85];//terrain 2d size
        for (int j = 0; j < 5; ++j) {
            for (int i = 0; i < 17; ++i) {
                int index = j * 17 + i;
                levelSprite[index] = img.get(i * TILES_SIZE, j * TILES_SIZE, TILES_SIZE, TILES_SIZE);
            }
        }
    }
    
    public void loadLevel(int level) {
        loadLevelTilesFromCsv(level);
        loadLevelBackgroundFromCsv(level);
        currentLevel = new Level(mapTileTerrain, mapTileBackground);
    }
    
    
    public void draw() {
        if (currentLevel != null) {
            //currentLevel.drawBackground(TILES_SIZE);  
            currentLevel.drawTerrain(TILES_SIZE); 
        }
    }
    
    private void loadLevelTilesFromCsv(int level) {
    String[] lines = loadStrings(LEVEL_TERRAIN_PATHS[level]);
    mapTileTerrain = new Tile[lines.length][];  // Initialize the terrain array
    
      for (int row = 0; row < lines.length; row++) {
          String[] values = split(lines[row], ',');  // Split each line into tile indices
          mapTileTerrain[row] = new Tile[values.length];  // Initialize each row of tiles
          
          for (int col = 0; col < values.length; col++) {
              int tileIndex = int(values[col]);  // Parse the tile index
              
              if (tileIndex != -1) {
                  // If the tileIndex is not blank on terrain, create a new Tile with collision enabled
                  boolean collision = true;
                  mapTileTerrain[row][col] = new Tile(levelSprite[tileIndex], collision, col * TILES_SIZE, row *TILES_SIZE);
              } else {
                  // If the tileIndex is -1 tile is blank so we create an empty file with no collison
                  mapTileTerrain[row][col] = new Tile(null, false, col * TILES_SIZE, row *TILES_SIZE);
              }
          }
      }
  }

    
    private void loadLevelBackgroundFromCsv(int level) {
        String[] lines = loadStrings(LEVEL_BACKGROUND_PATHS[level]);
        mapTileBackground = new Tile[lines.length][];
        for (int row = 0; row < lines.length; row++) {
            String[] values = split(lines[row], ',');
            mapTileBackground[row] = new Tile[values.length];
            for (int col = 0; col < values.length; col++) {
                int tileIndex = int(values[col]);
                if (tileIndex != -1) {
                    mapTileBackground[row][col] = new Tile(levelSprite[tileIndex], false, row * 16, col * 16);
                }
            }
        }
    }
    
    public Level getCurrentLevel(){
      return currentLevel;
    }
    
    public void setCurrentLevel(int index){
      currentLevelIndex = index;
    }
    
    //public void update() {
    //}
}
