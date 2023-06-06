public class Blob extends Shape{
  PVector[] joins, controls;
  ConicExpression[] conicsList;
  
  public Blob(PVector position, PVector[] joins, PVector[] controls){
    this.position = position;
    this.joins = joins;
    this.controls = controls;
    
    this.conicsList = new ConicExpression[joins.length]; // equations of each wall segment (arbitrary conics)
    for(int i=0; i<joins.length; i++){
      this.conicsList[i] = new ConicExpression(joins[i].x, joins[i].y, controls[i].x, controls[i].y, joins[(i+1)%joins.length].x, joins[(i+1)%joins.length].y);
    }
  }
  
  public boolean touching(PVector p){
    return 0 <= getExpression(p).eval(p.x, p.y);
  }
  
  public PVector getNormal(PVector p){
    ConicExpression expression = getExpression(p);
    float eval = expression.eval(p.x, p.y);
    float evalSouth = expression.eval(p.x, p.y-.1);
    float evalEast = expression.eval(p.x-.1, p.y); // i do not know how to find the normal to a curve at a given point, so just test nearby points
    
    return new PVector(eval-evalEast, eval-evalSouth).normalize();
  }
  
  public ConicExpression getExpression(PVector pos){
    for(int i=0; i<joins.length; i++){
      PVector l = PVector.sub(joins[i],position);
      PVector r = PVector.sub(joins[(i+1)%joins.length],position);
      PVector p = PVector.sub(pos, position); 
      if(l.heading()>pos.heading() && (p.heading()>r.heading() || l.heading()<r.heading() && p.heading()>r.heading()-2*PI) && // is position in the sector subtended by the arc of the given segment?
         (p.y-l.y - (l.y-r.y)/(l.x-r.x)*(p.x-l.x)) * Math.signum(r.x-l.x) > 0){ // point-slope form of midline times -1 or 1 depending on whether joins are going clockwise or counterclockwise
         return conicsList[i];
      }
    }
    return new ConicExpression();
  }
  
  public void render(float offset){ // erica i need your help here with the walls being in the wrong spot
    beginShape();
    vertex(joins[0].x,joins[0].y);
    for(int i=0; i<joins.length; i++){
      quadraticVertex(controls[i].x, controls[i].y, joins[(i+1)%joins.length].x, joins[(i+1)%joins.length].y);
    }
    endShape();
  }
  
  public String name(){
    return "blob";
  }

}
