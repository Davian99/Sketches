public class Tablero {
  int ancho, alto;
  int inicioAct;
  int finAct;
  int tam;
  float x, y;
  Square[] listaS;
  public Tablero(float ancho, float alto) {
    this.x = width / ancho;
    this.y = height / alto;
    this.ancho = (int)ancho;
    this.alto = (int)alto;
    this.inicioAct = -1;
    this.finAct = -1;
    this.tam = (int)(ancho * alto + 1);
    listaS = new Square[tam];
    createTablero();
  }

  public void createTablero() {
    int k = 0;
    for (float i = 0; i < width; i += x) {
      for (float j = 0; j < height; j += y) {
        double prob = rand.nextDouble();
        int state = prob < wallp ? 2 : 1;
        listaS[k] = new Square(i, j, state, k);
        k++;
      }
    }
  }

  public void draw() {
    for (Square s : listaS) {
      if (s == null || !s.change)
        continue;
      s.draw(x, y);
    }
  }

  public int getSquareInd(float px, float py) {
    if (px < 0 || py < 0 || px >= width || py >= height)
      return -1;
    float casX = px / x, casY = py / y;
    int ind = alto * (int)(casX) + (int)(casY);

    return ind;
  }

  public void inicioSquare(float px, float py) {
    int ind = getSquareInd(px, py);
    listaS[ind].modify(4);
    if (inicioAct != -1)
      listaS[inicioAct].modify(1);
    inicioAct = ind;
  }

  public void inicioSquare(int ind) {
    listaS[ind].modify(4);
    if (inicioAct != -1)
      listaS[inicioAct].modify(1);
    inicioAct = ind;
  }

  public void finSquare(float px, float py) {
    int ind = getSquareInd(px, py);
    listaS[ind].modify(3);
    if (finAct != -1)
      listaS[finAct].modify(1);
    finAct = ind;
  }

  public void finSquare(int ind) {
    listaS[ind].modify(3);
    if (finAct != -1)
      listaS[finAct].modify(1);
    finAct = ind;
  }
}
