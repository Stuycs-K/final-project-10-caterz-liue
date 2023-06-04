import java.util.*;
double[][] q, qI, qII, qIII, qIV;

public class BlobTable extends PoolTable{
  
  public BlobTable(float w, float h, float smoothness, float wall, float holeSize){
    super(w, h, smoothness, wall);
    qI = getExpression(0,240, 180,300, 240,0);
    qIV = getExpression(240,0, 80,-120, 0,-140);
    qIII = getExpression(0,-140, -200,-80, -280,0);
    qII = getExpression(-280,0, -300,60, 0,240);
    
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
    vertex(0*s,240*s);
    quadraticVertex(180*s,300*s, 240*s,0*s);
    quadraticVertex(80*s,-120*s, 0*s,-140*s);
    quadraticVertex(-200*s,-80*s, -280*s,0*s);
    quadraticVertex(-300*s,60*s, 0*s,240*s);
    endShape();
    //scale(1/(1 + wall/100));
  }
  
  public double[][] getExpression(float ax, float ay, float bx, float by, float cx, float cy){
    // StackExchange user robjohn, I love you with the entirety of my heart: https://math.stackexchange.com/a/1258406
    double[] u = new double[] {by-cy, cx-bx, bx*cy-by*cx};
    double[] v = new double[] {cy-ay, ax-cx, cx*ay-cy*ax};
    double[] w = new double[] {ay-by, bx-ax, ax*by-ay*bx};

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
