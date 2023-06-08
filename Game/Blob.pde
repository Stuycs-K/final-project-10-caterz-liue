public class Blob extends Shape{
  PVector[] joins, controls;
  boolean[] sides, convexes;
  ConicExpression[] conicsList;
  
  public Blob(PVector position, PVector[] joins, PVector[] controls, boolean[] convexes, boolean[] sides){
    this.position = position;
    this.joins = joins;
    this.controls = controls;
    this.sides = sides==null ? genSides(joins) : sides;
    this.convexes = convexes;
    
    this.conicsList = new ConicExpression[joins.length]; // equations of each wall segment (arbitrary conics)
    for(int i=0; i<joins.length; i++){
      this.conicsList[i] = new ConicExpression(joins[i].x, joins[i].y, controls[i].x, controls[i].y, joins[(i+1)%joins.length].x, joins[(i+1)%joins.length].y);
    }
  }
  
  public Blob(PVector position, PVector[] joins, PVector[] controls, boolean[] convexes){
    this(position, joins, controls, convexes, null);
  }
  
  public Blob(PVector position, PVector[] joins, PVector[] controls){
    this(position, joins, controls, new boolean[joins.length], null);
  }
  
  
  
  
  
  public boolean touching(PVector pos){
    int sector = getSector(pos);
    PVector p = PVector.sub(pos, position);
    PVector l = PVector.sub(joins[sector], position);
    PVector r = PVector.sub(joins[(sector+1)%joins.length], position);
    boolean side = sides[sector];
    boolean convex = convexes[sector];
    return convex ^ (0<inOuterHalf(p,l,r,side^convex) || 0<conicsList[sector].eval(p.x,p.y));
  }
  
  public PVector getNormal(PVector pos){
    ConicExpression expression = conicsList[getSector(pos)];
    PVector p = PVector.sub(pos, position);
    float eval = expression.eval(p.x, p.y);
    float evalSouth = expression.eval(p.x, p.y-.1);
    float evalEast  = expression.eval(p.x-.1, p.y); // i do not know how to find the normal to a curve at a given point, so just test nearby points
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
