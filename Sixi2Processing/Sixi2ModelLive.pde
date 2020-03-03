
// has network connection.
// sends/receives gcode.
class Sixi2ModelLive extends Sixi2Model implements NetworkConnectionListener {
  // fake
  long arrivalTime;
  long startTime;
  float feedRate;
  DHLink2D [] poseTarget;
  DHLink2D [] poseFrom;
  DHLink2D [] poseLive;
  
  Sixi2ModelLive() {
    super();
    poseLive=load();
    poseTarget=load();
    poseFrom=load();
    readyForCommands=true;
    feedRate=50;

    c=color(255,255,0);
  }
 
  void update(float dt) {
    long tNow=millis();
    long dtms = arrivalTime - tNow;
    
    if(dtms>0) {
      float tTotal = arrivalTime - startTime;
      float tPassed = tNow - startTime;
      float tFraction = tPassed / tTotal;
      
      for(int i=0;i<links.length;++i) {
        poseLive[i].angle = (poseTarget[i].angle - poseFrom[i].angle) * tFraction + poseFrom[i].angle;
      }
    } else {
      // nothing happening, send me something.
      // all stop
      for(int i=0;i<links.length;++i) {
        poseLive[i].angle = poseTarget[i].angle;
      }
      // ready for new command
      // report back through network connection.
      dataAvailable(null,"> ");
    }
    
    // oh and here's where I'm at.
    String message = "D17";
    for(int i=0;i<poseLive.length;++i) {
      message += " "+poseLive[i].letter+poseLive[i].angle;
    }
    dataAvailable(null,message);
  }
  
  void sendCommand(String command) {
    if(command==null) return;  // no more commands.
    print(" >>"+command);

    // parse the command and update the model immediately.
    String [] tok = command.split("\\s+");
    for( String t : tok ) {
      if( t.equals("G0") ) gMode=0;// move
      if( t.equals("G90") ) relativeMode=false;
      if( t.equals("G91") ) relativeMode=true;
      
      if(gMode==0) {
        for( DHLink2D n : poseTarget ) {
          if( t.startsWith(n.letter) ) {
            n.angle = Float.parseFloat(t.substring(1)) + (relativeMode ? n.angle : 0);
          }
        }
    
        float dMax=0;
        float dp=0;
        for(int i=0;i<poseLive.length;++i) {
          poseFrom[i].angle = poseLive[i].angle;
          float dAbs = abs(poseTarget[i].angle - poseFrom[i].angle);
          dp+=dAbs;
          if(dMax<dAbs) dMax=dAbs;
        }
        print(" dp="+nf(dp,0,2));
        
        if(dp==0) return;
        
        float travelS = dMax/feedRate;
        long travelMs = ceil(travelS*1000.0);
        startTime=millis();
        arrivalTime=startTime+travelMs;
        print(" arrives in "+travelS+"s");
    
        // wait for reply
        readyForCommands=false;
      }
    }
  }
  
  public void lineError(NetworkConnection arg0,int lineNumber) {
    readyForCommands=false;
    
  }
  
  public void sendBufferEmpty(NetworkConnection arg0) {
    // just because the buffer is empty does not mean the robot is ready to receive. 
  }

  public void dataAvailable(NetworkConnection arg0,String data) {
    if(data.equals("> ")) {
      //print(" READY");
      readyForCommands=true;
    }
    // all other data should probably update model
    if(data.startsWith("D17")) {
      //print(" <<"+data);
      String [] tokens = data.split("\\s+");
      int i=0;
      for( String t : tokens ) {
        for( DHLink2D n : links ) {
          if(t.startsWith(n.letter)) {
            n.angle = Float.parseFloat(t.substring(1));
          }
        }
      }
    }
  }
}
