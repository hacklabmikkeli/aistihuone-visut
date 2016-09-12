class MadWave {
  private int waveSize = 20;
  private FloatList values;
  private FloatList valueBuffer;
  private color waveColor;
  private float animationVelocity = 500;
  private float lastUpdate;


  public MadWave(color waveColor){
    this.values = new FloatList();
    this.valueBuffer = new FloatList();
    this.waveColor = waveColor;
  }
  
  void pushValue(float value) {
    valueBuffer.append(value);
  }
  
  void update() {
    float time = millis();
    float elapsed = ((time - lastUpdate) / 100000) * animationVelocity;
    if(valueBuffer.size() > 0) {
      if(elapsed < 1) {
        if(values.size() < waveSize) {
          values.append(valueBuffer.get(0));
        } else {
          values.append(lerp(values.get(values.size() - 1), valueBuffer.get(0), elapsed));
        }
      } else {
        values.append(valueBuffer.get(0));
        valueBuffer.remove(0);
        lastUpdate = time;
      }
    }
    if(values.size() > waveSize) {
      values.remove(0);
    }
  }
  
  void display(){
    update();
    stroke(waveColor);
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