class RecordingView {
  int textHeight = 12;
  int lineHeight=textHeight+2;
  int toShow=20;
  int first=0;
  int last=0;
  int margin=5;
  
  void render(Recording rec) {
    textSize(textHeight);

    int index = max(rec.commandIndex,0);
    int total = rec.commands.size();
    
    if( first > index ) {
      first=index;
    }
    last = min(first+toShow,total);
    
    if( last <= index ) {
      last=index+1;
      first = max(0,last-toShow);
    }
    println("\t"+first+"\t"+last);
    
    float startY = height-lineHeight*(toShow+1)-margin;
    int c;
    for(c=first; c<last; ++c) {
      if(c==index) {
        fill(255,255,0,192);
      } else {
        fill(255,255,255,192);
      }
      text(nf(c,5)+" "+rec.commands.get(c),margin,startY);
      startY+=lineHeight;
    }
  }
}
