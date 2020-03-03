class Sixi2View {
  int textHeight=12;
  int lineHeight=textHeight+2;
  int margin=5;
    
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
    textSize(textHeight);
    int c=textHeight+margin;
    text("[~]   "+(sixi2.operatingMode==OperatingMode.LIVE  ?"LIVE":"SIMULATED" ), margin,c);    c+=lineHeight;
    text("[TAB] "+(sixi2.controlMode  ==ControlMode.REAL_TIME?"REAL TIME":"PLAYBACK"), margin,c);    c+=lineHeight;
    fill(sixi2.cycleStart ?cOn:cOff); text("[SHIFT+ENTER] cycle start", margin,c);    c+=lineHeight;
    fill(sixi2.singleBlock?cOn:cOff); text("[S] Single block",margin,c);    c+=lineHeight;
    fill(cOn);
    //fill(sixi2.recording.m01break   ?cOn:cOff); text("[Unset] M01 break"   ,0,textHeight*6);
    text("[SPACE] reset", margin,c);    c+=lineHeight;
    text("[ENTER] set current keyframe to joystick position", margin,c);    c+=lineHeight;
    text("[DEL] remove previous keyframe", margin,c);    c+=lineHeight;
    text("[BACKSPACE] remove this keyframe", margin,c);    c+=lineHeight;
    text("[+] insert after the current keyframe", margin,c);    c+=lineHeight;
    text("[<] select previous keyframe", margin,c);    c+=lineHeight;
    text("[>] select next keyframe", margin,c);    c+=lineHeight;
    text("[1...6] select robot arm joint (now "+(sixi2.selectedJoint+1)+")", margin,c);    c+=lineHeight;
    text("[MOUSE WHEEL] change angle of selected joint", margin,c);    c+=lineHeight;
  }
}
