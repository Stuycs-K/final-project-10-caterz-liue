public class Hole {
  PVector position;
  float size;
  int number;
  
  public Hole(float x, float y, float size, int number){
    this.position = new PVector(x,y);
    this.size = size;
    this.number = number;
  }
  
  public Hole(PVector position, float size, int number){
    this.position = position;
    this.size = size;
    this.number = number;
  }
  
  public void renderHole(Shape shape){
    fill(BLACK); noStroke();
    //if(shape.name().equals("blob")){
      circle(position.x,position.y,size);
    //}else{
      //float b1 = shape.getNormal(PVector.add(position, new PVector(.01,.01)));
      //arc(position.x, position.y, size, size, b1.heading()-PI/2, b1.heading()+PI/2);
    //}
  }
}
