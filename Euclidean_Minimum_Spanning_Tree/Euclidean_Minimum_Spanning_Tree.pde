import java.util.*; 
import java.io.*;

final int sizex = 800, sizey = 800;
final int tam = 10000;
Random rand;
ArrayList<Par> arr;
ArrayList<Arista> aristas, arm;

void settings() {
  size(sizex, sizey);
  //fullScreen();
}

void setup() {
  //size(800, 800);
  rand = new Random();
  arr = new ArrayList<Par>();
  Map<Integer, Integer> map = new HashMap<Integer, Integer>();
  for (int i = 0; i < tam; ++i) {
    int x = rand.nextInt(width);
    int y = rand.nextInt(height);
    arr.add(new Par(x, y, i));
    map.put(x * sizex + y, i);
  }

  aristas = new ArrayList<Arista>();
 
  try{
    String s = new String();
    PrintWriter writer = new PrintWriter(dataPath("") + "\\in.in");
    writer.println(tam);
    for(Par p : arr)
      writer.println(p.x + " " + p.y);

    writer.close();
  }  
  catch (Exception e) {}
  long startTime = System.currentTimeMillis();
  try {
    // Execute command
    String command = "cmd /c start /wait cmd.exe /K p.bat";
    File file = new File(dataPath(""));
    Process p = Runtime.getRuntime().exec(command, null, file);
    p.waitFor();
  } 
  catch (Exception e) {}
  long estimatedTime = System.currentTimeMillis() - startTime;
  System.out.println("Tiempo de Delauny: " + estimatedTime);
  startTime = System.currentTimeMillis();
  try{
    File file = new File(dataPath("") + "\\out.out");
    Scanner sc = new Scanner(file);
    int n = sc.nextInt();
    for(int i = 0; i < n; ++i){ //<>//
      int x1, y1, x2, y2;
      x1 = sc.nextInt();
      y1 = sc.nextInt();
      x2 = sc.nextInt();
      y2 = sc.nextInt();
      Par p1 = new Par(x1, y1, map.get(x1 * sizex + y1));
      Par p2 = new Par(x2, y2, map.get(x2 * sizex + y2));
      aristas.add(new Arista(p1, p2));
    }
  }  
  catch (Exception e) {
    System.out.println(e.getMessage());
  }
  estimatedTime = System.currentTimeMillis() - startTime;
  System.out.println("Tiempo de Leer aristas: " + estimatedTime);
  
  startTime = System.currentTimeMillis();
  kruskal();
  estimatedTime = System.currentTimeMillis() - startTime;
  System.out.println("Tiempo de Kruskal: " + estimatedTime);
  
  noLoop();
}

void draw() {
  long startTime = System.currentTimeMillis();
  background(250);
  strokeWeight(1);
  for (Arista a : arm) {
    a.pinta();
  }
  strokeWeight(2);
  for (Par p : arr)
    p.pinta();
  long estimatedTime = System.currentTimeMillis() - startTime;
  System.out.println("Tiempo de Dibujar: " + estimatedTime);
  save("kruskal.png");
}

void kruskal() {
  Collections.sort(aristas);
  arm = new ArrayList<Arista>();
  int i = 0;
  UFDS ds = new UFDS(tam);
  for(Arista a : aristas){
    if(arm.size() == tam - 1)
      return;
    int id1 = a.p1.id, id2 = a.p2.id;
    if (ds.Find(id1) != ds.Find(id2)) {
      ds.Union(id1, id2);
      arm.add(a);
    }
    i++;
  }
  return;
}
