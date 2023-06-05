public class Ice extends Obstacle {
  public Ice(String shape, PVector position, float strength, int radius){
    super(shape, position, strength, "ice", radius);
  }
  
  public void affectBalls(){
    /*
    for(Ball b: balls){
      if(//touching the ball){
        b.acceleration =  mult(b.acceleration, 2*strength);
      }
    }
    */
  }
  
  public void render(){
    if(shape.equals("circle")){
      fill(ICECOLOR);
      circle(position.x, position.y, radius);
    }
    if(shape.equals("rect")){
      fill(ICECOLOR);
      rect(position.x, position.y, radius, radius);
    }
  }
}
