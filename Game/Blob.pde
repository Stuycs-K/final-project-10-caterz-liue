public class Blob extends Shape{
  PVector[] joins, controls;
  boolean[] sides, convexes;
  ConicExpression[] conicsList;
  
  public Blob(PVector position, PVector[] joins, PVector[] controls, boolean[] convexes, boolean[] sides){
    this.position = position;
    this.joins = joins;
    this.controls = controls;
    if(sides!=null){
      this.sides = sides;
    }else{
      this.sides = genSides();
    }
    if(convexes!=null){
      this.convexes = convexes;
    }else{
      this.convexes = genConvexes();
    }
    
    this.conicsList = new ConicExpression[joins.length]; // equations of each wall segment (arbitrary conics)
    for(int i=0; i<joins.length; i++){
      this.conicsList[i] = new ConicExpression(joins[i].x, joins[i].y, controls[i].x, controls[i].y, joins[(i+1)%joins.length].x, joins[(i+1)%joins.length].y);
    }
  }
  
  public Blob(PVector position, PVector[] joins, PVector[] controls){
    this(position, joins, controls, null, null);
  }
  
  public boolean touching(PVector pos){
    int sector = getSector(pos);
    PVector p = PVector.sub(pos, position);
    PVector l = PVector.sub(joins[sector], position);
    PVector r = PVector.sub(joins[(sector+1)%joins.length], position);
    boolean side = sides[sector];
    boolean convex = convexes[sector];
    return convex ^ (0<inOuterHalf(p,l,r,side^convex) || 0<conicsList[sector].eval(pos.x,pos.y));
  }
  
  public PVector getNormal(PVector pos){
    ConicExpression expression = conicsList[getSector(pos)];
    float eval = expression.eval(pos.x, pos.y);
    float evalSouth = expression.eval(pos.x, pos.y-.1);
    float evalEast  = expression.eval(pos.x-.1, pos.y); // i do not know how to find the normal to a curve at a given point, so just test nearby points
    return new PVector(eval-evalEast, eval-evalSouth).normalize();
  }
  
  public int getSector(PVector pos){
  PVector p = PVector.sub(pos, position);
    for(int sector=0; sector<joins.length; sector++){
      PVector l = PVector.sub(joins[sector], position);
      PVector r = PVector.sub(joins[(sector+1)%joins.length], position);
      if(between(p,l,r)){
        return sector;
      }
    }
    return -1;
  }
  
  public boolean between(PVector p, PVector a, PVector b){
    return a.heading() >= p.heading()      && p.heading()      >= b.heading()                              || // a>p>b, p>=0
           a.heading() >= p.heading()-2*PI && p.heading()      >= b.heading() && a.heading() < b.heading() || // a>p>b, angle AB is split over theta=PI, p >= 0
           a.heading() >= p.heading()      && p.heading()+2*PI >= b.heading() && a.heading() < b.heading() || // a>p>b, angle AB is split over theta=PI, p <= 0
           false;
  }
  
  public float inOuterHalf(PVector p, PVector a, PVector b, boolean side){
    // line between a and b: (y-a_y) - (x-a_x) * (a_y-b_y)/(a_x-b_x) = 0
    float temp = (p.y-a.y) - (p.x-a.x) * (a.y-b.y)/(a.x-b.x);
    return temp * (side ? 1 : -1);
  }
  
  public boolean[] genSides(){
    boolean[] acc = new boolean[joins.length];
    for(int i=0; i<acc.length; i++){
      acc[i] = joins[i].x > joins[(i+1)%joins.length].x;
    }
    return acc;
  }
  
  public boolean[] genConvexes(){
    boolean[] acc = new boolean[joins.length];
    for(int i=0; i<acc.length; i++){
      acc[i] = 0 < inOuterHalf(controls[i], joins[i], joins[(i+1)%joins.length], sides[i]);
    }
    return acc;
  }
  
  public void render(float offset){
    PVector[] tempjoins = new PVector[joins.length];
    PVector[] tempcontrols = new PVector[controls.length];
    for(int i=0; i<joins.length; i++){
      tempjoins[i] = joins[i].copy().setMag(joins[i].mag()+offset);
      tempcontrols[i] = controls[i].copy().setMag(controls[i].mag()+offset);
    }
    
    beginShape();
    strokeJoin(ROUND);
    vertex(tempjoins[0].x,tempjoins[0].y);
    for(int i=0; i<joins.length; i++){
      quadraticVertex(tempcontrols[i].x, tempcontrols[i].y, tempjoins[(i+1)%tempjoins.length].x, tempjoins[(i+1)%tempjoins.length].y);
    }
    endShape();
  }
  
  public String name(){
    return "blob";
  }

}
