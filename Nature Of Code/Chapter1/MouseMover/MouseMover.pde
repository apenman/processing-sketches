Mover[] movers = new Mover[10];


void setup() {
	size(640,640);
	for(int i = 0; i < movers.length; i++) {
    movers[i] = new Mover();
  }
}

void draw() {
	background(255);
  for(int i = 0; i < movers.length; i++) {
    movers[i].update();
    movers[i].checkEdges();
    movers[i].display();
  }
}


class Mover {
	PVector location;
	PVector velocity;
	PVector acceleration;
	float topSpeed;

	Mover() {
		location = new PVector(random(width), random(height));
		velocity = new PVector(0, 0);
		topSpeed = 10;
	}

	void update() {
		PVector mouse = new PVector(mouseX, mouseY);
		PVector dir = PVector.sub(mouse, location);

		dir.normalize();
		dir.mult(0.5);

		acceleration = dir;

		velocity.add(acceleration);
		velocity.limit(topSpeed);
		location.add(velocity);
	}

	void display() {
		stroke(0);
		fill(175);
		ellipse(location.x, location.y, 16, 16);
	}

	void checkEdges() {
		if(location.x > width) {
			location.x = 0;
		} else if (location.x < 0) {
			location.x = width;
		}

		if(location.y > height) {
			location.y = 0;
		} else if (location.y < 0) {
			location.y = height;
		}
	}
}