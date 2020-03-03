class Sixi2Model {
  color c;
  Point2D p;
  DHLink2D [] links;
  
  boolean readyForCommands;
  int gMode=0;
  boolean relativeMode=false;
  
  protected Sixi2Model() {
    p=new Point2D();
    c=color(0);

    gMode=0;
    
    links = load();
  }
  
  DHLink2D [] load() {
    DHLink2D [] linkSet = new DHLink2D[6];
    linkSet[0]= new DHLink2D("X",10,50*5);
    linkSet[1]= new DHLink2D("Y",10,40*5);
    linkSet[2]= new DHLink2D("Z",10,30*5);
    linkSet[3]= new DHLink2D("U",10,20*5);
    linkSet[4]= new DHLink2D("V",10,10*5);
    linkSet[5]= new DHLink2D("W",10,5*5);
    return linkSet;
  }
  
  void update(float dt) {}
  
  void sendCommand(String command) {}
  
  String getCommand() { 
    String gcode = "G0";
    for(int i=0;i<links.length;++i) {
      gcode += " " + links[i].letter + links[i].angle;
    }
    return gcode;
  }
}
