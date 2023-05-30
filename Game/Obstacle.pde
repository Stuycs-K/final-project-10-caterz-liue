public abstract class Obstacle {
  String shape;
  PVector position;
  int strength;
  String type;
  
  public Obstacle(String shape, PVector position, int strength, String type){
    this.shape = shape;
    this.position = position;
    this.strength = strength; // [0,1]; the closer to 1, the more it slows the acceleration
    this.type = type;
  }

  public void affectBalls(){
    /*
    for(Ball b: balls){
      if(//touching the ball){
        if(type.equals("sand")){ b.acceleration =  mult(b.acceleration, 1-strength);}
        if(type.equals("ice")){ b.acceleration = mult(b.acceleration, strength); }
      }
    }
    */
  }


}
