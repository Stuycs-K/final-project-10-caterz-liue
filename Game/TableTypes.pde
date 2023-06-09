public class RectangleTable extends PoolTable{

  public RectangleTable(float w, float h, float smoothness, float wall, float holeSize, float rot){
    super(smoothness, wall, holeSize);
    shape = new Rectangle(new PVector(0,0), w, h, rot);
    
    PVector[] positions = new PVector[] {new PVector(-w,-h), new PVector(0,-h), new PVector(w,-h),
                                         new PVector(-w, h), new PVector(0, h), new PVector(w, h)};
    generatePockets(rot, positions);
  }

}

public class EllipseTable extends PoolTable{

  public EllipseTable(float w, float h, float smoothness, float wall, float holeSize, float rot){
    super(smoothness, wall, holeSize);
    shape = new Ellipse(new PVector(0,0), w, h, rot);
    
    float magic_y = w*h / sqrt(3*h*h+w*w); // (magic_x,magic_y) is the point at which theta=pi/6 intersects the ellipse
    float magic_x = sqrt(3) * magic_y;
    PVector[] positions = new PVector[] {                     new PVector(0, -h),
                                         new PVector(-magic_x,-magic_y), new PVector(magic_x,-magic_y),
                                         new PVector(-magic_x, magic_y), new PVector(magic_x, magic_y),
                                                              new PVector(0,h)};
    generatePockets(rot, positions);
  }

}

public class BlobTable extends PoolTable{
  
  public BlobTable(PVector[] joins, PVector[] controls, float smoothness, float wall, float holeSize){
    super(smoothness, wall, holeSize);
    // joins/controls MUST go clockwise, controls must be in between joins, joins' x values cannot stay the same or temporarily jump in the wrong direction
    shape = new Blob(new PVector(0,0), joins, controls);

    generatePockets(0, joins); // pocket at each join
  }
  
}
