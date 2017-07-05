# hi-Storia
<div style="text-align:center"><a href="http://hi-storia.it/"><img src ="http://www.hi-storia.it/wp-content/uploads/2015/06/laquila.jpg" /></a></div>

The tactile device Hi-Storia is an innovative tool for the enhancement of cultural heritage. It is a 3D printed reproduction of a monument; on the surface of the print they are placed capacitive sensors that activate the multimedia content with the touch of fingers.

Tactile devices provide a simple and immediate understanding of cultural heritage and are accessible to blind and partially sighted persons, but they are also usable to the visually impaired, allowing socialization between able-bodied and disabled.

Hi-Storia it's both a startup and a community project; the Arduino source code and the design model is Open Source, and the content (text and audio) of every project are released under Creative Commons licenses. Furthermore, the hi-Storia team organizes educational workshops in schools and universities, designed to produce an interactive device of a local monument.
During the lessons, students design the device, write the descriptive texts of the monument, record audio tracks and work on 3D modeling and printing, electronic prototyping and coding.

English full description coming soon!
More information are available in hi-Storia website: [www.hi-storia.it](http://www.hi-storia.it) .

# Per iniziare: realizza la stampa 3D e il circuito con Arduino
Realizza la stampa 3D di un monumento e dotagli di elementi conduttivi utilizzando inchiostro conduttivo (es: Bare Conductive), filamenti conduttivi o semplice carta stagnola

# Carica lo scretch di Arduino
Segui la guida disponibile su [https://www.hi-storia.it/edu/courses/assemblare-programmare-elettronica-hi-storia/](https://www.hi-storia.it/edu/courses/assemblare-programmare-elettronica-hi-storia/)

Ricorda che è necessario avere installati sul proprio dispositivo i driver di Arduino.
Dipendenze:
- Se viene utilizzato un inclinometro, caricare le relative librerie. Nella cartella draft sono presenti alcuni esempi usando chip mpu6050 e adxl362. Il codice nella cartella draft non è aggiornato in quanto è assente la parte relativa all'handshake con i dispositivi.

# Utilizza il player Hi-Storia
Abbiamo sviluppato una applicazione che interpreta i segnali provenienti da Arduino o Micro:bit e attiva contenuti (audio, testuali e 3D) in base all'attivatore toccato. I player sono disponibili gratuitamente su richiesta, inoltre stiamo lavorando per condividere su GitHub le versioni del player.
Abbiamo sviluppato una versione di player sviluppata su Processing, ed una versione con Unity3D. La versione con Processing ha le seguenti dipendenze:
- controlP5
- Unfolding
- Minim
- gifAnimation

Puoi trovare ulteriori informazioni sul precedente repository, all'indirizzo [https://github.com/Riqua/reaudioguide](https://github.com/Riqua/reaudioguide) . A breve sarà disponibile tra i files anche esempi di .stl e circuiti .eagle.
