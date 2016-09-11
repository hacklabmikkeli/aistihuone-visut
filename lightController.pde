import processing.serial.*;

public static final String LIGHT_SERIAL = "/dev/rfcomm1";

Serial lightSerialPort;
float maxUpdateFreq = 1500;
boolean lightsActive = false;
float lastUpdate;

void updateColors(int blue, int red, int green, int white) {
  float time = millis();
  if(lightsActive && (time - lastUpdate > maxUpdateFreq)) {
    String blueString = String.format("4,%d;14,%d;24,%d;34,%d;", blue, blue, blue, blue);
    String redString = String.format("2,%d;12,%d;22,%d;32,%d;", red, red, red, red);
    String whiteString = String.format("5,%d;15,%d;25,%d;35,%d;", white, white, white, white);
    String greenString = String.format("3,%d;13,%d;23,%d;33,%d;", green, green, green, green);
    lightSerialPort.write(String.format("%s%s%s%s", blueString, redString, whiteString, greenString));
  }
}

void removeColors() {
  lightSerialPort.write("2,0;12,0;22,0;32,0;3,0;13,0;23,0;33,0;4,0;14,0;24,0;34,0;");
}

void initLights() {
  try {
    lightSerialPort = new Serial(this, LIGHT_SERIAL, 9600);
    lightsActive = true;
    lightSerialPort.write("1,255;11,255;21,255;31,255;");
    lastUpdate = millis();
  } catch (Exception ex) {
    print("lights disabled: " + ex.getMessage());
  }
}