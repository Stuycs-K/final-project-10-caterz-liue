public class Hole {
  float x, y;
  
  public Hole(float x, float y){
    this.x = x;
    this.y = y;
  }
  
  public void renderHole(float tableX, float tableY){
    fill(0); noStroke();
    circle(tableX+x,tableY+y,8);
  }
}
