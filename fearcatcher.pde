import io.socket.emitter.*;
import io.socket.client.*;

public static final String FEARCATCHER_ADDRESS = "http://127.0.0.1:3000/";

volatile boolean ringInFinger = true;
volatile int anger;
volatile int contempt;
volatile int disgust;
volatile int fear;
volatile int happiness;
volatile int neutral;
volatile int sadness;
volatile int surprise;
volatile int mm;
volatile int instant;

Socket socket;

void initFearCatcher() {
  try {
    socket = IO.socket(FEARCATCHER_ADDRESS);
    socket.on("face:analyzed", new Emitter.Listener() {
      @Override
      public void call(Object... incoming) {
        org.json.JSONObject obj = (org.json.JSONObject)incoming[0];
        try {
          anger = (int)(255.0 * obj.getDouble("anger"));
          contempt = (int)(255.0 * obj.getDouble("contempt"));
          disgust = (int)(255.0 * obj.getDouble("disgust"));
          fear = (int)(255.0 * obj.getDouble("fear"));
          happiness = (int)(255.0 * obj.getDouble("happiness"));
          neutral = (int)(255.0 * obj.getDouble("neutral"));
          sadness = (int)(255.0 * obj.getDouble("sadness"));
          surprise = (int)(255.0 * obj.getDouble("surprise"));
        } catch (Exception ex) {
          ex.printStackTrace();
        }
      }
    });
    socket.on("moodmetric:data", new Emitter.Listener() {
      @Override
      public void call(Object... incoming) {
        org.json.JSONObject obj = (org.json.JSONObject)incoming[0];
        try {
          mm = (int)obj.getInt("mm");
          instant = (int)obj.getInt("instant");
        } catch (Exception ex) {
          ex.printStackTrace();
        }
      }
    });
    socket.on("moodmetric:ring:removed", new Emitter.Listener() {
      @Override
      public void call(Object... incoming) {
        ringInFinger = false;
        removeColors();
      }
    });
    socket.on("moodmetric:ring:inserted", new Emitter.Listener() {
      @Override
      public void call(Object... incoming) {
        ringInFinger = true;
      }
    });
    socket.connect();
  } catch (Exception ex) {
    print("Couldn't initialize FearCatcher: ", ex.getMessage());
  }
}