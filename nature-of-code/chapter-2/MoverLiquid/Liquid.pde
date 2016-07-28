class Liquid {
    float x,y,w,h;
    float c;

    Liquid(float x, float y, float w, float h, float c) {
        this.x = x;
        this.y = y;
        this.w = w;
        this.h = h;
        this.c = c;
    }

    void display() {
        noStroke();
        fill(175);
        rect(x,y,w,h);
    }
}