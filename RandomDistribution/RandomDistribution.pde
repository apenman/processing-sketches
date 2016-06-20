int[] randomCounts;
int range = 20;

void setup() {
 size(640, 240);
 randomCounts = new int[range];
}

void draw() {
 background(255);
 
 int index = int(random(range));
 randomCounts[index]++;
 
 stroke(0);
 fill(175);
 
 // TODO: Add functionality to scale so bar with max takes up full height and others
   // adjust height proportionately
 int w = width/randomCounts.length;
 for(int i = 0; i < randomCounts.length; i++) {
   rect(i*w, height-randomCounts[i], w-1, randomCounts[i]); 
 }
}