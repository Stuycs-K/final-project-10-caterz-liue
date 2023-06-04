import java.util.*;
// THIS FILE DOES NOT EXIST
// IT IS HIDDEN AWAY IN NOWHERELAND, POPULATION 0
// DO NOT USE THIS RIGHT NOW BECAUSE IT DOES NOT WORK
// THANK YOU FOR YOUR COOPERATION
double[][] q, qI, qII, qIII, qIV;

public class BlobTable extends PoolTable{
  
  public BlobTable(float w, float h, float smoothness, float wall, float holeSize){
    super(w, h, smoothness, wall);
    qI = getExpression(0,120, 90,150, 120,0);
    qIV = getExpression(120,0, 40,-60, 0,-70);
    qIII = getExpression(0,-70, -100,-40, -140,0);
    qII = getExpression(-140,0, -150,30, 0,120);
    
    this.pockets = new Hole[] {};
  }
  
  public boolean onTable(PVector pos){
    square(0,0,2);
    
    double x = pos.x;
    double y = pos.y;
    
    q = x>0 ? (y>0 ? qI : qIV) : (y>0 ? qII : qIII);
    
    double tempa = x*(q[0][0]*x + q[0][1]*y + (q[0][2]+q[2][0])) + y*(q[1][0]*x + q[1][1]*y + (q[1][2]+q[2][1])) + q[2][2];
    
    {
    double x_0 = mouseX - VISUAL_OFFSET.x;
    double y_0 = mouseY - VISUAL_OFFSET.y;
    
    q = x_0>0 ? (y_0>0 ? qI : qIV) : (y_0>0 ? qII : qIII);
    
    x = x_0;
    y = y_0;
    double temp = x*(q[0][0]*x + q[0][1]*y + (q[0][2]+q[2][0])) + y*(q[1][0]*x + q[1][1]*y + (q[1][2]+q[2][1])) + q[2][2];
    System.out.println(Math.signum(temp));
    
    x = x_0;
    y = y_0 - .1;
    double tempU = x*(q[0][0]*x + q[0][1]*y + (q[0][2]+q[2][0])) + y*(q[1][0]*x + q[1][1]*y + (q[1][2]+q[2][1])) + q[2][2];
    x = x_0 - .1;
    y = y_0;
    double tempL = x*(q[0][0]*x + q[0][1]*y + (q[0][2]+q[2][0])) + y*(q[1][0]*x + q[1][1]*y + (q[1][2]+q[2][1])) + q[2][2];

    fill(0);
    square(100,-100,5);
    line(100,-100, 100,-.001* (float) (tempU-temp));
    line(100,-100,-.001* (float) (tempL-temp),-100);
    line(100,-100, (float) (temp-tempL)-100, (float) (temp-tempU)+100);
    
    }
    return 0<tempa;
  }
  
  public PVector inwardsFromWall(PVector pos){
    double x_0 = pos.x;
    double y_0 = pos.y;
    
    q = x_0>0 ? (y_0>0 ? qI : qIV) : (y_0>0 ? qII : qIII);
    
    double x = x_0;
    double y = y_0;
    double temp = x*(q[0][0]*x + q[0][1]*y + (q[0][2]+q[2][0])) + y*(q[1][0]*x + q[1][1]*y + (q[1][2]+q[2][1])) + q[2][2];
    
    x = x_0;
    y = y_0 - .1;
    double tempU = x*(q[0][0]*x + q[0][1]*y + (q[0][2]+q[2][0])) + y*(q[1][0]*x + q[1][1]*y + (q[1][2]+q[2][1])) + q[2][2];
    x = x_0 - .1;
    y = y_0;
    double tempL = x*(q[0][0]*x + q[0][1]*y + (q[0][2]+q[2][0])) + y*(q[1][0]*x + q[1][1]*y + (q[1][2]+q[2][1])) + q[2][2];
    
    return new PVector((float)(temp-tempL),(float)(temp-tempU)).normalize();
  }
  
  public void renderHelper(){
    beginShape();
    vertex(0,120);
    quadraticVertex(90,150, 120,0);
    quadraticVertex(40,-60, 0,-70);
    quadraticVertex(-100,-40, -140,0);
    quadraticVertex(-150,30, 0,120);
    endShape();
    
  }
  
  public double[][] getExpression(float ax, float ay, float bx, float by, float cx, float cy){
    double[] u = new double[] {by-cy, cx-bx, bx*cy-by*cx};
    double[] v = new double[] {cy-ay, ax-cx, cx*ay-cy*ax};
    double[] w = new double[] {ay-by, bx-ax, ax*by-ay*bx};

    //for(double[]r:matrixAdd(myMatrixMult(u,w), myMatrixMult(w,u))) System.out.println(Arrays.toString(r));
    
    double[][] q = matrixAdd(matrixScalarMult(2, matrixAdd(myMatrixMult(u,w), myMatrixMult(w,u))), matrixScalarMult(-1, myMatrixMult(v,v)));
    System.out.println("x(" + q[0][0]+"x + " + q[0][1]+"y + " + (q[0][2]+q[2][0]) + ") + y(" + q[1][0]+"x + " + q[1][1]+"y + " + (q[1][2]+q[2][1]) + ") + " + q[2][2]);
    return q;
  }
  
  public double[][] myMatrixMult(double[] a, double[] b){ // a * b.T when a and b are both 3x1 matrices
    return new double[][] {{a[0]*b[0], a[0]*b[1], a[0]*b[2]},
                           {a[1]*b[0], a[1]*b[1], a[1]*b[2]},
                           {a[2]*b[0], a[2]*b[1], a[2]*b[2]}};
  }
  public double[][] matrixAdd(double[][] a, double[][] b){
    double[][] acc = new double[a.length][a[0].length];
    for(int i=0; i<acc.length; i++){
      for(int j=0; j<acc[0].length; j++){
        acc[i][j] = a[i][j] + b[i][j];
      }
    }
    return acc;
  }
  public double[][] matrixScalarMult(double a, double[][] b){
    double[][] acc = new double[b.length][b[0].length];
    for(int i=0; i<acc.length; i++){
      for(int j=0; j<acc[0].length; j++){
        acc[i][j] = a * b[i][j];
      }
    }
    return acc;
  }
   
  
}
