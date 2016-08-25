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
        float r = random(1);

        if(r > 0.5)
            particles.add(new Particle(origin));
        else 
            particles.add(new Confetti(origin));
    }

    void applyForce(PVector force) {
        for(Particle p : particles) {
            p.applyForce(force);
        }
    }

    void run() {
        Iterator<Particle> iter = particles.iterator();
        
        while(iter.hasNext()) {
           Particle p = iter.next();
           p.run();
           if(p.isDead())
             // Creating an iterator makes removing values easy
             // iterators have the remove logic built in already
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
    float mass = 1;

    Particle(PVector l) {
        acceleration = new PVector(0, 0);
        velocity = new PVector(random(-1,1),random(-2,0));
        location = l.get();
        lifespan = 255;

        // Now that we added gravity in applyForce, clear acc
        acceleration.mult(0);
    }

    void applyForce(PVector force) {
        PVector f = force.get();
        f.div(mass);
        acceleration.add(f);
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

class Confetti extends Particle {
    Confetti(PVector l) {
        super(l);
    }

    void display() {
        float theta = map(location.x, 0, width, 0, TWO_PI*2);

        rectMode(CENTER);
        fill(0, lifespan);
        stroke(0, lifespan);

        pushMatrix();
        translate(location.x, location.y);
        rotate(theta);
        rect(0, 0, 8, 8);
        popMatrix();
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
        ps.applyForce(new PVector(0, 0.01));
        ps.addParticle();
        ps.run();
    }
}