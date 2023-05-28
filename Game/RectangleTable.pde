public class RectangleTable extends PoolTable{

  public RectangleTable(float w, float h, float smoothness, float wall){
    super(w, h, smoothness, wall);
    float tempw = w + wall;
    float temph = h + wall;
    this.pockets = new Hole[] {new Hole(-tempw, temph), new Hole(0, temph), new Hole(tempw, temph),
                               new Hole(-tempw,-temph), new Hole(0,-temph), new Hole(tempw,-temph)};
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
    rect(0, 0, w+wall, h+wall);
  }




}
