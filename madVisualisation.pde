public final int BAR_COUNT = 10;
public final int WAVE_COUNT = 4;
public float maxBarHeight;
ArrayList<MadBar> bars = new ArrayList<MadBar>();
ArrayList<MadWave> waves = new ArrayList<MadWave>();


void setup(){
   size(1280, 720, P2D);
   float barWidth = width / BAR_COUNT;
   maxBarHeight = height / 3;
   float currentXPos = 0;
   for(int i = 0; i < BAR_COUNT;i++) {
     float barHeight = random(maxBarHeight);
     bars.add(new MadBar(currentXPos, height - barHeight, barWidth, barHeight, maxBarHeight, 255));
     currentXPos += barWidth;
   }
   for(int j = 0; j < WAVE_COUNT;j++) {
     waves.add(new MadWave());
   }
  //initMindWave();
  //initFearCatcher();
  //initLights();
}

void draw() {
  background(0);
  if(!ringInFinger) {
    for(MadBar bar : bars) {
      bar.changeValue(0);
    }
  } else {
    //bars.get(0).changeValue(attention);
    //bars.get(1).changeValue(meditation);
    bars.get(2).changeValue(anger);
    bars.get(3).changeValue(contempt);
    bars.get(4).changeValue(disgust);
    bars.get(5).changeValue(fear);
    bars.get(6).changeValue(happiness);
    bars.get(7).changeValue(neutral);
    bars.get(8).changeValue(sadness);
    bars.get(9).changeValue(surprise);
    updateColors(
      (int)(map(bars.get(7).getBarHeight(), 0, maxBarHeight, 0, 255)),
      (int)(map(bars.get(2).getBarHeight(), 0, maxBarHeight, 0, 255)),
      (int)(map(bars.get(6).getBarHeight(), 0, maxBarHeight, 0, 255)),
      (int)(map(mm, 0, 100, 0, 255))
    );
  }
  for(MadBar bar : bars) {
      bar.display();
  }
  for(MadWave wave : waves) {
      float addValue = random(100);
      if(addValue > 70) {
        float base = height - (maxBarHeight * 2);
        float value = random(maxBarHeight);
        wave.update(base - value);
      }
      wave.display();
  }

}