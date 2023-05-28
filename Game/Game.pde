PoolTable table;
Ball ball0, ball1, ball2, ball3, ball4, ball5, 
     ball6, ball7, ball8, ball9, ball10, 
     ball11, ball12, ball13, ball14, ball15;
Ball[] balls;
CueStick stick;

public static final PVector VISUAL_OFFSET = new PVector(200,200);

public static final color WHITE = #ffffff;
public static final color RED = #ff0000;
public static final color ORANGE = #ff9100;
public static final color YELLOW = #fff700;
public static final color GREEN = #d70a00;
public static final color BLUE = #0046d7;
public static final color PURPLE = #9b00e6;
public static final color BURGUNDY = #a55000;
public static final color BLACK = #000000;

public void setup() {
    size(400,400);
    rectMode(RADIUS);
    ellipseMode(RADIUS);
    textAlign(CENTER,CENTER);
    table = new EllipseTable(54*3, 27*3, .98);
    makeBreak(0, 0, 5);
    //ball0 = new CueBall(0, 0, 5);
    //balls = new Ball[] {ball0};
    stick = new CueStick(80);
    stick.show();
  }
  
public void draw() {
  background(255);
  
  translate(VISUAL_OFFSET.x,VISUAL_OFFSET.y);
  table.render();
  for(Ball curr : balls){
    curr.roll(table);
    curr.render();
  }
  
  stick.render(ball0);
}

public void mousePressed(){
  stick.strike(ball0);
}
  
public void makeBreak(float x, float y, int size){ // wip
  float x_off = size * sqrt(3);
  float y_off = size * 1;
  ball0  = new CueBall(   x-4*x_off, y+0*y_off, size);
  ball1  = new NormalBall(x+0*x_off, y+0*y_off, size, 1,  YELLOW,   "solid");
  ball2  = new NormalBall(x+1*x_off, y-1*y_off, size, 2,  BLUE,     "solid");
  ball3  = new NormalBall(x+1*x_off, y+1*y_off, size, 3,  RED,      "solid");
  ball4  = new NormalBall(x+2*x_off, y-2*y_off, size, 4,  PURPLE,   "solid");
  ball5  = new NormalBall(x+2*x_off, y+0*y_off, size, 5,  ORANGE,   "solid");
  ball6  = new NormalBall(x+2*x_off, y+2*y_off, size, 6,  GREEN,    "solid");
  ball7  = new NormalBall(x+3*x_off, y-3*y_off, size, 7,  BURGUNDY, "solid");
  ball8  = new EightBall( x+3*x_off, y-1*y_off, size);
  ball9  = new NormalBall(x+3*x_off, y+1*y_off, size, 9,  YELLOW,   "striped");
  ball10 = new NormalBall(x+3*x_off, y+3*y_off, size, 10, BLUE,     "striped");
  ball11 = new NormalBall(x+4*x_off, y-4*y_off, size, 11, RED,      "striped");
  ball12 = new NormalBall(x+4*x_off, y-2*y_off, size, 12, PURPLE,   "striped");
  ball13 = new NormalBall(x+4*x_off, y+0*y_off, size, 13, ORANGE,   "striped");
  ball14 = new NormalBall(x+4*x_off, y+2*y_off, size, 14, GREEN,    "striped");
  ball15 = new NormalBall(x+4*x_off, y+4*y_off, size, 15, BURGUNDY, "striped");
  balls = new Ball[] {ball0, ball1, ball2, ball3, ball4, ball5, 
                      ball6, ball7, ball8, ball9, ball10, 
                      ball11, ball12, ball13, ball14, ball15};
}
