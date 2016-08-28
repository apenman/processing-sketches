/*
* TODO: Cleanup for easy toggle between types of movement
*/

class Vehicle {
    PVector location, velocity, acceleration;
    float r;
    float maxSpeed; // maximum speed of vehicle
    float maxForce; // limits the turning power of vehicle

    Vehicle(float x, float y) {
        location = new PVector(x,y);
        velocity = new PVector(0,0);
        acceleration = new PVector(0,0);

        r = 3;
        maxSpeed = 2;
        maxForce = 0.1;
    }

    void update() {
        velocity.add(acceleration);
        velocity.limit(maxSpeed);
        location.add(velocity);
        acceleration.mult(0);
    }

    void applyForce(PVector f) {
        acceleration.add(f);
    }

    void checkBounds() {
        if(location.x < 0)
            location.x = width;
        if(location.x > width)
            location.x = 0;
        if(location.y < 0)
            location.y = height;
        if(location.y > height)
            location.y = 0;
    }

    // Seeks a target location and calculates the difference in force needed to arrive
    void seek(PVector target) {
        PVector desired = PVector.sub(target, location);
        desired.normalize();
        desired.mult(maxSpeed);

        PVector steer = PVector.sub(desired, velocity);
        steer.limit(maxForce);
        applyForce(steer);
    }

    void arrive(PVector target) {
        PVector desired = PVector.sub(target, location);
        float d = desired.mag(); // Get distance from location to target
        desired.normalize();
        // Check if we are within a set radius of our target
        if(d < 75) {
            // If we are, slow down
            float m = map(d, 0, 100, 0, maxSpeed);
            desired.mult(m);
        }
        else {
            // We aren't, full speed!
            desired.mult(maxSpeed);
        }

        PVector steer = PVector.sub(desired, velocity);
        steer.limit(maxForce);
        applyForce(steer);
    }

    void flow(FlowField field) {
        PVector desired = field.lookup(location);
        desired.mult(maxSpeed);

        PVector steer = PVector.sub(desired, velocity);
        steer.limit(maxForce);
        applyForce(steer); 
        checkBounds();
    }

    void display() {
      float theta = velocity.heading() + PI/2; // Vehicle is a triangle, rotate it 90 degrees to face right way  
      fill(175);
      stroke(0);
      pushMatrix();
      translate(location.x,location.y);
      rotate(theta);
      beginShape();
      vertex(0, -r*2);
      vertex(-r, r*2);
      vertex(r, r*2);
      endShape(CLOSE);
      popMatrix();
    }
}

class FlowField {
    PVector[][] field;
    int cols, rows, resolution;

    FlowField(int r) {
        resolution = r;
        cols = width / resolution;
        rows = height / resolution;
        field = new PVector[cols][rows];
        init();
    }

    void init() {
        float xoff = 0;
        for(int i = 0; i < cols; i++) {
            float yoff = 0;
            for(int j = 0; j < rows; j++) {
                float theta = map(noise(xoff, yoff), 0, 1, 0, TWO_PI); // use perlin noise to generate angle
                field[i][j] = new PVector(cos(theta), sin(theta)); // Polar to Cartesian for PVector
                yoff += 0.1;
            }
            xoff += 0.1;
        }
    }

    void update() {
        float xoff = 0;
        for(int i = 0; i < cols; i++) {
            float yoff = 0;
            for(int j = 0; j < rows; j++) {
                float theta = map(noise(xoff, yoff, z), 0, 1, 0, TWO_PI); // use perlin noise to generate angle
                field[i][j] = new PVector(cos(theta), sin(theta)); // Polar to Cartesian for PVector
                yoff += 0.1;
            }
            xoff += 0.1;
        }
    }

    PVector lookup(PVector location) {
        int column = int(constrain(location.x/resolution, 0, cols-1)); // constrain these just to make sure they are valid field location
        int row = int(constrain(location.y/resolution, 0, rows-1));

        return field[column][row].get(); // return copy of PVector at location
    }


    /****** NOT MY CODE; TAKEN FROM EXAMPLES FOR EASY RENDERING ****/
    // Draw every vector
    void display() {
        for (int i = 0; i < cols; i++) {
            for (int j = 0; j < rows; j++) {
                drawVector(field[i][j],i*resolution,j*resolution,resolution-2);
            }
        }
    }

    // Renders a vector object 'v' as an arrow and a location 'x,y'
    void drawVector(PVector v, float x, float y, float scayl) {
        pushMatrix();
        float arrowsize = 4;
        // Translate to location to render vector
        translate(x,y);
        stroke(0,100);
        // Call vector heading function to get direction (note that pointing up is a heading of 0) and rotate
        rotate(v.heading2D());
        // Calculate length of vector & scale it to be bigger or smaller if necessary
        float len = v.mag()*scayl;
        // Draw three lines to make an arrow (draw pointing up since we've rotate to the proper direction)
        line(0,0,len,0);
        //line(len,0,len-arrowsize,+arrowsize/2);
        //line(len,0,len-arrowsize,-arrowsize/2);
        popMatrix();
    }
    /***************************************************************/
}


Vehicle[] vehicles;
float x,y,xSeekDir,ySeekDir;
FlowField field;
// For moving flow field
float trigger,z;

void setup() {
    size(400, 400);
    vehicles = new Vehicle[25];
    for(int i = 0; i < vehicles.length; i++) {
        vehicles[i] = new Vehicle(random(width), random(height));
    }
    x = width-100;
    y = 10;
    xSeekDir = 1;
    ySeekDir = 1;
    field = new FlowField(10);
    trigger = 1000;
    z = 0;
}

void draw() {
    background(255);
    field.display();

    // Changing field with trigger
    // TODO: Clean logic
    if(millis() > trigger) {
        z += 0.1;
        field.update();
        trigger = millis() + 1000;
    }

    /******** CODE FOR ARRIVING/SEEKING FUNCTION **************/
    // Lame logic just to get some following action going
    // if(y > height - 10) {
    //     ySeekDir = -1;
    // } 
    // if(y < 0) {
    //     ySeekDir = 1;
    // }
    // if(x > height - 10) {
    //     xSeekDir = -1;
    // } 
    // if(x < 0) {
    //     xSeekDir = 1;
    // }

    // y += ySeekDir * 2;
    // x += xSeekDir * 3;

    // stroke(0);
    // fill(175);
    // ellipse(x, y, 8, 8);

    for(int i = 0; i < vehicles.length; i++) {
         //vehicle.arrive(new PVector(x,y));
        //vehicle.seek(new PVector(x,y));
        vehicles[i].flow(field);

        vehicles[i].update();
        vehicles[i].display();
    }

}