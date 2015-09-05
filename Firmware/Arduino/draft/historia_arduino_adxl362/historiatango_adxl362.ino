/*
Connect SCLK, MISO, MOSI, and CSB of ADXL362 to
SCLK, MISO, MOSI, and DP 10 of Arduino 
(check http://arduino.cc/en/Reference/SPI for details)
 
*/ 
#include <LowPower.h>
#include <SPI.h>
#include <ADXL362.h>
#include <CapacitiveSensor.h>

ADXL362 xl;

int16_t interruptPin = 2;          //Setup ADXL362 interrupt output to Interrupt 0 (digital pin 2)
int16_t interruptStatus = 0;

int16_t temp;
int16_t XValue, YValue, ZValue, Temperature;

CapacitiveSensor capSensor = CapacitiveSensor(7,8);
CapacitiveSensor capSensor2 = CapacitiveSensor(6,5);
CapacitiveSensor capSensor3 = CapacitiveSensor(4,3);
int threshold = 360; 

int statoplay= 8;
int stato= 0;
int traccia = 0;

void setup(){
  
  Serial.begin(9600);
  xl.begin(10);                   // Setup SPI protocol, issue device soft reset
 
  delay(1000);    
    // Setup digital pin 7 for LED observation of awake/asleep  
    pinMode(9, OUTPUT);    
    digitalWrite(9, HIGH);
    

    //  Setup Activity and Inactivity thresholds
    //     tweaking these values will effect the "responsiveness" and "delay" of the interrupt function
    //     my settings result in a very rapid, sensitive, on-off switch, with a 2 second delay to sleep when motion stops
    xl.setupDCActivityInterrupt(200, 10);        // 300 code activity threshold.  With default ODR = 100Hz, time threshold of 10 results in 0.1 second time threshold
    xl.setupDCInactivityInterrupt(80, 1000);        // 80 code inactivity threshold.  With default ODR = 100Hz, time threshold of 30 results in 100 second time threshold
    
    // Setup ADXL362 for proper autosleep mode
    //
    
    // Map Awake status to Interrupt 1
    // *** create a function to map interrupts... coming soon
    xl.SPIwriteOneRegister(0x2A, 0x40);   
    
    // Setup Activity/Inactivity register
    xl.SPIwriteOneRegister(0x27, 0x3F); // Referenced Activity, Referenced Inactivity, Loop Mode  
        
    // turn on Autosleep bit
    byte POWER_CTL_reg = xl.SPIreadOneRegister(0x2D);
    POWER_CTL_reg = POWER_CTL_reg | (0x04);                // turn on POWER_CTL[2] - Autosleep bit
    xl.SPIwriteOneRegister(0x2D, POWER_CTL_reg);

    //
    // turn on Measure mode
    //
    xl.beginMeasure();                      // DO LAST! enable measurement mode   
    xl.checkAllControlRegs();               // check some setup conditions    
    delay(100);
    // Setup interrupt function on Arduino
    //    IMPORTANT - Do this last in the setup, after you have fully configured ADXL.  
    //    You don't want the Arduino to go to sleep before you're done with setup
    //
    pinMode(2, INPUT);    
    attachInterrupt(0, interruptFunction, RISING);  // A high on output of ADXL interrupt means ADXL is awake, and wake up Arduino 

}

void loop(){
  //
  //  Check ADXL362 interrupt status to determine if it's asleep
  //
  interruptStatus = digitalRead(interruptPin);

// if ADXL362 is asleep, call LowPower.powerdown  
  if(interruptStatus == 0) { 
    digitalWrite(9, LOW);    // Turn off LED as visual indicator of asleep
    delay(100);
    LowPower.powerDown(SLEEP_FOREVER, ADC_OFF, BOD_OFF);     
  }
  
// if ADXL362 is awake, report XYZT data to Serial Monitor
  else{
    delay(10);
    digitalWrite(9, HIGH);    // Turn on LED as visual indicator of awake
    xl.readXYZTData(XValue, YValue, ZValue, Temperature);           
  }
  // give circuit time to settle after wakeup
  delay(20);

  long sensorValue = capSensor.capacitiveSensor(3);
  long sensorValue2 = capSensor2.capacitiveSensor(30);
  long sensorValue3 = capSensor3.capacitiveSensor(80);
  
   if(sensorValue2 > threshold){
     if(traccia != 2){
       //Serial.write(2); //Play the second track: Ordine basso della facciata,
       Serial.println(2); //Play the second track: Ordine basso della facciata,
       traccia = 2;
     }
  }
   if(sensorValue3 > threshold){
     if(traccia != 3){
       //Serial.write(3); //Play the second track: Ordine basso della facciata,
       Serial.println(3); //Play the second track: Ordine basso della facciata,
       traccia = 3;
     }
  }
  if(sensorValue > threshold) {
    if(traccia != 1){
     //Serial.write(1); //Play the first track: Piazza,
     Serial.println(1); //Play the first track: Piazza,
     traccia = 1;
    }
  }
  xl.readXYZTData(XValue, YValue, ZValue, Temperature);  
  
  if(XValue > 1100 || XValue < -1100) {
    if(statoplay != 8){
      //Serial.write(8); //Pause mode,
      Serial.println(8); //Pause mode,
      statoplay = 8;
      traccia = 0;
    }
  }else{
     if((statoplay != 9)&&(XValue < 600 && XValue > -600)){
       //Serial.write(9); //Play mode,
       Serial.println(9); //Play mode,
       statoplay=9; //
       traccia = 0;
     } 
  }
  if(YValue > 500) {
    if(YValue > 1200) {
      if(stato != 12){
         //Serial.write(12); //Rewind the track,
         Serial.println(12); //Rewind the track,
         stato=12;
      }
    }else{
      if(stato == 12){
        if(YValue < 700) {
          //Serial.write(13); //return in play mode after rewind,
          Serial.println(13); //return in play mode after rewind,
          stato=0;
        }
      }
    }
  }
  if(YValue < -500) {
    if(YValue < -1200) {
      if(stato != 22){
         //Serial.write(22); //Foward the track,
         Serial.println(22); //Foward the track,
         stato=22;
      }
    }else{
      if(stato == 22){
        if(YValue > -700) {
          //Serial.write(23); //return in play mode after foward,
          Serial.println(23); //return in play mode after foward,
          stato=0;
        }
      }
    }
  }
/* Serial.println(Temperature);     */ 
  delay(20);        
}

//
// Function called if Arduino detects interrupt activity
//    when rising edge detected on Arduino interrupt
//
void interruptFunction(){
  //Serial.write(0);
  Serial.println(0);
}
