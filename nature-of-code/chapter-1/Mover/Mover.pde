MyMover mover;

void setup() {
	size(640, 360);
	mover = new MyMover();
}

void draw() {
	background(255);
	mover.update();
	mover.checkEdges();
	mover.display();
}

class MyMover {
	PVector location;
	PVector velocity;
	PVector acceleration;
	float topSpeed;
  
	MyMover() {
		location = new PVector(random(width), random(height));
		velocity = new PVector(random(-2,2), random(-2,2)); 
		acceleration = new PVector(-0.001, 0.01);
		topSpeed = 10;
	}


	void update() {
    //acceleration = PVector.random2D();
    //acceleration.mult(0.15);
		ve//locity.add(acceleration);
		ve//locity.limit(topSpeed);
		lo//cation.add(velocity);
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