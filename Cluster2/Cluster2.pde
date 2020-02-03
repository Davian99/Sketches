import java.util.*;

int rad = 30, np = 100;

Random rand;
ArrayList<Punto> puntos, centros;

int[] rc, gc, bc;
int[] closest_to; 
int nc = 3;
double last = 1e9;
boolean start = false;

void reset() {
  rand = new Random();
  puntos = new ArrayList<Punto>();
  centros = new ArrayList<Punto>();
  last = 1e9;
  start = false;
}

void setup() {
  size(800, 800);
  //fullScreen();
  rand = new Random();
  puntos = new ArrayList<Punto>();
  centros = new ArrayList<Punto>();
}

void random_start() {
  nc = rand.nextInt(10);
  closest_to = new int[np];
  rc = new int[nc];
  bc = new int[nc];
  gc = new int[nc];
  for (int i = 0; i < nc; ++i) {
    int x = rand.nextInt(width), y = rand.nextInt(height);
    int r = rand.nextInt(255), g = rand.nextInt(255), b = rand.nextInt(255);
    rc[i] = r;
    gc[i] = g;
    bc[i] = b;
    Punto c = new Punto(x, y, i);
    c.closest = -1;
    centros.add(c);
  }

  for (int i = 0; i < np; ++i) {
    int x = rand.nextInt(width), y = rand.nextInt(height);
    puntos.add(new Punto(x, y, i));
  }

  System.out.println(nc);
  start = true;
}

void user_start() {
  rc = new int[nc];
  bc = new int[nc];
  gc = new int[nc];
  closest_to = new int[np];
  for (int i = 0; i < nc; ++i) {
    int x = rand.nextInt(width), y = rand.nextInt(height);
    int r = rand.nextInt(255), g = rand.nextInt(255), b = rand.nextInt(255);
    rc[i] = r;
    gc[i] = g;
    bc[i] = b;
    Punto c = new Punto(x, y, i);
    c.closest = -1;
    centros.add(c);
  }
  start = true;
}
/*

 DRAW
 
 */
void draw() {
  background(240);
  if (start) {
    find_closest();
    for (Punto p : puntos)
      p.draw();
    for (Punto p : centros)
      p.draw();
    delay(1000);
    recalculate_centers();
  } else {
    for (Punto p : puntos)
      p.drawBlack();
  }
}

void keyPressed() {
  if (key == 'r')
    random_start();
  else if (key == ' ')
    reset();
  else if (key >= '1' && key <= '9') {
    nc = (int)key - '0';
    user_start();
  }
}

void mousePressed() {
  int x = mouseX, y = mouseY;
  puntos.add(new Punto(x, y, puntos.size()));
}

double dist(Punto a, Punto b) {
  return sqrt((a.x - b.x) * (a.x - b.x) + (a.y - b.y) * (a.y - b.y));
}

void find_closest() {
  for (Punto p : puntos) {
    p.closest = closest_center(p);
    closest_to[p.ind] = p.closest;
  }
}

int closest_center(Punto p) {
  int ind_c = 0, i = 0;
  double best = dist(p, centros.get(0));
  for (Punto c : centros) {
    double d = dist(p, c);
    if (d < best) {
      best = d;
      ind_c = i;
    }
    i++;
  }
  return ind_c;
}

void recalculate_centers() {
  int i = 0;
  ArrayList<Punto> centros2 = new ArrayList<Punto>();
  for (Punto p : centros) {
    centros2.add(media_puntos(i, p));
    i++;
  }
  centros = centros2;
}

Punto media_puntos(int k, Punto backup) {
  Punto ret = new Punto(0, 0, k);
  ret.closest = -1;
  int sumax = 0, sumay = 0, dentro = 0;
  for (Punto p : puntos) {
    if (p.closest == k) {
      sumax += p.x;
      sumay += p.y;
      dentro++;
    }
  }

  if (dentro == 0)
    return backup;

  ret.x = sumax / dentro;
  ret.y = sumay / dentro;

  //System.out.println("Centro k -> " + k + ", x = " + ret.x + ", y = " + ret.y);

  return ret;
}
