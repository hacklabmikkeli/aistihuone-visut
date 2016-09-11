class MadBar {
  
  private float animationVelocity = 200;
  private int barColor;
  private float x;
  private float y;
  private float barWidth;
  private float barHeight;
  private float barMaxHeight;
  private float targetHeight;
  private float lastUpdate;
  
  
  public MadBar(float x, float y, float barWidth, float barHeight, float barMaxHeight, int barColor) {
    this.x = x;
    this.y = y;
    this.barWidth = barWidth;
    this.barHeight = barHeight > barMaxHeight ? barMaxHeight : barHeight;
    this.barColor = barColor;
    this.targetHeight = barHeight;
    this.barMaxHeight = barMaxHeight; 
  }
  
  public void changeValue(float targetValue){
    this.targetHeight = map(targetValue, 0, 255, 0, barMaxHeight);
  }
  
  public void update(){
    float time = millis();
    float elapsed = ((time - lastUpdate) / 1000) * animationVelocity;
    lastUpdate = time;
    if(barHeight > targetHeight) {
      if(targetHeight > barHeight - elapsed) {
        barHeight = targetHeight;
      } else {
        barHeight -= elapsed;
      }
    } else if(barHeight < targetHeight) {
      if((barHeight + elapsed) > targetHeight) {
        barHeight = targetHeight;
      } else {
        barHeight += elapsed;
      }
    }
    y = height - barHeight;
  }
  
  public void display(){
    update();
    rect(x, y, barWidth, barHeight);
  }
  
  public float getX(){
    return x;
  }

  public float getY(){
    return y;
  }
  
  public float getBarWidth(){
    return barWidth;
  }
  
  public float getBarHeight(){
    return barHeight;
  }

  public float getMaxBarHeight(){
    return barMaxHeight;
  }
  
  public int getBarColor(){
    return barColor;
  }

}