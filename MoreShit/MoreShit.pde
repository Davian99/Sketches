Function f;
PFont font;

void setup() {
  size(1000, 1000);
  ArrayList<Double> lista_terms = new ArrayList<Double>();
  lista_terms.add(new Double(0.0));
  lista_terms.add(new Double(3.0));
  lista_terms.add(new Double(-1.0));
  f = new Function(lista_terms);
  font = createFont("Arial", 18, true); // Arial, 16 point, anti-aliasing on
  textFont(font, 18);
}

void draw() {
  background(240);
  ejes();
  fx(f);
  strokeWeight(3);
  translate(width/2, height/2);
  translate(-width/2, -height/2);
  strokeWeight(1);
}

void ejes() {
  line(0, height/2, width, height/2);
  line(width/2, 0, width/2, height);

  //Numeros en los ejes
  translate(width/2, height/2);
  fill(0);
  strokeWeight(0.05);
  float sep = width/10;
  for (int i = -4; i < 5; ++i) {
    text(i, i*sep, 20);
    line(i*sep, -height/2, i*sep, height/2);
    text(i, -20, i*sep);
    line(-width/2, i*sep, width/2, i*sep);
  }
  stroke(1);
  noFill();
  translate(-width/2, -height/2);
}

void fx(Function f) {
  translate(width/2, height/2);
  strokeWeight(3);
  stroke(255, 0, 0);
  float lastx = 1e9, lasty = 1e9;
  for (double x = -width/2; x < width; x += 1) {
    Double y = (-100.0) * f.evaluate(x/100.0);
    point((float)x, (float)(double)y);
    if (lastx == 1e9) {
      lastx = (float)x;
      lasty = (float)(double)y;
    } else {
      line((float)x, (float)(double)y, lastx, lasty);
      lastx = (float)x;
      lasty = (float)(double)y;
    }
  }
  stroke(0);
  strokeWeight(1);
  translate(-width/2, -height/2);
}
