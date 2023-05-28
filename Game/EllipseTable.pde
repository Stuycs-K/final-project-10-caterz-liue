public class EllipseTable extends PoolTable{

  public EllipseTable(float w, float h, float smoothness){
    super("ellipse", w, h, smoothness);
    
    float magic_y = w*h / sqrt(3*h*h+w*w); // (magic_x,magic_y) is the point at which theta=pi/6 intersects the ellipse
    float magic_x = sqrt(3) * magic_y;
    this.pockets = new Hole[] {                   new Hole(0, h),
                                new Hole(-magic_x, magic_y), new Hole(magic_x, magic_y),
                                new Hole(-magic_x,-magic_y), new Hole(magic_x,-magic_y),
                                                    new Hole(0,-h)};
  }
  
  public boolean onTable(PVector pos){
    return pos.x*pos.x/w/w + pos.y*pos.y/h/h < 1;
  }
  
  public PVector inwardsFromWall(PVector pos){
    return PVector.fromAngle(atan(pos.y/pos.x * w*w/h/h));
    //return new PVector(-1,0);
  }
  
  public void renderHelper(){
    ellipse(0,0,w,h);
  }




}
