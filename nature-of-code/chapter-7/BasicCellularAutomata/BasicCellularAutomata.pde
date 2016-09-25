int[] cells;
int[] ruleset = {0,1,0,1,1,0,1,0};
int generation, w, l;

void setup() {
    size(640, 640);
    background(255);

    generation = 0;
    // Cell width
    w = 5;
    
    cells = new int[100];

    // Start with all states as 0 except middle cell
    for(int i = 0; i < cells.length; i++) {
        cells[i] = 0;
    }
    cells[cells.length/2] = 1;
}

void draw() {
    generate();

    for(int i = 0; i < cells.length; i++) {
        // Only draw cells with state of 1 for now
        // Slight optimization for simple black and white
        if(cells[i] == 1) {
            fill(0);
            stroke(255);
            rect(i*w,generation*w,w,w);
        }
    }

    generation++;

    //// Stop looping
    // if(generation >= 100) {
    //     noLoop();
    // }

    // When CA hits bottom of window
    // Reset with new ruleset
    if(generation*w >= height) {
        generation = 0;
        generateNewRuleset();
        background(255);
    }
}

void generate() {
    // Use newCells array because we don't want to overwrite previous generation as we go
    int[] newGeneration = new int[cells.length];

    // Start at index 1 and end one less than length to skip edge cases
    for(int i = 0; i < cells.length; i++) {
        newGeneration[i] = rules(cells[i-1], cells[i], cells[i+1]);
    }

    cells = newGeneration;
}

int rules(int left, int middle, int right) {
    // Convert neighborhood to binary string
    String s = "" + left + middle + right;
    // Convert binary string to int
    int index = Integer.parseInt(s, 2);
    // Access the value from our ruleset using converted int
    return ruleset[index];
}

void generateNewRuleset() {
    for(int i = 0; i < 8; i++) {
        if(random(1) < 0.5)
            ruleset[i] = 0;
        else
            ruleset[i] = 1;
    }
}