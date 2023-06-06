public abstract class PoolTable {
  float w, h; // actually halfwidth and halfheight
  Hole[] pockets;
  Obstacle[] obstacles;
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
  
  public void makeObstacles(){
    if(tableType.equals("ellipse")){ // ellipse
      obstacles = new Obstacle[] {
        new Sand("circle", new PVector(80,-80), 0.99999, 40),
        new Sand("rect", new PVector(-80,80), 0.77777, 30),
        new Ice("circle", new PVector(-80,-80), 1.05, 30),
        new Ice("rect", new PVector(80,80), 1.05, 20),
      };
    }
    if(tableType.equals("rect")){ // rect
      obstacles = new Obstacle[] {
        new Sand("circle", new PVector(-80,80), 0.99999, 40),
        new Sand("rect", new PVector(80,-80), 0.77777, 30),
        new Ice("circle", new PVector(80,80), 1.05, 30),
        new Ice("rect", new PVector(-80,-80), 1.05, 20),
      };
    }
    if(tableType.equals("blob")){ // blob
      obstacles = new Obstacle[] {
        new Sand("circle", new PVector(-80,-80), 0.99999, 40),
        new Sand("rect", new PVector(80,80), 0.77777, 30),
        new Ice("circle", new PVector(80,-80), 1.05, 30),
        new Ice("rect", new PVector(-80,80), 1.05, 20),
      };
    }
  }
  
  
}
