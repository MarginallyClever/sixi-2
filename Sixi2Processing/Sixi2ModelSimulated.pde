// has no network connection.  instantaneous teleport to commanded location.
// always ready
// a better model would interpolate over time to simulate the real robot.  Would sometimes be not ready.
// an even better model would simulate jacobians and calculate all forces, plus detect collisions.

class Sixi2ModelSimulated extends Sixi2Model {  
  public Sixi2ModelSimulated() {
    super();
    readyForCommands=true;
    c=color(0,0,255);
  }

  void update(float dt) {}
  
  void sendCommand(String command) {
    if(command==null) return;  // no more commands.
    //print(" >>"+command);
    
    // parse the command and update the model immediately.
    String [] tok = command.split("\\s+");
    for( String t : tok ) {
      if( t.equals("G0") ) gMode=0;// move
      if( t.equals("G90") ) relativeMode=false;
      if( t.equals("G91") ) relativeMode=true;
        
      if(gMode==0) {
        for( DHLink2D n : links ) {
          if( t.startsWith(n.letter) ) {
            n.angle = Float.parseFloat(t.substring(1)) + (relativeMode ? n.angle : 0);
          }
        }
      }
    }
  }
}
