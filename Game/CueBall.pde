public class CueBall extends Ball {
  
  /*public CueBall(PVector position_, int size_){
    super(position_, 0, color(255), size_);
  }*/
  
  public CueBall(PVector position_, int number_, int ballColor_, int size_){
    super(position_, number_, ballColor_, size_, "cue");
  }
  public CueBall(float x, float y, int number_, int ballColor_, int size_){
    super(x, y, number_, ballColor_, size_, "cue");
  }
}
