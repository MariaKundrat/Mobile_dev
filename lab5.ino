#include <EEPROM.h>

const int EEPROM_SIZE = 512;
bool messageReceived = false;

void setup() {
  Serial.begin(9600);
  EEPROM.begin(EEPROM_SIZE);

  delay(1000);
  Serial.println("ESP32 starts...");

  String storedMessage = readFromEEPROM();
  if (storedMessage.length() > 0) {
    Serial.println(storedMessage);
  }
}

void loop() {
  if (Serial.available() > 0) {
    String message = Serial.readStringUntil('\n');
    message.trim();

    if (message == "GET") {
      String stored = readFromEEPROM();
      Serial.println(stored);
    } else if (message.length() > 0) {
      writeToEEPROM(message);
      Serial.println("Data saved!");
    } else {
      Serial.println("Get, but empty");
    }
  }
}

void writeToEEPROM(String data) {
  for (int i = 0; i < data.length() && i < EEPROM_SIZE - 1; ++i) {
    EEPROM.write(i, data[i]);
  }
  EEPROM.write(data.length(), '\0');

  EEPROM.commit();
}

String readFromEEPROM() {
  char data[EEPROM_SIZE];
  for (int i = 0; i < EEPROM_SIZE; ++i) {
    data[i] = EEPROM.read(i);
    if (data[i] == '\0') break;
  }
  return String(data);
}
