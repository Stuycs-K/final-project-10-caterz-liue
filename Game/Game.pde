PoolTable table;
Ball ball0, ball1, ball2, ball3, ball4, ball5, 
     ball6, ball7, ball8, ball9, ball10, 
     ball11, ball12, ball13, ball14, ball15;
Ball[] balls;
CueStick stick;
boolean debugOn;
UI ui;

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
public static final color TABLE_GREEN = #0a6c03;
public static final color BORDER_BROWN = #966F33;
public static final color SANDCOLOR = #ffffcc;
public static final color ICECOLOR = #33adff;


public void setup() {
    size(800,800);
    rectMode(RADIUS);
    ellipseMode(RADIUS);
    textAlign(CENTER,CENTER);
    debugOn = false;
    
    table = new BlobTable(new PVector[] {new PVector(-180,160), new PVector(10,240),  new PVector(100,150), new PVector(150,-100), new PVector(-50,-200),  new PVector(-240,-1)}, 
                          new PVector[] {new PVector(-100,200), new PVector(150,240), new PVector(30,0),    new PVector(150,-200), new PVector(-180,-100), new PVector(-180,80)}, .98, 15, 20);
    table.obstacles = new Obstacle[] {
      new Sand(0.99999, new Ellipse(new PVector(-80,-80), 40, 30)),
      new Sand(0.77777, new Rectangle(new PVector(20,80), 30, 20)),
      new Ice(1.05, new Ellipse(new PVector(40,-60), 30, 60)),
      new Ice(1.05, new Rectangle(new PVector(-80,80), 20, 10)),
      new Ice(1.05, new Blob(new PVector(-135,115), new PVector[] {new PVector(-100,100), new PVector(-150,100), new PVector(-151,150)}, new PVector[] {new PVector(-125, 80), new PVector(-170,120), new PVector(-80, 120)})),
    };
    ui = new UI();
    //makeBreak(0, 0, 10);
    ball0 = new NormalBall(0, 0, 10, 0, BLUE, "solid");
    balls = new Ball[]{ball0};
    stick = new CueStick(160, 10);
    stick.show();
  }
  
public void keyPressed(){
  if(key==' '){
    debugOn = !debugOn;
  }
  if(key=='x'){
    table = new EllipseTable(54*6, 27*6, .98, 15, 20, PI/9);
    makeBreak(0, 0, 10);
    ui = new UI();
    table.obstacles = new Obstacle[] {
      new Sand(0.99999, new Ellipse(new PVector(80,-80), 40, 50, -PI/5)),
      new Sand(0.77777, new Rectangle(new PVector(-80,80), 30, 30)),
      new Ice(1.05, new Ellipse(new PVector(-80,-80), 50, 10, -PI/7)),
      new Ice(1.05, new Rectangle(new PVector(80,80), 20, 20)),
    };
  }
  if(key=='c'){
    table = new RectangleTable(54*6, 27*6, .98, 15, 20, -PI/9);
    makeBreak(0, 0, 10);
    ui = new UI();
    table.obstacles = new Obstacle[] {
      new Sand(0.99999, new Ellipse(new PVector(-80,80), 40, 40)),
      new Sand(0.77777, new Rectangle(new PVector(80,-80), 30, 30)),
      new Ice(1.05, new Ellipse(new PVector(80,80), 30, 30)),
      new Ice(1.05, new Rectangle(new PVector(-80,-80), 20, 20)),
    };
  }
  if(key=='z'){
    table = new BlobTable(new PVector[] {new PVector(-180,160), new PVector(10,240),  new PVector(100,150), new PVector(150,-100), new PVector(-50,-200),  new PVector(-240,-1)}, 
                          new PVector[] {new PVector(-100,200), new PVector(150,240), new PVector(30,0),    new PVector(150,-200), new PVector(-180,-100), new PVector(-180,80)}, .98, 15, 20);
    makeBreak(0, 0, 10);
    ui = new UI();
    table.obstacles = new Obstacle[] {
      new Sand(0.99999, new Ellipse(new PVector(-80,-80), 40, 30)),
      new Sand(0.77777, new Rectangle(new PVector(20,80), 30, 20)),
      new Ice(1.05, new Ellipse(new PVector(40,-60), 30, 60)),
      new Ice(1.05, new Rectangle(new PVector(-80,80), 20, 10)),
      new Ice(1.05, new Blob(new PVector(-135,115), new PVector[] {new PVector(-100,100), new PVector(-150,100), new PVector(-151,150)}, new PVector[] {new PVector(-125, 80), new PVector(-170,120), new PVector(-80, 120)})),
    };
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
  background(BLACK);
  textAlign(CENTER);
  PVector mouse = new PVector(mouseX, mouseY).sub(VISUAL_OFFSET);
  fill(YELLOW); textSize(12);
  if(!debugOn){
    text("press [space] to turn on debug and allow for some\nhigh-quality unlimited cuesticking action.", width/2, textAscent());
  }else{
    text("press [space] to turn off debug and destroy your dreams of\nhigh-quality unlimited cuesticking action.", width/2, textAscent());
  }
  text("press [x] to regenerate elliptical table\npress [c] to regenerate rectangular table\npress [z] to regenerate blob table", width/2, textAscent()*5);
  text("press [a] to wipe out all solid balls\npress [s] to wipe out all striped balls\npress [d] to wipe out the eight ball", width/2, textAscent()*11);
  
  translate(VISUAL_OFFSET.x,VISUAL_OFFSET.y);
  table.render();
  ui.render(balls);
    
  for(Obstacle o : table.obstacles){
    if(o != null){
      o.render();
    }
  }
  
  boolean allStopped = true;
  for(Ball curr : balls){
    if(curr != null){
      curr.roll(table, balls, table.obstacles);
      curr.render();
      stroke(BLACK);
      //line(100,-100, 100+table.inwardsFromWall(mouse).x*100, -100+table.inwardsFromWall(mouse).y*100);
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
    fill(WHITE);
    textSize(60);
    text("PLAYER " + ui.currentPlayer + " WINS!", 0, -VISUAL_OFFSET.y/2);
  }
  
  //Shape test = new Blob(new PVector(-135,115), new PVector[] {new PVector(-100,100), new PVector(-150,100), new PVector(-151,150)}, new PVector[] {new PVector(-125, 80), new PVector(-170,120), new PVector(-80, 120)});
  //testVisible(table.shape);
}

public void testVisible(Shape shape){
  stroke(BLACK); strokeWeight(1);
  for(int i=-400; i<400; i++){
    for(int j=-400; j<400; j++){
      if(shape.touching(new PVector(i,j))){
        point(i,j);
      }
    }
  }
}


public void mouseReleased(){
  stick.strike(ball0, ui);
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
