import java.util.*;

final int rad = 30, np = 100;

Random rand;
ArrayList<Punto> puntos;

UFDS ds;
int[] rc, gc, bc;

void setup() {
  size(800, 800);
  //fullScreen();
  rand = new Random();
  puntos = new ArrayList<Punto>();
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
    puntos.add(new Punto(x, y, 20, 20, 20, i));
  }
}

void draw() {
  background(240);
  //line(0, height/2, width, height/2);
  //line(width/2, 0, width/2, height);
  for (Punto p : puntos)
    p.draw();
  join_closest();
  delay(500);
}

double dist(Punto a, Punto b) {
  return sqrt((a.x - b.x) * (a.x - b.x) + (a.y - b.y) * (a.y - b.y));
}

void join_closest() {
  Punto a = puntos.get(0), b = puntos.get(1);
  double best = dist(a, b);
  if(ds.same(a.ind, b.ind))
    best = 1e9;
  for (Punto p1 : puntos) {
    for (Punto p2 : puntos) {
      if(p1 == p2 || ds.same(p1.ind, p2.ind))
        continue;
      double d = dist(p1, p2);
      if(d < best){
        best = d;
        a = p1;
        b = p2;
      }
    }
  }
  if(best == 1e9){
    noLoop();
    return;
  }
    
  ds.Union(a.ind, b.ind);
  strokeWeight(3);
  line(a.x, a.y, b.x, b.y);
  strokeWeight(1);
}
