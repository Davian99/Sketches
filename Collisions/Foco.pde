public class Foco {
  int x, y;
  public Foco(int x, int y) {
    this.x = x;
    this.y = y;
  }

  public void draw() {
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
}
