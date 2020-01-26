import java.util.*; 
import java.io.*;
PFont f;
ArrayList<NumberBall> bolas;
Random rand;

int status = 0;

NumberBall nba, nbb;

void setup() {
  size(800, 800);
  //fullScreen();
  f = createFont("Consolas", 30, true); // Arial, 16 point, anti-aliasing on
  textFont(f, 30);
  rand = new Random();


  bolas = new ArrayList<NumberBall>();
  for (int i = 0; i < 50; ++i)
    bolas.add(newNB());
  frameRate(60);
}

void draw() {
  background(240);
  //line(0, height/2, width, height/2);
  //line(width/2, 0, width/2, height);
  strokeWeight(1);
  slowVoronoi();
  strokeWeight(2);
  stroke(0);
  for (NumberBall nb : bolas)
    nb.draw();
  /*
  NumberBall nba = closest(mouseX, mouseY), nbb = new NumberBall(0, mouseX, mouseY);
   nbb.draw();
   float gamma = getAngle(nba.x, nba.y, nbb.x, nbb.y);
   if (getDistance(nba.x, nba.y, nbb.x, nbb.y) >= 50) {
   float distance = getDistance(nba.x + cos(gamma) * 25, nba.y + sin(gamma) * 25, nbb.x - cos(gamma) * 25, nbb.y - sin(gamma) * 25);
   drawArrow(nba.x + cos(gamma) * 25, nba.y + sin(gamma) * 25, distance, gamma);
   }
   */
  save("Voronoi.png");
  noLoop();
}

NumberBall newNB() {
  int x = 25 + rand.nextInt(width-50);
  int y = 25 + rand.nextInt(height-50);
  int r = rand.nextInt(256);
  int g = rand.nextInt(256);
  int b = rand.nextInt(256);
  int n = rand.nextInt(1000);
  return new NumberBall(n, x, y, r, g, b);
}

NumberBall closest(int x, int y) {
  NumberBall close = null;
  float minDist = 1e9;
  for (NumberBall nb : bolas) {
    if (getDistance(nb.x, nb.y, x, y) < minDist) {
      minDist = getDistance(nb.x, nb.y, x, y);
      close = nb;
    }
  }

  return close;
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

void slowVoronoi() {
  for (int x = 0; x < width; x += 1) {
    for (int y = 0; y < height; y +=1) {
      NumberBall nb = closest(x, y); //<>//
      if (nb == null)
        continue;
      stroke(nb.r, nb.g, nb.b);
      point(x, y);
    }
  }
}
