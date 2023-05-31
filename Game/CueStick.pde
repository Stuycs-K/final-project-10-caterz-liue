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
    PVector pointing = new PVector(mouseX, mouseY).sub(VISUAL_OFFSET).sub(target.position).setMag(-1);
    stroke(BROWN); strokeWeight(5);
    line(target.position.x-pointing.x*target.size*3, target.position.y-pointing.y*target.size*3,
         target.position.x-pointing.x*size,          target.position.y-pointing.y*size);
    stroke(WHITE); strokeWeight(1);
    line(target.position.x+pointing.x*target.size*1.5, target.position.y+pointing.y*target.size*1.5,
         target.position.x+pointing.x*size*2,          target.position.y+pointing.y*size*2);
  }
  
  public void strike(Ball target){
    if(!visible) return;
    PVector endDrag = new PVector(mouseX, mouseY).sub(VISUAL_OFFSET).sub(target.position);
    PVector pointing = PVector.fromAngle(endDrag.heading()).setMag((endDrag.mag() - startDrag.mag()) / (size/2)).rotate(PI).mult(5);
    //PVector pointing = new PVector(mouseX, mouseY).sub(VISUAL_OFFSET).sub(target.position).setMag(-1);
    target.applyForce(pointing);
  }
  
  public void setStart(Ball target){
    startDrag = new PVector(mouseX, mouseY).sub(VISUAL_OFFSET).sub(target.position);

  }
}
