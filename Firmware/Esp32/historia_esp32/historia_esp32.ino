/*
 * Hi-Storia tactile device firmware
 * Board: ESP32 with Bluetooth Classic support
 * Touch sensing: native ESP32 capacitive touch inputs
 * Connection: Bluetooth Classic + USB serial
 * Persistent configuration: Preferences (NVS)
 *
 * Tested on:
 * - San Flaviano Hi-Storia tactile device (2026)
 *
 * Bluetooth device name:
 * - HI-STORIA
 *
 * Protocol:
 * - T<n>       touch event for sensor n (for example: T1)
 * - Z          reset active track
 * - SET:<n>    set and save touch threshold
 * - PING       connection test; replies with PONG
 *
 * Dependencies:
 * - BluetoothSerial (ESP32 Arduino core)
 * - Preferences (ESP32 Arduino core)
 */

#include "BluetoothSerial.h"
#include <Preferences.h>

BluetoothSerial SerialBT;
Preferences preferences;

// Capacitive touch inputs used by the tactile device.
const int pinSensori[] = {4, 13, 12, 14, 32, 33, 15};
const int numSensori = 7;

int soglia = 600;
unsigned long ultimoTocco = 0;

// Last activated sensor (0 = none).
int tracciaAttiva = 0;

// Last valid reading for each sensor, used to reject zero-value glitches.
int lastValid[numSensori];

const int debounceMs = 100;
const int minValid = 1;
const int minTouch = 20;

// Sends one Bluetooth protocol message terminated with CRLF.
void btSendLine(const String &s) {
  SerialBT.print(s);
  SerialBT.print("\r\n");
}

void gestisciComando(String comando);

void setup() {
  Serial.begin(115200);
  SerialBT.begin("HI-STORIA");

  preferences.begin("totem-config", false);
  soglia = preferences.getInt("soglia", 600);

  Serial.println("Sistema Avviato (Modalità Indice Unico).");
  Serial.print("Soglia attuale: ");
  Serial.println(soglia);

  // Initialize the anti-glitch values with the first valid readings.
  for (int i = 0; i < numSensori; i++) {
    int v = touchRead(pinSensori[i]);
    if (v < minValid) v = 1000;
    lastValid[i] = v;
    delay(10);
  }

  btSendLine("MSG:HI-STORIA READY");
}

void loop() {
  // Commands received from the Hi-Storia app over Bluetooth.
  if (SerialBT.available()) {
    String comando = SerialBT.readStringUntil('\n');
    gestisciComando(comando);
  }

  // The same commands can also be sent from a computer over USB serial.
  if (Serial.available()) {
    String comando = Serial.readStringUntil('\n');
    gestisciComando(comando);
  }

  if (millis() - ultimoTocco > (unsigned long)debounceMs) {
    int hitSensor = 0;
    int hitVal = 0;

    // Scan every sensor and always print a complete diagnostic row.
    for (int i = 0; i < numSensori; i++) {
      int val = touchRead(pinSensori[i]);

      // Replace invalid zero readings with the last valid value.
      if (val < minValid) {
        val = lastValid[i];
      } else {
        lastValid[i] = val;
      }

      // Continuous diagnostic output, compatible with Serial Plotter.
      Serial.print("S");
      Serial.print(i + 1);
      Serial.print(":");
      Serial.print(val);
      if (i == (numSensori - 1)) Serial.println();
      else Serial.print("\t");

      // ESP32 touch values decrease when a capacitive sensor is touched.
      if (hitSensor == 0 && val < soglia && val > minTouch) {
        hitSensor = i + 1;
        hitVal = val;
      }
    }

    // Generate one event per newly activated sensor without interrupting
    // the complete sensor scan above.
    if (hitSensor != 0) {
      if (hitSensor != tracciaAttiva) {
        btSendLine(String("T") + hitSensor);

        Serial.print("T");
        Serial.println(hitSensor);

        Serial.print("-> NUOVA TRACCIA: ");
        Serial.print(hitSensor);
        Serial.print(" (Valore: ");
        Serial.print(hitVal);
        Serial.println(")");

        tracciaAttiva = hitSensor;
      }

      ultimoTocco = millis();
    }
  }

  delay(40);
}

void gestisciComando(String comando) {
  comando.trim();
  if (comando.length() == 0) return;

  // Reset the active track after playback has ended.
  if (comando == "Z" || comando == "z") {
    tracciaAttiva = 0;
    Serial.println("RESET (Z): Indice azzerato, pronto.");
    btSendLine("MSG:RESET OK");
  }

  // Update and persist the touch threshold.
  else if (comando.startsWith("SET:")) {
    int nuovaSoglia = comando.substring(4).toInt();

    if (nuovaSoglia > 100 && nuovaSoglia < 1300) {
      soglia = nuovaSoglia;
      preferences.putInt("soglia", soglia);

      Serial.print("OK! Nuova soglia: ");
      Serial.println(soglia);

      btSendLine(String("MSG:Soglia salvata a ") + soglia);
    } else {
      Serial.println("ERRORE: Valore soglia non valido");
      btSendLine("MSG:ERRORE soglia");
    }
  }

  // Connection test.
  else if (comando == "PING" || comando == "ping") {
    btSendLine("PONG");
  }
}
