/*
CHANGES MADE TO THIS FILE:
- added this comment
- makeObstacles(); in setup
- makeObstacles method
*/

PoolTable table;
Ball ball0, ball1, ball2, ball3, ball4, ball5, 
     ball6, ball7, ball8, ball9, ball10, 
     ball11, ball12, ball13, ball14, ball15;
Ball[] balls;
CueStick stick;
boolean debugOn;
UI ui = new UI();

public static final PVector VISUAL_OFFSET = new PVector(400,400);

public static final color WHITE = #ffffff;
public static final color RED = #ff0000;
public static final color ORANGE = #ff9100;
public static final color YELLOW = #fff700;
public static final color GREEN = #00cc00;
public static final color BLUE = #0046d7;
public static final color PURPLE = #9b00e6;
public static final color BURGUNDY = #a55000;
public static final color BLACK = #000000;
public static final color BROWN = #664c28; // cue stick

public void setup() {
    size(800,800);
    rectMode(RADIUS);
    ellipseMode(RADIUS);
    textAlign(CENTER,CENTER);
    debugOn = false;
    
    table = new BlobTable(54*6, 27*6, .98, 10, 20);
    //makeBreak(0, 0, 10);
    ball0 = new NormalBall(0, 0, 10, 1, BLUE, "solid");
    balls = new Ball[]{ball0};
    stick = new CueStick(160, 10);
    stick.show();
    makeObstacles();
  }
  
public void keyPressed(){
  if(key==' '){
    debugOn = !debugOn;
  }
  if(key=='x'){
    table = new EllipseTable(54*6, 27*6, .98, 10, 20);
    makeBreak(0, 0, 10);
    ui = new UI();
  }
  if(key=='c'){
    table = new RectangleTable(54*6, 27*6, .98, 10, 20);
    makeBreak(0, 0, 10);
    ui = new UI();
  }
  if(key=='z'){
    table = new BlobTable(54*6, 27*6, .98, 10, 20);
    makeBreak(0, 0, 10);
  }
  if(key=='a'){
    for(int i=1; i<=7; i++){
      balls[i] = null;
    }
  }
  if(key=='s'){
    for(int i=9; i<=15; i++){
      balls[i] = null;
    }
  }
  if(key=='d'){
    balls[8] = null;
    ui.check8ball(balls);
  }
}
  
public void draw() {
  background(255);
  textAlign(CENTER);
  fill(BROWN); textSize(12);
  if(!debugOn){
    text("press [space] to turn on debug and allow for some\nhigh-quality unlimited cuesticking action.", width/2, textAscent());
  }else{
    text("press [space] to turn off debug and destroy your dreams of\nhigh-quality unlimited cuesticking action.", width/2, textAscent());
  }
  text("press [x] to regenerate elliptical table\npress [c] to regenerate rectangular table", width/2, textAscent()*5);
  text("press [a] to wipe out all solid balls\npress [s] to wipe out all striped balls\npress [d] to wipe out the eight ball", width/2, textAscent()*9);
  
  translate(VISUAL_OFFSET.x,VISUAL_OFFSET.y);
  table.render();
  ui.render(balls);
  
  boolean allStopped = true;
  for(Ball curr : balls){
    if(curr != null){
      curr.roll(table, balls);
      curr.render(table.pockets, ui);
      if(curr.velocity.mag()!=0){
        allStopped = false;
      }
    }
  }
  
  if(!ui.gameOver && (allStopped || debugOn)){
    stick.show();
    stick.render(table, ball0);
    if(!ui.stripePotted && !ui.stripePotted || // i hate this
       ui.currentPlayer==1 && ui.player1.equals("striped") && !ui.stripePotted ||
//       ui.currentPlayer==1 && ui.player1.equals("striped") && ui.solidPotted ||
       ui.currentPlayer==1 && ui.player1.equals("solid") && !ui.solidPotted ||
//       ui.currentPlayer==1 && ui.player1.equals("solid") && ui.stripePotted ||
       ui.currentPlayer==2 && ui.player2.equals("striped") && !ui.stripePotted ||
//       ui.currentPlayer==2 && ui.player2.equals("striped") && ui.solidPotted ||
       ui.currentPlayer==2 && ui.player2.equals("solid") && !ui.solidPotted){
//       ui.currentPlayer==2 && ui.player2.equals("solid") && ui.stripePotted){
      ui.nextTurn();
      ui.stripePotted = true;
      ui.solidPotted = true;
    }
  }else{
    stick.hide();
  }
  
  if(ui.gameOver){
    fill(0);
    textSize(60);
    text("PLAYER " + ui.currentPlayer + " WINS!", 0, -VISUAL_OFFSET.y/2);
  }
    
}

public void mouseReleased(){
  stick.strike(ball0, ui, balls);
}
  
public void makeBreak(float x, float y, int size){ // wip
  float x_off = (size+.1) * sqrt(3);
  float y_off = (size+.1) * 1;
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

public void makeObstacles(){
  
}
