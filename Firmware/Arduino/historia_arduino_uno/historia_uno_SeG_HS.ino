#include <CapacitiveSensor.h>

char val;
int delayVal=500;
boolean handshake=false;
CapacitiveSensor capSensor1 = CapacitiveSensor(8,2);
CapacitiveSensor capSensor2 = CapacitiveSensor(8,3);
CapacitiveSensor capSensor3 = CapacitiveSensor(8,4);
CapacitiveSensor capSensor4 = CapacitiveSensor(8,5);
CapacitiveSensor capSensor5 = CapacitiveSensor(8,6);
CapacitiveSensor capSensor6 = CapacitiveSensor(8,7);
CapacitiveSensor capSensor7 = CapacitiveSensor(8,9);
CapacitiveSensor capSensor8 = CapacitiveSensor(8,10);
CapacitiveSensor capSensor9 = CapacitiveSensor(8,11);
CapacitiveSensor capSensor10 = CapacitiveSensor(8,12);
int threshold = 180; 
 int tocco= -1;
  int traccia=0;
  int pausa=-1;

void setup(){
  Serial.begin(9600); // apri la porta seriale
}

void loop(){
  // HANDSHAKE
  if(!handshake){
    Serial.write('Z');
     if (Serial.available()) { // If data is available to read,
       val = Serial.read(); // read it and store it in val
       if (val == 'Z') { // If 1 was received
         delayVal=250;
         handshake=true;
       } else {
       }
       delay(10); // Wait 10 milliseconds for next reading
     }
   }else{
   //CAPACITIVE
  long sensorValue1 = capSensor1.capacitiveSensor(30);
  long sensorValue2 = capSensor2.capacitiveSensor(30);
  long sensorValue3 = capSensor3.capacitiveSensor(30);
  long sensorValue4 = capSensor4.capacitiveSensor(30);
  long sensorValue5 = capSensor5.capacitiveSensor(30);
  long sensorValue6 = capSensor6.capacitiveSensor(30);
  long sensorValue7 = capSensor7.capacitiveSensor(30);
  long sensorValue8 = capSensor8.capacitiveSensor(30);
  long sensorValue9 = capSensor9.capacitiveSensor(30);
  long sensorValue10 = capSensor10.capacitiveSensor(30);
    int verificatocco= tocco;
  /*Serial.print(sensorValue3);
  Serial.print(", ");
  Serial.print(sensorValue4);
  Serial.print(", ");
  Serial.print(sensorValue5);
  Serial.print(", ");
  Serial.print(sensorValue6);
  Serial.print(", ");
  Serial.print(sensorValue7);
    Serial.print(", ");
  Serial.print(sensorValue8);
    Serial.print(", ");
  Serial.print(sensorValue9);
    Serial.print(", ");
  Serial.print(sensorValue10);
    Serial.print(", ");
  Serial.print(sensorValue1);
      Serial.print(", ");
  Serial.println(sensorValue2);*/
  if(sensorValue1 > threshold) {
    if(traccia!=1){
      traccia=1;
      tocco=0;
     }else{
      tocco++;
     }
  }
  if(sensorValue2 > threshold) {
    if(traccia!=2){
      traccia=2;
      tocco=0;
     }else{
      tocco++;
     }
  }
  if(sensorValue3 > threshold) {
     if(traccia!=3){
      traccia=3;
      tocco=0;
     }else{
      tocco++;
     }
  }
  if(sensorValue4 > threshold) {
    if(traccia!=4){
      traccia=4;
      tocco=0;
     }else{
      tocco++;
     }
  }
  if(sensorValue5 > threshold) {
    if(traccia!=5){
      traccia=5;
      tocco=0;
     }else{
      tocco++;
     }
  }
  if(sensorValue6 > threshold) {
    if(traccia!=6){
      traccia=6;
      tocco=0;
     }else{
      tocco++;
     }
  }
  if(sensorValue7 > threshold) {
    if(traccia!=7){
      traccia=7;
      tocco=0;
     }else{
      tocco++;
     }
  }
  if(sensorValue8 > threshold) {
    if(traccia!=8){
      traccia=8;
      tocco=0;
     }else{
      tocco++;
     }
  }
  if(sensorValue9 > threshold) {
     if(traccia!=9){
      traccia=9;
      tocco=0;
     }else{
      tocco++;
     }
  }
  if(sensorValue10 > threshold) {
    if(traccia!=10){
      traccia=10;
      tocco=0;
     }else{
      tocco++;
     }
  }
  if(verificatocco==tocco){
    pausa++;
    if(pausa>10){
      tocco=-1;
    }
  }else{
    pausa=-1;
  }
  if(tocco>3) { // 2 secondi
        Serial.write(traccia);
  }
  }
  delay(delayVal);
}
