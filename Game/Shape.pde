public abstract class Shape{
  PVector position;
  boolean[] sides, convexes;
  
  public abstract boolean touching(PVector p);
  
  public abstract PVector getNormal(PVector p);
  
  public abstract void render(float offset);
  
  public void renderOutline(float offset){
    render(offset);
  }
  
  public PVector doBezier(int a, float b){return null;}
  
  
  public abstract String name();
}
