public class Rectangle extends Shape{
  float w, h, rot;
  
  public Rectangle(PVector position, float w, float h){
    this.position = position;
    this.w = w;
    this.h = h;
    this.rot = 0;
  }
  
  public boolean touching(PVector p){
    return abs(p.x-position.x)<w && abs(p.y-position.y)<h;
  }
  
  public PVector getNormal(PVector p){
    if(abs(p.x-position.x)/w > abs(p.y-position.y)/h){
      return new PVector(-Math.signum(p.x-position.x), 0);
    }
    else{
      return new PVector(0, -Math.signum(p.y-position.y));
    }
  }
  
  public void render(float offset){
    rect(position.x, position.y, w+offset, h+offset);
  }
  
  public String name(){
    return "rectangle";
  }

}
