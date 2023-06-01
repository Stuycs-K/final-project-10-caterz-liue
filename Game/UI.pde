public class UI {
  
  int currentPlayer = 1;
  String player1;
  String player2;
  boolean stripesDone = false;
  boolean solidsDone = false;
  boolean stripes8balled = false;
  boolean solids8balled = false;
  int nullCounter = 0;
  
  PVector[] trackerPositions = new PVector[]{
  new PVector(0,0), // for cue ball
  new PVector(-170,170), new PVector(-150,170), new PVector(-130,170), new PVector(-110,170), new PVector(-90,170), new PVector(-70,170), new PVector(-50,170),
  new PVector(0,0), // for eight ball
  new PVector(50,170), new PVector(70,170), new PVector(90,170), new PVector(110,170), new PVector(130,170), new PVector(150,170), new PVector(170,170)
  };
  
  String[] messages = new String[]{
  "You are stripes.",
  "You are solids.",
  "You did not hit your own ball.",
  "You pocketed the wrong ball.",
  "Stripes wins!",
  "Solids wins!"
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
    
    // counting nulls ------
    nullCounter = 0;
    for(int i = 1; i <= 7; i++){
      if(balls[i] == null){
        nullCounter++;
      }
    }
    if(nullCounter != 7){
      for(int i = 1; i <= 7; i++){
        if(balls[i] != null){
          fill(balls[i].ballColor);
          circle(trackerPositions[i].x, trackerPositions[i].y, 5 * 1.5);
          fill(255);
          circle(trackerPositions[i].x, trackerPositions[i].y, 5);
          fill(0);
          textSize(5*2);
          text(balls[i].number, trackerPositions[i].x - 1, trackerPositions[i].y + 3);
        }
      }
    }
    else{
      solidsDone = true;
      fill(0);
      circle(-110, 170, 5 * 1.5);
      fill(255);
      circle(-110, 170, 5);
      fill(0);
      textSize(5*2);
      text(8, -110 - 1, 170 + 3);
    }
    
    // counting nulls ------
    nullCounter = 0;
    for(int i = 9; i <= 15; i++){
      if(balls[i] == null){
        nullCounter++;
      }
    }
    if(nullCounter != 7){
      for(int i = 9; i <= 15; i++){
        if(balls[i] != null){
          fill(balls[i].ballColor);
          circle(trackerPositions[i].x, trackerPositions[i].y, 5 * 1.5);
          fill(255);
          circle(trackerPositions[i].x, trackerPositions[i].y, 5);
          fill(0);
          textSize(5*2);
          text(balls[i].number, trackerPositions[i].x, trackerPositions[i].y + 3);
        }
      }
    }
    else{
      stripesDone = true;
      fill(0);
      circle(110, 170, 5 * 1.5);
      fill(255);
      circle(110, 170, 5);
      fill(0);
      textSize(5*2);
      text(8, 110 - 1, 170 + 3);
    }
    
  }
  
  public void check8ball(Ball[] balls){
    // called when the 8ball is pocketed
    
  }
}
