// bugs: walls don't work quite right, invisible walls (hitting other end of the conic? hmm)

PVector[] joins;
PVector[] controls;
float[][][] qs;

float[][] curr_q; // cached current formula for ball position
float curr_eval; // cached current position value

public class BlobTable extends PoolTable{
  
  public BlobTable(float w, float h, float smoothness, float wall, float holeSize){
    super(w, h, smoothness, wall);
    
    // MUST go clockwise, joins[0] MUST be on the ray going directly west
    joins = new PVector[] {new PVector(-240,0), new PVector(-180,160), new PVector(10,240), new PVector(100,150), new PVector(150,-100), new PVector(-50,-200)};
    controls = new PVector[] {new PVector(-220,80), new PVector(-100,200),  new PVector(150,240), new PVector(300,0), new PVector(150,-200), new PVector(-150,-100)};
    qs = new float[][][] {getExpression(joins[0], controls[0], joins[1]),
                          getExpression(joins[1], controls[1], joins[2]),
                          getExpression(joins[2], controls[2], joins[3]),
                          getExpression(joins[3], controls[3], joins[4]),
                          getExpression(joins[4], controls[4], joins[5]),
                          getExpression(joins[5], controls[5], joins[0])}; // define equations for each component of wall
    
    // hole at each join
    this.pockets = new Hole[joins.length];
    for(int i=0; i<joins.length; i++){
      this.pockets[i] = new Hole(joins[i], holeSize);
    }

}
  
  public boolean onTable(PVector pos){
    curr_q = qs[getSector(pos)];
    curr_eval = evalExpression(pos.x, pos.y, curr_q);
    return 0<curr_eval;
  }
  
  public PVector inwardsFromWall(PVector pos){ // onTable must have been already run to ensure that curr_q and curr_eval are correct
    float x = pos.x;
    float y = pos.y;
    
    float evalSouth = evalExpression(x, y-.1, curr_q);
    float evalEast = evalExpression(x-.1, y, curr_q); // i do not know how to find the normal to a curve at a given point, so just test nearby points
    
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
  
  public int getSector(PVector pos){
    int a = 5;
    for(int i=0; i<joins.length; i++){
      if(joins[i].heading()>pos.heading() && pos.heading()>joins[(i+1)%joins.length].heading()){
        a = i;
      }
    }
    square(joins[a].x, joins[a].y, 15);
    return a;
  }
  
  
  // --- these functions are only run on generation ---
  public float[][] getExpression(PVector a, PVector b, PVector c){
    // StackExchange user robjohn, I love you with the entirety of my heart: https://math.stackexchange.com/a/1258406
    float[] u = new float[] {b.y-c.y, c.x-b.x, b.x*c.y-b.y*c.x};
    float[] v = new float[] {c.y-a.y, a.x-c.x, c.x*a.y-c.y*a.x};
    float[] w = new float[] {a.y-b.y, b.x-a.x, a.x*b.y-a.y*b.x};

    float[][] q = myAddM(myMultS(2, myAddM(myMultM(u,w), myMultM(w,u))), myMultS(-1, myMultM(v,v))); // 2(u*w.T + w*u.T) - v*v.T
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
