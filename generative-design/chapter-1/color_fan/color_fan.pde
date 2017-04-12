// Uses TRIANGLE_FAN shape to build a color wheel!
float segmentCount, radius;

void setup() {
  noStroke();
  size(800, 800);
  background(0);

  segmentCount = 6;
  radius = 100;
}

void draw() {
  // Hue/Saturation/Brightness
  // Three values set the max for each
  colorMode(HSB, 360, width, height);
  background(360);

  float angleStep = 360/segmentCount;
  radius = dist(mouseX, mouseY, width/2, height/2);

  // Triangle fan starts with midpoint, then all vertices around
  beginShape(TRIANGLE_FAN);
  vertex(width/2, height/2);
  for(float angle=0; angle<=360; angle+=angleStep) {
    float vx = width/2 + cos(radians(angle))*radius;
    float vy = height/2 + sin(radians(angle))*radius;
    vertex(vx, vy);
    fill(angle, width, height);
  }

  endShape();
}

void keyReleased() {
  switch(key) {
    case '1':
      segmentCount = 360;
      break;
    case '2':
      segmentCount = 45;
      break;
    case '3':
      segmentCount = 24;
      break;
    case '4':
      segmentCount = 12;
      break;
  }
}
