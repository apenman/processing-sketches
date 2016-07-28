class MyAttractor {
	float mass;
	PVector location;

	MyAttractor() {
		location = new PVector(width/2, height/2);
		mass = 20;
	}

	void display() {
		stroke(0);
		fill(175,200);
		ellipse(location.x, location.y, mass*2, mass*2);
	}

	PVector attract(MyMover m) {
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

class MyMover {
	PVector location;
	PVector velocity;
	PVector acceleration;
	float topSpeed;
  	float mass;
  
	MyMover(float m, float x, float y) {
		location = new PVector(x,y);
		velocity = new PVector(0, 0); 
		acceleration = new PVector(0, 0);
		topSpeed = 10;
    	mass = m;
	}


	void update() {
		velocity.add(acceleration);
		location.add(velocity);

		acceleration.mult(0); // clear acceleration each time
	}

	void applyForce(PVector force) {
		// Divide force by mass to get acceleration
		// Will be reusing force so make a copy to work with
		PVector f = PVector.div(force, mass);
		acceleration.add(f);
	}

	void display() {
		stroke(0);
		fill(175);
		ellipse(location.x, location.y, 16, 16);
	}

	PVector attract(MyMover m) {
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

MyMover[] movers = new MyMover[10];
MyAttractor a;
// Fake gravity constant
float G = 0.4;

void setup() {
	size(640, 360);
	for(int i = 0; i < movers.length; i++) {
		movers[i] = new MyMover(random(0.1,2), random(width), random(height));
	}
	a = new MyAttractor();
}

void draw() {
	background(255);

	// Draw a before movers so it looks like movers cross in front of a :-)
	a.display();

	for(int i = 0; i < movers.length; i++) {
		// Attract all movers to each other
		for(int j = 0; j < movers.length; j++) {
			if(i != j) {
				PVector force = movers[j].attract(movers[i]);
				movers[i].applyForce(force);
			}
		}

		// Attract mover to attractor
		PVector f = a.attract(movers[i]);
		movers[i].applyForce(f);
		movers[i].update();
		movers[i].display();
	}
}