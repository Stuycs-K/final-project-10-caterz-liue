public class Ellipse extends Shape{
  float w, h, rot;
  
  public Ellipse(PVector position, float w, float h, float rot){
    this.position = position;
    this.w = w;
    this.h = h;
    this.rot = rot;
  }
  
  public Ellipse(PVector position, float w, float h){
    this(position, w, h, 0);
  }
  
  public boolean touching(PVector pos){
    PVector p = pos.copy().rotate(rot);
    return pow(p.x-position.x, 2) /w/w + pow(p.y-position.y, 2) /h/h < 1;
  }
  
  public PVector getNormal(PVector pos){
    PVector p = pos.copy().rotate(rot);
    return PVector.fromAngle(atan((p.y-position.y)/(p.x-position.x) * w*w/h/h)).rotate(-rot);
  }
  
  public void render(float offset){
    translate(position.x, position.y);
    rotate(-rot);
    ellipse(0, 0, w+offset, h+offset);
    rotate(rot);
    translate(-position.x, -position.y);
  }
  
  public String name(){
    return "ellipse";
  }

}
