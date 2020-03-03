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
    
    fill(cOn);
    textSize(textHeight);
    int c=textHeight+margin;
                      fill(sixi2.operatingMode==OperatingMode.LIVE ?cOn:cOff);    text("[~]   "+(sixi2.operatingMode==OperatingMode.LIVE ?"LIVE":"SIMULATED"), margin,c);
    c+=lineHeight;    fill(sixi2.controlMode==ControlMode.REAL_TIME?cOn:cOff);    text("[TAB] "+(sixi2.controlMode==ControlMode.REAL_TIME?"REAL TIME":"PLAYBACK"), margin,c);
    c+=lineHeight;    fill(sixi2.cycleStart ?cOn:cOff);                           text("[SHIFT+ENTER] cycle start", margin,c);
    c+=lineHeight;    fill(sixi2.singleBlock?cOn:cOff);                           text("[S] Single block",margin,c);
    //c+=lineHeight;    fill(sixi2.recording.m01break?cOn:cOff);                    text("[Unset] M01 break"   ,0,textHeight*6);

    fill(cOn);
    c+=lineHeight;    text("[SPACE] reset", margin,c);
    c+=lineHeight;    // blank line
    c+=lineHeight;    text("[/] set this keyframe", margin,c);
    c+=lineHeight;    text("[+] insert a new keyframe after the current", margin,c);
    c+=lineHeight;    text("[ENTER] / and + together", margin,c);
    c+=lineHeight;    text("[BACKSPACE] remove previous keyframe", margin,c);
    c+=lineHeight;    text("[DEL] remove this keyframe", margin,c);
    c+=lineHeight;    text("[<] select previous keyframe", margin,c);
    c+=lineHeight;    text("[>] select next keyframe", margin,c);
    c+=lineHeight;    text("[1...6] select robot arm joint (now "+(sixi2.selectedJoint+1)+")", margin,c);
    c+=lineHeight;    text("[MOUSE WHEEL] change angle of selected joint", margin,c);
    c+=lineHeight;
  }
}
