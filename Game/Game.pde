PoolTable table;
Ball ball0, ball1, ball2, ball3, ball4, ball5,
  ball6, ball7, ball8, ball9, ball10,
  ball11, ball12, ball13, ball14, ball15;
Ball[] balls;
CueStick stick;
int messageTimer = 255;
boolean debugOn, movingCueBall, cuestickUsed;
boolean showInstructions = true;
UI ui;

public static final PVector VISUAL_OFFSET = new PVector(400, 400);


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
  size(800, 800);
  rectMode(RADIUS);
  ellipseMode(RADIUS);
  textAlign(CENTER, CENTER);
  debugOn = false;
  movingCueBall = false;

  table = new BlobTable(new PVector[] {new PVector(-180, 160), new PVector(10, 240), new PVector(100, 150), new PVector(150, -100), new PVector(-50, -200), new PVector(-240, -1)},
    new PVector[] {new PVector(-100, 200), new PVector(150, 240), new PVector(30, 0), new PVector(150, -200), new PVector(-180, -100), new PVector(-180, 80)}, .98, 15, 20);
  ball0 = new CueBall(0, 0, 10);
  makeBreak(0, 0, 10);
  ui = new UI();
  table.obstacles = new Obstacle[] {
    new Sand(0.88888, new Ellipse(new PVector(-80, -80), 40, 30)),
    new Sand(0.88888, new Rectangle(new PVector(20, 80), 30, 20)),
    new Ice(1.05, new Ellipse(new PVector(40, -60), 30, 60)),
    new Ice(1.05, new Rectangle(new PVector(-80, 80), 20, 10)),
    new Ice(1.05, new Blob(new PVector(-135, 115), new PVector[] {new PVector(-100, 100), new PVector(-150, 100), new PVector(-151, 150)}, new PVector[] {new PVector(-125, 80), new PVector(-170, 120), new PVector(-80, 120)})),
  };


  //balls = new Ball[]{ball0};
  stick = new CueStick(160, 10);
  stick.show();
}

public void keyPressed() {
  if (key==' ') {
    debugOn = !debugOn;
  }
  if (key=='x') {
    table = new EllipseTable(54*6, 27*6, .98, 15, 20, PI/9);
    makeBreak(0, 0, 10);
    ui = new UI();
    table.obstacles = new Obstacle[] {
      new Sand(0.88888, new Ellipse(new PVector(80, -80), 40, 50, -PI/5)),
      new Sand(0.88888, new Rectangle(new PVector(-80, 80), 30, 30)),
      new Ice(1.05, new Ellipse(new PVector(-80, -80), 50, 10, -PI/7)),
      new Ice(1.05, new Rectangle(new PVector(80, 80), 20, 20)),
    };
    cuestickUsed = false;
  }
  if (key=='n') {
    table = new EllipseTable(54*6, 27*6, .98, 15, 20, PI/9);
    makeBreak(0, 0, 15);
    ui = new UI();
    table.obstacles = new Obstacle[] {
      new Sand(0.88888, new Ellipse(new PVector(80, -80), 40, 50, -PI/5)),
      new Sand(0.88888, new Rectangle(new PVector(-80, 80), 30, 30)),
      new Ice(1.05, new Ellipse(new PVector(-80, -80), 50, 10, -PI/7)),
      new Ice(1.05, new Rectangle(new PVector(80, 80), 20, 20)),
    };
    cuestickUsed = false;
  }
  if (key=='c') {
    table = new RectangleTable(54*6, 27*6, .98, 15, 20, -PI/9);
    makeBreak(0, 0, 10);
    ui = new UI();
    table.obstacles = new Obstacle[] {
      new Sand(0.88888, new Ellipse(new PVector(-80, 80), 40, 40)),
      new Sand(0.88888, new Rectangle(new PVector(80, -80), 30, 30)),
      new Ice(1.05, new Ellipse(new PVector(80, 80), 30, 30)),
      new Ice(1.05, new Rectangle(new PVector(-80, -80), 20, 20)),
    };
    cuestickUsed = false;
  }
  if (key=='m') {
    table = new RectangleTable(54*6, 27*6, .98, 15, 20, -PI/9);
    makeBreak(0, 0, 15);
    ui = new UI();
    table.obstacles = new Obstacle[] {
      new Sand(0.88888, new Ellipse(new PVector(-80, 80), 40, 40)),
      new Sand(0.88888, new Rectangle(new PVector(80, -80), 30, 30)),
      new Ice(1.05, new Ellipse(new PVector(80, 80), 30, 30)),
      new Ice(1.05, new Rectangle(new PVector(-80, -80), 20, 20)),
    };
    cuestickUsed = false;
  }
  if (key=='z') {
    table = new BlobTable(new PVector[] {new PVector(-180, 160), new PVector(10, 240), new PVector(100, 150), new PVector(150, -100), new PVector(-50, -200), new PVector(-240, -1)},
      new PVector[] {new PVector(-100, 200), new PVector(150, 240), new PVector(30, 0), new PVector(150, -200), new PVector(-180, -100), new PVector(-180, 80)}, .98, 15, 20);
    makeBreak(0, 0, 10);
    ui = new UI();
    table.obstacles = new Obstacle[] {
      new Sand(0.88888, new Ellipse(new PVector(-80, -80), 40, 30)),
      new Sand(0.88888, new Rectangle(new PVector(20, 80), 30, 20)),
      new Ice(1.05, new Ellipse(new PVector(40, -60), 30, 60)),
      new Ice(1.05, new Rectangle(new PVector(-80, 80), 20, 10)),
      new Ice(1.05, new Blob(new PVector(-135, 115), new PVector[] {new PVector(-100, 100), new PVector(-150, 100), new PVector(-151, 150)}, new PVector[] {new PVector(-125, 80), new PVector(-170, 120), new PVector(-80, 120)})),
    };
    cuestickUsed = false;
  }
  if (key=='a') {
    for (int i=1; i<=7; i++) {
      balls[i] = null;
    }
    if(ui.firstBallPocketed == false){
      ui.initializeUI("solid");
    }
  }
  if (key=='s') {
    for (int i=9; i<=15; i++) {
      balls[i] = null;
    }
    if(ui.firstBallPocketed == false){
      ui.initializeUI("striped");
    }
  }
  if (key=='d') {
    ui.firstBallPocketedInATurn = 8;
    balls[8].size = 0;
    balls[8].pocketed = true;
    ui.check8ball(balls);
  }
  if (key=='i') {
    if(showInstructions == true) showInstructions = false;
    else if(showInstructions == false) showInstructions = true;
  }
}

public void draw() {
  background(BLACK);
  translate(VISUAL_OFFSET.x, VISUAL_OFFSET.y);
  table.render();
  ui.render(balls);

  for (Obstacle o : table.obstacles) {
    if (o != null) {
      o.render();
    }
  }

  boolean allStopped = true;
  for (Ball curr : balls) {
    if (curr != null) {
      if (!curr.type.equals("cue") || curr.type.equals("cue") && !movingCueBall) {
        curr.roll(table, balls, table.obstacles);
        if (curr.velocity.mag()!=0) {
          allStopped = false;
        }
      } else {
        curr.position = getMouse();
      }
      curr.render();
    }
  }

  if (!ui.gameOver && allStopped) {  // rewrite this whole thing
    if(cuestickUsed) {
      ui.messageCheck();
      if (ui.canInitializeUI != null) {
        ui.initializeUI(ui.canInitializeUI);
        ui.canInitializeUI = null;
      }
      cuestickUsed = false;
    }
  } 
  
  if(!ui.gameOver && !movingCueBall && (allStopped || debugOn)){
    stick.show();
    stick.render(table, ball0);
  }else {
    stick.hide();
  }

  if (ui.showMessage == true && ui.gameOver == false) {
    ui.displayMessage(ui.messageToDisplay, messageTimer - 1);
    messageTimer--;
    if (messageTimer == 0) {
      messageTimer = 255;
      ui.showMessage = false;
    }
  }

  if(showInstructions == true){
    fill(150);
    noStroke();
    rect(0, 0, 200, 270, 28);
    textAlign(CENTER);
    fill(WHITE);
    textSize(40);
    text("INSTRUCTIONS", 0, -220);
    textSize(20);
    text("press [i] to hide", 0, -190);
    textSize(25);
    text("--- DEBUGGING ---", 0, -140);
    textSize(15);
    if (!debugOn) {
      text("press [space] to turn on debug and allow for some\nhigh-quality unlimited cuesticking action.", 0, -110);
    } else {
      text("press [space] to turn off debug and destroy your dreams of\nhigh-quality unlimited cuesticking action.", 0, -110);
    }
    textSize(25);
    text("--- REGENERATING TABLES ---", 0, -40);
    textSize(15);
    text("[x]: elliptical table w/ normal-sized balls\n[n]: elliptical table w/ bigger balls\n[c]: rectangular table w/ normal-sized balls\n[m]: rectangular table w/ bigger balls\n[z]: blob table w/ normal-sized balls", 0, -10);
    textSize(25);
    text("--- ELIMINATING BALLS ---", 0, 140);
    textSize(15);
    text("press [a] to wipe out all solid balls\npress [s] to wipe out all striped balls\npress [d] to wipe out the eight ball", 0, 170);    
  } else {
    fill(WHITE);
    textSize(20);
    textAlign(LEFT);
    text("press [i] to toggle\ninstructions for controls", -375, -180);
  }
  //Shape test = new Blob(new PVector(-135,115), new PVector[] {new PVector(-100,100), new PVector(-150,100), new PVector(-151,150)}, new PVector[] {new PVector(-125, 80), new PVector(-170,120), new PVector(-80, 120)});
  //testVisible(table.shape);
}

public void testVisible(Shape shape) {
  stroke(BLACK);
  strokeWeight(1);
  for (int i=-400; i<400; i++) {
    for (int j=-400; j<400; j++) {
      if (shape.touching(new PVector(i, j))) {
        point(i, j);
      }
    }
  }
}


public void mouseReleased() {
  if (movingCueBall) {
    boolean valid = table.onTable(ball0.position);
    for (int i=1; i<balls.length; i++) {
      valid = valid && (balls[i]==null || ball0.position.dist(balls[i].position) > (ball0.size+balls[i].size));
    }
    for (Hole pocket : table.pockets){
      valid = valid && ball0.position.dist(pocket.position) > (ball0.size+pocket.size);
    }
    if (valid) {
      movingCueBall = false;
    }
  } else {
    cuestickUsed = true;
    stick.strike(ball0, ui);
  }
}

public void makeBreak(float x, float y, int size) { // wip
  float x_off = (size+.1) * sqrt(3);
  float y_off = (size+.1) * 1;
  ball0  = new CueBall(   x-4*x_off, y+0*y_off, size);
  ball1  = new NormalBall(x+0*x_off, y+0*y_off, size, 1, YELLOW, "solid");
  ball2  = new NormalBall(x+1*x_off, y-1*y_off, size, 2, BLUE, "solid");
  ball3  = new NormalBall(x+1*x_off, y+1*y_off, size, 3, RED, "solid");
  ball4  = new NormalBall(x+2*x_off, y-2*y_off, size, 4, PURPLE, "solid");
  ball5  = new NormalBall(x+2*x_off, y+0*y_off, size, 5, ORANGE, "solid");
  ball6  = new NormalBall(x+2*x_off, y+2*y_off, size, 6, GREEN, "solid");
  ball7  = new NormalBall(x+3*x_off, y-3*y_off, size, 7, BURGUNDY, "solid");
  ball8  = new EightBall( x+3*x_off, y-1*y_off, size);
  ball9  = new NormalBall(x+3*x_off, y+1*y_off, size, 9, YELLOW, "striped");
  ball10 = new NormalBall(x+3*x_off, y+3*y_off, size, 10, BLUE, "striped");
  ball11 = new NormalBall(x+4*x_off, y-4*y_off, size, 11, RED, "striped");
  ball12 = new NormalBall(x+4*x_off, y-2*y_off, size, 12, PURPLE, "striped");
  ball13 = new NormalBall(x+4*x_off, y+0*y_off, size, 13, ORANGE, "striped");
  ball14 = new NormalBall(x+4*x_off, y+2*y_off, size, 14, GREEN, "striped");
  ball15 = new NormalBall(x+4*x_off, y+4*y_off, size, 15, BURGUNDY, "striped");
  balls = new Ball[] {ball0, ball1, ball2, ball3, ball4, ball5,
    ball6, ball7, ball8, ball9, ball10,
    ball11, ball12, ball13, ball14, ball15};
}

public PVector getMouse() {
  return new PVector(mouseX, mouseY).sub(VISUAL_OFFSET);
}
