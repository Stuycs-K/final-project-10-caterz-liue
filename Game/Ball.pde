public abstract class Ball {
  PVector position;
  PVector velocity;
  PVector acceleration;
  int number;
  color ballColor;
  boolean pocketed;
  int size;
  String type;
  
  public Ball(PVector position, int size, int number, color ballColor, String type){
    this.position = position;
    this.velocity = new PVector(0,0);
    this.acceleration = new PVector(0,0);
    this.number = number;
    this.ballColor = ballColor;
    this.pocketed = false;
    this.size = size;
    this.type = type;
  }
  
  public Ball(float x, float y, int size, int number, color ballColor, String type){
    this(new PVector(x,y), size, number, ballColor, type);
  }
  
  public Ball(){
  }
  
  public void render(){
    fill(ballColor);
    circle(position.x, position.y, size);
    //fill(0); textSize(size*2);
    //text(number, position.x, position.y);
  }
  
  public void roll(PoolTable table, Ball[] balls){
    position.add(velocity);
    velocity.add(acceleration);
    velocity.mult(table.smoothness);
    if(velocity.mag()<.1){
      velocity.setMag(0);
    }
    
    boolean hitSomething = false;
    PVector safeSpot = PVector.sub(position,velocity);
    
    if(!table.onTable(position)){
      hitSomething = true;
      float angle = PVector.mult(velocity,-1).heading() - table.inwardsFromWall(safeSpot).heading(); // angleBetween() doesn't give the sign 
      velocity.rotate(PI - angle*2); // could all be simpplified but this actually makes sense
    }
    
    for(Ball other : balls){
      if(other!=this){
        if(position.dist(other.position)<size*2){
          //System.out.println(other.number + " and " + number + " are touching");
          hitSomething = true;
          
          PVector temp = velocity;
          velocity = other.velocity;
          other.velocity = temp;
          
        }
      }
    }
    
    if(hitSomething){
      position = safeSpot;
    }
  }
  
  public void applyForce(PVector force){
    velocity.add(force);
  }
}
