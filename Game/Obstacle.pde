public class Obstacle {
  String shape;
  PVector position;
  float strength;
  String type;
  float w, h, rot; // w and h are the semimajor and semiminor axes
  color col;
  
  public Obstacle(String shape, PVector position, float strength, String type, float w, float h, float rot, color col){
    this.shape = shape;
    this.position = position;
    this.strength = strength; // [0,1]; the closer to 1, the more it slows the acceleration
    this.type = type;
    this.w = w;
    this.h = h;
    this.rot = rot;
    this.col = col;
  }

  public void render(){
    if(shape.equals("ellipse")){
      fill(col);
      ellipse(position.x, position.y, w, h);
    }
    if(shape.equals("rect")){
      fill(col);
      rect(position.x, position.y, w, h);
    }
  }

}
