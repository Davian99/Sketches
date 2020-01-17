import Turtle.*;
Turtle t;

float i;
float tamano = 5;
boolean recto;

void setup() {
  size(800, 800);
  background(255);
  stroke(0);
  t = new Turtle(this);
  t.penUp();
  double d = 180*tamano/Math.PI;
  t.setX((float)(width/2 - d));
  t.setY(height/2);
  recto = false;
  i = 1;
}

void draw () {
  if (!recto) {
    t.forward(tamano);
    t.setHeading(i);
    
    i++;
    if (i % 360 == 0)
      tamano *= 0.8;
    if (tamano <= 2)
      recto = true;
  } else {
    t.setHeading(90);
    t.forward(2);
  }
  t.drawTurtle();
}
