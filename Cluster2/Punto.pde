public class Punto {
  public int x, y;
  public int ind, closest = 0;
  public Punto(int x, int y, int ind) {
    this.x = x;
    this.y = y;
    this.ind = ind;
  }
  public void draw() {
    if (closest == -1) {
      fill(rc[ind], gc[ind], bc[ind]);
      ellipse(x, y, rad/2, rad/2);
      noFill();
    } else {
      fill(rc[closest], gc[closest], bc[closest]);
      ellipse(x, y, rad, rad);
      noFill();
    }
  }
  public void drawBlack() {
    fill(0);
    ellipse(x, y, rad, rad);
    noFill();
  }
}
