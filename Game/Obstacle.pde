public class Obstacle {
  String shape;
  PVector position;
  float strength;
  String type;
  int radius;
  color col;
  
  public Obstacle(String shape, PVector position, float strength, String type, int radius, color col){
    this.shape = shape;
    this.position = position;
    this.strength = strength; // [0,1]; the closer to 1, the more it slows the acceleration
    this.type = type;
    this.radius = radius;
    this.col = col;
  }

  public void render(){
    if(shape.equals("circle")){
      fill(col);
      circle(position.x, position.y, radius);
    }
    if(shape.equals("rect")){
      fill(col);
      rect(position.x, position.y, radius, radius);
    }
  }

}
