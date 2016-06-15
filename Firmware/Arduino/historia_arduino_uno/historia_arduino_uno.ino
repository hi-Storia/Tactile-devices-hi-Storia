#include <CapacitiveSensor.h>

char val;
int delayVal=500;
boolean handshake=false;
const int commonpin = 13; // il PIN utilizzato come input di tutti i sensori capacitivi
const int numbersensors = 10; // numero di sensori capacitivi inseriti. Cambia questo valore in base alle tue esigenze
const int ritardo = 1500; // tempo (in millisecondi) necessario per attivare un sensore. non è pari a 0 perché non vogliamo far partire il segnale con un tocco fortuito, ma solo se l'utente lo vuole 
int threshold = 180; 
int traccia=0;
int tocco= -1;

CapacitiveSensor* capSensor[numbersensors];

void setup(){
  //inizializzazione dei sensori capacitivi
  int i = 0; // nella versione con bluetooth, PIN0 e PIN1 sono utilizzati per la trasmissione dati, quindi sono inutilizzabili per i sensori capacitivi
  while(i < numbersensors-1){
    if(i!=commonpin){
      capSensor[i] = new CapacitiveSensor(commonpin,i);
      i++;
    }
  }
  Serial.begin(9600); // apri la porta seriale
}

void loop(){
  // HANDSHAKE
  if(!handshake){ //se NON abbiamo stabilito una connessione con l'app PC (o smarthphone)
    Serial.write('Z'); //inviamo al PC o allo smarthphone un segnale contente il carattere "Z". Per dire: il dispositivo è connesso, ma è dormiente!
     if (Serial.available()) { // se è stabilita una connessione
       val = Serial.read(); // salviamo su una variabile il messaggio che ci arriva dal PC (o smartphone)
       if (val == 'H') { // se riceviamo il carattere "H", vuol dire che il PC ci ha riconosciuto: sveglia!
         delayVal=20; // cambiamo la velocità del ciclo: prima era un loop ogni 500 millisecondi (1/2 secondo), ora uno ogni 20 millisecondi
         handshake=true; //il dispositivo diventa operativo
       }
       delay(10); // Wait 10 milliseconds for next reading
     }
   }else{ //se il dispositivo è collegato ed abbiamo stabilito una connessione con l'app PC (o smarthphone)
     //CAPACITIVE
     long sensorValue;
     int doppiotocco=0; // variabile per capire se abbiamo toccato due sensori
     int verificatocco= tocco;
     for(int i=0;i < numbersensors-1;i++){ // catturo i valori di output di ogni sensore capacitivo
       sensorValue = capSensor[i]->capacitiveSensor(30);
       if(sensorValue > threshold){ // verifico se il valore di output del sensore capacitivo "i" ha superato la soglia massima, cioè se è stato toccato
          doppiotocco++; //doppiotocco diventa 1. se rimane 1, vuol dire che abbiamo toccato un solo sensore. se aumenta, vuol dire che siamo passati qui più di una volta e quindi abbiamo toccato più sensori
          if(traccia!=i){ // se in precedenza avevo toccato un altro sensore
            traccia=i;
            tocco=0;
          }else{ // se invece ho toccato sempre questo sensore
            tocco++;
          }
       } // fine della verifica del superamento della soglia
     } // fine del ciclo for per la cattura dei valori di output
     
    if(doppiotocco>1){ //se ho toccato due sensori
      Serial.write('!'); //invio un segnale per dire che stiamo toccando due sensori
      traccia=0; //azzero l'indicatore della traccia toccata
    }else{
      if(tocco>(ritardo/20)) { // dividiamo per 20 perché c'è un loop ogni 20 millisecondi
        Serial.write(traccia); // invio il segnale al PC o allo smarphone: il sensore attiva la traccia audio
      }
    }

    if (Serial.available()) { //ultima verifica: vediamo se riceviamo altri segnali dall'app PC (o smartphone)
      val = Serial.read();
      if (val == '@') { // se arriva il segnale con il carattere chiocciola
        handshake=false; // vuol dire che dobbiamo resettare il dispositivo
      }
    }
  } // fine if-else per verifica se è stata stabilita una connessione con l'app PC (o smarthphone)
  delay(delayVal); // inserisco una pausa: lunga se non c'è stata connessione con il PC (o smarthphone), corta se il dispositivo è collegato
}
