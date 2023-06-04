Point[] joins;
Point[] controls;

float[][] qI, qII, qIII, qIV;

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
    float x = pos.x;
    float y = pos.y;
    
    float[][] q = x>0 ? (y>0 ? qI : qIV) : (y>0 ? qII : qIII);
    
    float eval = evalExpression(x, y, q);
    
    return 0<eval;
  }
  
  public PVector inwardsFromWall(PVector pos){
    float x = pos.x;
    float y = pos.y;
    
    float[][] q = x>0 ? (y>0 ? qI : qIV) : (y>0 ? qII : qIII);
    
    float eval = evalExpression(x, y, q);
    float evalSouth = evalExpression(x, y-.1, q);
    float evalEast = evalExpression(x-.1, y, q); // i do not know how to find the normal to a curve at a given point, so just test nearby points
    
    return new PVector(eval-evalEast, eval-evalSouth).normalize();
  }
  
  public void renderHelper(){
    //scale(1 + wall/100);
    //float s = 1 + wall/100; // erica i need your help here math team person
    float s = 1;
    beginShape();
    vertex(joins[0].x*s,joins[0].y*s);
    quadraticVertex(controls[0].x*s,controls[0].y*s, joins[1].x*s,joins[1].y*s);
    quadraticVertex(controls[1].x*s,controls[1].y*s, joins[2].x*s,joins[2].y*s);
    quadraticVertex(controls[2].x*s,controls[2].y*s, joins[3].x*s,joins[3].y*s);
    quadraticVertex(controls[3].x*s,controls[3].y*s, joins[0].x*s,joins[0].y*s);
    endShape();
    //scale(1/(1 + wall/100));
  }
  
  public float[][] getExpression(Point a, Point b, Point c){
    // StackExchange user robjohn, I love you with the entirety of my heart: https://math.stackexchange.com/a/1258406
    float[] u = new float[] {b.y-c.y, c.x-b.x, b.x*c.y-b.y*c.x};
    float[] v = new float[] {c.y-a.y, a.x-c.x, c.x*a.y-c.y*a.x};
    float[] w = new float[] {a.y-b.y, b.x-a.x, a.x*b.y-a.y*b.x};

    float[][] q = myAddM(myMultS(2, myAddM(myMultM(u,w), myMultM(w,u))), myMultS(-1, myMultM(v,v))); // 2(u*w.T + w*u.T) - v*v.T
    //System.out.println("x(" + q[0][0]+"x + " + q[0][1]+"y + " + (q[0][2]+q[2][0]) + ") + y(" + q[1][0]+"x + " + q[1][1]+"y + " + (q[1][2]+q[2][1]) + ") + " + q[2][2]);
    return q;
  }
  public float evalExpression(float x, float y, float[][] q){
    return x*(q[0][0]*x + q[0][1]*y + (q[0][2]+q[2][0])) + y*(q[1][0]*x + q[1][1]*y + (q[1][2]+q[2][1])) + q[2][2];
  }
  
  public float[][] myMultM(float[] a, float[] b){ // a * b.T when a and b are both 3x1 matrices
    return new float[][] {{a[0]*b[0], a[0]*b[1], a[0]*b[2]},
                           {a[1]*b[0], a[1]*b[1], a[1]*b[2]},
                           {a[2]*b[0], a[2]*b[1], a[2]*b[2]}};
  }
  public float[][] myAddM(float[][] a, float[][] b){ // a * b when a and b are the same size
    float[][] acc = new float[a.length][a[0].length];
    for(int i=0; i<acc.length; i++){
      for(int j=0; j<acc[0].length; j++){
        acc[i][j] = a[i][j] + b[i][j];
      }
    }
    return acc;
  }
  public float[][] myMultS(float a, float[][] b){ // a * b when a is a scalar and b is a matrix
    float[][] acc = new float[b.length][b[0].length];
    for(int i=0; i<acc.length; i++){
      for(int j=0; j<acc[0].length; j++){
        acc[i][j] = a * b[i][j];
      }
    }
    return acc;
  }
   
  
}
