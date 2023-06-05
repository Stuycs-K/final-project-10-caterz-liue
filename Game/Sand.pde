public class Sand extends Obstacle {
  
  public Sand(String shape, PVector position, int strength, int radius){
    super(shape, position, strength, "sand", radius);
  }
  
  public void affectBalls(){
    /*
    for(Ball b: balls){
      if(//touching the ball){
        b.acceleration =  mult(b.acceleration, 1-strength);
      }
    }
    */
  }
  
  public void render(){
    if(shape.equals("circle")){
      fill(SANDCOLOR);
      circle(position.x, position.y, radius);
    }
    if(shape.equals("rect")){
      fill(SANDCOLOR);
      rect(position.x, position.y, radius, radius);
    }
  }
  
}
