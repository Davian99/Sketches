float x = 0;
final int sizex = 200, sizey = 200;
ArrayList<Circle> circulos;
int inicio = 10;
boolean acabar = false;
PFont f;

void setup() {
  frameRate(60);
  circulos = new ArrayList<Circle>();
  for (int i = 1; i <= 7; ++i) {
    Circle c = new Circle(width/2, height/2, i * 19, i);
    circulos.add(c);
  }
  f = createFont("Arial",10,true); // Arial, 16 point, anti-aliasing on
  textFont(f, 10);
  scale(1,-1);
}

void settings() {
  size(sizex, sizey);
}

void draw() {
  background(250);
  noFill();
  strokeWeight(1);
  for (Circle c : circulos) {
    if (!acabar)
      c.avanza();
    c.pinta();
  }
  strokeWeight(1);
  line(0, height/2, width, height/2);
  line(width/2, 0, width/2, height);
  saveFrame("output/spin_######.tif");
  if (acaba() && inicio < 0) {
    acabar = true;
    inicio = 60;
  }
  if (acabar && inicio == 0)
    exit();
  inicio--;
}

boolean acaba() {
  for (Circle c : circulos) {
    if (c.angle > 1e-1)
      return false;
  }
  return true;
}
