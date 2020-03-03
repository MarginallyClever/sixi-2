// 
// 2020-02-26 dan@marginallyclever.com
/*
draw blue robot, simulation.
draw yellow robot, live.

- there are two OperatingMode: simulation and live.
  - there is one Arm in each mode.
  
- there exists a DanceInstructor which demands a sequence of DanceMoves.
- an Arm is a Dancer that may subscribe to one or more a DanceInstructor(s).

The human has is a DanceInstructor. 

in mode simulation,
- yellow arm ignores all DanceInstructors.
- blue arm visuals come from SimulatedArm.

in mode live,
- blue arm ignores all DanceInstructors.
- commands are sent to the yellow arm model via Strings
- visuals are received from the blue arm model via Strings
*/


Sixi2Robot sixi2;
long tNextUpdate;
long MS_PER_UPDATE=30;


void setup() {
  size(800,800);
  sixi2 = new Sixi2Robot();
  sixi2.loadRecording("recording.txt");
  tNextUpdate=millis()+MS_PER_UPDATE;
}


void draw() {
  long tNow = millis();
  if(tNow>tNextUpdate) {
    sixi2.update((float)MS_PER_UPDATE/1000.0);
    tNextUpdate+=MS_PER_UPDATE;
  }
  
  background(128);
  sixi2.render();
}


void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  sixi2.changePosition(e);
}


boolean shiftPressed=false;
void keyPressed() {
  if(keyCode==SHIFT) shiftPressed=true;
}

void keyReleased() {
  if(keyCode==SHIFT) shiftPressed=false;
  sixi2.handleInput();
}
