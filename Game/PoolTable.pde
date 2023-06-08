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
    
    int i=0;
    for(Hole pocket : pockets){
      pocket.renderHole();
      if(debugOn){
        fill(WHITE); textSize(pocket.size*1.5);
        text(i++, pocket.x, pocket.y);
      }
    } 
  }
  
  public abstract void makeObstacles();
  
  
}
