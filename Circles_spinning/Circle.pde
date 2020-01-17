public class Circle {
  float x, y, tam;
  float angle = 0;
  int entra = 0, giros = 0, id;
  public Circle(float x, float y, float tam, int id) {
    this.x = x;
    this.y = y;
    this.tam = tam;
    this.id = id;
  }

  public void pinta() {
    if (angle < 0.5) {
      stroke(255, 0, 0);
    }
    if (id == 1) {
      fill(0);
      text(giros, 5, 15);
      noFill();
    }
    arc(x, y, tam, tam, 0 + angle, HALF_PI + angle);
    stroke(0, 0, 0);
  }

  public void avanza() {
    angle += PI * 1/tam;
    angle = angle % (PI*2);
    if (angle < 1e-1) {
      giros++;
      if (id == 1) {
        System.out.println(giros);
      }
    }
  }
}
