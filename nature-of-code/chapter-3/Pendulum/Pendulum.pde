class MyPendulum {
    PVector location;
    PVector origin;

    float r; // rod length
    float angle; // current angle of pendulum
    float aVelocity; // angle velocity
    float aAcceleration; // angle acceleration
    float damping; // arbitrary damping value to simulate real life kinda

    MyPendulum(PVector origin, float r) {
        this.r  = r;
        this.origin = origin.copy(); // get copy of PVector

        location = new PVector();
        angle = PI/4;
        aVelocity = 0.0;
        aAcceleration = 0.0;
        damping = 0.95;
    }

    void go() {
        update();
        display();
    }

    void update() {
        float g = 0.4; // arbitrary gravity constant

        aAcceleration = (-1 * g / r) * sin(angle);
        aVelocity += aAcceleration;
        angle += aVelocity;
    }

    void display() {
        location.set(r * sin(angle), r * cos(angle), 0); // get where ball should be based on angle (to cartesian converstion);
        location.add(origin); // add origin offset

        stroke(0);
        line(origin.x, origin.y, location.x, location.y);
        ellipse(location.x, location.y, 16,16);
    }
}

MyPendulum p;

void setup() {
    size(640,360);
    p = new MyPendulum(new PVector(width/2, 10), 250);
}

void draw() {
    background(255);
    p.go();
}