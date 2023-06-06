public class ConicExpression{
  float[][] expression;
  
  public ConicExpression(float ax, float ay, float bx, float by, float cx, float cy){
    // StackExchange user robjohn, I love you with the entirety of my heart: https://math.stackexchange.com/a/1258406
    float[] u = new float[] {by-cy, cx-bx, bx*cy-by*cx};
    float[] v = new float[] {cy-ay, ax-cx, cx*ay-cy*ax};
    float[] w = new float[] {ay-by, bx-ax, ax*by-ay*bx};

    expression = myAddM(myMultS(2, myAddM(myMultM(u,w), myMultM(w,u))), myMultS(-1, myMultM(v,v))); // 2(u*w.T + w*u.T) - v*v.T
  }
  
  public ConicExpression(){
    expression = new float[3][3];
  }
  
  public float eval(float x, float y){
    return x*(expression[0][0]*x + expression[0][1]*y + (expression[0][2]+expression[2][0])) + y*(expression[1][0]*x + expression[1][1]*y + (expression[1][2]+expression[2][1])) + expression[2][2];
  }
  
  public static float[][] myMultM(float[] a, float[] b){ // a * b.T when a and b are both 3x1 matrices
    return new float[][] {{a[0]*b[0], a[0]*b[1], a[0]*b[2]},
                           {a[1]*b[0], a[1]*b[1], a[1]*b[2]},
                           {a[2]*b[0], a[2]*b[1], a[2]*b[2]}};
  }
  public static float[][] myAddM(float[][] a, float[][] b){ // a * b when a and b are the same size
    float[][] acc = new float[a.length][a[0].length];
    for(int i=0; i<acc.length; i++){
      for(int j=0; j<acc[0].length; j++){
        acc[i][j] = a[i][j] + b[i][j];
      }
    }
    return acc;
  }
  public static float[][] myMultS(float a, float[][] b){ // a * b when a is a scalar and b is a matrix
    float[][] acc = new float[b.length][b[0].length];
    for(int i=0; i<acc.length; i++){
      for(int j=0; j<acc[0].length; j++){
        acc[i][j] = a * b[i][j];
      }
    }
    return acc;
  }
}
