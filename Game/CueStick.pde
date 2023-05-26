public class CueStick {
  public boolean visible = false;
  
  public CueStick(){};
  
  public void show(){
    visible = true;
  }
  
  public void hide(){
    visible = false;
  }
  
  public void render(Ball target){
    if(!visible) return;
    stroke(0);
    line(target.position.x, target.position.y, mouseX, mouseY);
  }
}
