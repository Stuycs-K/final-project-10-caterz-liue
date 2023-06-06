public abstract class PoolTable {
  Shape shape;
  Hole[] pockets;
  Obstacle[] obstacles;
  float smoothness;
  float wall;
  String tableType;
  
  
  public PoolTable(float smoothness, float wall, String tableType){
    this.smoothness = smoothness;
    this.wall = wall;
    this.tableType = tableType;
  }
  
  public boolean onTable(PVector pos){
    return shape.touching(pos);
  }
  
  public PVector inwardsFromWall(PVector pos){
    return shape.getNormal(pos);
  }
  
  
  //public PoolTable(){
    //this("rectangle", 54*3, 27*3, .98); // standard pool table is roughly 108 by 54 inches
  //}
  
  public void render(){
    fill(#0a6c03);
    stroke(#966F33); strokeWeight(wall);
    shape.render(wall);
    
    for(Hole pocket : pockets){
      pocket.renderHole();
    } 
  }
  
  public abstract void makeObstacles();
  
  
}
