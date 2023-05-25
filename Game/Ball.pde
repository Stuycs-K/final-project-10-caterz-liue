public abstract class Ball {
  PVector position;
  PVector velocity;
  PVector acceleration;
  int number;
  color ballColor;
  boolean pocketed;
  int size;
  String type;
  
  color WHITE = color(255,255,255);
  color RED = color(255,0,0);
  color ORANGE = color(255,145,0);
  color YELLOW = color(255,247,0);
  color GREEN = color(215,10,0);
  color BLUE = color(0,70,215);
  color PURPLE = color(155,0,230);
  color BROWN = color(165,80,0);
  color BLACK = color(0,0,0);
  
  public Ball(PVector position_, int number_, int ballColor_, int size_, String type_){
    position = position_;
    velocity = new PVector(0,0,0);
    acceleration = new PVector(0,0,0);
    number = number_;
    ballColor = ballColor_;
    pocketed = false;
    size = size_;
    type = type_;
    
    //circle(position.x,position.y,size);
  }
  
  public Ball(){
  }
}
