// bugs: walls don't work quite right
public class BlobTable extends PoolTable{
  PVector[] joins, controls;
  
  public BlobTable(float smoothness, float wall, float holeSize){
    super(smoothness, wall, "blob");
    
    // MUST go clockwise, must be concave, joins' x values cannot stay the same or temporarily jump in the wrong direction
    joins = new PVector[] {new PVector(-180,160), new PVector(10,240), new PVector(100,150), new PVector(150,-100), new PVector(-50,-200), new PVector(-240,0)};
    controls = new PVector[] {new PVector(-100,200),  new PVector(150,240), new PVector(300,0), new PVector(150,-200), new PVector(-180,-100), new PVector(-220,80)};
    
    shape = new Blob(new PVector(0,0), joins, controls);
    //shape.sides[2] = !shape.sides[2];

    
    this.pockets = new Hole[joins.length]; // hole at each join
    for(int i=0; i<joins.length; i++){
      this.pockets[i] = new Hole(joins[i], holeSize);
    }

  }
  
   public void render(){
    fill(TABLE_GREEN);
    stroke(BORDER_BROWN); strokeWeight(wall);
    shape.render(wall);
    
    int i=0;
    for(Hole pocket : pockets){
      pocket.renderHole();
      fill(WHITE); textSize(pocket.size*1.5);
      text(i++, pocket.x, pocket.y);
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
