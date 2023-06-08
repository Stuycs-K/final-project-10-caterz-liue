public class Blob extends Shape{
  PVector[] joins, controls;
  //boolean[] sides;
  ConicExpression[] conicsList;
  
  public Blob(PVector position, PVector[] joins, PVector[] controls){
    this.position = position;
    this.joins = joins;
    this.controls = controls;
    this.sides = genSides(joins);
    this.convexes = new boolean[6];
    
    this.conicsList = new ConicExpression[joins.length]; // equations of each wall segment (arbitrary conics)
    for(int i=0; i<joins.length; i++){
      this.conicsList[i] = new ConicExpression(joins[i].x, joins[i].y, controls[i].x, controls[i].y, joins[(i+1)%joins.length].x, joins[(i+1)%joins.length].y);
    }
  }
  
  /*public boolean touching(PVector p){
    return 0 <= getExpression(p).eval(p.x, p.y);
  }*/
  
  public PVector getNormal(PVector p){
    ConicExpression expression = getExpression(p);
    float eval = expression.eval(p.x, p.y);
    float evalNorth = expression.eval(p.x, p.y+.1);
    float evalSouth = expression.eval(p.x, p.y-.1);
    float evalWest = expression.eval(p.x+.1, p.y);
    float evalEast = expression.eval(p.x-.1, p.y); // i do not know how to find the normal to a curve at a given point, so just test nearby points
    
    return new PVector(eval-evalEast, eval-evalSouth).normalize();
  }
  
  public boolean touching(PVector pos){
    PVector p = PVector.sub(pos, position);
    for(int i=0; i<joins.length; i++){
      PVector l = PVector.sub(joins[i], position);
      PVector r = PVector.sub(joins[(i+1)%joins.length], position);
      boolean side = sides[i];
      boolean convex = convexes[i];
      if(between(p,r,l, convex) && (0<inOuterHalf(p,r,l,side) && !convex || !convex && 0<conicsList[i].eval(p.x,p.y) || convex && 0>inOuterHalf(p,r,l,side) && 0>conicsList[i].eval(p.x,p.y))) return true;
    }
    return false;

  }
  
  
  public ConicExpression getExpression(PVector pos){
    PVector p = PVector.sub(pos, position);
    float closest = 0;
    ConicExpression closest_expr = new ConicExpression();
    for(int i=0; i<joins.length; i++){
      PVector l = PVector.sub(joins[i], position);
      PVector r = PVector.sub(joins[(i+1)%joins.length], position);
      boolean side = sides[i];
      
      if(true || between(p, r, l, false)){
        float temp = inOuterHalf(p, r, l, side);
        if(temp<closest && between(p, r, l, false)){
          closest = temp;
          closest_expr = conicsList[i];
          //return closest_expr;
        }
      }
    }
    return closest_expr;
  }
  
  /*public boolean between(PVector p, PVector a, PVector b){
    // why do we not need case for p<=0? i do not know
    return a.heading() <= p.heading()      && p.heading() <= b.heading() || // a<p<b, p>=0
           a.heading() <= p.heading()+2*PI && p.heading() <= b.heading() && p.heading() < 0; // a<p<b, angle AB is split over theta=PI, p <= 0
  }*/
  
  public float inOuterHalf(PVector p, PVector a, PVector b, boolean side){
    // line between a and b: (y-a_y) - (x-a_x) * (a_y-b_y)/(a_x-b_x) = 0
    float temp = (p.y-a.y) - (p.x-a.x) * (a.y-b.y)/(a.x-b.x);
    return temp * (side ? 1 : -1);
  }
  
  public boolean[] genSides(PVector[] ps){
    boolean[] acc = new boolean[ps.length];
    for(int i=0; i<acc.length; i++){
      acc[i] = ps[i].x > ps[(i+1)%joins.length].x;
    }
    return acc;
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
