public class Hole {
  float x, y, size;
  
  public Hole(float x, float y, float size){
    this.x = x;
    this.y = y;
    this.size = size;
  }
  
  public Hole(PVector p, float size){
  this.x = p.x;
  this.y = p.y;
  this.size = size;
  }
  
  public void renderHole(){
    fill(0); noStroke();
    circle(x,y,size);
  }
}
