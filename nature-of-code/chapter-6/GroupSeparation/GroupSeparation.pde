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
        checkBounds();
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

    void separate(ArrayList<Vehicle> others) {
        float desiredSeparation = r*2;
        PVector sum = new PVector();
        int count = 0;

        for(Vehicle v : others) {
            float d = PVector.dist(this.location, v.location);
            if(d > 0 && d < desiredSeparation) {
                PVector diff = PVector.sub(this.location, v.location);
                diff.normalize();
                diff.div(d);
                sum.add(diff);
                count++;
            }
        }

        if(count > 0) {
            // Get average vector after summing close vehicles
            sum.div(count);
            sum.setMag(maxSpeed);
            PVector steer = PVector.sub(sum, velocity);
            steer.limit(maxForce);
            applyForce(steer);
        }
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

ArrayList<Vehicle> vehicles;

void setup() {
    size(320, 240);
    vehicles = new ArrayList<Vehicle>();
    for(int i = 0; i < 100; i++) {
        vehicles.add(new Vehicle(random(width), random(height)));
    }
}

void draw() {
    background(255);
    for(Vehicle v : vehicles) {
        v.separate(vehicles);
        v.update();
        v.display();
    }
}