import java.util.*; 
import java.io.*;
PFont f;
ArrayList<Point> puntos;
Random rand;
boolean voronoi = false;
int status = 0;


void setup() {
  size(800, 800);
  //fullScreen();
  f = createFont("Consolas", 30, true); // Arial, 16 point, anti-aliasing on
  textFont(f, 30);
  rand = new Random();
  puntos = new ArrayList<Point>();
  voronoi = false;
  frameRate(60);
}

void draw() {
  background(240);

  if (voronoi) {
    strokeWeight(3);
    slowVoronoi();
    stroke(0);
    noLoop();
  }
  for (Point p : puntos)
    p.draw();
  //noLoop();
  save("Voronoi.png");
}

void mouseClicked() {
  puntos.add(new Point(mouseX, mouseY, rand.nextInt(256), rand.nextInt(256), rand.nextInt(256)));
}

void keyPressed() {
  if (key == ENTER) {
    voronoi = true;
  } else if (key == 'z' || key == 'x') {
    puntos.add(new Point(mouseX, mouseY, rand.nextInt(256), rand.nextInt(256), rand.nextInt(256)));
    System.out.println(puntos.size());
  }
}

Point closest(int x, int y) {
  Point close = null;
  float minDist = 1e9;
  for (Point p : puntos) {
    if (getDistance(p.x, p.y, x, y) < minDist) {
      minDist = getDistance(p.x, p.y, x, y);
      close = p;
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
  for (int x = 0; x < width; x += 2) {
    for (int y = 0; y < height; y +=2) {
      Point nb = closest(x, y);
      if (nb == null)
        continue;
      stroke(nb.r, nb.g, nb.b);
      point(x, y);
    }
  }
}
