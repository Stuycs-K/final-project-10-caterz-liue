public abstract class PoolTable {
  String shape;
  float w, h; // actually halfwidth and halfheight
  Hole[] pockets;
  float smoothness;
  
  
  public PoolTable(String shape, float w, float h, float smoothness){
    this.shape = shape;
    this.w = w;
    this.h = h;
    this.smoothness = smoothness;
  }
  
  public abstract boolean onTable(PVector pos);
  
  public abstract PVector inwardsFromWall(PVector pos);
  
  public abstract void renderHelper();
  
  public PoolTable(){
    this("rect", 54*3, 27*3, .98); // standard pool table is roughly 108 by 54 inches
  }
  
  public void render(){
    fill(#0a6c03);
    stroke(#966F33); strokeWeight(5);
    
    renderHelper();
    
    for(Hole pocket : pockets){
      pocket.renderHole();
    } 
  }
  
  
}
