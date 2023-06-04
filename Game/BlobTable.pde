Point[] joins;
Point[] controls;

double[][] q, qI, qII, qIII, qIV;

public class BlobTable extends PoolTable{
  
  public BlobTable(float w, float h, float smoothness, float wall, float holeSize){
    super(w, h, smoothness, wall);
    joins = new Point[] {new Point(0,240), new Point(240,0), new Point(0,-140), new Point(-280,0)};
    controls = new Point[] {new Point(180,300), new Point(80,-120), new Point(-200,-80), new Point(-300,60)};
    qI = getExpression(joins[0], controls[0], joins[1]);
    qIV = getExpression(joins[1], controls[1], joins[2]);
    qIII = getExpression(joins[2], controls[2], joins[3]);
    qII = getExpression(joins[3], controls[3], joins[0]);
    
    this.pockets = new Hole[] {};
  }
  
  public boolean onTable(PVector pos){
    double x = pos.x;
    double y = pos.y;
    
    q = x>0 ? (y>0 ? qI : qIV) : (y>0 ? qII : qIII);
    
    double eval = evalExpression(x, y, q);
    
    return 0<eval;
  }
  
  public PVector inwardsFromWall(PVector pos){
    double x = pos.x;
    double y = pos.y;
    
    q = x>0 ? (y>0 ? qI : qIV) : (y>0 ? qII : qIII);
    
    double eval = evalExpression(x, y, q);
    double evalSouth = evalExpression(x, y-.1, q);
    double evalEast = evalExpression(x-.1, y, q); // i do not know how to find the normal to a curve at a given point, so just test nearby points
    
    return new PVector((float)(eval-evalEast),(float)(eval-evalSouth)).normalize();
  }
  
  public void renderHelper(){
    //scale(1 + wall/100);
    //float s = 1 + wall/100; // erica i need your help here math team person
    float s = 1;
    beginShape();
    vertex((float)joins[0].x*s,(float)joins[0].y*s);
    quadraticVertex((float)controls[0].x*s,(float)controls[0].y*s, (float)joins[1].x*s,(float)joins[1].y*s);
    quadraticVertex((float)controls[1].x*s,(float)controls[1].y*s, (float)joins[2].x*s,(float)joins[2].y*s);
    quadraticVertex((float)controls[2].x*s,(float)controls[2].y*s, (float)joins[3].x*s,(float)joins[3].y*s);
    quadraticVertex((float)controls[3].x*s,(float)controls[3].y*s, (float)joins[0].x*s,(float)joins[0].y*s);
    endShape();
    //scale(1/(1 + wall/100));
  }
  
  public double[][] getExpression(Point a, Point b, Point c){
    // StackExchange user robjohn, I love you with the entirety of my heart: https://math.stackexchange.com/a/1258406
    double[] u = new double[] {b.y-c.y, c.x-b.x, b.x*c.y-b.y*c.x};
    double[] v = new double[] {c.y-a.y, a.x-c.x, c.x*a.y-c.y*a.x};
    double[] w = new double[] {a.y-b.y, b.x-a.x, a.x*b.y-a.y*b.x};

    double[][] q = myAddM(myMultS(2, myAddM(myMultM(u,w), myMultM(w,u))), myMultS(-1, myMultM(v,v))); // 2(u*w.T + w*u.T) - v*v.T
    //System.out.println("x(" + q[0][0]+"x + " + q[0][1]+"y + " + (q[0][2]+q[2][0]) + ") + y(" + q[1][0]+"x + " + q[1][1]+"y + " + (q[1][2]+q[2][1]) + ") + " + q[2][2]);
    return q;
  }
  public double evalExpression(double x, double y, double[][] q){
    return x*(q[0][0]*x + q[0][1]*y + (q[0][2]+q[2][0])) + y*(q[1][0]*x + q[1][1]*y + (q[1][2]+q[2][1])) + q[2][2];
  }
  
  public double[][] myMultM(double[] a, double[] b){ // a * b.T when a and b are both 3x1 matrices
    return new double[][] {{a[0]*b[0], a[0]*b[1], a[0]*b[2]},
                           {a[1]*b[0], a[1]*b[1], a[1]*b[2]},
                           {a[2]*b[0], a[2]*b[1], a[2]*b[2]}};
  }
  public double[][] myAddM(double[][] a, double[][] b){ // a * b when a and b are the same size
    double[][] acc = new double[a.length][a[0].length];
    for(int i=0; i<acc.length; i++){
      for(int j=0; j<acc[0].length; j++){
        acc[i][j] = a[i][j] + b[i][j];
      }
    }
    return acc;
  }
  public double[][] myMultS(double a, double[][] b){ // a * b when a is a scalar and b is a matrix
    double[][] acc = new double[b.length][b[0].length];
    for(int i=0; i<acc.length; i++){
      for(int j=0; j<acc[0].length; j++){
        acc[i][j] = a * b[i][j];
      }
    }
    return acc;
  }
   
  
}
