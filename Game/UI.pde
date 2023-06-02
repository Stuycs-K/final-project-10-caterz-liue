public class UI {
  
  int currentPlayer = 1;
  String player1;
  String player2;
  boolean stripesDone = false;
  boolean solidsDone = false;
  boolean stripes8balled = false;
  boolean solids8balled = false;
  int nullCounter = 0;
  boolean firstBallPocketed = false;
  boolean gameOver = false;
  float size = 2;
  
  PVector[] trackerPositions = new PVector[]{
  new PVector(0,0), // for cue ball
  new PVector(-340,340), new PVector(-300,340), new PVector(-260,340), new PVector(-220,340), new PVector(-180,340), new PVector(-140,340), new PVector(-100,340),
  new PVector(0,0), // for eight ball
  new PVector(100,340), new PVector(140,340), new PVector(180,340), new PVector(220,340), new PVector(260,340), new PVector(300,340), new PVector(340,340)
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
    textSize(60);
    fill(0,0,0);
    textAlign(CENTER);
    text("PLAYER " + currentPlayer + "'S TURN", 0, VISUAL_OFFSET.y*3/5);
    textAlign(LEFT);
    
    fill(220,220,220);
    rect(-VISUAL_OFFSET.x/4*3+80, VISUAL_OFFSET.y*4/5, VISUAL_OFFSET.x/4+60, VISUAL_OFFSET.y/5-20);
    rect( VISUAL_OFFSET.x/4*3-80, VISUAL_OFFSET.y*4/5, VISUAL_OFFSET.x/4+60, VISUAL_OFFSET.y/5-20);
    textSize(40);
    fill(0,0,0);
    if(player1 != null && player1.equals("solid")){
      textAlign(CENTER);
      text("PLAYER ONE", -220, 310);
      text("PLAYER TWO", 220, 310);
    }
    if(player1 != null && player1.equals("striped")){
      textAlign(CENTER);
      text("PLAYER ONE", 220, 310);
      text("PLAYER TWO", -220, 310);
    }
    
    // only start rendering balls in UI when player types are determined
    if(player1 != null){
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
            circle(trackerPositions[i].x, trackerPositions[i].y, 10 * 1.5);
            fill(255);
            circle(trackerPositions[i].x, trackerPositions[i].y, 10);
            fill(0);
            textSize(10*2);
            text(balls[i].number, trackerPositions[i].x - 1, trackerPositions[i].y + 3);
          }
        }
      }
      else{
        solidsDone = true;
        fill(0);
        circle(-220, 340, 10 * 1.5);
        fill(255);
        circle(-220, 340, 10);
        fill(0);
        textSize(10*2);
        text(8, -220 - 1, 340 + 3);
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
            circle(trackerPositions[i].x, trackerPositions[i].y, 10 * 1.5);
            fill(255);
            circle(trackerPositions[i].x, trackerPositions[i].y, 10);
            fill(0);
            textSize(10*2);
            text(balls[i].number, trackerPositions[i].x, trackerPositions[i].y + 3);
          }
        }
      }
      else{
        stripesDone = true;
        fill(0);
        circle(220, 340, 10 * 1.5);
        fill(255);
        circle(220, 340, 10);
        fill(0);
        textSize(10*2);
        text(8, 220 - 1, 340 + 3);
      }
    }
    
    
  }
  
  public void check8ball(Ball[] balls){
    // called when the 8ball is pocketed
    if(currentPlayer == 1 && player1.equals("solids")){
      nullCounter = 0;
      for(int i = 1; i <= 7; i++){
        if(balls[i] == null){
          nullCounter++;
        }
      }
    }
    if(currentPlayer == 1 && player1.equals("stripes")){
      nullCounter = 0;
      for(int i = 9; i <= 15; i++){
        if(balls[i] == null){
          nullCounter++;
        }
      }
    }
    if(currentPlayer == 2 && player2.equals("solids")){
      nullCounter = 0;
      for(int i = 1; i <= 7; i++){
        if(balls[i] == null){
          nullCounter++;
        }
      }
    }
    if(currentPlayer == 2 && player2.equals("stripes")){
      nullCounter = 0;
      for(int i = 9; i <= 15; i++){
        if(balls[i] == null){
          nullCounter++;
        }
      }
    }

    
    if(nullCounter == 7){ // got rid of all balls already
      fill(0);
      textSize(60);
      text("PLAYER " + currentPlayer + " WINS!", 0, 0);
      gameOver = true;
    } else {
      fill(0);
      textSize(60);
      text("PLAYER " + nextTurn() + " WINS!", 0, 0);
      gameOver = true;
    }
  }
  
  public int nextTurn(){
    if(currentPlayer == 1){
      currentPlayer = 2;
    } else {
      currentPlayer = 1;
    }
    return currentPlayer;
  }
}
