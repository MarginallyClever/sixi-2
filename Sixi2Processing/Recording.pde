
class Recording {
  ArrayList<String> commands;
  int commandIndex;

  
  
  public Recording() {
    commands = new ArrayList<String>();
    commands.add("");
  }

  void reset() {
    commandIndex=0;
  }
  
  void loadRecording(String fileName) {
    commands.clear();
    
    try {
      BufferedReader stream = createReader(fileName);
      String line;
      while( ( line = stream.readLine() ) != null ) {
        commands.add(line);
      }
      stream.close();
    }
    catch(IOException e) {
      println("Failed to load file "+fileName);
      commands.clear();
    }
    reset();
    println("loaded "+fileName+" with "+(commands.size())+" lines.");
  }
  
  void saveRecording(String fileName) {
    PrintWriter stream = createWriter(fileName);
    for( String line : commands ) {
      stream.println(line);
    }
    stream.flush();
    stream.close();
    println("saved "+fileName+" with "+(commands.size())+" lines.");
  }
  
  void setCommand(String line) {
    if(commands.size()==0) {
      commands.set(0,line);
      return;
    }
    if( commandIndex>=0 && commandIndex<commands.size() ) {
      commands.set(commandIndex,line);
    }
  }
  
  String getCommand(int index) {
    if( index<0 || index>=commands.size() ) return null;
    return commands.get(index);
  }
  String getCommand() {
    return getCommand(commandIndex);
  }

  boolean hasNext() {
    return commandIndex < commands.size()-1;
  }
  boolean hasPrev() {
    return commandIndex > 0;
  }

  String next() {
    commandIndex++;
    return getCommand();
  }
  String prev() {
    commandIndex--;
    return getCommand();
  }
  
  void addCommand(String line) {
    if(commands.size()==0) {
      commands.add(line);
      commandIndex=0;
      return;
    }
    println("I"+commandIndex+" S"+commands.size());
    if( commandIndex>=0 && commandIndex<commands.size() ) {
      commandIndex++;
      commands.add(commandIndex,line);
    }
  }
  
  void deleteCurrentCommand() {
    if( commands.size()>0 && commandIndex < commands.size() ) {
      commands.remove(commandIndex);
      if(commandIndex == commands.size()) commandIndex = commands.size()-1;
    }
  }
  void deletePreviousCommand() {
    if( commands.size()>0 && commandIndex-1 > 0 ) {
      commands.remove(commandIndex-1);
      commandIndex--;
    }
  }
}
