PoolTable table;
Ball ball0, ball1, ball2, ball3, ball4, ball5, 
     ball6, ball7, ball8, ball9, ball10, 
     ball11, ball12, ball13, ball14, ball15;
Ball[] balls;

  public static final color WHITE = #ffffff;
  public static final color RED = #ff0000;
  public static final color ORANGE = #ff9100;
  public static final color YELLOW = #fff700;
  public static final color GREEN = #d70a00;
  public static final color BLUE = #0046d7;
  public static final color PURPLE = #9b00e6;
  public static final color BROWN = #a55000;
  public static final color BLACK = #000000;

public void setup() {
    size(400,400);
    rectMode(RADIUS);
    ellipseMode(RADIUS);
    table = new PoolTable();
    //test = new CueBall(new PVector(100,100), 8);
    ball0 = new CueBall(200, 200, 0, color(255,255,255), 5);
    ball1 = new NormalBall(50,100, 0, YELLOW, 5, "solid");
    ball2 = new NormalBall(50,150, 0, BLUE, 5, "solid");
    ball3 = new NormalBall(50,200, 0, RED, 5, "solid");
    ball4 = new NormalBall(50,250, 0, PURPLE, 5, "solid");
    ball5 = new NormalBall(50,300, 0, ORANGE, 5, "solid");
    ball6 = new NormalBall(50,350, 0, GREEN, 5, "solid");
    ball7 = new NormalBall(100,100, 0, BROWN, 5, "solid");
    ball8 = new EightBall(100,150, 0, BLACK, 5);
    ball9 = new NormalBall(100,200, 0, YELLOW, 5, "striped");
    ball10 = new NormalBall(100,250, 0, BLUE, 5, "striped");
    ball11 = new NormalBall(100,300, 0, RED, 5, "striped");
    ball12 = new NormalBall(100,350, 0, PURPLE, 5, "striped");
    ball13 = new NormalBall(150,100, 0, ORANGE, 5, "striped");
    ball14 = new NormalBall(150,150, 0, GREEN, 5, "striped");
    ball15 = new NormalBall(150,200, 0, BROWN, 5, "striped");
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
