PoolTable table;
Ball test;

public void setup() {
    size(400,400);
    test = new CueBall(new PVector(100,100), 8);
    table = new PoolTable(300, 300);
  }
  
public void draw() {
    background(255);
    fill(test.ballColor);
    table.renderTable();
    circle(test.position.x, test.position.y, test.size);
  }
