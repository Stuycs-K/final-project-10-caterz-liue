public class NormalBall extends Ball {
  public NormalBall(PVector position, int size, int number, color ballColor, String type) {
    super(position, size, number, ballColor, type);
  }
  public NormalBall(float x, float y, int size, int number, color ballColor, String type) {
    super(x, y, size, number, ballColor, type);
  }

  public void render() {
    fill(ballColor);
    circle(position.x, position.y, size);

    PVector relativePos = new PVector(mouseX, mouseY).sub(VISUAL_OFFSET).sub(position).limit(20);

    fill(WHITE);
    PShape cover;
    cover = createShape();
    cover.beginShape();
    cover.fill(BLACK);
    cover.arc




    if (debugOn) {
      fill(0);
      textSize(size*2);
      text(number, position.x, position.y);
    }
  }
}
