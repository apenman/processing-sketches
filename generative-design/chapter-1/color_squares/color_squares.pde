void setup() {
  size(720, 720);
  noCursor();
}

void draw() {
  // Hue values are from 0 to 360
  colorMode(HSB, 360, 100, 100);
  rectMode(CENTER);
  noStroke();
  // Set colors based on MouseY
  background(mouseY/2, 100, 100);
  fill(360-mouseY/2, 100, 100);
  // Draw rectagle in middle based on mouse X
  rect(360, 360, mouseX+1, mouseX+1);
}