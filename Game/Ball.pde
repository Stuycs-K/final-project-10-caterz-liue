public abstract class Ball {
  PVector position;
  PVector velocity;
  PVector acceleration;
  int number;
  color ballColor;
  boolean pocketed;
  int size;
  String type;
  
  color WHITE = color(255,255,255);
  color RED = color(255,0,0);
  color ORANGE = color(255,145,0);
  color YELLOW = color(255,247,0);
  color GREEN = color(215,10,0);
  color BLUE = color(0,70,215);
  color PURPLE = color(155,0,230);
  color BROWN = color(165,80,0);
  color BLACK = color(0,0,0);
  
  public Ball(PVector position, int number, int ballColor, int size, String type){
    this.position = position;
    this.velocity = new PVector(0,0,0);
    this.acceleration = new PVector(0,0,0);
    this.number = number;
    this.ballColor = ballColor;
    this.pocketed = false;
    this.size = size;
    this.type = type;
  }
  
  public Ball(float x, float y, int number, int ballColor, int size, String type){
    this(new PVector(x,y), number, ballColor, size, type);
  }
  
  public Ball(){
  }
}
