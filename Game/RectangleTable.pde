public class RectangleTable extends PoolTable{

  public RectangleTable(float w, float h, float smoothness, float wall, float holeSize){
    super(smoothness, wall, "rectangle");
    
    shape = new Rectangle(new PVector(0,0), w, h);
    
    float tempw = w + wall;
    float temph = h + wall;
    this.pockets = new Hole[] {new Hole(-tempw, temph, holeSize), new Hole(0, temph, holeSize), new Hole(tempw, temph, holeSize),
                               new Hole(-tempw,-temph, holeSize), new Hole(0,-temph, holeSize), new Hole(tempw,-temph, holeSize)};
  }
  
  public void makeObstacles(){
    obstacles = new Obstacle[] {
      new Sand("ellipse", new PVector(-80,80), 0.99999, 40),
      new Sand("rectangle", new PVector(80,-80), 0.77777, 30),
      new Ice("ellipse", new PVector(80,80), 1.05, 30),
      new Ice("rectangle", new PVector(-80,-80), 1.05, 20),
    };
  }




}
