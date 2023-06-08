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
    fill(TABLE_GREEN); noStroke();
    shape.render(wall);
    
    for(Hole pocket : pockets){
      pocket.renderHole(shape);
      if(debugOn){
        fill(WHITE); textSize(pocket.size*1.5);
        text(pocket.number, pocket.position.x, pocket.position.y);
      }
    }
    
    stroke(BORDER_BROWN); strokeWeight(wall); noFill();
    shape.renderOutline(wall);
  }
  
  public abstract void makeObstacles();
  
  
}
