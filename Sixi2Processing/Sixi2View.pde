class Sixi2View {
  void load() {
  }
  
  void render(Sixi2Model m) {
    if(m==null) return;
    
    stroke(m.c);
    
    pushMatrix();
      translate(10,10);
      translate(
        m.p.x,
        m.p.y
      );
      
      for(int i=0;i<m.links.length;++i) {
        DHLink2D n = m.links[i];
        rotate(radians(n.angle));
        line(0,0,n.p.x,n.p.y);
        translate(n.p.x,n.p.y);
      }
    popMatrix();
    
    color cOn=color(255);
    color cOff=color(255,0,0);
    
    fill(0,255,255);
    int textHeight=12;
    int c=textHeight;
    text("[~]   "+(sixi2.operatingMode==OperatingMode.LIVE  ?"LIVE":"SIMULATED" ), 0,c);    c+=textHeight;
    text("[TAB] "+(sixi2.controlMode  ==ControlMode.REAL_TIME?"REAL TIME":"PLAYBACK"), 0,c);    c+=textHeight;
    fill(sixi2.cycleStart ?cOn:cOff); text("[SHIFT+ENTER] cycle start", 0,c);    c+=textHeight;
    fill(sixi2.singleBlock?cOn:cOff); text("[S] Single block",0,textHeight*4);    c+=textHeight;
    fill(cOn);
    //fill(sixi2.recording.m01break   ?cOn:cOff); text("[Unset] M01 break"   ,0,textHeight*6);
    text("[SPACE] reset", 0,c);    c+=textHeight;
    text("[ENTER] set current keyframe to joystick position", 0,c);    c+=textHeight;
    text("[DEL] remove previous keyframe", 0,c);    c+=textHeight;
    text("[BACKSPACE] remove this keyframe", 0,c);    c+=textHeight;
    text("[+] insert after the current keyframe", 0,c);    c+=textHeight;
    text("[<] select previous keyframe", 0,c);    c+=textHeight;
    text("[>] select next keyframe", 0,c);    c+=textHeight;
    text("[1...6] select robot arm joint (now "+(sixi2.selectedJoint+1)+")", 0,c);    c+=textHeight;
    text("[MOUSE WHEEL] change angle of selected joint", 0,c);    c+=textHeight;
  }
}
