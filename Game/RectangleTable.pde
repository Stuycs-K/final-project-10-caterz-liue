public class RectangleTable extends PoolTable{

  public RectangleTable(float w, float h, float smoothness){
    super("rect", w, h, smoothness);
    this.pockets = new Hole[] {new Hole(-w, h), new Hole(0, h), new Hole(w, h),
                               new Hole(-w,-h), new Hole(0,-h), new Hole(w,-h)};
  }
  
  public boolean onTable(PVector pos){
    return abs(pos.x)<w && abs(pos.y)<h;
  }
  
  public PVector inwardsFromWall(PVector pos){
    if(abs(pos.x)/w > abs(pos.y)/h){
      return new PVector(-Math.signum(pos.x), 0);
    }
    else{
      return new PVector(0, -Math.signum(pos.y));
    }
  }
  
  public void renderHelper(){
    rect(0, 0, w, h);
  }




}
