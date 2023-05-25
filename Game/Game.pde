PoolTable table;
Ball ball0, ball1, ball2, ball3, ball4, ball5, 
     ball6, ball7, ball8, ball9, ball10, 
     ball11, ball12, ball13, ball14, ball15;
Ball[] balls;

public void setup() {
    size(400,400);
    rectMode(RADIUS);
    ellipseMode(RADIUS);
    table = new PoolTable();
    //test = new CueBall(new PVector(100,100), 8);
    ball0 = new CueBall(new PVector(200,200), 0, color(255,255,255), 5);
    ball1 = new NormalBall(new PVector(50,100), 0, ball0.YELLOW, 5, "solid");
    ball2 = new NormalBall(new PVector(50,150), 0, ball0.BLUE, 5, "solid");
    ball3 = new NormalBall(new PVector(50,200), 0, ball0.RED, 5, "solid");
    ball4 = new NormalBall(new PVector(50,250), 0, ball0.PURPLE, 5, "solid");
    ball5 = new NormalBall(new PVector(50,300), 0, ball0.ORANGE, 5, "solid");
    ball6 = new NormalBall(new PVector(50,350), 0, ball0.GREEN, 5, "solid");
    ball7 = new NormalBall(new PVector(100,100), 0, ball0.BROWN, 5, "solid");
    ball8 = new EightBall(new PVector(100,150), 0, ball0.BLACK, 5);
    ball9 = new NormalBall(new PVector(100,200), 0, ball0.YELLOW, 5, "striped");
    ball10 = new NormalBall(new PVector(100,250), 0, ball0.BLUE, 5, "striped");
    ball11 = new NormalBall(new PVector(100,300), 0, ball0.RED, 5, "striped");
    ball12 = new NormalBall(new PVector(100,350), 0, ball0.PURPLE, 5, "striped");
    ball13 = new NormalBall(new PVector(150,100), 0, ball0.ORANGE, 5, "striped");
    ball14 = new NormalBall(new PVector(150,150), 0, ball0.GREEN, 5, "striped");
    ball15 = new NormalBall(new PVector(150,200), 0, ball0.BROWN, 5, "striped");
    balls = new Ball[] {ball0, ball1, ball2, ball3, ball4, ball5, 
                        ball6, ball7, ball8, ball9, ball10, 
                        ball11, ball12, ball13, ball14, ball15};
    
  }
  
public void draw() {
    background(255);

    table.renderTable(200, 200);
    for(Ball curr : balls){
      fill(curr.ballColor);
      circle(curr.position.x, curr.position.y, curr.size);
    }
  }
