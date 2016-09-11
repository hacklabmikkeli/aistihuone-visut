class MadWave {
  private int waveSize = 10;
  private FloatList values;
  
  public MadWave(){
    this.values = new FloatList();
  }
  
  void update(float value) {
    values.append(value);
    if(values.size() > waveSize) {
      values.remove(0);
    }
  }
  
  void display(){
    stroke(153);
    if(values.size() < 2) {
      return;
    }
    float lineLength = width / (values.size() - 1);
    float currentX = 0;
    float prevValue = values.get(0);
    for(int i = 1; i < values.size();i++) {
      float value = values.get(i);
      line(currentX, prevValue, currentX + lineLength, value);
      prevValue = value;
      currentX += lineLength;
    }
  }
}