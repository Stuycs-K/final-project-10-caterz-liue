public abstract class Ball {
  PVector position;
  PVector velocity;
  int number;
  color ballColor;
  boolean pocketed;
  float size;
  float originalSize;
  int weight;
  String type;

  public Ball(PVector position, float size, int number, color ballColor, String type) {
    this.position = position;
    this.velocity = new PVector(0, 0);
    this.number = number;
    this.ballColor = ballColor;
    this.pocketed = false;
    this.size = size;
    this.originalSize = size;
    this.weight = 1;
    this.type = type;
  }

  public Ball(float x, float y, float size, int number, color ballColor, String type) {
    this(new PVector(x, y), size, number, ballColor, type);
  }

  public void render() {
    fill(ballColor);
    noStroke();
    circle(position.x, position.y, size);
    fill(WHITE);
    if (number!=0) {
      if(type.equals("striped")){
        arc(position.x, position.y, size, size,     asin(2./3), PI-asin(2./3), CHORD);
        arc(position.x, position.y, size, size, -PI+asin(2./3),   -asin(2./3), CHORD);
      }else{
        circle(position.x, position.y, size*2/3);
      }
      fill(BLACK);
      textSize(size*1.5);
      textAlign(CENTER);
      text(number, position.x-1, position.y+4);
    }
  }

  public void roll(PoolTable table, Ball[] balls) {
    if(!pocketed){
      PVector nextSpot = PVector.add(position, velocity);
      boolean everHit = bounceCushion(table, nextSpot) | bounceAmong(balls, nextSpot);
      position.add(velocity);
      if(!everHit){
        velocity.mult(table.smoothness);
        if(velocity.mag()<.1){
          velocity.setMag(0);
        }
      }
      checkPockets(table.pockets);
    }
    if(pocketed){
      fall();
    }
  }

  public boolean bounceCushion(PoolTable table, PVector nextSpot) {
    if (!table.onTable(nextSpot)) {
      float angle = PVector.mult(velocity, -1).heading() - table.inwardsFromWall(nextSpot).heading(); // angleBetween() doesn't give the sign
      velocity.rotate(PI - angle*2); // could all be simplified but this actually makes sense
      return true;
    }
    return false;
  }

  public boolean bounceAmong(Ball[] balls, PVector nextSpot) {
    boolean hitSomething = false;
    for (int i = number+1; i < balls.length; i++) {
      if (balls[i] != null) {
        Ball other = balls[i];
        if (nextSpot.dist(PVector.add(other.position, other.velocity)) < size+other.size) {
          hitSomething = true;
          // https://www.gamedeveloper.com/programming/pool-hall-lessons-fast-accurate-collision-detection-between-circles-or-spheres
          PVector dir = PVector.sub(position, other.position).normalize();
          float momentumChange = 2 * (dir.dot(velocity) - dir.dot(other.velocity)) / (weight + other.weight);
          velocity.sub(PVector.mult(dir, momentumChange));
          other.velocity.add(PVector.mult(dir, momentumChange));
        }
      }
    }
    return hitSomething;
  }

  public void applyForce(PVector force) {
    velocity.add(force);
  }
  
  public void checkPockets(Hole[] pockets){
    for(Hole h : pockets){
      if(position.dist(new PVector(h.x, h.y)) < h.size){
        pocketed = true;
      }
    }
  }
  
  public void checkObstacles(Obstacle[] obstacles){
    for(Obstacle o : obstacles){
      if(o.type.equals("sand")){ // sand
        if(position.dist(new PVector(o.position.x, o.position.y)) < o.radius){
          velocity.add(new PVector(-2,-2));
        }
      } else { // ice
        if(position.dist(new PVector(o.position.x, o.position.y)) < o.radius){
          velocity.add(new PVector(2,2));
        }
      }
    }
  }
  
  public void fall(){
    if(size>0){
    size--;
    }else{
      if(number == 0){
        size = originalSize;
        pocketed = false;
        if(!ui.firstBallPocketed){ // if needs to be rebroken
          position = new PVector(-4 * (size+1) * sqrt(3), 0);
        }else{
          position = new PVector(0, 0);
        }
        velocity = new PVector(0, 0); 
      }
      if (number == 8){
        ui.check8ball(balls);
      }
      if(number!=0 && number!=8){
        balls[number] = null;
        if(type.equals("striped")){
          ui.stripePotted = true;
        }
        if(type.equals("solid")){
          ui.solidPotted = true;
        }
        if(!ui.firstBallPocketed) {
          ui.firstBallPocketed = true;
          if(ui.currentPlayer == 1){
            ui.player1 = type;
            ui.player2 = ui.other(type);
          }else{
            ui.player1 = ui.other(type);
            ui.player2 = type;
          }
          System.out.println(ui.player1 + " " + ui.player2);
        }
      }
    }
  }
  
}
