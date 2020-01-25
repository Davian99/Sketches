import java.util.*; 
import java.io.*;
PFont f;
ArrayList<NumberBall> bolas;
Random rand;

void setup() {
  size(800, 800);
  f = createFont("Consolas", 30, true); // Arial, 16 point, anti-aliasing on
  textFont(f, 30);
  bolas = new ArrayList<NumberBall>();
  frameRate(60);
  rand = new Random();

  bolas.add(newNB());
  bolas.add(newNB());
}

void draw() {
  background(240);
  line(0, height/2, width, height/2);
  line(width/2, 0, width/2, height);
  for (NumberBall nb : bolas) {
    nb.draw();
  }
  drawArrow(bolas.get(0).x+25, bolas.get(0).y, 100, 0);
  
  noLoop();
}

NumberBall newNB() {
  int x = rand.nextInt(width);
  int y = rand.nextInt(height);
  int n = rand.nextInt(1000);
  System.out.println(x + "\n" + y + "\n"); 
  return new NumberBall(n, x, y);
}

void drawArrow(int cx, int cy, int len, float angle){
  pushMatrix();
  translate(cx, cy);
  rotate(radians(angle));
  line(0,0,len, 0);
  line(len, 0, len - 8, -8);
  line(len, 0, len - 8, 8);
  line(0, 0, 8, -8);
  line(0, 0, 8, 8);
  popMatrix();
}
