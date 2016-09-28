class KochLine {
    PVector start, end;

    KochLine(PVector s, PVector e) {
        start = s.get();
        end = e.get();
    }

    void display() {
        stroke(0);
        line(start.x, start.y, end.x, end.y);
    }

    PVector kochA() {
        return start;
    }

    PVector kochB() {
        PVector dist = PVector.sub(end, start);
        dist.div(3); 
        return dist.add(start);
    }

    PVector kochC() {
        // Move to b
        // Same logic but we need distance of v
        PVector a = start.get();
        PVector v = PVector.sub(end, start);

        v.div(3);
        a.add(v);

        // Equilateral triangle has all 60 degree angles
        // Rotate and move the length of a segment
        v.rotate(-radians(60));
        a.add(v);

        return a;
    }

    PVector kochD() {
        PVector dist = PVector.sub(end, start);
        dist.mult(2/3.0);
        dist.add(start);
        return dist;
    }

    PVector kochE() {
        return end;
    }
}

ArrayList<KochLine> lines;

void setup() {
    size(640, 640);
    lines = new ArrayList<KochLine>();

    lines.add(new KochLine(new PVector(0, 200), new PVector(width, 200)));

    for(int i = 0; i < 5; i++) {
        generate();
    }
}

void draw() {
    background(255);
    for(KochLine l : lines) {
        l.display();
    }
}

void generate() {
    ArrayList<KochLine> next = new ArrayList<KochLine>();

    // For every current line, generate new lines for segment
    for(KochLine l : lines) {
        PVector a = l.kochA();
        PVector b = l.kochB();
        PVector c = l.kochC();
        PVector d = l.kochD();
        PVector e = l.kochE();

        next.add(new KochLine(a, b));
        next.add(new KochLine(b, c));
        next.add(new KochLine(c, d));
        next.add(new KochLine(d, e));
    }

    lines = next;
}