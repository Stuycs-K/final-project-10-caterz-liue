public class UI {
  
  PVector[] trackerPositions = new PVector[]{
  new PVector(0,0), // for cue ball
  new PVector(-170,170), new PVector(-150,170), new PVector(-130,170), new PVector(-110,170), new PVector(-90,170), new PVector(-70,170), new PVector(-50,170),
  new PVector(0,0), // for eight ball
  new PVector(50,170), new PVector(70,170), new PVector(90,170), new PVector(110,170), new PVector(130,170), new PVector(150,170), new PVector(170,170)
  };
  
  public UI(){
  }
  
  public void render(Ball[] balls){
    fill(220,220,220);
    rect(-110,160,80,30);
    rect(110,160,80,30);
    textSize(20);
    fill(0,0,0);
    textAlign(CENTER);
    text("PLAYER ONE", -110, 155);
    textAlign(CENTER);
    text("PLAYER TWO", 110, 155);
    
    System.out.println(balls);
    for(int i = 0; i <= 15; i++){
      if(balls[i] != null && i != 8 && i != 0){
        fill(balls[i].ballColor);
        circle(trackerPositions[i].x, trackerPositions[i].y, balls[i].size * 1.5);
        fill(255);
        textSize(balls[i].size*2);
        text(balls[i].number, trackerPositions[i].x, trackerPositions[i].y);
      }
    }
  }
}
