public class Sand extends Obstacle {
  public static final color SANDCOLOR = #ffffcc;
  
  public Sand(String shape, PVector position, float strength, float w, float h){
    super(shape, position, strength, "sand", w, h, 0, SANDCOLOR);
  }
  
  public Sand(String shape, PVector position, float strength, int radius){
    super(shape, position, strength, "sand", radius, radius, 0, SANDCOLOR);
  }
  
}
