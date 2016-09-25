// Continuosly remove middle third of line segments indefinitely
void setup() {
    size(640, 640);
    background(255);
}

void draw() {
    cantor(10, 20, width-20);
}

void cantor(float x, float y, float len) {
    if(len >= 1) {
        line(x, y, x+len, y);

        y+=20;
        cantor(x,y,len/3);
        cantor(x+len*2/3,y,len/3);
    }
}