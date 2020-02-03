public class Punto{
  public int x, y;
  public int ind;
  public int r, g, b;
  public Punto(int x, int y, int r, int g, int b, int ind){
    this.x = x;
    this.y = y;
    this.r = r;
    this.g = g;
    this.b = b;
    this.ind = ind;
  }
  public void draw(){
    int p = ds.Find(this.ind);
    fill(rc[p], gc[p], bc[p]);
    ellipse(x, y, rad, rad);
    noFill();
  }
}
