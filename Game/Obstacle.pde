public class Obstacle {
  Shape shape;
  float strength;
  String type;
  color col;
  
  public Obstacle(float strength, String type, Shape shape, color col){
    this.shape = shape;
    this.strength = strength; // multiplies velocity
    this.type = type;
    this.col = col;
  }

  public void render(){
    fill(col);
    noStroke();
    shape.render(0);
  }

}
