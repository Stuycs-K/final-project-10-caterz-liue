public class CueStick {
  public boolean visible = false;
  public float len;
  public float wide;

  public CueStick(float len, float wide) {
    this.len = len;
    this.wide = wide;
  }

  public void show() {
    visible = true;
  }

  public void hide() {
    visible = false;
  }

  public void render(PoolTable table, Ball target) {
    if (!visible) return;
    PVector relativePos = new PVector(mouseX, mouseY).sub(VISUAL_OFFSET).sub(target.position);
    PVector start = relativePos.copy().div(2);
    PVector end   = relativePos.copy().setMag(start.mag()+len);

    stroke(BROWN);
    strokeWeight(wide);
    line(target.position.x + end.x,   target.position.y + end.y,
         target.position.x + start.x, target.position.y + start.y);

    PVector pointing = relativePos.copy().rotate(PI).div(len).mult(4);
    //pointing.mult(1-pow(table.smoothness, ceil(log(.1/pointing.mag())/log(table.smoothness)))).div(1-table.smoothness); // exact
    pointing.setMag(pointing.mag()-.1).div(1-table.smoothness); // approximate
    // starting velocity: pointing.mag() = v0
    // rate of change: table.smoothness = s
    // exact total velocity: finite geometric series, a(1-r^n)/(1-r)
    //                       final term is when vn<=.1, which is when v0*(s)^n<=.1 -> n >= log_s(.1/v0) = ceil(log(.1/v0)/log(s))
    //                       -> v0(1-s^ceil(log(.1/v0)/log(s)))/(1-s)
    // approximation:        -> v0(1-s^log(.1/v0)/log(s))/(1-s) = v0(1-10^log(.1/v0))/(1-s) = v0(1-.1/v0)/(1-s) = (v0-.1)/(1-s)

    stroke(WHITE);
    strokeWeight(wide/5);
    line(target.position.x,              target.position.y,
         target.position.x + pointing.x, target.position.y + pointing.y);
  }

  public void strike(Ball target) {
    if (!visible) return;
    PVector relativePos = new PVector(mouseX, mouseY).sub(VISUAL_OFFSET).sub(target.position);
    PVector pointing = relativePos.rotate(PI).div(len).mult(4);
    target.applyForce(pointing);
  }
}
