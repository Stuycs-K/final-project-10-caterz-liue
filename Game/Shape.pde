public abstract class Shape{
  PVector position;
  boolean[] sides;
  
  public abstract boolean touching(PVector p);
  
  public abstract PVector getNormal(PVector p);
  
  public abstract void render(float offset);
  
  public abstract String name();

}
