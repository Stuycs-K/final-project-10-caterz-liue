public class PoolTable {
  String shape;
  int w, h;
  
  
  public PoolTable(String shape, int w, int h){
    this.shape = shape;
    this.w = w;
    this.h = h;
  }
  
  public PoolTable(){ // standard pool table is roughly 108 by 54 inches
    this.shape = "rect";
    this.w = 108 * 2;
    this.h =  54 * 2;
  }
  
  public void renderTable(int x, int y){
    fill(color(10, 108, 3));
    if(shape.equals("rect")){
      rect(x, y, w, h);
    }
    if(shape.equals("ellipse")){
      ellipse(x, y, w, h);
    }
  }
  
  
}
