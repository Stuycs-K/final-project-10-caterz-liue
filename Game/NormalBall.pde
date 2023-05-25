public class NormalBall extends Ball {
  public NormalBall(PVector position_, int number_, int ballColor_, int size_, String type_){
    super(position_, number_, ballColor_, size_, type_);
  }
  public NormalBall(float x, float y, int number_, int ballColor_, int size_, String type_){
    super(x, y, number_, ballColor_, size_, "cue");
  }
}
