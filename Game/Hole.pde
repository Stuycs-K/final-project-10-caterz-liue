public class Hole {
  PVector position;
  float size;
  int number;
  
  public Hole(float x, float y, float size, int number){
    this.position = new PVector(x,y);
    this.size = size;
    this.number = number;
  }
  
  public Hole(PVector position, float size, int number){
    this.position = position;
    this.size = size;
    this.number = number;
  }
  
  public void renderHole(){
    fill(BLACK); noStroke();
    circle(position.x,position.y,size);
  }
}
