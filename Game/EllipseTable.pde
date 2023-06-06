public class EllipseTable extends PoolTable{

  public EllipseTable(float w, float h, float smoothness, float wall, float holeSize){
    super(w, h, smoothness, wall, "ellipse");
    
    float tempw = w + wall;
    float temph = h + wall;
    float magic_y = tempw*temph / sqrt(3*temph*temph+tempw*tempw); // (magic_x,magic_y) is the point at which theta=pi/6 intersects the ellipse
    float magic_x = sqrt(3) * magic_y;
    this.pockets = new Hole[] {                   new Hole(0, temph, holeSize),
                                new Hole(-magic_x, magic_y, holeSize), new Hole(magic_x, magic_y, holeSize),
                                new Hole(-magic_x,-magic_y, holeSize), new Hole(magic_x,-magic_y, holeSize),
                                                  new Hole(0,-temph, holeSize)};
  }
  
  public boolean onTable(PVector pos){
    return pos.x*pos.x/w/w + pos.y*pos.y/h/h < 1;
  }
  
  public PVector inwardsFromWall(PVector pos){
    return PVector.fromAngle(atan(pos.y/pos.x * w*w/h/h));
  }
  
  public void renderHelper(){
    ellipse(0,0,w+wall,h+wall);
  }
  
  public void makeObstacles(){
    obstacles = new Obstacle[] {
      new Sand("ellipse", new PVector(80,-80), 0.99999, 40),
      new Sand("rect", new PVector(-80,80), 0.77777, 30),
      new Ice("ellipse", new PVector(-80,-80), 1.05, 30),
      new Ice("rect", new PVector(80,80), 1.05, 20),
    };
  }




}
