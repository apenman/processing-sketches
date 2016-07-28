import java.util.Random;

Random generator;
void setup() {
  
    size(640,360);
    generator = new Random();
}

float getGaussianPoint() {
 float num = (float) generator.nextGaussian(); 
 float sd = 60;
 float mean = 320;
 return sd * num + mean; 
}

float[] getSplatterPoint() {
 float numx = (float) generator.nextGaussian(); 
 float numy = (float) generator.nextGaussian(); 
 float sd = 60;
 float mean = 320;
 
 float[] points = new float[2];
 points[0] = sd * numx + mean;
 points[1] = sd * numy + mean;
 
 return points;
}

color getSplatterColor() {
 float numr = (float) generator.nextGaussian(); 
 float numg = (float) generator.nextGaussian();
 float numb = (float) generator.nextGaussian(); 

 float sd = 60;
 float mean = 320;
 
 float[] points = new float[3];
 points[0] = sd * numr + mean;
 points[1] = sd * numg + mean;
 points[2] = sd * numb + mean;

  return color(numr, numg, numb);
}

void draw() { 
 noStroke();
 color fillCol = getSplatterColor();
 fill(fillCol, 10);
 //ellipse(getGaussianPoint(), 180, 16, 16);
 float[] point = getSplatterPoint();
 ellipse(point[0], point[1], 16, 16);
}