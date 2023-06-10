public class UI {
  int currentPlayer = 1;
  String[] players;
  boolean stripeone;
  boolean stripePotted;
  boolean solidsDone;
  boolean solidPotted;
  boolean stripe8balled;
  boolean solids8balled;
  boolean firstBallPocketed;
  boolean gameOver;
  float size;
  int firstBallHitInATurn = 16; // 16 means no ball
  int firstBallPocketedInATurn = 16; // 16 means no ball
  String messageToDisplay = null;
  boolean showMessage = false;
  String canInitializeUI = null;
  boolean cueballPocketedOnTurn = false;
  
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
    players = new String[] {"", ""};
    stripeone = false;
    stripePotted = true;
    solidsDone = false;
    solidPotted = true;
    stripe8balled = false;
    solids8balled = false;
    firstBallPocketed = false;
    gameOver = false;
    size = 2;
  }
  
  public void render(Ball[] balls){
    if(!gameOver){
      textSize(60);
      fill(255,0,0);
      textAlign(LEFT);
      text("PLAYER", -380, -340);
      text(currentPlayer + "'S", -380, -280);
      text("TURN", -380, -215);
      /*
      fill(WHITE);
      textAlign(CENTER);
      text("PLAYER " + (currentPlayer+1) + "'S TURN", 0, VISUAL_OFFSET.y*3/5);
      */
    }
    
    fill(110,110,110); noStroke();
    rect(-VISUAL_OFFSET.x/4*3+80, VISUAL_OFFSET.y*4/5, VISUAL_OFFSET.x/4+60, VISUAL_OFFSET.y/5-20, 28);
    rect( VISUAL_OFFSET.x/4*3-80, VISUAL_OFFSET.y*4/5, VISUAL_OFFSET.x/4+60, VISUAL_OFFSET.y/5-20, 28);
    textSize(40);
    fill(WHITE);
    if(players[0].equals("solid")){
      textAlign(CENTER);
      text("PLAYER ONE", -220, 310);
      text("PLAYER TWO", 220, 310);
    }
    if(players[0].equals("stripe")){
      textAlign(CENTER);
      text("PLAYER ONE", 220, 310);
      text("PLAYER TWO", -220, 310);
    }
    
    // only start rendering balls in UI when player types are determined
    if(players[0].length() != 0){
      if(countNulls(1,7,balls) != 7){
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
      
      if(countNulls(9,15,balls) != 7){
        for(int i = 9; i <= 15; i++){
          if(balls[i] != null){
            dispBall(340-40*(15-i), 340, 10, i, balls);
          }
        }
      }
      else{
        stripeone = true;
        if(balls[8] != null){
          dispBall(220, 340, 10, 8, balls);
        }
      }
    }
    
  }
  
  public void check8ball(Ball[] balls){
    // called when the 8ball is pocketed
    int nullCounter = 0;
    System.out.println(players[currentPlayer - 1]);
    if(players[currentPlayer - 1].equals("solid")){
      nullCounter = countNulls(1,7,balls);
      System.out.println("1runs");
    }
    else if(players[currentPlayer - 1].equals("stripe")){
      nullCounter = countNulls(9,15,balls);
      System.out.println("2runs");
    }

    
    /*if(nullCounter == 7){ // got rid of all balls already
      fill(255);
      textSize(60);
      text("PLAYER " + (currentPlayer+1) + " WINS!", 0, -VISUAL_OFFSET.y/2);
      gameOver = true;
    } else {
      fill(255);
      textSize(60);
      text("PLAYER " + (1-currentPlayer+1) + " WINS!", 0, -VISUAL_OFFSET.y/2);
      gameOver = true;
    }*/
  
      /*// called when the 8ball is pocketed
      if(currentPlayer == 1 && player1.equals("solid")){
        nullCounter = countNulls(1,7,balls);
      }
      if(currentPlayer == 1 && player1.equals("stripe")){
        nullCounter = countNulls(9,15,balls);
      }
      if(currentPlayer == 2 && player2.equals("solid")){
        nullCounter = countNulls(1,7,balls);
      }
      if(currentPlayer == 2 && player2.equals("stripe")){
        nullCounter = countNulls(9,15,balls);
      }*/
  
  for(int i = 0; i < balls.length; i++){
    System.out.println(balls[i]);
  }
  System.out.println(nullCounter);
     
      if(nullCounter == 7){ // got rid of all balls already
        fill(255);
        textSize(60);
        text("PLAYER " + currentPlayer + " WINS!", 0, -VISUAL_OFFSET.y/2);
        gameOver = true;
      } else {
        fill(255);
        textSize(60);
        if(currentPlayer == 1) text("PLAYER 2 WINS!", 0, -VISUAL_OFFSET.y/2);
        else if(currentPlayer == 2) text("PLAYER 1 WINS!", 0, -VISUAL_OFFSET.y/2);
        gameOver = true;
        setMessage("8balllossfor" + currentPlayer);
        textAlign(CENTER);
        textSize(30);
        fill(255);
        text("FOUL!", 220, -335);
        textSize(20);
        text(messageToDisplay, 220, -300);
      }
    
  }
  
  public int nextTurn(){
    /*if(currentPlayer == 1){
      currentPlayer = 2;
    } else {
      currentPlayer = 1;
    }*/
    currentPlayer = currentPlayer * 2 % 3;
    
    ui.stripePotted = false;
    ui.solidPotted = false;
    firstBallHitInATurn = 16; // 16 means no ball
    firstBallPocketedInATurn = 16; // 16 means no ball
    cueballPocketedOnTurn = false;    
  
    //currentPlayer = 1 - currentPlayer;
    return currentPlayer;
  }
  
  public int countNulls(int from, int to, Ball[] balls){
    int acc = 0;
    for(int i=from; i<=to; i++){
      //System.out.println("t");
      if(balls[i] == null){
        //System.out.println("t2");
        acc++;
      }
    }
    System.out.println(acc);
    return acc;
  }
  
  public void dispBall(float x, float y, float size, int i, Ball[] balls){
    fill(balls[i].ballColor); noStroke();
    circle(x, y, size * 1.5);
    fill(WHITE);
    if(balls[i].type.equals("stripe")){
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
    if(s.equals("stripe")){
      return "solid";
    }else{
      return "stripe";
    }
  }
  
  public void messageCheck(){
    System.out.println(players[0] + " " + players[1] + " " + firstBallHitInATurn + " " + firstBallPocketedInATurn);
    if(ui.currentPlayer==1 && cueballPocketedOnTurn == true){
        ui.setMessage("cueball1");
        ui.nextTurn();
        return;
      }
      if(ui.currentPlayer==2 && cueballPocketedOnTurn == true){
        ui.setMessage("cueball2");
        ui.nextTurn();
        return;
      }
      if(ui.currentPlayer==1 && ui.firstBallHitInATurn == 16){
        ui.setMessage("notHit1");
        ui.nextTurn();
        return;
      }
      if(ui.currentPlayer==2 && ui.firstBallHitInATurn == 16){
        ui.setMessage("notHit2");
        ui.nextTurn();
        return;
      }
      if(ui.currentPlayer==1 && players[0].equals("stripe") && ui.firstBallPocketedInATurn < 8 && firstBallPocketed == true
      || ui.currentPlayer==1 && players[0].equals("solid") && ui.firstBallPocketedInATurn > 8 && ui.firstBallPocketedInATurn < 16 && firstBallPocketed == true){ // first ball pocketed is wrong type
        ui.setMessage("wrongTypePocketed1");
        ui.nextTurn();
        return;
      }
      if(ui.currentPlayer==2 && players[1].equals("stripe") && ui.firstBallPocketedInATurn < 8 && firstBallPocketed == true
      || ui.currentPlayer==2 && players[1].equals("solid") && ui.firstBallPocketedInATurn > 8 && ui.firstBallPocketedInATurn < 16 && firstBallPocketed == true){ // first ball pocketed is wrong type
        ui.setMessage("wrongTypePocketed2");
        ui.nextTurn();
        return;
      }
      if(ui.currentPlayer==1 && players[0].equals("stripe") && ui.firstBallHitInATurn <= 8 && firstBallPocketed == true
      || ui.currentPlayer==1 && players[0].equals("solid") && ui.firstBallHitInATurn >= 8 && ui.firstBallHitInATurn < 16 && firstBallPocketed == true){ // first ball hit is wrong type
        ui.setMessage("wrongTypeHit1");
        ui.nextTurn();
        return;
      }
      if(ui.currentPlayer==2 && players[1].equals("stripe") && ui.firstBallHitInATurn <= 8 && firstBallPocketed == true
      || ui.currentPlayer==2 && players[1].equals("solid") && ui.firstBallHitInATurn >= 8 && ui.firstBallHitInATurn < 16 && firstBallPocketed == true){ // first ball hit is wrong type
        ui.setMessage("wrongTypeHit2");
        ui.nextTurn();
        return;
      }
      
    if(!stripePotted && !solidPotted && gameOver == false){
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
    if(message.equals("8balllossfor1")) messageToDisplay = messages[6];
    if(message.equals("8balllossfor2")) messageToDisplay = messages[7];
    if(message.equals("cueball1")) messageToDisplay = messages[8];
    if(message.equals("cueball2")) messageToDisplay = messages[9];
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
      players[0] = type;
      players[1] = other(type);
    }else{
      players[0] = other(type);
      players[1] = type;
    }
  }
}
