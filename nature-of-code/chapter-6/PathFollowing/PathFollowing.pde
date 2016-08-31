// Doesn't handle sharp angles well
class Vehicle {
    PVector location, velocity, acceleration;
    float r;
    float maxSpeed; // maximum speed of vehicle
    float maxForce; // limits the turning power of vehicle

    Vehicle(float x, float y) {
        location = new PVector(x,y);
        velocity = new PVector(0,0);
        acceleration = new PVector(0,0);

        r = 3;
        maxSpeed = 2;
        maxForce = 0.1;
    }

    void update() {
        velocity.add(acceleration);
        velocity.limit(maxSpeed);
        location.add(velocity);
        acceleration.mult(0);
    }

    void applyForce(PVector f) {
        acceleration.add(f);
    }

    void checkBounds() {
        if(location.x < 0)
            location.x = width;
        if(location.x > width)
            location.x = 0;
        if(location.y < 0)
            location.y = height;
        if(location.y > height)
            location.y = 0;
    }

    // Seeks a target location and calculates the difference in force needed to arrive
    void seek(PVector target) {
        PVector desired = PVector.sub(target, location);
        desired.normalize();
        desired.mult(maxSpeed);

        PVector steer = PVector.sub(desired, velocity);
        steer.limit(maxForce);
        applyForce(steer);
    }

    void follow(Path p) {
        PVector target = new PVector(0,0);
        float closestNormal = 100000000;
        PVector predict = velocity.get();
        predict.normalize();
        predict.mult(25); // arbitrarily pick 25 pixels ahead
        PVector predictLoc = PVector.add(location, predict);

        for (int i = 0; i < p.points.size()-1; i++) {
            PVector a = p.points.get(i);
            PVector b = p.points.get(i+1);
            PVector normalPoint = getNormalPoint(predictLoc, a, b);
            // Check if normal point is on our path
            if (normalPoint.x < a.x || normalPoint.x > b.x) {
                normalPoint = b.get(); // use endpoint if we cant find normal on path
            }

            float distance = PVector.dist(normalPoint, predictLoc);
            if(distance < closestNormal) {
                closestNormal = distance;
                target = normalPoint.get();
            }
        }

        // Quick check for now; fix it
        if(target.x != 0 && target.y != 0)
            seek(target);
    }

    PVector getNormalPoint(PVector p, PVector a, PVector b) {
        PVector ap = PVector.sub(p, a);
        PVector ab = PVector.sub(b, a);
        ab.normalize();
        ab.mult(ap.dot(ab));

        return PVector.add(a, ab);
    }

    void display() {
      float theta = velocity.heading() + PI/2; // Vehicle is a triangle, rotate it 90 degrees to face right way  
      fill(175);
      stroke(0);
      pushMatrix();
      translate(location.x,location.y);
      rotate(theta);
      beginShape();
      vertex(0, -r*2);
      vertex(-r, r*2);
      vertex(r, r*2);
      endShape(CLOSE);
      popMatrix();
    }
}

class Path {
    ArrayList<PVector> points;
    float radius; // How wide the path is; vehicle will stay in radius

    Path() {
        radius = 20;
        points = new ArrayList<PVector>();
    }

    void addPoint(float x, float y) {
        points.add(new PVector(x, y));
    }

    void display() {
        stroke(0);
        noFill();

        beginShape();
        for (PVector v : points) {
            vertex(v.x,v.y);
        }
        endShape();
    }
}

Vehicle v;
Path p;

void setup() {
    size(640, 640);
    p = new Path();
    for(int i = 0; i < 5; i++) {
        p.addPoint(width/5*i, random(250));
    }
    v = new Vehicle(10,0);
}

void draw() {
    background(255);

    p.display();
    v.update();
    v.follow(p);
    v.display();
}