import java.util.Random;

class Walker {
 int x;
 int y;
 
 Walker() {
   x = width/2;
   y = height/2;
 }
 
 void display() {
  stroke(0);
  point(x,y);
 }

 // 50% chance of moving towards mouse
 void stepLeanMouse() {
   float r = random(1);
 }
 
 // Tendency to go down and right
 void stepLeanDownRight() {
  float stepx = random(-1, 2.5);
  // Coordinates are inverted for y's. Positive number goes down
  float stepy = random(-1, 2.5);

  x += stepx;
  y += stepy;
 }
 
 void stepNormalDistribution() {
  float stepx = random(-1, 1);
  float stepy = random(-1, 1);
   
  Random generator = new Random();
  float num = (float) generator.nextGaussian();
  float sd = 1;
  float mean = 2;
  float stepSize = sd * num + mean;
  
 
  x += stepx * stepSize;
  y += stepy * stepSize;
 }
 
 // Pseudo-random steps
 void step() {
  float stepx = random(-1, 1);
  float stepy = random(-1, 1);
  
  x += stepx;
  y += stepy;
  }
}

Walker w;

void setup() {
  size(640,360);
  background(255);
  w = new Walker();
}

void draw() {
 w.step();
 w.display();
}