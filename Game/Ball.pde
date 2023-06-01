public abstract class Ball {
  PVector position;
  PVector velocity;
  PVector acceleration;
  int number;
  color ballColor;
  boolean pocketed;
  int size;
  int originalSize;
  int weight;
  String type;

  public Ball(PVector position, int size, int number, color ballColor, String type) {
    this.position = position;
    this.velocity = new PVector(0, 0);
    this.acceleration = new PVector(0, 0);
    this.number = number;
    this.ballColor = ballColor;
    this.pocketed = false;
    this.size = size;
    originalSize = size;
    this.weight = 1;
    this.type = type;
  }

  public Ball(float x, float y, int size, int number, color ballColor, String type) {
    this(new PVector(x, y), size, number, ballColor, type);
  }

  public Ball() {
  }

  public void render(Hole[] pockets, UI ui) {
    fill(ballColor);
    circle(position.x, position.y, size);
    fill(255);
    if (number != 0) {
      circle(position.x, position.y, size / 2);
      fill(0);
      textSize(size*2);
      text(number, position.x, position.y);
    }
    checkSurroundings(pockets, ui);
    if (debugOn) {
      fill(0);
      textSize(size*2);
      text(number, position.x, position.y);
    }
  }

  public void roll(PoolTable table, Ball[] balls) {
    PVector nextSpot = PVector.add(position, velocity);
    boolean everHit = bounceCushion(table, nextSpot) | bounceAmong(balls, nextSpot);
    position.add(velocity);
    if (!everHit) {
      velocity.mult(table.smoothness);
      if (velocity.mag()<.1) {
        velocity.setMag(0);
      }
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

    for (int i = number+1; i <= 15; i++) {
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

  public void checkSurroundings(Hole[] pockets, UI ui) {
    for (Hole h : pockets) {
      if (pocketed == true) {
        if (size > 0) {
          size--;
        } else {
          if (size == 0) {
            if (number == 0) {
              size = originalSize;
              position = new PVector(0, 0);
              velocity = new PVector(0, 0);
            } else {
              if (ui.firstBallPocketed == false) {
                System.out.println("test");
                ui.firstBallPocketed = true;
                if (ui.currentPlayer == 1) {
                  ui.player1 = type;
                  if (type.equals("solid")) {
                    ui.player2 = "striped";
                  }
                  if (type.equals("striped")) {
                    ui.player2 = "solid";
                  }
                } else {
                  ui.player2 = type;
                  if (type.equals("solid")) {
                    ui.player1 = "striped";
                  }
                  if (type.equals("striped")) {
                    ui.player1 = "solid";
                  }
                }
                System.out.println(ui.player1 + " " + ui.player2);
              }
              balls[number] = null;
              if (number == 8) {
                //Game.ui.check8ball();
              }
            }
          }
        }
      }
      if (position.dist(new PVector(h.x, h.y)) < 10) {
        pocketed = true;
      }
    }
  }
}
