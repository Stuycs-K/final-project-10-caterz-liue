public class Game {
  Ball test;
  
  public void setup() {
    test = new CueBall(new PVector(100,100), 2, color(123), 8);
  
  }
  
  public void draw() {
    background(255);
    fill(test.ballColor);
    renderTable();
    circle(test.position.x, test.position.y, test.size);
  }
}
