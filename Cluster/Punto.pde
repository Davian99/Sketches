public class Punto{
  public int x, y;
  public int ind;
  public Punto(int x, int y, int ind){
    this.x = x;
    this.y = y;
    this.ind = ind;
  }
  public void draw(){
    int p = ds.Find(this.ind);
    fill(rc[p], gc[p], bc[p]);
    ellipse(x, y, rad, rad);
    noFill();
  }
  public void drawBlack(){
    fill(0);
    ellipse(x, y, rad, rad);
    noFill();
  }
}
