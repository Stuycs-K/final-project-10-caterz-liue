public class RectangleTable extends PoolTable{

  public RectangleTable(float w, float h, float smoothness, float wall, float holeSize){
    super(smoothness, wall, "rectangle");
    
    shape = new Rectangle(new PVector(0,0), w, h);
    
    float tempw = w + wall;
    float temph = h + wall;
    this.pockets = new Hole[] {new Hole(-w, h, holeSize, 0), new Hole(0, h, holeSize, 1), new Hole(w, h, holeSize, 2),
                               new Hole(-w,-h, holeSize, 3), new Hole(0,-h, holeSize, 4), new Hole(w,-h, holeSize, 5)};
  }
  
  public void makeObstacles(){
    obstacles = new Obstacle[] {
      new Sand(0.99999, new Ellipse(new PVector(-80,80), 40, 40)),
      new Sand(0.77777, new Rectangle(new PVector(80,-80), 30, 30)),
      new Ice(1.05, new Ellipse(new PVector(80,80), 30, 30)),
      new Ice(1.05, new Rectangle(new PVector(-80,-80), 20, 20)),
    };
  }




}
