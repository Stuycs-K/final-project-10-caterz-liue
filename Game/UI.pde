public class UI {
  public UI(){
  }
  
  public void render(){
    fill(220,220,220);
    rect(-110,160,80,30);
    rect(110,160,80,30);
    textSize(20);
    fill(0,0,0);
    textAlign(CENTER);
    text("PLAYER ONE", -110, 155);
    textAlign(CENTER);
    text("PLAYER TWO", 110, 155);
    
  }
}
