// 

// TODO: Cohesion and alignment loops are identical -- combine them

class Flock{
    ArrayList<Boid> boids;

    Flock() {
        boids = new ArrayList<Boid>();
    }

    void run() {
        for(Boid b : boids) {
            b.run(boids);
        }
    }

    void addBoid(Boid b) {
        boids.add(b);
    }
}

class Boid {
    PVector location, velocity, acceleration;
    float maxSpeed, maxForce;

    Boid(float x, float y) {
        location = new PVector(x, y);
        velocity = new PVector();
        acceleration = new PVector();

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
            if(dist > 0 && dist < neighborDist) {
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

            return steer
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
}

void setup() {
    size(640, 640);
}

void draw() {
    background(255);
}