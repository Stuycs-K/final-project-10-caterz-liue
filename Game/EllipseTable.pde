public class EllipseTable extends PoolTable{

  public EllipseTable(float w, float h, float smoothness, float wall){
    super(w, h, smoothness, wall);
    
    float tempw = w + wall;
    float temph = h + wall;
    float magic_y = tempw*temph / sqrt(3*temph*temph+tempw*tempw); // (magic_x,magic_y) is the point at which theta=pi/6 intersects the ellipse
    float magic_x = sqrt(3) * magic_y;
    this.pockets = new Hole[] {                   new Hole(0, temph),
                                new Hole(-magic_x, magic_y), new Hole(magic_x, magic_y),
                                new Hole(-magic_x,-magic_y), new Hole(magic_x,-magic_y),
                                                  new Hole(0,-temph)};
  }
  
  public boolean onTable(PVector pos){
    return pos.x*pos.x/w/w + pos.y*pos.y/h/h < 1;
  }
  
  public PVector inwardsFromWall(PVector pos){
    return PVector.fromAngle(atan(pos.y/pos.x * w*w/h/h));
  }
  
  public void renderHelper(){
    ellipse(0,0,w+wall,h+wall);
  }




}
