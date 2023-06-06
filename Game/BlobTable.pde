// bugs: walls don't work quite right
public class BlobTable extends PoolTable{
  PVector[] joins, joins2, controls;
  ConicExpression[] qs;

  ConicExpression curr_q; // cached current formula for ball position
  float curr_eval; // cached current position value
  
  public BlobTable(float w, float h, float smoothness, float wall, float holeSize){
    super(w, h, smoothness, wall, "blob");
    
    // MUST go clockwise, must be concave, joins' x values cannot stay the same or temporarily jump in the wrong direction
    joins = new PVector[] {new PVector(-180,160), new PVector(10,240), new PVector(100,150), new PVector(150,-100), new PVector(-50,-200), new PVector(-240,0)};
    controls = new PVector[] {new PVector(-100,200),  new PVector(150,240), new PVector(300,0), new PVector(150,-200), new PVector(-180,-100), new PVector(-220,80)};
    
    this.qs = new ConicExpression[joins.length]; // equations of each wall segment (arbitrary conics)
    this.pockets = new Hole[joins.length]; // hole at each join
    for(int i=0; i<joins.length; i++){
      this.qs[i] = new ConicExpression(joins[i].x, joins[i].y, controls[i].x, controls[i].y, joins[(i+1)%joins.length].x, joins[(i+1)%joins.length].y);
      this.pockets[i] = new Hole(joins[i], holeSize);
    }

}
  
  public boolean onTable(PVector pos){
    curr_q = getExpression(pos);
    curr_eval = curr_q.eval(pos.x, pos.y);
    return 0<=curr_eval;
  }
  
  public PVector inwardsFromWall(PVector pos){ // onTable must have been already run to ensure that curr_q and curr_eval are correct
    float x = pos.x;
    float y = pos.y;
    
    float evalSouth = curr_q.eval(x, y-.1);
    float evalEast = curr_q.eval(x-.1, y); // i do not know how to find the normal to a curve at a given point, so just test nearby points
    
    return new PVector(curr_eval-evalEast, curr_eval-evalSouth).normalize();
  } 
  
  public void renderHelper(){ // erica i need your help here with the walls being in the wrong spot
    beginShape();
    vertex(joins[0].x,joins[0].y);
    quadraticVertex(controls[0].x,controls[0].y, joins[1].x,joins[1].y);
    quadraticVertex(controls[1].x,controls[1].y, joins[2].x,joins[2].y);
    quadraticVertex(controls[2].x,controls[2].y, joins[3].x,joins[3].y);
    quadraticVertex(controls[3].x,controls[3].y, joins[4].x,joins[4].y);
    quadraticVertex(controls[4].x,controls[4].y, joins[5].x,joins[5].y);
    quadraticVertex(controls[5].x,controls[5].y, joins[0].x,joins[0].y);
    endShape();    
  }
  
  public ConicExpression getExpression(PVector pos){
    for(int i=0; i<joins.length; i++){
      PVector l = joins[i];
      PVector r = joins[(i+1)%joins.length];
      if(l.heading()>pos.heading() && (pos.heading()>r.heading() || l.heading()<r.heading() && pos.heading()>r.heading()-2*PI) && // is position in the sector subtended by the arc of the given segment?
         (pos.y-l.y - (l.y-r.y)/(l.x-r.x)*(pos.x-l.x)) * Math.signum(r.x-l.x) > 0){ // point-slope form of midline times -1 or 1 depending on whether joins are going clockwise or counterclockwise
         return qs[i];
      }
    }
    return new ConicExpression();
  }
  
  public void makeObstacles(){
    obstacles = new Obstacle[] {
      new Sand("ellipse", new PVector(-80,-80), 0.99999, 40, 30),
      new Sand("rect", new PVector(80,80), 0.77777, 30, 20),
      new Ice("ellipse", new PVector(80,-80), 1.05, 30, 60),
      new Ice("rect", new PVector(-80,80), 1.05, 20, 10),
    };
  }
  
   
  
}
