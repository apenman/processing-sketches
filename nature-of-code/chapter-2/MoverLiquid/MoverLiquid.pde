MyMover[] movers = new MyMover[3];
Liquid liquid;

void setup() {
    size(640, 360);
    for(int i = 0; i < movers.length; i++) {
        movers[i] = new MyMover(random(0.1,5), 0, 0);
    }   

    liquid = new Liquid(width/4, height/2, width, height/2, 0.1);
}

void draw() {
    background(255);
    liquid.display();

    PVector wind = new PVector(0.01, 0);

    for(int i = 0; i < movers.length; i++) {
        if(movers[i].isInsideLiquid(liquid)) {
            movers[i].drag(liquid);
        }

        // In real life gravity scales with mass
        float m = movers[i].mass;
        PVector gravity = new PVector(0, 0.1*m);

        movers[i].applyForce(wind);
        movers[i].applyForce(gravity);

        movers[i].update();
        movers[i].display();
        movers[i].checkEdges();
    }
}

class MyMover {
    PVector location;
    PVector velocity;
    PVector acceleration;
    float mass;
  
    MyMover(float m, float x, float y) {
        mass = m;
        location = new PVector(x, y);
        velocity = new PVector(0, 0); 
        acceleration = new PVector(0, 0);
    }

    void applyForce(PVector force) {
        // Divide force by mass to get acceleration
        // Will be reusing force so make a copy to work with
        PVector f = PVector.div(force, mass);
        acceleration.add(f);
    }

    void drag(Liquid l) {
        float speed = velocity.mag();
        float dragMagnitude = l.c * speed * speed;

        PVector drag = velocity.get();
        drag.mult(-1);
        drag.normalize();
        drag.mult(dragMagnitude);

        applyForce(drag);
    }

    boolean isInsideLiquid(Liquid l) {
        if(location.x>l.x && location.x<l.x+l.w && location.y>l.y && location.y< l.y+l.h)
            // It's in the liquid!!
            return true;
        else 
            return false;
    }

    void update() {
        velocity.add(acceleration);
        location.add(velocity);
        acceleration.mult(0); // clear acceleration each time
    }

    void display() {
        stroke(0);
        fill(175);
        ellipse(location.x, location.y, mass*16, mass*16);
    }

    void checkEdges() {
        if(location.x > width) {
            location.x = width - mass;
        }
        
        if(location.y > height) {
            velocity.y *= -1;
            location.y = height;
        }
    }
}