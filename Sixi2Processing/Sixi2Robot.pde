enum OperatingMode {
  LIVE,
  SIM,
};

enum ControlMode {
  REAL_TIME,
  RECORD,
};


// Robot is a facade for a model-view-controller pattern.
// it controls a live robot by sending it text commands in GCODE format.
// it controls a simulated robot the exact same way.
// commands may come from any input source.  Currently these are: the joystick, the human, and the recording. 
class Sixi2Robot {
  private OperatingMode operatingMode;
  private ControlMode   controlMode;
  
  Sixi2ModelLive       modelLive;
  Sixi2ModelSimulated  modelSim;
  
  Sixi2View            view;
  RecordingView        rcView;
  
  Recording            recording;
  
  float tTotal=0;
  int selectedJoint=0;
  
  boolean singleBlock;
  boolean cycleStart;
  boolean m01break;
  
  //--------------------------------------------------------
  
  Sixi2Robot() {
    recording = new Recording();
    
    modelLive = new Sixi2ModelLive();
    modelSim = new Sixi2ModelSimulated();
    
    view = new Sixi2View();
    rcView = new RecordingView();

    operatingMode = OperatingMode.SIM;
    controlMode=ControlMode.REAL_TIME;
  }

  void reset() {
    recording.reset();
    singleBlock=false;
    cycleStart=false;
    m01break=true;
    //modelSim.sendCommand(recording.getCommand());
  }
  
  OperatingMode getOperatingMode() { return operatingMode; }
  void toggleOperatingMode() {
    operatingMode = (operatingMode==OperatingMode.LIVE) ? OperatingMode.SIM : OperatingMode.LIVE;
  }
  
  ControlMode getControlMode() { return controlMode; }
  
  void toggleControlMode() {
    controlMode = (controlMode==ControlMode.REAL_TIME) ? ControlMode.RECORD : ControlMode.REAL_TIME;
    
    if(controlMode==ControlMode.REAL_TIME) {
      // move the joystick to match the simulated position?
    }
    
    reset();
  }
  
  
  void update(float dt) {
    print(nf(tTotal,5,3)+" ");
    tTotal+=dt;
    
    Sixi2Model activeModel = null;
    switch(operatingMode) {
      case LIVE: activeModel = modelLive; break;
      case SIM : activeModel = modelSim;  break;
    }

    if(activeModel!=null) {
      if(activeModel.readyForCommands) {
        if(controlMode==ControlMode.REAL_TIME) {
          activeModel.sendCommand(modelSim.getCommand());
        } else {
          if(cycleStart && recording.hasNext()) {
            activeModel.sendCommand(recording.next());
            if(singleBlock) {
              cycleStart=false;
            }
          } else {
            cycleStart=false;
          }
        }
      }
      activeModel.update(dt);
    }
    println();
  }
  
  void render() {
    switch(operatingMode) {
      case LIVE:
        if(modelLive!=null) view.render(modelLive);
        // in live mode the sim can't be seen.
        break;
      case SIM:
        if(modelSim!=null) view.render(modelSim);
        // in sim mode, also render the live modelLive.
        if(modelLive!=null) view.render(modelLive);
        break;
    }
    
    rcView.render(recording);
  }
  
  void changePosition(float e) {
    modelSim.links[selectedJoint].angle += e;
  }
  
  // key released
  void handleInput() {
    if(key>='1' && key <='6') {
      selectedJoint = (key-'1');
    }
    
    if(key==TAB) {
      toggleControlMode();
    }
    if(key=='`' || key=='~') {
      toggleOperatingMode();
    }
  
    if(key==' ') {  // stop and reset
      reset();
    }
    if(key=='s') {
      toggleSingleBlock();
    }
    
    if(shiftPressed) {
      if((keyCode==ENTER || keyCode==RETURN)) {
        // shift+enter
        // toggle start/stop
        if(controlMode==ControlMode.RECORD) {
          toggleCycleStart();
        }
      }
    } else {
      if((keyCode==ENTER || keyCode==RETURN)) {
        // no shift + enter
        if(controlMode==ControlMode.REAL_TIME) {
          println("add command");
          recording.addCommand(modelSim.getCommand());
        }
      }
    
      if(key=='/' || key=='?') {
        recording.setCommand(modelSim.getCommand());
      }
      if(key=='+') {
        recording.addCommand(modelSim.getCommand());
      }
      
      if(key==DELETE) {
        recording.deleteCurrentCommand();
      }
      if(key==BACKSPACE) {
        recording.deletePreviousCommand();
      }
      if(key=='<' || key==',') {  // previous command
        if(recording.hasPrev()) {
          String line=recording.prev();
          modelSim.sendCommand(line);
        }
      }
      if(key=='>' || key=='.') {  // next command
        if(recording.hasNext()) {
          String line=recording.next();
          modelSim.sendCommand(line);
        }
      }
    }
  }
  
  void toggleCycleStart() {
    cycleStart = !cycleStart;
  }
  
  void toggleSingleBlock() {
    singleBlock = !singleBlock;
  }
  
  void loadRecording(String filename) {
    recording.loadRecording(filename); //<>//
  }
}
