MyMover[] movers = new MyMover[3];

void setup() {
	size(640, 360);
	for(int i = 0; i < movers.length; i++) {
		movers[i] = new MyMover(random(0.1,5), 0, 0);
	}	
}

void draw() {
	background(255);
	PVector wind = new PVector(0.01, 0);
	PVector gravity = new PVector(0, 0.1);

	for(int i = 0; i < movers.length; i++) {
		movers[i].applyForce(wind);
		movers[i].applyForce(gravity);

		movers[i].update();
		movers[i].display();
		movers[i].checkEdges();
	}
}

class MyMover {
	PVector location;
	PVector velocity;
	PVector acceleration;
	float mass;
  
	MyMover(float m, float x, float y) {
		mass = m;
		location = new PVector(x, y);
		velocity = new PVector(0, 0); 
		acceleration = new PVector(0, 0);
	}

	void applyForce(PVector force) {
		// Divide force by mass to get acceleration
		// Will be reusing force so make a copy to work with
		PVector f = PVector.div(force, mass);
		acceleration.add(f);
	}


	void update() {
		velocity.add(acceleration);
		location.add(velocity);

		acceleration.mult(0); // clear acceleration each time
	}

	void display() {
		stroke(0);
		fill(175);
		ellipse(location.x, location.y, mass*16, mass*16);
	}

	void checkEdges() {
		if(location.x > width) {
			location.x = 0;
		} else if (location.x < 0) {
			location.x = width;
		}

		if(location.y > height) {
			velocity.y *= -1;
			location.y = height;
		}
	}
}