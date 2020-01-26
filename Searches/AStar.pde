public class AStar {
  PriorityQueue<Square> pq;
  Square ini, fin;
  int tam;
  int[] arr, padres;
  float sumx, sumy;

  public AStar(Square ini, Square f, int tam, float sumx, float sumy) {
    this.ini = ini;
    this.fin = f;
    this.sumx = sumx;
    this.sumy = sumy;
    pq = new PriorityQueue<Square>(1, new SquareComparator(f, this));
    pq.add(ini);
    this.tam = tam;
    arr = new int[tam];
    padres = new int[tam];
    for (int i = 0; i < tam; ++i)
      arr[i] = (int)1e9;
    arr[tab.getSquareInd(ini.x, ini.y)] = 0;
  }
  public void paso() {
    if (pq.size() == 0) {
      return;
    }

    Square act = pq.peek();
    System.out.println("Ind: " + act.ind + " value: " + (arr[act.ind] + (int)(abs(fin.x - act.x)/tab.x + abs(fin.y - act.y)/tab.y)));
    int ind, padre = act.ind, dp = arr[padre];
    pq.remove();
    float x = act.x + sumx, y = act.y + sumy;
    //Arriba
    float xup = x, yup = y - sumy*2;
    ind = tab.getSquareInd(xup, yup);
    this.add(dp, padre, ind);

    float xle = x - sumx * 2, yle = y;
    ind = tab.getSquareInd(xle, yle);
    this.add(dp, padre, ind);

    float xdo = x, ydo = y + sumy*2;
    ind = tab.getSquareInd(xdo, ydo);
    this.add(dp, padre, ind);

    float xri = x + sumx * 2, yri = y;
    ind = tab.getSquareInd(xri, yri);
    this.add(dp, padre, ind);
  }

  public void add(int d, int padre, int ind) {
    if (ind >= 0 && ind < tam && arr[padre] + 1 < arr[ind] && tab.listaS[ind] != null && tab.listaS[ind].state != 2) {
      Square s = tab.listaS[ind];
      arr[ind] = 1 + d;
      padres[ind] = padre;
      if (s == fin) {
        camino();
        busqueda = false;
        finbusqueda = true;
        return;
      }
      s.modify(5);
      pq.add(s);
    }
  }

  public void camino() {
    int ind;
    if (fin != ini) {
      ind = fin.ind;
      ind = padres[ind];
      fin = tab.listaS[ind];
      if (fin == ini)
        return;
      fin.modify(6);
    }
  }

  class SquareComparator implements Comparator<Square> {
    Square fin;
    AStar as;
    public SquareComparator(Square fin, AStar as) {
      this.as = as;
      this.fin = fin;
    }
    public int compare(Square s1, Square s2) {
      if (dist(s1) < dist(s2))
        return -1;
      else if (dist(s1) == dist(s2))
        return 0;
      else
        return 1;
    }
    public double dist(Square s) {
      
      return sqrt((fin.x - s.x) * (fin.x - s.x) + (fin.y - s.y) * (fin.y - s.y));
    }
  }
}
