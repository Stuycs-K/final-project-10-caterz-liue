public class Ice extends Obstacle {

  public Ice(String shape, PVector position, float strength, float w, float h){
    super(shape, position, strength, "ice", w, h, 0, ICECOLOR);
  }
  
  public Ice(String shape, PVector position, float strength, PVector[] joins, PVector[] controls){
    super(shape, position, strength, "ice", joins, controls, ICECOLOR);
  }
  
  public Ice(String shape, PVector position, float strength, int radius){
    super(shape, position, strength, "ice", radius, radius, 0, ICECOLOR);
  }
  
}
