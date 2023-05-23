public abstract class Ball {
  PVector position;
  PVector velocity;
  PVector acceleration;
  int number;
  color ballColor;
  boolean pocketed;
  int size;
  
  public Ball(PVector position_, int number_, color ballColor_, int size_){
    position = position_;
    velocity = new PVector(0,0,0);
    acceleration = new PVector(0,0,0);
    number = number_;
    ballColor = ballColor_;
    pocketed = false;
    size = size_;
  }
  
  public Ball(){
  }
}
