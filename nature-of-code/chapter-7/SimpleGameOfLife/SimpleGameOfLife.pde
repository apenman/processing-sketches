int[][] board;
int col, row, w;

void setup() {
    size(640, 640);
    background(255);
    col = 50;
    row = 50;
    w = 10;

    board = new int[col][row];
    for(int i = 0; i < col; i++) {
        for(int j = 0; j < row; j++) {
            board[i][j] = int(random(2));
        }
    }
}

void draw() {
    generate();
    drawBoard();
}

void drawBoard() {
    for(int i = 0; i < col; i++) {
        for(int j = 0; j < row; j++) {
            if(board[i][j] == 0) 
                fill(255);
            else 
                fill(0);
            stroke(0);
            rect(i*w, j*w, w, w);
        }
    }   
}

int calculateNeighbors(int x, int y) {
    int neighbors = 0;

    for(int i = -1; i <= 1; i++) {
        for(int j = -1; j <= 1; j++) {
            if(i != 0 && j != 0)
                neighbors += board[x+i][y+j];
        }
    }

    return neighbors;
}

int getNewState(int currentState, int neighbors) {
    // Dies of loneliness
    if(currentState == 1 && neighbors < 2) {
        return 0;
    }
    // Dies of overpopulation
    else if(currentState == 1 && neighbors > 3) {
        return 0;
    }
    // Born!
    else if(currentState == 0 && neighbors == 3) {
        return 1;
    }
    // Remain in current state
    else {
        return currentState;
    }
}

void generate() {
    int[][] nextGen = new int[col][row];

    for(int i = 1; i < col-1; i++) {
        for(int j = 1; j < row-1; j++) {
            nextGen[i][j] = getNewState(board[i][j], calculateNeighbors(i, j));
        }
    }

    board = nextGen;
}