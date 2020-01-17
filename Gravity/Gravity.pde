import java.util.*; //<>//
ArrayList<Body> b;
int n = 100;
float G = 0.001;
PFont f;
float total;

void setup() {
  size(1500, 900);
  b = new ArrayList<Body>();
  for (int i = 0; i < n; ++i)
    b.add(new Body());
  /*
  Body bo = b.get(0);
   bo.mobile = false;
   bo.mass = 200000;
   bo.xpos = width/2;
   bo.ypos = height/2;
   */
  total = 0;
  for (Body bi : b)
    total += bi.mass;

  f = createFont("Arial", 60, true);
}

boolean cmp(Body a, Body b){
  return a.mass > b.mass;
}

String to_string(Body b){
  return Integer.toString(b.kills) + " " + Float.toString(b.mass);
}

void draw() {
  background(50);
  superponen();
  //lineas();
  Collections.sort(b, new Sortbyroll());
  apply();
  for (Body bo : b) {
    bo.pinta();
    bo.update();
  }
  fill(255);
  //text("Total mass: " + total, 80, 20);
  if (b.size() == 1) {
    textFont(f, 100);
    text("Victory Royale #1", width/2, height/2);
  }
  textFont(f, 40);
  text("#" + b.size(), 1400, 50);
  textFont(f, 24);
  for (int i = 0; i < 10 && i < b.size(); ++i){
    text(to_string(b.get(i)), 1400, 100 + 30* i);
  }
  //rect(1300, 700, 1400, 800);
  //delay(50);
}

void lineas() {
  for (Body bi : b) {
    for (Body bj : b) {
      if (bi != bj) {
        if (random(1.0) >= 0.9) {
          stroke(random(255), random(255), random(255));
          line(bi.xpos, bi.ypos, bj.xpos, bj.ypos);
        }
      }
    }
  }
}

float distance(Body a, Body b) {
  return sqrt(pow((a.xpos - b.xpos), 2) + pow((a.ypos - b.ypos), 2));
}

void superponen() {
  ArrayList<Body> toRemove = new ArrayList<Body>();
  for (Body bi : b) {
    for (Body bj : b) {
      if (bi != bj) {
        if (Math.hypot(bi.xpos-bj.xpos, bi.ypos-bj.ypos) < (sqrt(bi.mass)/2 + sqrt(bj.mass)/2)) {
          if (bi.mass >= bj.mass) {
            bi.mass += bj.mass;
            toRemove.add(bj);
            bi.kills += 1;
          } else {
            //bj.mass += bi.mass / 2;
            //toRemove.add(bi);
            //bj.kills += 1;
          }
        }
      }
    }
  }
  b.removeAll(toRemove);
}
void apply() {
  float fuerza;
  float xtotal = 0;
  float ytotal = 0;
  for (Body bi : b) {
    xtotal = 0;
    ytotal = 0;
    for (Body bj : b) {
      if (bi != bj) {
        fuerza = (G * bi.mass * bj.mass) / pow(distance(bi, bj), 2);
        xtotal += (bj.xpos - bi.xpos) * fuerza;
        ytotal += (bj.ypos - bi.ypos) * fuerza;
      }
    }
    bi.xacc = xtotal * (1 / bi.mass);
    bi.yacc = ytotal * (1 / bi.mass);
  }
}

float log15 (float x) {
  return (log(x) / log(1.5));
}

class Body {
  float mass;
  float xpos;
  float ypos;
  float xvel;
  float yvel;
  float xacc;
  float yacc;
  float r;
  float g;
  float b;
  int kills;
  boolean mobile;
  ArrayList<Float> history;
  int gu;

  Body() {
    mass = 200;//10 + random(500);
    xpos = random(width);
    ypos = random(height);
    xvel = random(1);
    yvel = random(1);
    xacc = random(1);
    yacc = random(1);
    r = random(255);
    b = random(255);
    g = random(255);
    mobile = true;
    kills = 0;
    gu = 0;
    history = new ArrayList<Float>();
  }

  Body(float m) {
    this();
    this.mass = m;
  }

  void update() {
    gu++;
    if (mobile) {
      xpos += xvel + xacc * 0.5;
      ypos += yvel + yacc * 0.5;
      xvel += xacc;
      yvel += yacc;
      /*
      if (xpos > width)
       xpos = width;
       if (ypos > height)
       ypos = height;
       */
      if (xpos > width || xpos < 0)
        xvel *= -1;
      if (ypos > height || ypos < 0)
        yvel *= -1;

      if (gu % 1 == 0) {
        history.add(xpos);
        history.add(ypos);
        history.add(mass);
      }
      if (history.size() == 99) {
        history.remove(0);
        history.remove(0);
        history.remove(0);
      }
    }
  }

  void pinta() {
    stroke(0);
    fill(r, g, b);
    textFont(f, 32);        
    textAlign(CENTER);
    //text(mass, xpos+sqrt(mass), ypos+sqrt(mass));
    //line(xpos, ypos, xpos + xvel*sqrt(mass), ypos + yvel*sqrt(mass));
    strokeWeight(4);
    for (int i = 0; i < history.size(); i += 3) {
      point(history.get(i), history.get(i+1));
    }
    strokeWeight(1);
    circle(xpos, ypos, sqrt(mass));
    stroke(255);
    textFont(f, 32);        
    textAlign(CENTER);
    fill(255);
    text(kills, xpos, ypos);

    //point(xpos, ypos);
  }
  
}

class Sortbyroll implements Comparator<Body> 
{ 
    // Used for sorting in ascending order of 
    // roll number 
    public int compare(Body a, Body b) 
    { 
        return (int)(b.mass - a.mass); 
    } 
} 
