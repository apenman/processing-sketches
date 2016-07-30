void setup() {
  size(640,360);
}

void draw() {
  background(255);
  
  float period = 120; // frames
  float amplitude = 200; // pixels
  float x = amplitude * cos(TWO_PI * frameCount / period); // amp * point on sine wave at given time (frame)
  
  stroke(0);
  fill(175);
  translate(width/2,height/2);
  line(0,0,x,0);
  ellipse(x,0,20,20);
}