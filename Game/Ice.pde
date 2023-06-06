public class Ice extends Obstacle {
  public static final color ICECOLOR = #33adff;

  public Ice(String shape, PVector position, float strength, int radius){
    super(shape, position, strength, "ice", radius, ICECOLOR);
  }
  
}
