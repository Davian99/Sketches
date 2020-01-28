int x = -1, y = -1, rot = 0;

void setup() {
  size(800, 800);
}

void draw() {
  background(240);
  ellipse(100, 100 , 100, 100);
  if (x >= 0) {
    translate(x, y);
    strokeWeight(3);
    point(0, 0);
    strokeWeight(1);
    for (int i = 0; i < 360; ++i) {
      rotate(radians(1));
      line(0, 0, 2000, 0);
    }
    translate(-x, -y);
  }
  
}  

void mousePressed() {
  x = mouseX;
  y = mouseY;
}
