Ball test;

public void setup() {
    size(300,300);
    test = new CueBall(new PVector(100,100), 8);
  
  }
  
public void draw() {
    background(255);
    fill(test.ballColor);
    circle(test.position.x, test.position.y, test.size);
  }
