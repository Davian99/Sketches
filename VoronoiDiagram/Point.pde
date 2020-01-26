public class Point{
  int x, y, r, g, b;
  public Point(int x, int y, int r, int g, int b){
    this.x = x;
    this.y = y;
    this.r = r;
    this.g = g;
    this.b = b;
  }
  
  public void draw(){
    fill(0);
    ellipse(x, y, 10, 10);
    fill(255);
  }
}
