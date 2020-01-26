public class BFS { //<>//
  Queue<Square> q;
  Square ini, fin;
  int tam;
  int[] arr, padres;
  float sumx, sumy;

  public BFS(Square ini, Square f, int tam, float sumx, float sumy) {
    this.ini = ini;
    this.fin = f;
    this.sumx = sumx;
    this.sumy = sumy;
    q = new LinkedList<Square>();
    q.add(ini);
    this.tam = tam;
    arr = new int[tam];
    padres = new int[tam];
    for (int i = 0; i < tam; ++i)
      arr[i] = (int)1e9;
    arr[tab.getSquareInd(ini.x, ini.y)] = 0;
  }
  public void paso() {
    if (q.size() == 0) {
      return;
    }
    int dini = arr[q.peek().ind];
    while (q.size() > 0) {
      Square act = q.peek();
      int ind, padre = act.ind, dp = arr[padre];
      if (dp > dini)
        return;
      q.remove();
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
  }

  public void add(int d, int padre, int ind) {
    if (ind >= 0 && ind < tam && arr[ind] == (int)1e9 && tab.listaS[ind] != null && tab.listaS[ind].state != 2) {
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
      q.add(s);
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
}
