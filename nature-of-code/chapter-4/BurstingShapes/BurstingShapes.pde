import java.util.Iterator;

class ParticleSystem {
    ArrayList<Particle> particles;
    PVector origin;
    PVector oVelocity; // move origin

    ParticleSystem(PVector origin) {
        particles = new ArrayList<Particle>();
        this.origin = origin;
        oVelocity = new PVector(1, 0); 
    }

    void addParticle() {
        particles.add(new Particle(origin));
    }

    void run() {
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

ArrayList<ParticleSystem> systems;

void setup() {
    size(640, 640);
    systems = new ArrayList<ParticleSystem>();
}

void mousePressed() {
    systems.add(new ParticleSystem(new PVector(mouseX, mouseY)));
}

void draw() {
    background(255);

    for(ParticleSystem ps : systems) {
        ps.run();
        ps.addParticle();
    }
}