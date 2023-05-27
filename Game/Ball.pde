public abstract class Ball {
  PVector position;
  PVector velocity;
  PVector acceleration;
  int number;
  color ballColor;
  boolean pocketed;
  int size;
  String type;
  
  public Ball(PVector position, int number, int ballColor, int size, String type){
    this.position = position;
    this.velocity = new PVector(0,0);
    this.acceleration = new PVector(0,0);
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
  
  public void render(){
    fill(ballColor);
    circle(position.x, position.y, size);
  }
  
  public void roll(PoolTable table){
    position.add(velocity);
    velocity.add(acceleration);
    velocity.mult(table.smoothness);
    if(velocity.mag()<.1){
      velocity.setMag(0);
    }
  }
  
  public void applyForce(PVector force){
    velocity.add(force);
  }
}
