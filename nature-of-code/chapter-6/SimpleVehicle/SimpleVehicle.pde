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
        maxSpeed = 4;
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

    // Seeks a target location and calculates the difference in force needed to arrive
    void seek(PVector target) {
        PVector desired = PVector.sub(target, location);
        desired.normalize();
        desired.mult(maxSpeed);

        PVector steer = PVector.sub(desired, velocity);
        steer.limit(maxForce);
        applyForce(steer);
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


Vehicle vehicle;
float x,y,xSeekDir,ySeekDir;

void setup() {
    size(640, 640);
    vehicle = new Vehicle(width/3, height/3);
    x = width-100;
    y = 10;
    xSeekDir = 1;
    ySeekDir = 1;
}

void draw() {
    background(255);

    // Lame logic just to get some following action going
    if(y > height - 10) {
        ySeekDir = -1;
    } 
    if(y < 0) {
        ySeekDir = 1;
    }
    if(x > height - 10) {
        xSeekDir = -1;
    } 
    if(x < 0) {
        xSeekDir = 1;
    }

    y += ySeekDir * 4;
    x += xSeekDir * 5;

    vehicle.seek(new PVector(x,y));
    vehicle.update();
    vehicle.display();
    fill(0);
    fill(175);
    ellipse(x, y, 8, 8);
}