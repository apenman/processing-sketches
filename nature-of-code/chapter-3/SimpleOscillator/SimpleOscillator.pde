class Oscillator {
    PVector angle;
    PVector velocity;
    PVector amplitude;

    Oscillator() {
        // Random oscillation in both x and y directions
        angle = new PVector();
        velocity = new PVector(random(-0.05,0.05), random(-0.05,0.05));
        amplitude = new PVector(random(width/2), random(height/2));
    }

    void oscillate() {
        angle.add(velocity);
    }

    void display() {
        float x = sin(angle.x)*amplitude.x;
        float y = sin(angle.y)*amplitude.y;

        pushMatrix();
        translate(width/2, height/2);
        stroke(0);
        fill(175);
        line(0,0,x,y);
        ellipse(x,y,16,16);
        popMatrix();
    }
}

Oscillator[] o = new Oscillator[10];

void setup() {
    size(640,360);

    for(int i = 0; i < o.length; i++) {
        o[i] = new Oscillator();
    }
}

void draw() {
    background(255);

    for(int i = 0; i < o.length; i++) {
        o[i].oscillate();
        o[i].display();
    }

}