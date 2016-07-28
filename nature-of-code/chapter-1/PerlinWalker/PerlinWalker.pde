float t = 0;
Walker w;

class Walker {
 float x,y;
 float tx,ty;
 
 Walker() {
  // Time variables to keep track of x and y
  // noise() is deterministic and will return same values twice for a specified time
  // Setting ty to 10000 just spaces them out so they act independently
  tx = 0; 
  ty = 10000;
 }
 
 void step() {
  x = map(noise(tx), 0,1,0,width);
  y = map(noise(ty), 0,1,0,height);
  
  tx += 0.02;
  ty += 0.02;
 }
 
 void render() {
   ellipse(x,y,16,16);
 }
}

void setup() {
  size(640,360);
  background(255);
  w = new Walker();
}


void draw() {
 w.step();
 w.render();
}