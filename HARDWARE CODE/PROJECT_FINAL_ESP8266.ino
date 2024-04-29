#include <FirebaseESP8266.h>
#include <ESP8266WiFi.h>
#include <NTPClient.h>
#include <WiFiUdp.h>

#define FIREBASE_HOST "smarteco-61678-default-rtdb.asia-southeast1.firebasedatabase.app"
#define FIREBASE_AUTH "AIzaSyBH9RJILm5SQQMBR2lHQz8KV4KWUWWJuBM"


// Replace with your Wi-Fi credentials
const char* ssid = "Zubble HQ";
const char* password = "airzubble";

FirebaseData firebaseData;
FirebaseData StringData;
FirebaseData log_data;

float Watt = 0, AmpsRMS = 0;
int motionSensorData = 0, relay1State = 0, relay2State = 0, relay3State = 0;

unsigned long previousMillis = 0;
const unsigned long interval = 5000;  // Interval in milliseconds

unsigned long previousMillisMOTION = 0;
const unsigned long intervalMOTION = 60000;  // Interval in milliseconds


WiFiUDP ntpUDP;
NTPClient timeClient(ntpUDP, "pool.ntp.org");

String getTime() {
  timeClient.update();
  unsigned long now = timeClient.getEpochTime();
  return String(now);
}
// String getDateString(unsigned long epochTime) {
//   struct tm* ptm = gmtime((time_t*)&epochTime);
//   int currentYear = ptm->tm_year + 1900;  // Years offset from 1900
//   int currentMonth = ptm->tm_mon + 1;     // Months range from 0-11, so we add 1
//   int monthDay = ptm->tm_mday;


//   // Format the date as a string
//   String formattedDate = String(currentYear) + "-" + String(currentMonth) + "-" + String(monthDay);
//   return formattedDate;
// }

void setup() {
  Serial.begin(9600);  // Initialize serial communication
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.println("X");
  }
  Serial.println("x");
  timeClient.begin();
  Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);
  Firebase.reconnectWiFi(true);
  // init
}

void loop() {
  unsigned long currentMillis = millis();
  int new_motionSensorData, new_relay1State, new_relay2State, new_relay3State;
  if (Serial.available() > 0) {
    String receivedData = Serial.readStringUntil('\n');  // Read until newline character
    // Parse the received data
    sscanf(receivedData.c_str(), "%d,%d,%d,%d", &new_motionSensorData, &new_relay1State, &new_relay2State, &new_relay3State);
  }
  delay(100);  // Adjust delay as needed
  //to turn on or off relays by checking firebase
  if (motionSensorData != new_motionSensorData) {
    if (Firebase.setInt(firebaseData, "/MiniIot/Devices/Device1/MV", new_motionSensorData)) {
      motionSensorData = new_motionSensorData;
      if (currentMillis - previousMillisMOTION >= intervalMOTION) {
        previousMillisMOTION = currentMillis;
        UpdateLog("MV", new_motionSensorData);
      }
      if (Firebase.setString(StringData, "/MiniIot/Devices/Device1/MT", getTime())) {
        delay(10);
      }
    }
  }
  if (relay1State != new_relay1State) {
    if (Firebase.setInt(firebaseData, "/MiniIot/Devices/Device1/A", new_relay1State)) {
      relay1State = new_relay1State;
      UpdateLog("A", new_relay1State);
    }
  }
  if (relay2State != new_relay2State) {
    if (Firebase.setInt(firebaseData, "/MiniIot/Devices/Device1/B", new_relay2State)) {
      relay2State = new_relay2State;
      UpdateLog("B", new_relay2State);
    }
  }
  if (relay3State != new_relay3State) {
    if (Firebase.setInt(firebaseData, "/MiniIot/Devices/Device1/C", new_relay3State)) {
      relay3State = new_relay3State;
      UpdateLog("C", new_relay3State);
    }
  }
  //CHECK

  if (currentMillis - previousMillis >= interval) {
    previousMillis = currentMillis;
    if (Firebase.getInt(firebaseData, "/MiniIot/Devices/Device1/A")) {
      int FBrelay1State = firebaseData.intData();
      if (relay1State != FBrelay1State) {
        int state = FBrelay1State;
        if (state == 1) {
          Serial.println("A");
        } else {
          Serial.println("a");
        }
        // relay1State = FBrelay1State;
      }
    }

    if (Firebase.getInt(firebaseData, "/MiniIot/Devices/Device1/B")) {
      int FBrelay2State = firebaseData.intData();
      if (relay2State != FBrelay2State) {
        int state = FBrelay2State;
        if (state == 1) {
          Serial.println("B");
        } else {
          Serial.println("b");
        }
        // relay2State = FBrelay2State;
      }
    }

    if (Firebase.getInt(firebaseData, "/MiniIot/Devices/Device1/C")) {
      int FBrelay3State = firebaseData.intData();
      if (relay3State != FBrelay3State) {
        int state = FBrelay3State;
        if (state == 1) {
          Serial.println("C");
        } else {
          Serial.println("c");
        }
        // relay3State = FBrelay3State;
      }
    }
  }
}

void UpdateLog(String ID, int state) {
  FirebaseJson json;
  json.set("ID", ID);
  json.set("status", state);
  json.set("updated", getTime());
  Firebase.pushJSON(log_data, "/MiniIot/Devices/Device1/logs/" + ID, json);
}
