public class Rectangle extends Shape{
  float w, h, rot;
  
  public Rectangle(PVector position, float w, float h, float rot){
    this.position = position;
    this.w = w;
    this.h = h;
    this.rot = rot;
  }
  
  public Rectangle(PVector position, float w, float h){
    this(position, w, h, 0);
  }
  
  public boolean touching(PVector pos){
    PVector p = pos.copy().rotate(rot);
    return abs(p.x-position.x)<w && abs(p.y-position.y)<h;
  }
  
  public PVector getNormal(PVector pos){
    PVector p = pos.copy().rotate(rot);
    if(abs(p.x-position.x)/w > abs(p.y-position.y)/h){
      return new PVector(-Math.signum(p.x-position.x), 0).rotate(-rot);
    }
    else{
      return new PVector(0, -Math.signum(p.y-position.y)).rotate(-rot);
    }
  }
  
  public void render(float offset){
    translate(position.x, position.y);
    rotate(-rot);
    rect(0, 0, w+offset, h+offset);
    rotate(rot);
    translate(-position.x, -position.y);
  }
  
  public String name(){
    return "rectangle";
  }

}
