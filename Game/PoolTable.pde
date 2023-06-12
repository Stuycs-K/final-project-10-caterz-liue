public abstract class PoolTable {
  Shape shape;
  Hole[] pockets;
  Obstacle[] obstacles;
  float smoothness, wall, holeSize;
  
  
  public PoolTable(float smoothness, float wall, float holeSize){
    this.smoothness = smoothness;
    this.wall = wall;
    this.holeSize = holeSize;
  }
  
  public void generatePockets(float rot, PVector[] positions){
    this.pockets = new Hole[positions.length];
      for(int i=0; i<pockets.length; i++){
        this.pockets[i] = new Hole(positions[i].rotate(-rot), holeSize, i);
      }
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
      pocket.renderHole();
      if(debugOn){
        fill(WHITE); textSize(pocket.size*1.5);
        text(pocket.number, pocket.position.x, pocket.position.y);
      }
    }
    
    stroke(BORDER_BROWN); strokeWeight(wall); noFill();
    shape.renderOutline(wall);
  }  
  
}
