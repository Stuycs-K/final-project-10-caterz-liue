public class Hole {
  float x, y;
  
  public Hole(float x, float y){
    this.x = x;
    this.y = y;
  }
  
  public void renderHole(){
    fill(0); noStroke();
    circle(x,y,8);
  }
}
