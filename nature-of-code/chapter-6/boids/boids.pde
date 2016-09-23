// 

// TODO: Cohesion and alignment loops are identical -- combine them

class Flock{
    ArrayList<Boid> boids;

    Flock() {
        boids = new ArrayList<Boid>();
    }

    void run() {
        for(Boid b : boids) {
            b.flock(boids);
        }
    }

    void addBoid(Boid b) {
        boids.add(b);
    }
}

class Boid {
    PVector location, velocity, acceleration;
    float maxSpeed, maxForce, r;

    Boid(float x, float y) {
        location = new PVector(x, y);
        velocity = new PVector();
        acceleration = new PVector();

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

    void applyForce(PVector force) {
        acceleration.add(force);
    }

    PVector separate(ArrayList<Boid> others) {
        float desiredSeparation = 50;
        PVector sum = new PVector();
        PVector steer = new PVector();
        int count = 0;

        for(Boid b : others) {
            float d = PVector.dist(this.location, b.location);
            if(d > 0 && d < desiredSeparation) {
                PVector diff = PVector.sub(this.location, b.location);
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
            steer = PVector.sub(sum, velocity);
            steer.limit(maxForce);
        }

        return steer;
    }

    // Seeks a target location and calculates the difference in force needed to arrive
    PVector seek(PVector target) {
        PVector desired = PVector.sub(target, location);
        desired.normalize();
        desired.mult(maxSpeed);

        PVector steer = PVector.sub(desired, velocity);
        steer.limit(maxForce);
        return steer;
    }

    // Calculate the average velocity of other boids nearby 
    PVector align(ArrayList<Boid> boids) {
        // Boids can only look to the neighbors close to them
        // They do not look at the whole flock to gauge direction
        float neighborDist = 50;

        PVector sum = new PVector();
        int count = 0;
        for(Boid b : boids) {
            float dist = PVector.dist(location, b.location);

            // TODO: boids can only see other boids in peripheral vision
                    // (not circle around them)
            if(dist >= 0 && dist < neighborDist) {
                // Average all other boids' velocity within proximity to get our velocity
                sum.add(b.velocity);
                count++;
            }
        }

        if(count > 0) {
            sum.div(count);
            sum.normalize();
            sum.mult(maxSpeed);
            PVector steer = PVector.sub(sum, velocity);
            steer.setMag(maxForce);

            return steer;
        } else {
            return new PVector();
        }
    }

    // Find the average location between all neighbors and use that as a target location
    PVector cohesion(ArrayList<Boid> boids) {
        float neighborDist = 50;

        PVector sum = new PVector();
        int count = 0;
        for(Boid b : boids) {
            float dist = PVector.dist(location, b.location);

            // TODO: boids can only see other boids in peripheral vision
                    // (not circle around them)
            if(dist > 0 && dist < neighborDist) {
                // Average all other boids' velocity within proximity to get our velocity
                sum.add(b.location);
                count++;
            }
        }

        if(count > 0) {
            sum.div(count);

            return seek(sum);
        } else {
            return new PVector();
        }
    }


    void flock(ArrayList<Boid> boids) {
        PVector sep = separate(boids);   
        PVector ali = align(boids); 
        PVector coh = cohesion(boids);

        // Add the force vectors to acceleration
        applyForce(sep);
        applyForce(ali);
        applyForce(coh);
        update();
        display();
    }

    void display() {
        // Pulled from vehicle class in previous exercise
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

    void borders() {
        if (location.x < -r) location.x = width+r;
        if (location.y < -r) location.y = height+r;
        if (location.x > width+r) location.x = -r;
        if (location.y > height+r) location.y = -r;
      }
    
}

Flock flock;

void setup() {
    size(640, 640);
    flock = new Flock();
    for(int i = 0; i < 50; i++) {
        flock.addBoid(new Boid(random(width), random(height)));
    }
}

void draw() {
    background(255);
    flock.run();
}