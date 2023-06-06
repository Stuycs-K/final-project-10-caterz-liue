public class EllipseTable extends PoolTable{

  public EllipseTable(float w, float h, float smoothness, float wall, float holeSize){
    super(smoothness, wall, "ellipse");
    
    shape = new Ellipse(new PVector(0,0), w, h);
    
    float tempw = w + wall;
    float temph = h + wall;
    float magic_y = tempw*temph / sqrt(3*temph*temph+tempw*tempw); // (magic_x,magic_y) is the point at which theta=pi/6 intersects the ellipse
    float magic_x = sqrt(3) * magic_y;
    this.pockets = new Hole[] {                   new Hole(0, temph, holeSize),
                                new Hole(-magic_x, magic_y, holeSize), new Hole(magic_x, magic_y, holeSize),
                                new Hole(-magic_x,-magic_y, holeSize), new Hole(magic_x,-magic_y, holeSize),
                                                  new Hole(0,-temph, holeSize)};
  }
  
  public void makeObstacles(){
    obstacles = new Obstacle[] {
      new Sand("ellipse", new PVector(80,-80), 0.99999, 40),
      new Sand("rectangle", new PVector(-80,80), 0.77777, 30),
      new Ice("ellipse", new PVector(-80,-80), 1.05, 30),
      new Ice("rectangle", new PVector(80,80), 1.05, 20),
    };
  }




}
