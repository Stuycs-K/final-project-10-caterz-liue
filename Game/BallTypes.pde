public class NormalBall extends Ball {
  public NormalBall(PVector position, float size, int number, color ballColor, String type) {
    super(position, size, number, ballColor, type);
  }
  public NormalBall(float x, float y, float size, int number, color ballColor, String type) {
    super(x, y, size, number, ballColor, type);
  }
}

public class CueBall extends Ball {
  public CueBall(PVector position, float size) {
    super(position, size, 0, WHITE, "cue");
  }
  public CueBall(float x, float y, float size) {
    super(x, y, size, 0, WHITE, "cue");
  }
}

public class EightBall extends Ball {
  public EightBall(PVector position, float size) {
    super(position, size, 8, BLACK, "eight");
  }
  public EightBall(float x, float y, float size) {
    super(x, y, size, 8, BLACK, "eight");
  }
}
