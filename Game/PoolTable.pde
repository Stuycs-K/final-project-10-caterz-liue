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
  
  public void render(){
    fill(TABLE_GREEN);
    stroke(BORDER_BROWN); strokeWeight(wall);
    shape.render(wall);
    
    for(Hole pocket : pockets){
      pocket.renderHole();
    } 
  }
  
  public abstract void makeObstacles();
  
  
}
