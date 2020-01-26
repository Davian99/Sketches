import java.util.*;
import javafx.util.Pair; 


Tablero tab;
Random rand;
int sx = 50, sy = 50;

BFS b;
AStar as;

boolean busqueda, finbusqueda, runas, runb;
final double wallp = 0.35;

void setup() {
  size(800, 800);
  //fullScreen();
  rand = new Random();
  busqueda = false;
  finbusqueda = false;
  runas = false;
  runb = false;
  tab = new Tablero(sx, sy);
  frameRate(30);
}

void restart() {
  rand = new Random();
  tab = new Tablero(sx, sy);
  busqueda = false;
  finbusqueda = false;
  runas = false;
  runb = false;
  background(250);
}

void draw() {
  //background(250);
  tab.draw();
  if (busqueda) {
    if(runas)
      as.paso();
    else if(runb)
      b.paso();
    //delay(1000);
  }
  if (finbusqueda) {
    if(runas)
      as.camino();
    else if(runb)
      b.camino();
  }
  //saveFrame("output/frame_#####.tif");
}

void mousePressed() {
  System.out.println(mouseX  + " " + mouseY);
  if (mouseButton == LEFT)
    tab.inicioSquare(mouseX, mouseY);
  else
    tab.finSquare(mouseX, mouseY);
}

void keyPressed() {
  if (key == 'a') {
    as = new AStar(tab.listaS[tab.inicioAct], tab.listaS[tab.finAct], tab.tam, (float)width / (2*sx), (float)height / (2*sy));
    busqueda = true;
    runas = true;
  } else if (key == 'b') {
    b = new BFS(tab.listaS[tab.inicioAct], tab.listaS[tab.finAct], tab.tam, (float)width / (2*sx), (float)height / (2*sy));
    busqueda = true;
    runb = true;
  }
  if (key == ' ') {
    restart();
  }
}
