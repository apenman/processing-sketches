// Sample project with Polar to Cartesian conversion
// Circle travels center using Polar coordinates

float r = 75;
float theta = 0;

void setup() {
  size(640,360);
}

void draw() {
  background(255);
  
  // Convert theta to x and y coordinates
  float x = r * cos(theta);
  float y = r * sin(theta);
  
  noStroke();
  fill(0);
  
  ellipse(x+width/2, y+height/2, 16, 16);
  
  theta += 0.01;
}