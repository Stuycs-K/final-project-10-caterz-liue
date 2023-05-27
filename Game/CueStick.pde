public class CueStick {
  public boolean visible = false;
  public float size;
  
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
    PVector pointing = new PVector(mouseX, mouseY).sub(target.position).setMag(-1);
    stroke(#664c28);
    line(target.position.x-pointing.x*target.size*3, target.position.y-pointing.y*target.size*3,
         target.position.x-pointing.x*size,          target.position.y-pointing.y*size);
  }
  
  public void strike(Ball target){
    if(!visible) return;
    PVector pointing = new PVector(mouseX, mouseY).sub(target.position).setMag(-1);
    target.applyForce(pointing.mult(5));
  }
}
