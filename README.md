# hi-Storia
The Tactile devices hi-Storia are made with 3D printing and reproducing historic buildings and artistic treasures. Through a capacitive circuit, the devices allow the user to access media content with the touch of the fingers.

English description coming soon!

I dispositivi tattili Hi-Storia sono stampe 3D di edifici storici ed opere d’arte, dotate di un circuito capacitivo, basato su Arduino, che permette all’utente di accedere ai contenuti multimediali con il semplice tocco delle dita.
I dispositivi hi-Storia si interfacciano con smartphone Android e PC (Linux, Windows); le applicazioni permettono la visualizzazione di video interattivi, contenuti audio e approfondimenti sull'elemento appena toccato.

Maggiori informazioni sono disponibili sul sito [www.hi-storia.it](http://www.hi-storia.it) .

# Per iniziare: realizza la stampa 3D e il circuito con Arduino
Realizza la stampa 3D di un monumento e dotagli di un circuito capacitivo basato su Arduino. 
Consulta le informazioni presenti sul precedente repository, all'indirizzo [https://github.com/Riqua/reaudioguide](https://github.com/Riqua/reaudioguide) . A breve sarà disponibile tra i files anche esempi di .stl e circuiti .eagle.

# Carica lo scretch di Arduino
Vai nella cartella Firmware / Arduino, seleziona il corretto modello di Arduino a tua disposizione e carica via USB il software. Ricorda che è necessario avere installati sul proprio dispositivo i driver di Arduino.
Dipendenze:
- Se viene utilizzato un inclinometro, caricare le relative librerie. Nella cartella draft sono presenti alcuni esempi usando chip mpu6050 e adxl362. Il codice nella cartella draft non è aggiornato in quanto è assente la parte relativa all'handshake con i dispositivi.

# Personalizza e compila l'applicazione JAVA
Nella cartella Application / Processing è presente il software per interfacciarsi con il dispositivo. La comunicazione avviene via Serial COM. Il software caricato contiene già un esempio di tracce audio, quelle relative al progetto [http://www.hi-storia.it/portfolio/santi-guerrieri/](http://www.hi-storia.it/portfolio/santi-guerrieri/t) 
Dipendenze:
- controlP5
- Unfolding
- Minim
- gifAnimation