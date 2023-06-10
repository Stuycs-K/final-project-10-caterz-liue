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
      if(!(number == 8 && ui.gameOver == true)){
        text(number, position.x-1, position.y+4);
      }
    }
  }

  public void roll(PoolTable table, Ball[] balls, Obstacle[] obstacles) {
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
      checkObstacles(obstacles);
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
          if(ui.firstBallHitInATurn == 16){
            ui.firstBallHitInATurn = i;
          }
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
    for(Hole pocket : pockets){
      if(position.dist(pocket.position) < pocket.size){
        pocketed = true;
      }
    }
  }
  
  public void checkObstacles(Obstacle[] obstacles){
    for(Obstacle o : obstacles){
      if(o.shape.touching(position)){
        velocity = new PVector(velocity.x * o.strength, velocity.y * o.strength);
      }
    }
  }
  
  public void fall(){
    if(size>0){
    size--;
    }else{
      if(ui.firstBallPocketedInATurn == 16){
        ui.firstBallPocketedInATurn = number;
      }
      if(number == 0){
        ui.cueballPocketedOnTurn = true;
        size = originalSize;
        pocketed = false;
        position = getMouse();
        velocity = new PVector(0, 0);
        movingCueBall = true;
      }
      if (number == 8){
          ui.check8ball(balls);
      }
      if(number!=0 && number!=8){
        balls[number] = null;
        if(type.equals("striped")){
          ui.stripedPotted = true;
        }
        if(type.equals("solid")){
          ui.solidPotted = true;
        }
        if(!ui.firstBallPocketed) {
          ui.canInitializeUI = type;
          
          // below is merged code; we'll see if this messes with anything
          //ui.firstBallPocketed = true;
          ui.players[ui.currentPlayer * 2 % 3 - 1] = type;
          ui.players[ui.currentPlayer - 1] = ui.other(type);
          
        }
      }
    }
  }
  
}
