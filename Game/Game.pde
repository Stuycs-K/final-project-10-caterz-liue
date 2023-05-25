PoolTable table;
Ball test;

public void setup() {
    size(400,400);
    rectMode(RADIUS);
    ellipseMode(RADIUS);
    test = new CueBall(new PVector(200,200), 8);
    table = new PoolTable("ellipse", 54*3, 27*3);
  }
  
public void draw() {
    background(255);
    fill(test.ballColor);
    table.renderTable(200, 200);
    fill(color(255));
    circle(test.position.x, test.position.y, test.size);
  }
