void setup() {
    size(640, 360);

}

void draw() {
    background(255);
    drawSquare(width/2,height/2,200);
    //drawCircle(width/2,height/2,200);
}

void drawCircle(float x, float y, float radius) {
    stroke(0);
    noFill();

    ellipse(x, y, radius, radius);

    if(radius > 8) {
        // For every circle, draw a smaller circle to the left and right
        drawCircle(x + radius/2, y, radius/2);
        drawCircle(x - radius/2, y, radius/2);
        // For every circle, draw a smaller circle above and below
        drawCircle(x, y + radius/2, radius/2);
        drawCircle(x, y - radius/2, radius/2);
    }
}

void drawSquare(float x, float y, float radius) {
    stroke(0);
    noFill();

    rect(x, y, radius, radius);

    if(radius > 8) {
        // For every circle, draw a smaller circle to the left and right
        drawSquare(x + radius/2, y, radius/2);
        drawSquare(x - radius/2, y, radius/2);
        // For every circle, draw a smaller circle above and below
        drawSquare(x, y + radius/2, radius/2);
        drawSquare(x, y - radius/2, radius/2);
    }
}