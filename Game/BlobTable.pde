// bugs: walls don't work quite right
public class BlobTable extends PoolTable{
  
  public BlobTable(float smoothness, float wall, float holeSize){
    super(smoothness, wall, "blob");
    
    // MUST go clockwise, must be concave, joins' x values cannot stay the same or temporarily jump in the wrong direction
    PVector[] joins = new PVector[] {new PVector(-180,160), new PVector(10,240), new PVector(100,150), new PVector(150,-100), new PVector(-50,-200), new PVector(-240,-1)};
    PVector[] controls = new PVector[] {new PVector(-100,200),  new PVector(150,240), new PVector(30,0), new PVector(150,-200), new PVector(-180,-100), new PVector(-180,80)};
    boolean[] convexes = new boolean[] {false, false, true, false, false, true};
    
    shape = new Blob(new PVector(0,0), joins, controls, convexes);

    this.pockets = new Hole[joins.length]; // hole at each join
    for(int i=0; i<joins.length; i++){
      this.pockets[i] = new Hole(joins[i], holeSize);
    }

  }
  
  public void makeObstacles(){
    obstacles = new Obstacle[] {
      new Sand("ellipse", new PVector(-80,-80), 0.99999, 40, 30),
      new Sand("rectangle", new PVector(80,80), 0.77777, 30, 20),
      new Ice("ellipse", new PVector(80,-80), 1.05, 60, 30),
      new Ice("rectangle", new PVector(-80,80), 1.05, 20, 10),
      new Ice("blob", new PVector(-135,115), 1.05, new PVector[] {new PVector(-100,100), new PVector(-150,100), new PVector(-150,150)}, new PVector[] {new PVector(-125, 80), new PVector(-170,120), new PVector(-80, 120)}),
    };
  }
  
   
  
}
