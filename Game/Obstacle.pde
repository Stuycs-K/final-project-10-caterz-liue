public class Obstacle {
  Shape shape;
  float strength;
  String type;
  color col;
  
  public Obstacle(float strength, String type, Shape shape, color col){
    this.shape = shape;
    this.strength = strength; // [0,1]; the closer to 1, the more it slows the acceleration
    this.type = type;
    this.col = col;
  }
  
  public Obstacle(String shapeName, PVector position, float strength, String type, float w, float h, float rot, color col){
    if(shapeName.equals("ellipse")){
      shape = new Ellipse(position, w, h);
    }
    if(shapeName.equals("rectangle")){
      shape = new Rectangle(position, w, h);
    }
    
    this.strength = strength; // [0,1]; the closer to 1, the more it slows the acceleration
    this.type = type;
    this.col = col;
  }
  
  public Obstacle(String shapeName, PVector position, float strength, String type, PVector[] joins, PVector[] controls, color col){
    if(shapeName.equals("blob")){
      shape = new Blob(position, joins, controls);
    }
    
    this.strength = strength; // [0,1]; the closer to 1, the more it slows the acceleration
    this.type = type;
    this.col = col;
  }

  public void render(){
    fill(col);
    noStroke();
    shape.render(0);
  }

}
