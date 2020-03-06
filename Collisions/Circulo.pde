public class Circulo{
  int x, y , r;
  public Circulo(int x, int y, int r){
    this.x = x;
    this.y = y;
    this.r = r;
  }
  
  public void draw(){
    ellipse(x, y, r, r);
  }
}
