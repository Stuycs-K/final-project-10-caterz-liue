public class Sand extends Obstacle {
  public static final color SANDCOLOR = #ffffcc;
  
  public Sand(String shape, PVector position, float strength, int radius){
    super(shape, position, strength, "sand", radius, SANDCOLOR);
  }
  
}
