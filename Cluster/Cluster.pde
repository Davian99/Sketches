import java.util.*;

int rad = 30, np = 100;

Random rand;
ArrayList<Punto> puntos;

UFDS ds;
int[] rc, gc, bc;
double media;
double last = 1e9;
boolean start = false;

void reset(){
  rand = new Random();
  puntos = new ArrayList<Punto>();
  last = 1e9;
  start = false;
}

void setup() {
  size(800, 800);
  //fullScreen();
  rand = new Random();
  puntos = new ArrayList<Punto>();
}

void random_start() {
  rc = new int[np];
  bc = new int[np];
  gc = new int[np];
  ds = new UFDS(np);
  for (int i = 0; i < np; ++i) {
    int x = rand.nextInt(width), y = rand.nextInt(height);
    int r = rand.nextInt(255), g = rand.nextInt(255), b = rand.nextInt(255);
    rc[i] = r;
    gc[i] = g;
    bc[i] = b;
    puntos.add(new Punto(x, y, i));
  }
  media = get_media();
  System.out.println(media);
  start = true;
}

void user_start() {
  np = puntos.size();
  rc = new int[np];
  bc = new int[np];
  gc = new int[np];
  ds = new UFDS(np);
  for (int i = 0; i < np; ++i) {
    int r = rand.nextInt(255), g = rand.nextInt(255), b = rand.nextInt(255);
    rc[i] = r;
    gc[i] = g;
    bc[i] = b;
  }
  media = get_media();
  System.out.println(media);
  start = true;
}

void keyPressed() {
  if (key == 'r')
    random_start();
  else if (key == ENTER)
    user_start();
  else if (key == ' ')
    reset();
}

void mousePressed() {
  int x = mouseX, y = mouseY;
  puntos.add(new Punto(x, y, puntos.size()));
}

void draw() {
  background(240);
  if (start) {
    for(Punto p : puntos)
      p.draw();
    join_closest();
    delay(200);
  } else {
    for(Punto p : puntos)
      p.drawBlack();
  }
}

double dist(Punto a, Punto b) {
  return sqrt((a.x - b.x) * (a.x - b.x) + (a.y - b.y) * (a.y - b.y));
}

void join_closest() {
  Punto a = puntos.get(0), b = puntos.get(1);
  double best = dist(a, b);
  if (ds.same(a.ind, b.ind))
    best = 1e9;
  for (Punto p1 : puntos) {
    for (Punto p2 : puntos) {
      if (p1 == p2 || ds.same(p1.ind, p2.ind))
        continue;
      double d = dist(p1, p2);
      if (d < best) {
        best = d;
        a = p1;
        b = p2;
      }
    }
  }
  System.out.println(best);
  if (best > last * 2) {
    return;
  }
  if (best == 1e9) {
    return;
  }
  last = best;
  ds.Union(a.ind, b.ind);
  strokeWeight(3);
  line(a.x, a.y, b.x, b.y);
  strokeWeight(1);
}

double get_media() {
  double c = 0;
  double med = 0;
  for (Punto p1 : puntos) {
    for (Punto p2 : puntos) {
      if (p1 == p2)
        continue;
      med += dist(p1, p2);
      c += 1;
    }
  }
  return med / c;
}
