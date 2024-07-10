#include <CapacitiveSensor.h>

// Define constants
const int threshold = 400;
const int debounceDelay = 200;  // Debounce delay in milliseconds to avoid immediate subsequent triggers
const int prolongedDelay = 1000;  // Prolonged delay for triggering special track in milliseconds
const int delayVal = 40;
const int numSensors = 3;  // Set this to the number of sensors you have

// Digital pins to be used for capacitive sensors
int sensorPins[numSensors];
const int capPin = 13;  // Common pin for CapacitiveSensor library

// Arrays to store CapacitiveSensor objects and sensor states
CapacitiveSensor* capSensors[numSensors];
bool sensorTriggered[numSensors] = {false};

// Variables to track current track and timing for debounce and prolonged triggers
int currentTrack = 0;
unsigned long lastTriggerTime = 0;
unsigned long prolongedTriggerStartTime = 0;
bool prolongedTriggerActive = false;

void setup() {
  Serial.begin(115200);

  // Initialize sensorPins starting from pin 2
  for (int i = 0; i < numSensors; i++) {
    sensorPins[i] = i + 2;
    capSensors[i] = new CapacitiveSensor(capPin, sensorPins[i]);
  }
}

void loop() {
  int triggeredSensors = 0;
  int lastTriggeredSensor = -1;
  unsigned long currentTime = millis();

  for (int i = 0; i < numSensors; i++) {
    long sensorValue = capSensors[i]->capacitiveSensor(3);

    if (sensorValue > threshold) {
      triggeredSensors++;
      lastTriggeredSensor = i + 2; // Assuming track numbers start from 2

      // Check if prolonged trigger condition is met
      if (prolongedTriggerActive && (currentTime - prolongedTriggerStartTime > prolongedDelay)) {
        if (currentTrack != 99) {
          Serial.write(99); // Special signal for multiple sensors held down
          currentTrack = 99;
          prolongedTriggerActive = false; // Reset prolonged trigger flag
        }
      }
      sensorTriggered[i] = true;

      // Handle single sensor trigger immediately
      if (triggeredSensors == 1 && (currentTime - lastTriggerTime > debounceDelay)) {
        if (currentTrack != lastTriggeredSensor) {
          Serial.write(lastTriggeredSensor);
          currentTrack = lastTriggeredSensor;
          lastTriggerTime = currentTime; // Update the last trigger time
        }
      }
    } else {
      sensorTriggered[i] = false;
    }
  }

  // Handle multiple sensor prolonged trigger
  if (triggeredSensors > 1) {
    if (!prolongedTriggerActive) {
      prolongedTriggerActive = true;
      prolongedTriggerStartTime = currentTime;
    }
  } else {
    prolongedTriggerActive = false;
  }

  if (Serial.available()) {
    char val = Serial.read();
    if (val == 'h') {
      // Implement handshake handling if necessary
    } else if (val == 'r') {
      currentTrack = 0;
      // Add any additional reset behavior here
    }
  }

  delay(delayVal);
}
