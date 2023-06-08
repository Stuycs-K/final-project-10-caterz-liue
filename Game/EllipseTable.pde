public class EllipseTable extends PoolTable{

  public EllipseTable(float w, float h, float smoothness, float wall, float holeSize){
    super(smoothness, wall, "ellipse");
    
    shape = new Ellipse(new PVector(0,0), w, h);
    
    float tempw = w + 0;
    float temph = h + 0;
    float magic_y = tempw*temph / sqrt(3*temph*temph+tempw*tempw); // (magic_x,magic_y) is the point at which theta=pi/6 intersects the ellipse
    float magic_x = sqrt(3) * magic_y;
    this.pockets = new Hole[] {                       new Hole(0, temph, holeSize, 0),
                                new Hole(-magic_x, magic_y, holeSize, 1), new Hole(magic_x, magic_y, holeSize, 2),
                                new Hole(-magic_x,-magic_y, holeSize, 3), new Hole(magic_x,-magic_y, holeSize, 4),
                                                      new Hole(0,-temph, holeSize, 5)};
  }
  
  public void makeObstacles(){
    obstacles = new Obstacle[] {
      new Sand(0.99999, new Ellipse(new PVector(80,-80), 40, 40)),
      new Sand(0.77777, new Rectangle(new PVector(-80,80), 30, 30)),
      new Ice(1.05, new Ellipse(new PVector(-80,-80), 30, 30)),
      new Ice(1.05, new Rectangle(new PVector(80,80), 20, 20)),
    };
  }




}
