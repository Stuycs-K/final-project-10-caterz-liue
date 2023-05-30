public abstract class Obstacle {
  String shape;
  PVector position;
  int strength;
  
  public Obstacle(String shape, PVector position, int strength){
    this.shape = shape;
    this.position = position;
    this.strength = strength; // [0,1]; the closer to 1, the more it slows the acceleration
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
  
  public static final color SANDCOLOR = #ffffcc;
  public static final color ICECOLOR = #33adff;

  public void render(){/*
    if(shape.equals("circle") && type.equals("sand")){
      fill(SANDCOLOR);
      circle(position.x, position.y, 20);
    }
    if(shape.equals("rect") && type.equals("sand")){
      fill(SANDCOLOR);
      rect(position.x, position.y, 20, 20);
    }
    if(shape.equals("circle") && type.equals("ice")){
      fill(ICECOLOR);
      circle(position.x, position.y, 20);
    }
    if(shape.equals("rect") && type.equals("ice")){
      fill(ICECOLOR);
      rect(position.x, position.y, 20, 20);
    }*/
  }

}
