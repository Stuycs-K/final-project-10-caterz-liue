public class Ellipse extends Shape{
  float w, h, rot;
  
  public Ellipse(PVector position, float w, float h){
    this.position = position;
    this.w = w;
    this.h = h;
    this.rot = 0;
  }
  
  public boolean touching(PVector p){
    return pow(p.x-position.x, 2) /w/w + pow(p.y-position.y, 2) /h/h < 1;
  }
  
  public PVector getNormal(PVector p){
    return PVector.fromAngle(atan((p.y-position.y)/(p.x-position.x) * w*w/h/h));
  }
  
  public void render(float offset){
    ellipse(position.x, position.y, w+offset, h+offset);
  }
  
  public String name(){
    return "ellipse";
  }

}
