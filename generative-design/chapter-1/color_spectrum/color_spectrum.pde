int stepX,stepY;

void setup() {
  noStroke();
  size(800, 400);
  background(0);
}

void draw() {
  // Hue/Saturation/Brightness
  // Three values set the max for each
  colorMode(HSB, width, height, 100);

  stepX = mouseX+2;
  stepY = mouseY+2;

  for(int gridY = 0; gridY < height; gridY+=stepY) {
    for(int gridX = 0; gridX < width; gridX+=stepX) {
      fill(gridX, height-gridY, 100);
      rect(gridX, gridY, stepX, stepY);
    }
  }
}
