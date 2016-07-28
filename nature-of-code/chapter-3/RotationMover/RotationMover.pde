class Mover {
	PVector location;
	PVector velocity;
	PVector acceleration;
	float mass;

	float angle = 0;
	float aVelocity = 0;
	float aAcceleration = 0.001;
	float G = 0.4;

	Mover(float m, float x, float y) {
		mass = m;
		location = new PVector(x, y);
		velocity = new PVector(0, 0);
		acceleration = new PVector(0, 0);
	}

	void update() {
		velocity.add(acceleration);
		location.add(velocity);

		aVelocity += aAcceleration;
		angle += aVelocity;

		acceleration.mult(0);
	}

	void display() {
		stroke(0);
		fill(175,200);
		rectMode(CENTER);

		// Use push/pop matrix so rotation does not affect the rest of the world
		pushMatrix();
		translate(location.x, location.y);
		rotate(angle);
		rect(0,0,mass*16,mass*16);
		popMatrix();
	}

	void applyForce(PVector force) {
		// Divide force by mass to get acceleration
		// Will be reusing force so make a copy to work with
		PVector f = PVector.div(force, mass);
		acceleration.add(f);
	}

	PVector attract(Mover m) {
		PVector force = PVector.sub(location, m.location);
		float distance = force.mag();

		// Based on pixels
		// Don't want distance to be too high or too low to throw off force
		distance = constrain(distance,5,25);
		
		force.normalize();

		float strength = (G * mass * m.mass) / (distance * distance);
		force.mult(strength);

		return force;
	}
}


Mover[] movers = new Mover[10];

void setup() {
	size(640,360);
	for(int i = 0; i < movers.length; i++) {
		movers[i] = new Mover(random(0.1,2), random(width), random(height));
	}
}

void draw() {
	background(255);

	for(int i = 0; i < movers.length; i++) {
		// Attract all movers to each other
		for(int j = 0; j < movers.length; j++) {
			if(i != j) {
				PVector force = movers[j].attract(movers[i]);
				movers[i].applyForce(force);
			}
		}
		
		movers[i].update();
		movers[i].display();
	}
}