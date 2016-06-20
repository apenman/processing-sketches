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
   
   if(r<0.5) {
     
   }
 }
 
 // Tendency to go down and right
 void stepLeanDownRight() {
  float stepx = random(-1, 2.5);
  // Coordinates are inverted for y's. Positive number goes down
  float stepy = random(-1, 2.5);

  x += stepx;
  y += stepy;
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
 w.stepLeanDownRight();
 w.display();
}