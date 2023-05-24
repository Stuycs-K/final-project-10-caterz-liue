PoolTable table;
Ball test;
Ball ball0, ball1, ball2, ball3, ball4, ball5, 
     ball6, ball7, ball8, ball9, ball10, 
     ball11, ball12, ball13, ball14, ball15;

public void setup() {
    size(400,400);
    //test = new CueBall(new PVector(100,100), 8);
    ball0 = new CueBall(new PVector(50,50), 0, color(255,255,255), 10);
    ball1 = new NormalBall(new PVector(50,100), 0, ball0.YELLOW, 10, "solid");
    ball2 = new NormalBall(new PVector(50,150), 0, ball0.BLUE, 10, "solid");
    ball3 = new NormalBall(new PVector(50,200), 0, ball0.RED, 10, "solid");
    ball4 = new NormalBall(new PVector(50,250), 0, ball0.PURPLE, 10, "solid");
    ball5 = new NormalBall(new PVector(50,300), 0, ball0.ORANGE, 10, "solid");
    ball6 = new NormalBall(new PVector(50,350), 0, ball0.GREEN, 10, "solid");
    ball7 = new NormalBall(new PVector(100,100), 0, ball0.BROWN, 10, "solid");
    ball8 = new EightBall(new PVector(100,150), 0, ball0.WHITE, 10);
    ball9 = new NormalBall(new PVector(100,200), 0, ball0.YELLOW, 10, "striped");
    ball10 = new NormalBall(new PVector(100,250), 0, ball0.BLUE, 10, "striped");
    ball11 = new NormalBall(new PVector(100,300), 0, ball0.RED, 10, "striped");
    ball12 = new NormalBall(new PVector(100,350), 0, ball0.PURPLE, 10, "striped");
    ball13 = new NormalBall(new PVector(150,100), 0, ball0.ORANGE, 10, "striped");
    ball14 = new NormalBall(new PVector(150,150), 0, ball0.GREEN, 10, "striped");
    ball15 = new NormalBall(new PVector(150,200), 0, ball0.BROWN, 10, "striped");
    
    rectMode(CENTER);
    ellipseMode(CENTER);
    table = new PoolTable("rect", 300, 300);
  }
  
public void draw() {
    background(255);

    table.renderTable(200, 200);
    fill(color(255));
    circle(ball0.position.x, ball0.position.y, ball0.size);
  }
