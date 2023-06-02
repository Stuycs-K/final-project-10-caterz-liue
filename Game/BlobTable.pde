// THIS FILE DOES NOT EXIST
// IT IS HIDDEN AWAY IN NOWHERELAND, POPULATION 0
// DO NOT USE THIS RIGHT NOW BECAUSE IT DOES NOT WORK
// THANK YOU FOR YOUR COOPERATION

public class BlobTable extends PoolTable{
  
  public BlobTable(float w, float h, float smoothness, float wall){
    super(w, h, smoothness, wall);
    
   this.pockets = new Hole[] {new Hole(10, 10, 2)};
  }
  
  public boolean onTable(PVector pos){
    return true;
  }
  
  public PVector inwardsFromWall(PVector pos){
    return new PVector(1,0);
  }
  
  public void renderHelper(){
    beginShape();
    vertex(0,120);
    bezierVertex(90,150, 150,90, 120,0);
    bezierVertex(90,-90, 40,-60, 0,-70);
    bezierVertex(-40,-90, -100,-40, -140,0);
    bezierVertex(-150,30, -150,70, 0,120);
    endShape();
  }
  
}
