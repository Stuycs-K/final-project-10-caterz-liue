public class RectangleTable extends PoolTable{

  public RectangleTable(float w, float h, float smoothness, float wall, float holeSize){
    super(w, h, smoothness, wall, "rect");
    float tempw = w + wall;
    float temph = h + wall;
    this.pockets = new Hole[] {new Hole(-tempw, temph, holeSize), new Hole(0, temph, holeSize), new Hole(tempw, temph, holeSize),
                               new Hole(-tempw,-temph, holeSize), new Hole(0,-temph, holeSize), new Hole(tempw,-temph, holeSize)};
  }
  
  public boolean onTable(PVector pos){
    return abs(pos.x)<w && abs(pos.y)<h;
  }
  
  public PVector inwardsFromWall(PVector pos){
    if(abs(pos.x)/w > abs(pos.y)/h){
      return new PVector(-Math.signum(pos.x), 0);
    }
    else{
      return new PVector(0, -Math.signum(pos.y));
    }
  }
  
  public void renderHelper(){
    rect(0, 0, w+wall, h+wall);
  }
  
  public void makeObstacles(){
    obstacles = new Obstacle[] {
      new Sand("ellipse", new PVector(-80,80), 0.99999, 40),
      new Sand("rect", new PVector(80,-80), 0.77777, 30),
      new Ice("ellipse", new PVector(80,80), 1.05, 30),
      new Ice("rect", new PVector(-80,-80), 1.05, 20),
    };
  }




}
