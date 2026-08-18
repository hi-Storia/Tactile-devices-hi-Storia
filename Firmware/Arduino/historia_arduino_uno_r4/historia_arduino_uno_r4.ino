/*
 * Hi-Storia tactile device firmware
 * Board: Arduino UNO R4
 * Touch sensing: R4_Touch (single-scan mode)
 * Connection: USB serial
 * Persistent configuration: EEPROM
 *
 * Tested on:
 * - Torpignattara Hi-Storia tactile device (Rome, 2026)
 *
 * Protocol:
 * - T<n>       touch event for sensor n (for example: T1)
 * - Z          reset active track
 * - SET:<n>    set and save touch threshold
 * - PING       connection test; replies with PONG
 *
 * Dependencies:
 * - R4_Touch
 * - EEPROM
 *
 * The touch sensors are read in single-scan mode rather than free-running
 * mode. This is the configuration validated on the Torpignattara device.
 */

#include <R4_Touch.h>
#include <EEPROM.h>
#include <string.h>
#include <stdlib.h>

const uint8_t pinSensori[] = {2, 3, 8, 9, 11};
const int numSensori = sizeof(pinSensori) / sizeof(pinSensori[0]);

uint16_t soglia = 6500;
unsigned long ultimoTocco = 0;
int tracciaAttiva = 0;

const int debounceMs = 100;
const uint16_t minRaw = 1;
const uint16_t maxReasonable = 65000;
constexpr int EEPROM_ADDR = 0;

TouchSensor sensors[numSensori];

// Sends one protocol message terminated with CRLF.
void sendLine(const String &s) {
  Serial.print(s);
  Serial.print("\r\n");
}

void gestisciComando(char *comando) {
  while (*comando == ' ' || *comando == '\t' || *comando == '\r' || *comando == '\n') comando++;
  if (comando[0] == '\0') return;

  // Reset the active track after playback has ended.
  if ((comando[0] == 'Z' || comando[0] == 'z') && comando[1] == '\0') {
    tracciaAttiva = 0;
    sendLine("MSG:RESET OK");
    return;
  }

  // Update and persist the touch threshold.
  if (strncmp(comando, "SET:", 4) == 0 || strncmp(comando, "set:", 4) == 0) {
    int nuovaSoglia = atoi(comando + 4);
    if (nuovaSoglia > 1000 && nuovaSoglia < 20000) {
      soglia = (uint16_t)nuovaSoglia;
      for (int i = 0; i < numSensori; i++) sensors[i].setThreshold(soglia);
      EEPROM.put(EEPROM_ADDR, soglia);
      sendLine(String("MSG:Soglia salvata a ") + soglia);
    } else {
      sendLine("MSG:ERRORE soglia");
    }
    return;
  }

  // Connection test.
  if (strcmp(comando, "PING") == 0 || strcmp(comando, "ping") == 0) {
    sendLine("PONG");
  }
}

void leggiComandiSeriali() {
  static char commandBuffer[48];
  static uint8_t commandIndex = 0;

  while (Serial.available()) {
    char c = (char)Serial.read();
    if (c == '\r') continue;

    if (c == '\n') {
      commandBuffer[commandIndex] = '\0';
      gestisciComando(commandBuffer);
      commandIndex = 0;
      continue;
    }

    if (commandIndex < sizeof(commandBuffer) - 1) {
      commandBuffer[commandIndex++] = c;
    } else {
      commandIndex = 0;
      sendLine("MSG:ERRORE comando troppo lungo");
    }
  }
}

void setup() {
  Serial.begin(115200);
  while (!Serial) { }

  EEPROM.get(EEPROM_ADDR, soglia);
  if (soglia < 1000 || soglia > 20000) soglia = 6500;

  Serial.println("Sistema Avviato (UNO R4 + R4_Touch single-scan).");
  Serial.print("Soglia attuale: ");
  Serial.println(soglia);

  for (int i = 0; i < numSensori; i++) {
    bool ok = sensors[i].begin(pinSensori[i], soglia);
    if (!ok) {
      Serial.print("ERRORE: pin non supportato o gia in uso: ");
      Serial.println(pinSensori[i]);
    }
  }

  sendLine("MSG:HI-STORIA READY");
}

void loop() {
  leggiComandiSeriali();

  if (millis() - ultimoTocco > (unsigned long)debounceMs) {
    TouchSensor::startSingle();

    int hitSensor = 0;
    uint16_t hitVal = 0;

    // Read all sensors and keep the first sensor above the threshold.
    for (int i = 0; i < numSensori; i++) {
      uint16_t raw = sensors[i].readRaw();
      if (raw < minRaw || raw > maxReasonable) {
        raw = (raw < minRaw) ? minRaw : maxReasonable;
      }

      // Continuous diagnostic output, compatible with Serial Plotter.
      Serial.print("S");
      Serial.print(i + 1);
      Serial.print(":");
      Serial.print(raw);
      if (i == (numSensori - 1)) Serial.println();
      else Serial.print("\t");

      if (hitSensor == 0 && raw > soglia) {
        hitSensor = i + 1;
        hitVal = raw;
      }
    }

    if (hitSensor != 0) {
      if (hitSensor != tracciaAttiva) {
        sendLine(String("T") + hitSensor);
        tracciaAttiva = hitSensor;
      }
      ultimoTocco = millis();
    }
  }

  delay(40);
}
