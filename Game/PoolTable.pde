public class PoolTable {
  String shape;
  int w, h;
  
  public PoolTable(String shape, int w, int h){
    this.shape = shape;
    this.w = w;
    this.h = h;
  }
  
  public void renderTable(int x, int y){
    if(shape.equals("rect")){
      rect(x, y, w, h);
    }
    if(shape.equals("ellipse")){
      ellipse(x, y, w, h);
    }
  }
  
  
}
