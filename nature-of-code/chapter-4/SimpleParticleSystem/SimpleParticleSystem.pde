import java.util.Iterator;

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

ArrayList<Particle> plist;

void setup() {
    size(640, 640);
    plist = new ArrayList<Particle>();
}

void draw() {
    background(255);
    
    plist.add(new Particle(new PVector(width/2, 50)));
    
    Iterator<Particle> iter = plist.iterator();
    
    while(iter.hasNext()) {
       Particle p = iter.next();
       p.run();
       if(p.isDead())
         // Creating an iterator makes removing values easy
         iter.remove();
    }
}