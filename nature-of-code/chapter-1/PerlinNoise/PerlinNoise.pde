import codeanticode.syphon.*;


SyphonServer server;
float test = 0.0;

void settings() {
      size(300,300, P3D);  
      PJOGL.profile=1;
}

void setup() {
      server = new SyphonServer(this, "Processing Syphon");
}

void draw() {
  test += 0.01;
  loadPixels();
  float xoff = 0.0;
  for(int x = 0; x < width; x++) {
    float yoff = 0.0;
   for(int y = 0; y<height; y++) {
    float bright = map(noise(xoff,yoff, test),0,1,0,255); 
    pixels[x+y*width] = color(bright);
    yoff += 0.01;
   }
   
   xoff += 0.01;
  }
  updatePixels();
    server.sendScreen();

}