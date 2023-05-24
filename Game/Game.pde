PoolTable table;
Ball test;
Ball ball0, ball1, ball2, ball3, ball4, ball5, 
     ball6, ball7, ball8, ball9, ball10, 
     ball11, ball12, ball13, ball14, ball15;

public void setup() {
    size(400,400);
    //test = new CueBall(new PVector(100,100), 8);
    ball0 = new CueBall(new PVector(50,50), 0, color(255,255,255), 10);
    ball1 = new NormalBall(new PVector(50,100), 0, ball0.WHITE, 10);
    ball2 = new NormalBall(new PVector(50,150), 0, ball0.WHITE, 10);
    ball3 = new NormalBall(new PVector(50,200), 0, ball0.WHITE, 10);
    ball4 = new NormalBall(new PVector(50,250), 0, ball0.WHITE, 10);
    ball5 = new NormalBall(new PVector(50,300), 0, ball0.WHITE, 10);
    ball6 = new NormalBall(new PVector(50,350), 0, ball0.WHITE, 10);
    ball7 = new NormalBall(new PVector(100,100), 0, ball0.WHITE, 10);
    ball8 = new EightBall(new PVector(100,150), 0, ball0.WHITE, 10);
    ball9 = new NormalBall(new PVector(100,200), 0, ball0.WHITE, 10);
    ball10 = new NormalBall(new PVector(100,250), 0, ball0.WHITE, 10);
    ball11 = new NormalBall(new PVector(100,300), 0, ball0.WHITE, 10);
    ball12 = new NormalBall(new PVector(100,350), 0, ball0.WHITE, 10);
    ball13 = new NormalBall(new PVector(150,100), 0, ball0.WHITE, 10);
    ball14 = new NormalBall(new PVector(150,150), 0, ball0.WHITE, 10);
    ball15 = new NormalBall(new PVector(150,200), 0, ball0.WHITE, 10);
    
    table = new PoolTable(350, 175);
  }
  
public void draw() {
    background(255);
    fill(test.ballColor);
    table.renderTable();
    circle(test.position.x, test.position.y, test.size);
  }
