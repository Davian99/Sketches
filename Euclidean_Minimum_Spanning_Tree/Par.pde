public class Par{
  public int x, y, id;
  
  public Par(int i, int j, int id){
    this.x = i;
    this.y = j;
    this.id = id;
  }
  
  public void pinta(){
    point(x, y);
  }
}
