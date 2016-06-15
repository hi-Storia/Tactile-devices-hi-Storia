# hi-Storia
<div style="text-align:center"><a href="http://hi-storia.it/"><img src ="http://www.hi-storia.it/wp-content/uploads/2015/06/laquila.jpg" /></a></div>

The tactile device Hi-Storia is an innovative tool for the enhancement of cultural heritage. It is a 3D printed reproduction of a monument; on the surface of the print they are placed capacitive sensors that activate the multimedia content with the touch of fingers.

Tactile devices provide a simple and immediate understanding of cultural heritage and are accessible to blind and partially sighted persons, but they are also usable to the visually impaired, allowing socialization between able-bodied and disabled.

Hi-Storia it's both a startup and a community project; the Arduino source code and the design model is Open Source, and the content (text and audio) of every project are released under Creative Commons licenses. Furthermore, the hi-Storia team organizes educational workshops in schools and universities, designed to produce an interactive device of a local monument.
During the lessons, students design the device, write the descriptive texts of the monument, record audio tracks and work on 3D modeling and printing, electronic prototyping and coding.

English full description coming soon!
More information are available in hi-Storia website: [www.hi-storia.it](http://www.hi-storia.it) .

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
