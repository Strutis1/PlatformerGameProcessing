import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;


PImage terrain;
PImage[] tiles;
int scol = 0, srow = 0;
int tile = 32;
int imgW, imgH;
int row, col;
int tileNr = 0;
int ptileNr = 0;
String filePath = "C:\\Users\\vejas\\OneDrive\\Desktop\\PlatformerGameWithProcessing\\Main\\SavedMaps\\LevelOne_Terrain.csv";

int worldX = 74;//max is 74
int worldY = 30;

int[][] worldMap;

int ts = 16; // smaller size will fit more

void setup() {
    size(1200, 800);
    terrain = loadImage("Terrain/Terrain (32x32).png"); //47 - 84 blank tiles
    textSize(24);
    imgW = terrain.width;
    imgH = terrain.height;
    col = imgW / tile;
    row = imgH / tile;
    tiles = new PImage[col * row];
    img2mas(); 
    worldMap = new int[worldY][worldX];
    generateMap();
}

private void generateMap() {
    for (int j = 0; j < worldY; j++) {
        for (int i = 0; i < worldX; i++) {
            worldMap[j][i] = 47;  
        }
    }
}

void draw() {
    background(100, 100, 100);
    image(terrain, 0, 0);
    
    if (mouseX < imgW && mouseY < imgH) {
        scol = mouseX / tile;
        srow = mouseY / tile;
        tileNr = srow * col + scol;

        if (mousePressed) {
            ptileNr = tileNr; 
        }
    }

    text(scol + " - " + srow + "   " + tileNr, 700, 20);

    grid(0, 0, tile, col, row);
    grid(0, row * tile + tile, ts, worldX, worldY);

    image(tiles[ptileNr], mouseX + 5, mouseY + 5, ts, ts);

    drawMap(tile, row * tile + tile, ts, worldX, worldY);
}

public void mousePressed() {
    if (mouseX >= 0 && mouseX < 0 + worldX * ts && mouseY >= row * tile + tile && mouseY < row * tile + tile + worldY * ts) {
        worldMap[(mouseY - (row * tile + tile)) / ts][(mouseX - tile) / ts] = ptileNr;  // Place selected tile in the world map
    }
}

public void keyPressed() {
    if (key == 's') {
        saveMap();
    } else if (key == 'l') {
        loadMap();
    }
}

void img2mas() {
    for (int j = 0; j < row; j++) {
        for (int i = 0; i < col; i++) {
            tiles[j * col + i] = terrain.get(i * tile, j * tile, tile, tile);
        }
    }
}

void grid(int startposX, int startposY, int ts, int tcol, int trow) {
    noFill();
    for (int j = 0; j < trow; j++) {
        for (int i = 0; i < tcol; i++) {
            rect((i * ts) + startposX, (j * ts) + startposY, ts, ts);  
        }
    }
}

void drawMap(int startposX, int startposY, int ts, int tcol, int trow) {
    for (int j = 0; j < trow; j++) {
        for (int i = 0; i < tcol; i++) {
            image(tiles[worldMap[j][i]], (i * ts) + startposX, (j * ts) + startposY, ts, ts);
        }
    }
}

void saveMap() {
    try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath))) {
        for (int i = 0; i < worldMap.length; i++) {
            for (int j = 0; j < worldMap[i].length; j++) {
              if(isBlankTile(worldMap[i][j])){//blank tiles
                  writer.write(String.valueOf(-1));
              } else{
                writer.write(String.valueOf(worldMap[i][j])); 
              }
              
              if (j < worldMap[i].length - 1) {
                  writer.write(",");
              }
            }
            writer.write('\n');
        }
    } catch (IOException e) {
        e.printStackTrace();
    }
}


void loadMap() {
    String[] lines = loadStrings(filePath);
    if (lines != null && lines.length > 0) {
        for (int i = 0; i < worldMap.length; i++) {
            String[] values = split(lines[i], ',');
            for (int j = 0; j < worldMap[i].length; j++) {
                if(int(values[j]) == -1)
                  values[j] = "47";//first blank tile
                worldMap[i][j] = int(values[j]);
            }
        }
    } else {
        println("Failed to load the map or the map file is empty.");
    }
}

private boolean isBlankTile(int tileValue) {
    return tileValue >= 47 && tileValue <= 84;
}
