public class CueStick {
  public boolean visible = false;
  public float size;
  public float strength;
  public PVector startDrag = new PVector(0,0);
  
  public CueStick(float size){
    this.size = size;
  }
  
  public void show(){
    visible = true;
  }
  
  public void hide(){
    visible = false;
  }
  
  public void render(Ball target){
    if(!visible) return;
    PVector relativePos = new PVector(mouseX, mouseY).sub(VISUAL_OFFSET).sub(target.position);
    PVector pointing = relativePos.rotate(PI).div(size).mult(1);
    PVector a = pointing.copy().setMag(pointing.mag()+size/2);
    PVector b = pointing.copy().setMag(pointing.mag()-size/2);
    
    
    stroke(BROWN); strokeWeight(5);
    line(target.position.x + a.x, target.position.y + a.y,
         target.position.x + b.x, target.position.y + b.y);
    //stroke(WHITE); strokeWeight(1);
    //line(target.position.x+pointing.x*target.size*1.5, target.position.y+pointing.y*target.size*1.5,
    //     target.position.x+pointing.x*size*2,          target.position.y+pointing.y*size*2);
  }
  
  public void strike(Ball target){
    if(!visible) return;
    PVector relativePos = new PVector(mouseX, mouseY).sub(VISUAL_OFFSET).sub(target.position);
    PVector pointing = relativePos.rotate(PI).div(size).mult(5);
    target.applyForce(pointing);
  }
  
  public void setStart(Ball target){
    startDrag = new PVector(mouseX, mouseY).sub(VISUAL_OFFSET).sub(target.position);

  }
}
