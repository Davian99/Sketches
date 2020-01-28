import java.util.*;
//Constantes globales
final int d = 10, margen = 50;
final int init = 10000;
final int ax = 900, ay = 900, mx = 200, my = 200;
final int npintar = 12;
final double pCross = 0.7, pMut = 0.05;
final int rnp = 70;

boolean running;
boolean show;

int indice, gen, lastbest;
int np;
double bestfitness = 1e18;
Cromosome bestEver;
PFont f;

//Variables globales
Point[] puntos;
Random rand;
TSP tsp;

void setup() {
  size(1400, 700);
  rand = new Random();
  puntos = new Point[10000];
  indice = 0;
  gen = 0;
  lastbest = 0;
  f = createFont("Arial", 18, true); // Arial, 16 point, anti-aliasing on
  textFont(f, 18);
  running = false;
  show = false;
  bestfitness = 1e18;
  np = 0;
}

void restart() {
  rand = new Random();
  puntos = new Point[10000];
  indice = 0;
  gen = 0;
  lastbest = 0;
  f = createFont("Arial", 18, true); // Arial, 16 point, anti-aliasing on
  textFont(f, 18);
  running = false;
  show = false;
  bestfitness = 1e18;
  np = 0;
}

void randomtsp() {
  np = rnp;
  puntos = new Point[np];
  for (int i = 0; i < np; ++i) {
    int x = margen + rand.nextInt(ax-margen*2), y = margen*2 + rand.nextInt(ay-margen*3);
    puntos[i] = new Point(x, y);
  }

  tsp = new TSP(puntos);
  bestEver = tsp.cromosomas[0];

  show = true;
}

void inputtsp() {
  tsp = new TSP(puntos);
  bestEver = tsp.cromosomas[0];
}

void draw() {
  background(240);
  if(gen - lastbest > 1000)
    running = false;
  if (show) {
    int b = 0;
    double bb = 1e9;
    Arrays.sort(tsp.cromosomas);
    for (int i = 0; i < npintar-8; ++i) {
      tsp.cromosomas[i].draw(4.5, i);
      if (tsp.cromosomas[i].fitness < bb) {
        bb = tsp.cromosomas[i].fitness;
        b = i;
      }
    }
    
    strokeWeight(2);
    stroke(255, 0, 0);
    line(0, my*2, mx*4, my*2);
    line(0, my, mx*4, my);
    stroke(0);
    strokeWeight(1);
    line(0, my, mx*4, my);
    
    for(int i = init/2; i < init/2+4; ++i){
      tsp.cromosomas[i].draw(4.5, (npintar-8 + (i - init/2)));
    }
    
    for(int i = init-4; i < init; ++i){
      tsp.cromosomas[i].draw(4.5, (npintar-4 + (i - init + 4)));
    }
    if (tsp.cromosomas[b].fitness < bestfitness) {
      bestfitness = tsp.cromosomas[b].fitness;
      bestEver = tsp.cromosomas[b];
      lastbest = gen;
    }
    bestEver.drawBest();
    if (running) {
      gen++;
      tsp.gen_step();
    }
  } else {
    translate(mx*4, 0);
    scale(2.0/3, 2.0/3);
    for (int i = 0; i < np; ++i)
      puntos[i].draw();
    scale(3.0/2, 3.0/2);
    translate(-mx*4, 0);


    double scale = 3.0;
    for (int pos = 0; pos < npintar; ++pos) {
      int px = pos / 4;
      int py = pos % 4;
      noFill();
      translate(py*mx, px*my);
      rect(0, 0, mx, my);
      translate(-py*mx, -px*my);
    }
    translate(mx * 4, 0);
    noFill();
    rect(0, 0, mx*3, my*3);
    translate(-mx * 4, 0);
  }

  drawStats();

  //delay(500);
}

double dist(Point a, Point b) {
  return sqrt((a.x - b.x) * (a.x - b.x) + (a.y - b.y) * (a.y - b.y));
}

public double fitness(Cromosome c) {
  double val = 0;
  for (int i = 0; i < np-1; ++i)
    val += dist(puntos[c.perm[i]], puntos[c.perm[i+1]]);
  //No olvidar volver hasta el principio
  val += dist(puntos[c.perm[np-1]], puntos[c.perm[0]]);
  return val;
}

void drawStats() {
  fill(0);
  textFont(f, 18);
  noFill();
  translate(0, my*3);
  rect(0, 0, mx * 4, height-my*3);
  text("STATS: ", 5, 25);
  text("VERTEXS: " + np, 5, 45);
  text("GEN: " + gen, 5, 65);
  if (running) text("AVG: " + Math.round(tsp.avg() * 1000) / 1000.0, 5, 85);

  text("BEST EVER: " + Math.round(bestfitness * 1000) / 1000.0, 5 + mx*2, 25);
  text("GEN OF BEST: " + lastbest, 5 + mx*2, 45);
  text("TOTAL GENERATED: " + ((gen+1) * init), 5 + mx*2, 65);

  translate(mx*4, 0);
  rect(0, 0, width, height-my*3);
  fill(150);
  rect(20, 25, 100, 50);
  fill(0);
  text("RANDOM", 30, 57);


  fill(150);
  rect(150, 25, 100, 50);
  fill(0);
  text("RESET", 170, 57);

  fill(150);
  rect(480, 25, 100, 50);
  fill(0);
  text("START", 500, 57);

  translate(-mx*4, -my*3);
}

void mousePressed() {
  int x = mouseX, y = mouseY;
  System.out.println(x + " " + y);
  if (botonRandom(x, y)) {
    restart();
    randomtsp();
  } else if (botonStart(x, y)) {
    if (show)
      running = !running;
    else {
      show = true;
      inputtsp();
      running = true;
    }
  } else if (!running && !show && dentro(x, y)) {
    System.out.println("DENTRO");
    addPoint(x, y);
  } else if (reset(x, y)) {
    restart();
  }
}

void keyPressed() {
  if (key == 'z' || key == 'x') {
    if (!running && !show && dentro(mouseX, mouseY)) {
      System.out.println("DENTRO");
      addPoint(mouseX, mouseY);
    }
  }
}

boolean botonRandom(int x, int y) {
  if (x >= mx*4 + 20 && x <= mx*4 + 120 && y >= my*3 +25 && y <= my*3 + 75)
    return true;
  return false;
}

boolean reset(int x, int y) {
  if (x >= mx*4 + 150 && x <= mx*4 + 250 && y >= my*3 + 25 && y <= my*3 + 75)
    return true;
  return false;
}

boolean botonStart(int x, int y) {
  if (x >= mx*4 + 480 && x <= mx*4 + 580 && y >= my*3 + 25 && y <= my*3 + 75)
    return true;
  return false;
}

boolean dentro(int x, int y) {
  if (x >= mx*4 && x <= width && y >= 0 && y <= my*3)
    return true;
  return false;
}

void addPoint(int x, int y) {
  x -= mx*4;
  int px =(int)(x * (3/2.0)), py = (int)(y * (3/2.0));
  puntos[np] = new Point(px, py);
  np++;
}
