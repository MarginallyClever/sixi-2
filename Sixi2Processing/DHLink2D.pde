class DHLink2D {
  String letter;
  float angle;  // degrees
  float boneLength;
  Point2D p;
  
  public DHLink2D(String letter,float angle,float boneLength) {
    this.letter = letter;
    this.angle = angle;
    this.boneLength = boneLength;
    angle=0;
    p = new Point2D();
    refreshPose();
  }
  
  public void refreshPose() {
    float radians=radians(0);
    float c=cos(radians);
    float s=sin(radians);
    p.x = c*boneLength;// -s*boneLengthY;
    p.y = s*boneLength;// +c*boneLengthY;
  }
};
