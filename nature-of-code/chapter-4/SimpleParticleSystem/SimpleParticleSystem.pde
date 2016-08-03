import java.util.Iterator;

class ParticleSystem {
    ArrayList<Particle> particles;
    PVector origin;
    PVector oVelocity; // move origin

    ParticleSystem() {
        particles = new ArrayList<Particle>();
        origin = new PVector(width/2, 50);
        oVelocity = new PVector(5, 0); 
    }

    void addParticle() {
        particles.add(new Particle(origin));
    }

    void run() {
        addParticle();

        Iterator<Particle> iter = particles.iterator();
        
        while(iter.hasNext()) {
           Particle p = iter.next();
           p.run();
           if(p.isDead())
             // Creating an iterator makes removing values easy
             iter.remove();
        }

        // Move origin
        origin.add(oVelocity);
        // keep origin in x bounds
        if(origin.x > width - 25 || origin.x < 25)
            oVelocity = new PVector(-1 * oVelocity.x, 0);
    }
}

class Particle {
    PVector location;
    PVector velocity;
    PVector acceleration;
    float lifespan;

    Particle(PVector l) {
        acceleration = new PVector(0, 0.05);
        velocity = new PVector(random(-1,1),random(-2,0));
        location = l.get();
        lifespan = 255;
    }

    void run() {
        update();
        display();
    }

    void update() {
        velocity.add(acceleration);
        location.add(velocity);
        lifespan -= 2.0;
    }

    void display() {
        stroke(0, lifespan);
        fill(175, lifespan);
        ellipse(location.x,location.y,8,8);
    }

    boolean isDead() {
        return lifespan < 0.0;
    }
}

ParticleSystem ps;

void setup() {
    size(640, 640);
    ps = new ParticleSystem();
}

void draw() {
    background(255);
    ps.run();
}