// mpu6050
#include "I2Cdev.h"
#include "MPU6050.h"
#if I2CDEV_IMPLEMENTATION == I2CDEV_ARDUINO_WIRE
    #include "Wire.h"
#endif
MPU6050 accelgyro;
int16_t ax, ay, az;
int16_t gx, gy, gz;
#define OUTPUT_READABLE_ACCELGYRO
#define LED_PIN 13
bool blinkState = false;
// capacitive & BT
#include <CapacitiveSensor.h>

char blueToothVal;           //value sent over via bluetooth
char lastValue;              //stores last state of device (on/off)

CapacitiveSensor capSensor1 = CapacitiveSensor(12,10);
CapacitiveSensor capSensor2 = CapacitiveSensor(12,8);
CapacitiveSensor capSensor3 = CapacitiveSensor(12,6);
CapacitiveSensor capSensor4 = CapacitiveSensor(12,4);
int threshold = 200; 
int statoplay= 8;
int stato= 0;
int traccia = 0;
int count = 0;
int numero = 0;

void setup() {
  #if I2CDEV_IMPLEMENTATION == I2CDEV_ARDUINO_WIRE
      Wire.begin();
      TWBR = 24; // 400kHz I2C clock (200kHz if CPU is 8MHz)
  #elif I2CDEV_IMPLEMENTATION == I2CDEV_BUILTIN_FASTWIRE
      Fastwire::setup(400, true);
  #endif
  Serial.begin(9600);
  accelgyro.initialize();
}

void loop() {
    /*if(Serial.available())
  {//if there is data being recieved
    blueToothVal=Serial.read(); //read it
  }
    if (blueToothVal=='c')
  {//if value from bluetooth serial is n
    //digitalWrite(13,HIGH);            //switch on LED
    if (lastValue!='c')
      //Serial.println(F("16")); //print LED is on
    lastValue=blueToothVal;
  }
  else if (blueToothVal=='d')
  {//if value from bluetooth serial is n
    //digitalWrite(13,LOW);             //turn off LED
    if (lastValue!='d')
      //Serial.println(F("17")); //print LED is on
    lastValue=blueToothVal;
  } */
  //MPU6050
  int gestures= -1;
  int gesto=0;
    accelgyro.getMotion6(&ax, &ay, &az, &gx, &gy, &gz);
    #ifdef OUTPUT_READABLE_ACCELGYRO
       if(ay > 10000) {
          if(statoplay != 8){
              gesto=88;
              gestures=0;
              //Serial.println(F("8")); //pause
            statoplay = 8;
            traccia = 0;
            }
          }else{
             if((statoplay != 9)&&(ay < 5000)){
                 gesto=99;
                 gestures=0;
                 //Serial.println(F("9")); //play
               statoplay=9; //
               traccia = 0;
             } 
          }
          
            if(ax > 5000) {
              if(ax > 12000) {
                  if(stato != 32){
                     gesto=32;
                     gestures=0;
                     //Serial.println(F("12")); //rewind
                     stato=32;
                  }
              }else{
                if(stato == 32){
                  if(ax < 7000) {
                      gesto=33;
                      gestures=0;
                      //Serial.println(F("13")); //end rew
                      stato=0;
                  }
                }
              }
            }
            if(ax < -5000) {
              if(ax < -12000) {
                  if(stato != 22){
                     gesto=22;
                     gestures=0;
                     //Serial.println(F("22")); //print LED is on
                     stato=22;
                  }
              }else{
                if(stato == 22){
                  if(ax > -7000) {
                      gesto=23;
                      gestures=0;
                      //Serial.println(F("23")); //print LED is on
                      stato=0;
                  }
                }
              }
            }
        /*Serial.print("a/g:\t");
        Serial.print(ax); Serial.print("\t");
        Serial.print(ay); Serial.print("\t");
        Serial.print(az); Serial.print("\t");
        Serial.print(gx); Serial.print("\t");
        Serial.print(gy); Serial.print("\t");
        Serial.println(gz); */
    #endif
  //CAPACITIVE
  int tocco= -1;
  int traccia=0;
  long sensorValue1 = capSensor1.capacitiveSensor(30);
  long sensorValue2 = capSensor2.capacitiveSensor(30);
  long sensorValue3 = capSensor3.capacitiveSensor(30);
  long sensorValue4 = capSensor4.capacitiveSensor(30);
  if(sensorValue1 > threshold) {
      traccia=1;
      tocco++;
  }
    if(sensorValue2 > threshold) {
      traccia=2;
      tocco++;
  }
    if(sensorValue3 > threshold) {
      traccia=3;
      tocco++;
  }
    if(sensorValue4 > threshold) {
      traccia=4;
      tocco++;
  }
  
  if(tocco>-1) {    
      if(tocco==0){
        Serial.println(traccia);
        //Serial.write(traccia);
      }else{
        Serial.println(90); 
        //Serial.write(90);          
      }
  }
  if(gestures==0){
      //Serial.println(gesto);
      Serial.write(gesto);
  } 
  delay(60);
}
