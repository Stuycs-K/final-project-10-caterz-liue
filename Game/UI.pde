public class UI {
  int currentPlayer = 1;
  String player1;
  String player2;
  boolean stripesDone;
  boolean stripePotted;
  boolean solidsDone;
  boolean solidPotted;
  boolean stripes8balled;
  boolean solids8balled;
  int nullCounter;
  int previousTurnNulls;
  boolean firstBallPocketed;
  boolean gameOver;
  float size;
  
  /*PVector[] trackerPositions = new PVector[]{
  new PVector(0,0), // for cue ball
  new PVector(-340,340), new PVector(-300,340), new PVector(-260,340), new PVector(-220,340), new PVector(-180,340), new PVector(-140,340), new PVector(-100,340),
  new PVector(0,0), // for eight ball
  new PVector(100,340), new PVector(140,340), new PVector(180,340), new PVector(220,340), new PVector(260,340), new PVector(300,340), new PVector(340,340)
  };*/
  
  String[] messages = new String[]{
  "You are stripes.",
  "You are solids.",
  "You did not hit your own ball.",
  "You pocketed the wrong ball.",
  "Stripes wins!",
  "Solids wins!"
  };
  
  public UI(){
    player1 = "";
    player2 = "";
    stripesDone = false;
    stripePotted = true;
    solidsDone = false;
    solidPotted = true;
    stripes8balled = false;
    solids8balled = false;
    nullCounter = 0;
    previousTurnNulls = -1;
    firstBallPocketed = false;
    gameOver = false;
    size = 2;
  }
  
  public void render(Ball[] balls){
    if(!gameOver){
      textSize(60);
      fill(0,0,0);
      textAlign(CENTER);
      text("PLAYER " + currentPlayer + "'S TURN", 0, VISUAL_OFFSET.y*3/5);
    }
    
    fill(220,220,220);
    rect(-VISUAL_OFFSET.x/4*3+80, VISUAL_OFFSET.y*4/5, VISUAL_OFFSET.x/4+60, VISUAL_OFFSET.y/5-20);
    rect( VISUAL_OFFSET.x/4*3-80, VISUAL_OFFSET.y*4/5, VISUAL_OFFSET.x/4+60, VISUAL_OFFSET.y/5-20);
    textSize(40);
    fill(0,0,0);
    if(player1.equals("solid")){
      textAlign(CENTER);
      text("PLAYER ONE", -220, 310);
      text("PLAYER TWO", 220, 310);
    }
    if(player1.equals("striped")){
      textAlign(CENTER);
      text("PLAYER ONE", 220, 310);
      text("PLAYER TWO", -220, 310);
    }
    
    // only start rendering balls in UI when player types are determined
    if(player1.length() != 0){
      nullCounter = countNulls(1,7,balls);
      //System.out.println(nullCounter);
      if(nullCounter != 7){
        for(int i = 1; i <= 7; i++){
          if(balls[i] != null){
            dispBall(-380+40*i, 340, 10, i, balls);
          }
        }
      }
      else{
        solidsDone = true;
        if(balls[8] != null){
          dispBall(-220, 340, 10, 8, balls);
        }
      }
      
      nullCounter = countNulls(9,15,balls);
      if(nullCounter != 7){
        for(int i = 9; i <= 15; i++){
          if(balls[i] != null){
            dispBall(340-40*(15-i), 340, 10, i, balls);
          }
        }
      }
      else{
        stripesDone = true;
        if(balls[8] != null){
          dispBall(220, 340, 10, 8, balls);
        }
      }
    }
    
  }
  
  public void check8ball(Ball[] balls){
    // called when the 8ball is pocketed
    if(currentPlayer == 1 && player1.equals("solids")){
      nullCounter = countNulls(1,7,balls);
    }
    if(currentPlayer == 1 && player1.equals("stripes")){
      nullCounter = countNulls(9,15,balls);
    }
    if(currentPlayer == 2 && player2.equals("solids")){
      nullCounter = countNulls(1,7,balls);
    }
    if(currentPlayer == 2 && player2.equals("stripes")){
      nullCounter = countNulls(9,15,balls);
    }

    
    if(nullCounter == 7){ // got rid of all balls already
      fill(0);
      textSize(60);
      text("PLAYER " + currentPlayer + " WINS!", 0, -VISUAL_OFFSET.y/2);
      gameOver = true;
    } else {
      fill(0);
      textSize(60);
      text("PLAYER " + nextTurn() + " WINS!", 0, -VISUAL_OFFSET.y/2);
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
  
  public int countNulls(int from, int to, Ball[] balls){
    int acc = 0;
    for(int i=from; i<=to; i++){
      if(balls[i] == null){
        acc++;
      }
    }
    return acc;
  }
  
  public void dispBall(float x, float y, float size, int i, Ball[] balls){
    fill(balls[i].ballColor);
    circle(x, y, size * 1.5);
    fill(WHITE);
    if(balls[i].type.equals("striped")){
      arc(x, y, size * 1.5, size * 1.5, asin(2./3), PI-asin(2./3), CHORD);
      arc(x, y, size * 1.5, size * 1.5, -PI+asin(2./3), -asin(2./3), CHORD);
    }else{
      circle(x, y, size);
    }
    fill(BLACK);
    textSize(size*2);
    text(balls[i].number, x - 1, y + 6);
  }
  
  public String other(String s){
    if(s.equals("striped")){
      return "solid";
    }else{
      return "striped";
    }
  }
}
