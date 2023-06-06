public abstract class PoolTable {
  float w, h; // actually halfwidth and halfheight
  Hole[] pockets;
  float smoothness;
  float wall;
  String tableType;
  
  
  public PoolTable(float w, float h, float smoothness, float wall, String tableType){
    this.w = w;
    this.h = h;
    this.smoothness = smoothness;
    this.wall = wall;
    this.tableType = tableType;
  }
  
  public abstract boolean onTable(PVector pos);
  
  public abstract PVector inwardsFromWall(PVector pos);
  
  public abstract void renderHelper();
  
  //public PoolTable(){
    //this("rect", 54*3, 27*3, .98); // standard pool table is roughly 108 by 54 inches
  //}
  
  public void render(){
    fill(#0a6c03);
    stroke(#966F33); strokeWeight(wall);
    
    renderHelper();
    
    for(Hole pocket : pockets){
      pocket.renderHole();
    } 
  }
  
  
}
