public class RectangleTable extends PoolTable{

  public RectangleTable(float w, float h, float smoothness, float wall, float holeSize){
    super(smoothness, wall);
    shape = new Rectangle(new PVector(0,0), w, h);
    this.pockets = new Hole[] {new Hole(-w, h, holeSize, 0), new Hole(0, h, holeSize, 1), new Hole(w, h, holeSize, 2),
                               new Hole(-w,-h, holeSize, 3), new Hole(0,-h, holeSize, 4), new Hole(w,-h, holeSize, 5)};
  }

}

public class EllipseTable extends PoolTable{

  public EllipseTable(float w, float h, float smoothness, float wall, float holeSize){
    super(smoothness, wall);
    shape = new Ellipse(new PVector(0,0), w, h);
    
    float magic_y = w*h / sqrt(3*h*h+w*w); // (magic_x,magic_y) is the point at which theta=pi/6 intersects the ellipse
    float magic_x = sqrt(3) * magic_y;
    this.pockets = new Hole[] {                       new Hole(0, h, holeSize, 0),
                                new Hole(-magic_x, magic_y, holeSize, 1), new Hole(magic_x, magic_y, holeSize, 2),
                                new Hole(-magic_x,-magic_y, holeSize, 3), new Hole(magic_x,-magic_y, holeSize, 4),
                                                      new Hole(0,-h, holeSize, 5)};
  }

}

public class BlobTable extends PoolTable{
  
  public BlobTable(PVector[] joins, PVector[] controls, float smoothness, float wall, float holeSize){
    super(smoothness, wall);
    
    // joins/controls MUST go clockwise, controls must be in between joins, joins' x values cannot stay the same or temporarily jump in the wrong direction
    shape = new Blob(new PVector(0,0), joins, controls);

    this.pockets = new Hole[joins.length]; // hole at each join
    for(int i=0; i<joins.length; i++){
      this.pockets[i] = new Hole(joins[i], holeSize, i);
    }
  }
  
}
