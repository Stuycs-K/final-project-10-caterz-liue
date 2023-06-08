// bugs: walls don't work quite right
public class BlobTable extends PoolTable{
  
  public BlobTable(float smoothness, float wall, float holeSize){
    super(smoothness, wall, "blob");
    
    // MUST go clockwise, must be concave, joins' x values cannot stay the same or temporarily jump in the wrong direction
    PVector[] joins = new PVector[] {new PVector(-180,160), new PVector(10,240), new PVector(100,150), new PVector(150,-100), new PVector(-50,-200), new PVector(-240,-1)};
    PVector[] controls = new PVector[] {new PVector(-100,200),  new PVector(150,240), new PVector(30,0), new PVector(150,-200), new PVector(-180,-100), new PVector(-180,80)};
    
    shape = new Blob(new PVector(0,0), joins, controls);

    this.pockets = new Hole[joins.length]; // hole at each join
    for(int i=0; i<joins.length; i++){
      this.pockets[i] = new Hole(joins[i], holeSize, i);
    }

  }
  
  public BlobTable(PVector[] joins, PVector[] controls, float smoothness, float wall, float holeSize){
    super(smoothness, wall, "blob");
    
    // MUST go clockwise, must be concave, joins' x values cannot stay the same or temporarily jump in the wrong direction
    boolean[] convexes = new boolean[] {false, false, true, false, false, true};
    
    shape = new Blob(new PVector(0,0), joins, controls, convexes);

    this.pockets = new Hole[joins.length]; // hole at each join
    for(int i=0; i<joins.length; i++){
      this.pockets[i] = new Hole(joins[i], holeSize, i);
    }

  }
  
  public void makeObstacles(){
    obstacles = new Obstacle[] {
      new Sand(0.99999, new Ellipse(new PVector(-80,-80), 40, 30)),
      new Sand(0.77777, new Rectangle(new PVector(80,80), 30, 20)),
      new Ice(1.05, new Ellipse(new PVector(80,-80), 60, 30)),
      new Ice(1.05, new Rectangle(new PVector(-80,80), 20, 10)),
      new Ice(1.05, new Blob(new PVector(-135,115), new PVector[] {new PVector(-100,100), new PVector(-150,100), new PVector(-151,150)}, new PVector[] {new PVector(-125, 80), new PVector(-170,120), new PVector(-80, 120)})),
    };
  }
  
   
  
}
