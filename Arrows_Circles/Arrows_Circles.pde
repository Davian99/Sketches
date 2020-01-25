import java.util.*; 
import java.io.*;
PFont f;
ArrayList<NumberBall> bolas;
Random rand;

NumberBall nba, nbb;

void setup() {
  size(800, 800);
  f = createFont("Consolas", 30, true); // Arial, 16 point, anti-aliasing on
  textFont(f, 30);
  bolas = new ArrayList<NumberBall>();
  frameRate(60);
  rand = new Random();
  nba = newNB();
  nbb = newNB();
  //bolas.add(newNB());
  //bolas.add(newNB());
}

void draw() {
  background(240);
  line(0, height/2, width, height/2);
  line(width/2, 0, width/2, height);
  for (NumberBall nb : bolas)
    nb.draw();
  nbb.x = mouseX;
  nbb.y = mouseY;
  nba.draw();
  nbb.draw();

  float gamma = getAngle(nba.x, nba.y, nbb.x, nbb.y);
  float distance = getDistance(nba.x + cos(gamma) * 25, nba.y + sin(gamma) * 25, nbb.x - cos(gamma) * 25, nbb.y - sin(gamma) * 25);


  drawArrow(nba.x + cos(gamma) * 25, nba.y + sin(gamma) * 25, distance, gamma);

  //noLoop();
}

NumberBall newNB() {
  int x = 25 + rand.nextInt(width-50);
  int y = 25 + rand.nextInt(height-50);
  int n = rand.nextInt(1000);
  System.out.println(x + "\n" + y + "\n"); 
  return new NumberBall(n, x, y);
}

void drawArrow(float cx, float cy, float len, float angle) {
  pushMatrix();
  translate(cx, cy);
  rotate(angle);
  line(0, 0, len, 0);
  line(len, 0, len - 8, -8);
  line(len, 0, len - 8, 8);
  line(0, 0, 8, -8);
  line(0, 0, 8, 8);
  popMatrix();
}

float getAngle(float x1, float y1, float x2, float y2) {
  return atan2((y2 - y1), (x2 - x1));
}

float getDistance(float x1, float y1, float x2, float y2) {
  return sqrt((x1-x2) * (x1-x2) + (y1-y2) * (y1-y2));
}
