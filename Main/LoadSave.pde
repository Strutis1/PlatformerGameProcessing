
class LoadSave {
  public static final String PlayerSprites = "Animations\\NinjaFrog 32x32.png";
  public static final String LevelAtlas = "LevelResources\\Terrain (32x32).png";
  
 
  public PImage GetSprites(String fileName) {
    PImage img = null;
    try {
      // In Processing, you can directly load images using loadImage()
      img = loadImage(fileName);
      if (img == null) {
        println("Error loading image: " + fileName);
      }
    } catch (Exception e) {
      e.printStackTrace();
    }
    return img;
  }
}
