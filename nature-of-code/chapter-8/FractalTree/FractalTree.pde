float theta;

void setup() {
    size(640, 640);
    theta = PI/6;
}

void draw() {
    background(255);

    // Start at bottom of window in middle
    translate(width/2, height);
    stroke(0);
    branch(60);
}

void branch(float len) {
    // Move up length of branch
    line(0,0,0,-len);
    translate(0, -len);

    len *= 0.66;

    // Exit when length gets too small
    if(len > 2) {
        // Rotate clockwise
        pushMatrix();
        rotate(theta);
        // Recursively call branch
        branch(len);
        // Pop off transformation
        popMatrix();

        // Rotate counter-clockwise
        pushMatrix();
        rotate(-theta);
        // Recursively call branch
        branch(len);
        // Pop off transformation
        popMatrix();
    } 
}