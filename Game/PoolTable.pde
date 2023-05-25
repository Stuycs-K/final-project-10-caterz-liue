public class PoolTable {
  String shape;
  float w, h; // actually halfwidth and halfheight
  Hole[] pockets;
  
  
  public PoolTable(String shape, float w, float h){
    this.shape = shape;
    this.w = w;
    this.h = h;
    
    if(shape.equals("rect")){
      this.pockets = new Hole[] {new Hole(-w,h), new Hole(0,h), new Hole(w,h),
                                 new Hole(-w,-h), new Hole(0,-h), new Hole(w,-h)};
    }
    if(shape.equals("ellipse")){ // placeholder
      float magic_y = (float) w*h / sqrt(3*h*h+w*w); // (magic_x,magic_y) is the point at which theta=pi/6 intersects the ellipse
      float magic_x = sqrt(3) * magic_y;
      this.pockets = new Hole[] {new Hole(0, h), new Hole(0, -h),
                                 new Hole(magic_x,magic_y), new Hole(-magic_x,magic_y),
                                 new Hole(magic_x,-magic_y), new Hole(-magic_x,-magic_y)};
    }
    
  }
  
  public PoolTable(){
    this("rect", 54*3, 27*3); // standard pool table is roughly 108 by 54 inches
  }
  
  public void renderTable(float x, float y){
    fill(#0a6c03);
    stroke(#966F33); strokeWeight(5);
    
    if(shape.equals("rect")){
      rect(x, y, w, h);
    }
    if(shape.equals("ellipse")){
      ellipse(x, y, w, h);
    }
    
    for(Hole pocket : pockets){
      pocket.renderHole(x, y);
    } 
  }
  
  
}
