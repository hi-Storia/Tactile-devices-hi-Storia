// mpu6050
#include "I2Cdev.h"
//#include "MPU6050.h"
#include "MPU6050_6Axis_MotionApps20.h"
#if I2CDEV_IMPLEMENTATION == I2CDEV_ARDUINO_WIRE
    #include "Wire.h"
#endif
// capacitive & BT
#include <CapacitiveSensor.h>

char blueToothVal;           //value sent over via bluetooth
char lastValue;              //stores last state of device (on/off)

char val;
int delayVal=500;
boolean handshake=false;
CapacitiveSensor capSensor3 = CapacitiveSensor(12,6);
CapacitiveSensor capSensor4 = CapacitiveSensor(12,8);
CapacitiveSensor capSensor5 = CapacitiveSensor(12,9);
CapacitiveSensor capSensor6 = CapacitiveSensor(12,10);
CapacitiveSensor capSensor7 = CapacitiveSensor(12,11);
CapacitiveSensor capSensor8 = CapacitiveSensor(12,18);
CapacitiveSensor capSensor9 = CapacitiveSensor(12,19);
CapacitiveSensor capSensor10 = CapacitiveSensor(12,20);
CapacitiveSensor capSensor11 = CapacitiveSensor(12,5);
CapacitiveSensor capSensor12 = CapacitiveSensor(12,4);
int threshold = 150; 
int tocco= -1;
int traccia=0;
int pausa=-1;
int fermadelay=0;

void setup() {
  Serial.begin(9600);
  Serial1.begin(9600);
  /*while (!Serial1) {
    ; // wait for serial port to connect. Needed for Leonardo only
  }*/
}
 
 
void loop() {
   if(!handshake){
    Serial.write('Z');
    Serial1.println('Z');
     if (Serial.available()) { // If data is available to read,
       val = Serial.read(); // read it and store it in val
       if (val == 'Z') { // If 1 was received
         delayVal=250;
         handshake=true;
       } else {
         if (Serial1.available()) { // If data is available to read,
             val = Serial1.read(); // read it and store it in val
             if (val == 'Z') { // If 1 was received
               delayVal=250;
               handshake=true;
             }
         }
       }
       delay(10); // Wait 10 milliseconds for next reading
     }
   }else{
  //CAPACITIVE
  int tocco= -1;
  int traccia=0;
  long sensorValue3 = capSensor3.capacitiveSensor(30);
  long sensorValue4 = capSensor4.capacitiveSensor(30);
  long sensorValue5 = capSensor5.capacitiveSensor(30);
  long sensorValue6 = capSensor6.capacitiveSensor(30);
  long sensorValue7 = capSensor7.capacitiveSensor(30);
  long sensorValue8 = capSensor8.capacitiveSensor(30);
  long sensorValue9 = capSensor9.capacitiveSensor(30);
  long sensorValue10 = capSensor10.capacitiveSensor(30);
  long sensorValue11 = capSensor11.capacitiveSensor(30);
  long sensorValue12 = capSensor12.capacitiveSensor(30);
  
  if(sensorValue11 > threshold) {
      traccia=1;
      tocco++;
  }
  if(sensorValue12 > threshold) {
      traccia=5; //capes
      tocco++;
  }
  if(sensorValue3 > threshold) {
      traccia=10;
      tocco++;
  }
  if(sensorValue4 > threshold) {
      traccia=7;
      tocco++;
  }
  if(sensorValue5 > threshold) {
      traccia=4;
      tocco++;
  }
  if(sensorValue6 > threshold) {
      traccia=8;
      tocco++;
  }
  if(sensorValue7 > threshold) {
      traccia=9; //PNGS
      tocco++;
  }
  if(sensorValue8 > threshold) {
      traccia=2;
      tocco++;
  }
  if(sensorValue9 > threshold) {
      traccia=3;
      tocco++;
  }
  if(sensorValue10 > threshold) {
      traccia=6; //tirino
      tocco++;
  }
  
  if(tocco>-1) {
    
      if(tocco==0){
        Serial1.println(traccia);
      }else{
        Serial1.println(90); 
      }
      
      if(tocco==0){
        //Serial.println(traccia);
        Serial.write(traccia);
      }else{
        //Serial.println(90); 
        Serial.write(90);     
      } 
  fermadelay++;
  }else{
  fermadelay--;
  }
  }
  delay(delayVal);
}
