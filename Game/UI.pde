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
  int firstBallHitInATurn = 16; // 16 means no ball
  int firstBallPocketedInATurn = 16; // 16 means no ball
  String messageToDisplay = null;
  boolean showMessage = false;
  String canInitializeUI = null;
  
  /*PVector[] trackerPositions = new PVector[]{
  new PVector(0,0), // for cue ball
  new PVector(-340,340), new PVector(-300,340), new PVector(-260,340), new PVector(-220,340), new PVector(-180,340), new PVector(-140,340), new PVector(-100,340),
  new PVector(0,0), // for eight ball
  new PVector(100,340), new PVector(140,340), new PVector(180,340), new PVector(220,340), new PVector(260,340), new PVector(300,340), new PVector(340,340)
  };*/
  
  String[] messages = new String[]{
  "Player 1 did not hit any balls.",
  "Player 2 did not hit any balls.",
  "Player 1 did not hit their ball type first.",
  "Player 2 did not hit their ball type first.",
  "Player 1 pocketed the wrong ball type.",
  "Player 2 pocketed the wrong ball type.",
  "Player 1 illegally pocketed the 8-ball.",
  "Player 2 illegally pocketed the 8-ball.",
  "Player 1 pocketed the cue ball.",
  "Player 2 pocketed the cue ball."
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
    
    ui.stripePotted = false;
    ui.solidPotted = false;
    cuestickUsed = false;
    firstBallHitInATurn = 16; // 16 means no ball
    firstBallPocketedInATurn = 16; // 16 means no ball
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
  
  public void messageCheck(){
    /*if(ui.player1.equals("solid") && ui.firstBallHitInATurn < 8
    || ui.player1.equals("striped") && ui.firstBallHitInATurn > 8 && ui.firstBallHitInATurn < 16
    || ui.player1 == null
    || ui.player2.equals("solid") && ui.firstBallHitInATurn < 8
    || ui.player2.equals("striped") && ui.firstBallHitInATurn > 8 && ui.firstBallHitInATurn < 16
    || ui.player2 == null){ // ball hits well
      ui.nextTurn();
    } else { // ball hits badly
      
  }*/
  System.out.println(player1 + " " + player2 + " " + firstBallHitInATurn + " " + firstBallPocketedInATurn);
    if(ui.currentPlayer==1 && ui.firstBallHitInATurn == 16){
        System.out.println("h1");
        ui.setMessage("notHit1");
        ui.nextTurn();
        return;
      }
      if(ui.currentPlayer==2 && ui.firstBallHitInATurn == 16){
        System.out.println("h2");
        ui.setMessage("notHit2");
        ui.nextTurn();
        return;
      }
      if(ui.currentPlayer==1 && ui.player1.equals("striped") && ui.firstBallPocketedInATurn < 8 && firstBallPocketed == true
      || ui.currentPlayer==1 && ui.player1.equals("solid") && ui.firstBallPocketedInATurn > 8 && ui.firstBallPocketedInATurn < 16 && firstBallPocketed == true){ // first ball pocketed is wrong type
        System.out.println("test1");
        ui.setMessage("wrongTypePocketed1");
        ui.nextTurn();
        return;
      }
      if(ui.currentPlayer==2 && ui.player2.equals("striped") && ui.firstBallPocketedInATurn < 8 && firstBallPocketed == true
      || ui.currentPlayer==2 && ui.player2.equals("solid") && ui.firstBallPocketedInATurn > 8 && ui.firstBallPocketedInATurn < 16 && firstBallPocketed == true){ // first ball pocketed is wrong type
        System.out.println("test2");
        ui.setMessage("wrongTypePocketed2");
        ui.nextTurn();
        return;
      }
      if(ui.currentPlayer==1 && ui.player1.equals("striped") && ui.firstBallHitInATurn < 8 && firstBallPocketed == true
      || ui.currentPlayer==1 && ui.player1.equals("solid") && ui.firstBallHitInATurn > 8 && ui.firstBallHitInATurn < 16 && firstBallPocketed == true){ // first ball hit is wrong type
        System.out.println("test1");
        ui.setMessage("wrongTypeHit1");
        ui.nextTurn();
        return;
      }
      if(ui.currentPlayer==2 && ui.player2.equals("striped") && ui.firstBallHitInATurn < 8 && firstBallPocketed == true
      || ui.currentPlayer==2 && ui.player2.equals("solid") && ui.firstBallHitInATurn > 8 && ui.firstBallHitInATurn < 16 && firstBallPocketed == true){ // first ball hit is wrong type
        System.out.println("test2");
        ui.setMessage("wrongTypeHit2");
        ui.nextTurn();
        return;
      }
      
    if(!stripePotted && !solidPotted){
      ui.nextTurn();
    }
  }
  
  public void setMessage(String message){
    messageToDisplay = messages[0]; // temporary initialization
    if(message.equals("notHit1")) messageToDisplay = messages[0];
    if(message.equals("notHit2")) messageToDisplay = messages[1];
    if(message.equals("wrongTypeHit1")) messageToDisplay = messages[2];
    if(message.equals("wrongTypeHit2")) messageToDisplay = messages[3];
    if(message.equals("wrongTypePocketed1")) messageToDisplay = messages[4];
    if(message.equals("wrongTypePocketed2")) messageToDisplay = messages[5];
    if(message.equals("8ball1")) messageToDisplay = messages[6];
    if(message.equals("8ball2")) messageToDisplay = messages[7];
    showMessage = true;
  }
  
  public void displayMessage(String messageToDisplay, int brightness){
    textAlign(CENTER);
    textSize(30);
    fill(brightness);
    text("FOUL!", 220, -335);
    textSize(20);
    text(messageToDisplay, 220, -300);
    if(brightness == 255) showMessage = false;
  }
  
  public void initializeUI(String type){
    firstBallPocketed = true;
    if(currentPlayer == 1){
      player1 = type;
      player2 = other(type);
    }else{
      player1 = other(type);
      player2 = type;
    }
  }
}
