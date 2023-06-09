public class Ice extends Obstacle {

  public Ice(float strength, Shape shape){
    super(strength, "ice", shape, ICECOLOR);
  }
  
}

public class Sand extends Obstacle {
  
  public Sand(float strength, Shape shape){
    super(strength, "sand", shape, SANDCOLOR);
  }
  
}
