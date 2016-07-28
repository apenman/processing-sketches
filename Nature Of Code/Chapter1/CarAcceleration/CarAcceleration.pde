Car car;

void setup() {
	size(640, 360);
	car = new Car();
}

void draw() {
	background(255);
  car.update();
  car.checkEdges();
	car.display();
}

void keyPressed() {
	if (key == CODED) {
		if (keyCode == UP) {
			car.accelerate();
		} else if (keyCode == DOWN) {
			car.decelerate();
		}
 	}
}

class Car {
	PVector location;
	PVector velocity;
	PVector acceleration;

	Car() {
		location = new PVector(width/2, height/2);
		velocity = new PVector(0, 0);
		acceleration = new PVector(0,0);
	}

  void update() {
    velocity.add(acceleration);
    location.add(velocity);   
  }

	void accelerate() {
		acceleration.add(new PVector(0.001, 0));
	}

	void decelerate() {
		acceleration.add(new PVector(-0.001, 0));
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
	}
}