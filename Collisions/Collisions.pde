int x = -1, y = -1, rot = 0;

Foco f;
ArrayList<Circulo> circles;

void setup() {
  size(800, 800);
  f = new Foco(-1, -1);
  circles = new ArrayList<Circulo>();
  circles.add(new Circulo(100, 100, 100));
}

void draw() {
  background(240);
  for (Circulo c : circles)
    c.draw();
  f.draw();
}  

void mousePressed() {
  f.x = mouseX;
  f.y = mouseY;
}

void interseccion(Circulo c){
  double dx = 2000;
  double dy = 0;
  
}
