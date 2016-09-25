int[] cells;
int[] ruleset = {0,1,0,1,1,0,1,0};
int generation, w;

void setup() {
    size(640, 640);
    background(255);
    cells = new int[100];

    // Start with all states as 0 except middle cell
    for(int i = 0; i < cells.length; i++) {
        cells[i] = 0;
    }
    cells[cells.length/2] = 1;

    generation = 0;
    w = 5;
}

void draw() {
    generate();

    for(int i = 0; i < cells.length; i++) {
        if(cells[i] == 0)
            fill(255);
        else 
            fill(0);
        stroke(0);
        rect(i*w,generation*w,w,w);
    }

    generation++;

    if(generation >= 100) {
        noLoop();
    }
}

private void generate() {
    // Use newCells array because we don't want to overwrite previous generation as we go
    int[] newGeneration = new int[cells.length];

    // Start at index 1 and end one less than length to skip edge cases
    for(int i = 1; i < cells.length-1; i++) {
        newGeneration[i] = rules(cells[i-1], cells[i], cells[i+1]);
    }

    cells = newGeneration;
}

private int rules(int left, int middle, int right) {
    // Convert neighborhood to binary string
    String s = "" + left + middle + right;
    // Convert binary string to int
    int index = Integer.parseInt(s, 2);
    // Access the value from our ruleset using converted int
    return ruleset[index];
}