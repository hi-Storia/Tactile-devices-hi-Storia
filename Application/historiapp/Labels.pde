/******* Dispositivo MAPPA DI TERAMO ********/

void videoPlayer(){
  if(mappattuale!=1){
    testiaudioguide = loadXML("data/santi-guerrieri.xml");
    img = loadImage("santi-guerrieri.png");
    loopingGif = new Gif(this, "img0.gif");
    loopingGif.loop();
    mappattuale=1;
  }
  textSize(12);
  numerotraccia = 0;
  int lettura = myPort.read();
  if (lettura == 88 || lettura == 22 || lettura == 12) {
    autorizz = 88;
  }else{
    autorizz = 99;
  }

  if (autorizz == 99 && (millis() - pausePlaying) > 1000){
    if (lettura >= 0 && lettura <= 11) {
// 1, 2, 3 and 4 are the signals to play the four specific audio-tracks
// 0 is general audio-track. The general track is activated the first time that the audioguide comes out of standby mode.
      if(!(lettura == 0 && audiotrack.isPlaying())){ //a NAND operation to prevent the play of general audio-track while a user is listening to another track
          indexForNames = lettura;
          //video
          videostop();
          delay(50);
          //fine video
        switch(lettura) {
          /*case 2: 
            audiotrack.close();
            videoplay = true;
            //videoplay = !videoplay;
            videostop = false;
            myMovie.stop();
            myMovie = introSantanna;
            myMovie.play();
            break;*/
         /* case 10: 
          audiotrack.close();
            videoplay = true;
            //videoplay = !videoplay;
            videostop = false;
            introSantanna.stop();
            myMovie.play();
            break;*/
           case 2:
           if(true){
           videoplay = false;
            //videoplay = !videoplay;
            videostop = true;
             myMovie.stop();
             introSantanna.stop();
              if(nowPlaying !=lettura){ // if a user touches the sensor relative to the current track, the track is not charged again
                audiotrack.pause();
                //audiotrack = minim.loadFile("track"+indexForNames+".mp3");
                audiotrack = minim.loadFile("track"+indexForNames+".mp3");
                imgtrack = Gif.getPImages(this, "img"+indexForNames+".gif");
                loopingGif = new Gif(this, "img"+indexForNames+".gif");
                loopingGif.loop();
                songLength = audiotrack.length();
                meta = audiotrack.getMetaData();
              }
             audiotrack.play();
             nowPlaying = lettura;
             haisbloccato=false;
             piazzainiziata=true;
             break;
           }
           case 8:
           if(!piazzainiziata){
           videoplay = false;
            //videoplay = !videoplay;
            videostop = true;
             myMovie.stop();
             introSantanna.stop();
              if(nowPlaying !=lettura){ // if a user touches the sensor relative to the current track, the track is not charged again
                audiotrack.pause();
                //audiotrack = minim.loadFile("track"+indexForNames+".mp3");
                audiotrack = minim.loadFile("track"+indexForNames+".mp3");
                imgtrack = Gif.getPImages(this, "img"+indexForNames+".gif");
                loopingGif = new Gif(this, "img"+indexForNames+".gif");
                loopingGif.loop();
                songLength = audiotrack.length();
                meta = audiotrack.getMetaData();
              }
             audiotrack.play();
             nowPlaying = lettura;
             haisbloccato=false;
             museoiniziato=true;
             break;
           }
           case 10:
           if(!museoiniziato){
           videoplay = false;
            //videoplay = !videoplay;
            videostop = true;
             myMovie.stop();
             introSantanna.stop();
              if(nowPlaying !=lettura){ // if a user touches the sensor relative to the current track, the track is not charged again
                audiotrack.pause();
                //audiotrack = minim.loadFile("track"+indexForNames+".mp3");
                audiotrack = minim.loadFile("track"+indexForNames+".mp3");
                imgtrack = Gif.getPImages(this, "img"+indexForNames+".gif");
                loopingGif = new Gif(this, "img"+indexForNames+".gif");
                loopingGif.loop();
                songLength = audiotrack.length();
                meta = audiotrack.getMetaData();
              }
             audiotrack.play();
             nowPlaying = lettura;
             haisbloccato=false;
             duomoiniziato=true;
             break;
           }
           /* default:
           videoplay = false;
            //videoplay = !videoplay;
            videostop = true;
             myMovie.stop();
             introSantanna.stop();
              if(nowPlaying !=lettura){ // if a user touches the sensor relative to the current track, the track is not charged again
                audiotrack.pause();
                //audiotrack = minim.loadFile("track"+indexForNames+".mp3");
                audiotrack = minim.loadFile("track"+indexForNames+".mp3");
                imgtrack = Gif.getPImages(this, "img"+indexForNames+".gif");
                loopingGif = new Gif(this, "img"+indexForNames+".gif");
                loopingGif.loop();
                songLength = audiotrack.length();
                meta = audiotrack.getMetaData();
              }
             audiotrack.play();
             nowPlaying = lettura;
             haisbloccato=false;
             break; */
        }
        /*if(lettura == 10){
          videoplay = true;
          //videoplay = !videoplay;
          videostop = false;
          myMovie.play();
        }else{
        audiotrack.play();
        nowPlaying = lettura;
        } */
        //if(numerotraccia !=lettura){
        //if(numerotraccia != indexForNames){
           //numerotraccia = lettura;
        //}
      }
    }
  }

 if (lettura == 88){ // 88 is the STOP signal: Arduino sends 88, via serial, when the model is tilted downward
  if (audiotrack.isPlaying()) {
    audiotrack.pause();
    //imgtrack = loadImage("img0.gif");
  }
  pausePlaying = millis(); // is saved the moment of pause. We want, after pausing, it is impossible to start with a new play before the lapse of time (1 second)
 }

  if (lettura == 22 && audiotrack.isPlaying() || countRewind != 0){
//12 and 22 are respectively the signals for REWIND and FOWARD. Arduino sends 12 or 22 when the model is tilted (respectively) to the left or right
    if (audiotrack.isPlaying()) {
      audiotrack.pause();
      //imgtrack = loadImage("img0.gif");
    }
    countRewind = countRewind - 180;
 }
  if (lettura == 32 && audiotrack.isPlaying() || countFoward != 0){
//12 and 22 are respectively the signals for REWIND and FOWARD. Arduino sends 12 or 22 when the model is tilted (respectively) to the left or right
    if (audiotrack.isPlaying()) {audiotrack.pause();}
    countFoward = countFoward + 180;
 }
 if (lettura == 33 || lettura == 23){
    countRewFow = countRewind + countFoward;
    audiotrack.skip(countRewFow);
    countRewind=0;
    countFoward=0;
    audiotrack.play();
 }
  if (img!=null){
    background(img);
  }else{
    background(0);}
    fill(255);
if ( audiotrack.isPlaying()){
  text("Audioguida in funzione", 665, 37);
    // show pause button
    textSize(16);
    fill(255);
  buttonPause.display();
  //old show progress bar PRIMA era qui
    textSize(12);
    fill(3);
}else{
  fill(255);
  text("Nessuna traccia audio attiva", 665, 37);
}
  
  
/* image(imgtrack, 690, 350); */
image(loopingGif, 690, 265);
  //image(imgtrack[(int) (imgtrack.length / (float) (width) * mouseX)],690, 350);
showMeta();
// show progress bar
  buttonProgressFrame.display();
    if (!(meta==null)){
      //buttonProgressData.w = map(audiotrack.position(), 0, meta.length(), 0, width-240 );
      buttonProgressData.w = map(audiotrack.position(), 0, meta.length(), 0, 196 );
      buttonProgressData.display();
    }
    // end progress bar

  /* if(myPort.available() > 0){
    if (lettura >= 0 && lettura <= 11) {
      text("Stai toccando un punto d'interesse", 50, 60);
    }else{
      //text("Connesso", 50, 60);
    }
  }else{
    text("Non connesso", 50, 75);} */
    fill(3);
  showSidebar(indexForNames);
  
  textSize(10);
    text("Contenuti e modellino realizzati", 15, 540);
    text("con il contributo di:", 15, 553);
  
      //text("Software attualmente abilitato per:", 770, 575);
      image(imgon, diston, 595);
      image(imgoff, distoff, 595);
      fill(3);
     buttonUno.display();
   buttonMicro.display();
   
  if(videostop) {
    //background(0);
  } else {
    image(myMovie, 0, 45);
  }
  
  if(videoplay) {
    //myMovie.read();
    myMovie.play();
    image(footer, 0, 560);
    textSize(18);
    text("Indovina di che monumento stiamo parlando e collocalo correttamente sulla mappa", 100, 606);
textSize(12);  
} 
//createHeader();
   //image(header, 0, 0);
  delay(30);
  //image(myMovie, 0, 0);
  if ( audiotrack.isPlaying()) {
      if (audiotrack.position() > (meta.length()/2)) {
        text("Hai sbloccato la prossima traccia", 790, 18);
        haisbloccato=true;
        // test quiz
      }
    }
    if(!starttrack){
    buttonStart.display();
    //buttonStart2.display();
    image(startbutton, 886, 36);
    }else{
    buttonReset.display();
    image(resetbutton, 883, 34);
    }
    buttonMappa.display();
    buttonLista.display();
    buttonMode.display();
    
    if(quizdemo){
  // test quiz
  radioButton.update();
  text(options[radioButton.getValue()], (width-textWidth(options[radioButton.getValue()]))/2, height-20);
// fine testquiz
}
    
if(lettura>-1){
// @TODO  leggere il segnale 90 per il tocco multiplo
//#riquafix println(lettura);
//println(myPort);
//println(numerotraccia);
}
  
}

/******* Dispositivo SANTI E GUERRIERI ********/

void santiguerrieriPlayer(){
  background(255);
  createBackground("santiguerrieri");
  if(mappattuale!=5){
    animazionelayout=0;
    testiaudioguide = loadXML("data/santiguerrieri/audioguide.xml");
    //img = loadImage("santiguerrieri/santi-guerrieri.png");
  loopingSponsor = new Gif(this, "santiguerrieri/sponsor.gif");
  loopingSponsor.loop();
  loopingGif = new Gif(this, "santiguerrieri/img0.gif");
    loopingGif.loop();
    mappattuale=5;
  }
  textSize(12);
  numerotraccia = 0;
  int lettura = myPort.read();
  if (lettura == 88 || lettura == 22 || lettura == 12) {
    autorizz = 88;
  }else{
    autorizz = 99;
  }

  if (autorizz == 99 && (millis() - pausePlaying) > 1000){
    if (lettura >= 0 && lettura <= 11) {
      if(animazionelayout==0){
        animazioneLayout();
        animazionelayout=1;
      }
// 1, 2, 3 and 4 are the signals to play the four specific audio-tracks
// 0 is general audio-track. The general track is activated the first time that the audioguide comes out of standby mode.
      if(!(lettura == 0 && audiotrack.isPlaying())){ //a NAND operation to prevent the play of general audio-track while a user is listening to another track
          indexForNames = lettura;
        if(nowPlaying !=lettura){ // if a user touches the sensor relative to the current track, the track is not charged again
          audiotrack.pause();
          //audiotrack = minim.loadFile("track"+indexForNames+".mp3");
          audiotrack = minim.loadFile("santiguerrieri/track"+indexForNames+".wav");
          imgtrack = Gif.getPImages(this, "santiguerrieri/img"+indexForNames+".gif");
          loopingGif = new Gif(this, "santiguerrieri/img"+indexForNames+".gif");
          loopingGif.loop();
          songLength = audiotrack.length();
          meta = audiotrack.getMetaData();
        }
        audiotrack.play();
        nowPlaying = lettura;
        //if(numerotraccia !=lettura){
        //if(numerotraccia != indexForNames){
           //numerotraccia = lettura;
        //}
      }
    }
  }

 if (lettura == 88){ // 88 is the STOP signal: Arduino sends 88, via serial, when the model is tilted downward
  if (audiotrack.isPlaying()) {
    audiotrack.pause();
    //imgtrack = loadImage("img0.gif");
  }
  pausePlaying = millis(); // is saved the moment of pause. We want, after pausing, it is impossible to start with a new play before the lapse of time (1 second)
 }

  if (lettura == 22 && audiotrack.isPlaying() || countRewind != 0){
//12 and 22 are respectively the signals for REWIND and FOWARD. Arduino sends 12 or 22 when the model is tilted (respectively) to the left or right
    if (audiotrack.isPlaying()) {
      audiotrack.pause();
      //imgtrack = loadImage("img0.gif");
    }
    countRewind = countRewind - 180;
 }
  if (lettura == 32 && audiotrack.isPlaying() || countFoward != 0){
//12 and 22 are respectively the signals for REWIND and FOWARD. Arduino sends 12 or 22 when the model is tilted (respectively) to the left or right
    if (audiotrack.isPlaying()) {audiotrack.pause();}
    countFoward = countFoward + 180;
 }
 if (lettura == 33 || lettura == 23){
    countRewFow = countRewind + countFoward;
    audiotrack.skip(countRewFow);
    countRewind=0;
    countFoward=0;
    audiotrack.play();
 }
 // deprecated nella versione TRE
  /*if (img!=null){
    background(img);
  }else{
    background(0);}*/
    //background(255);
    fill(255);
if ( audiotrack.isPlaying()){
  text("Audioguida in funzione", 665, 37);
    // show pause button
    textSize(16);
    fill(255);
  buttonPause.display();
  //old show progress bar PRIMA era qui
  // riqua TEMP metti pausa
  rect(30, 149,2,12);
  rect(38, 149,2,12);
    textSize(12);
    fill(3);
}else{
  fill(255);
  text("Nessuna traccia audio attiva", 665, 37);
}
  /* image(imgtrack, 690, 350); */
  image(loopingGif, 730, 310);
    //image(imgtrack[(int) (imgtrack.length / (float) (width) * mouseX)],690, 350);
  //showMeta();
  // show progress bar
  if(animazionelayout!=0){
    buttonProgressFrameSfondo.display();
    buttonProgressFrameMain.display();
      if (!(meta==null)){
        //buttonProgressData.w = map(audiotrack.position(), 0, meta.length(), 0, width-240 );
        buttonProgressDataSfondo.w = map(audiotrack.position(), 0, meta.length(), 0, 960 );
        buttonProgressDataMain.w = map(audiotrack.position(), 0, meta.length(), 0, 320 );
        buttonProgressDataSfondo.display();
        buttonProgressDataMain.display();
      }
  }
    // end progress bar

  /* if(myPort.available() > 0){
    if (lettura >= 0 && lettura <= 11) {
      text("Stai toccando un punto d'interesse", 50, 60);
    }else{
      //text("Connesso", 50, 60);
    }
  }else{
    text("Non connesso", 50, 75);} */
    fill(3);
  //showSidebar(indexForNames);
  
  textSize(10);
    image(loopingSponsor, 5, 410);
  
      //image(imgon, diston, 595);
      //image(imgoff, distoff, 595);
      fill(3);
      //createHeader();
      //image(header, 0, 0);
   //buttonUno.display();
   //buttonMicro.display();
   createLayout("santiguerrieri");
   fill(3);
     showSidebar(indexForNames);
  delay(5);
  
if(lettura>-1){
// @TODO  leggere il segnale 90 per il tocco multiplo
//#riquafix println(lettura);
//println(myPort);
//println(numerotraccia);
}
}

/******* Dispositivo SAN BERNARDINO ********/

void sanbernardinoPlayer(){

  background(255);
  createBackground("sanbernardino");
  if(mappattuale!=4){
    animazionelayout=0;
    testiaudioguide = loadXML("data/sanbernardino/audioguide.xml");
  loopingSponsor = new Gif(this, "sanbernardino/sponsor.gif");
  loopingSponsor.loop();
  loopingGif = new Gif(this, "sanbernardino/img0.gif");
    loopingGif.loop();
    mappattuale=4;
  }
  textSize(12);
  numerotraccia = 0;
  int lettura = myPort.read();
  if (lettura == 88 || lettura == 22 || lettura == 12) {
    autorizz = 88;
  }else{
    autorizz = 99;
  }

  if (autorizz == 99 && (millis() - pausePlaying) > 1000){
    if (lettura >= 49 && lettura <= 54) {
     if(animazionelayout==0){
        animazioneLayout();
        animazionelayout=1;
      }
// 1, 2, 3 and 4 are the signals to play the four specific audio-tracks
// 0 is general audio-track. The general track is activated the first time that the audioguide comes out of standby mode.
      if(!(lettura == 0 && audiotrack.isPlaying())){ //a NAND operation to prevent the play of general audio-track while a user is listening to another track
          indexForNames = lettura;
        if(nowPlaying !=lettura){ // if a user touches the sensor relative to the current track, the track is not charged again
          audiotrack.pause();
          //audiotrack = minim.loadFile("track"+indexForNames+".mp3");
          audiotrack = minim.loadFile("sanbernardino/track"+indexForNames+".mp3");
          imgtrack = Gif.getPImages(this, "sanbernardino/img"+indexForNames+".gif");
          loopingGif = new Gif(this, "sanbernardino/img"+indexForNames+".gif");
          loopingGif.loop();
          songLength = audiotrack.length();
          meta = audiotrack.getMetaData();
        }
        audiotrack.play();
        nowPlaying = lettura;
        //if(numerotraccia !=lettura){
        //if(numerotraccia != indexForNames){
           //numerotraccia = lettura;
        //}
      }
    }
  }

 if (lettura == 88){ // 88 is the STOP signal: Arduino sends 88, via serial, when the model is tilted downward
  if (audiotrack.isPlaying()) {
    audiotrack.pause();
    //imgtrack = loadImage("img0.gif");
  }
  pausePlaying = millis(); // is saved the moment of pause. We want, after pausing, it is impossible to start with a new play before the lapse of time (1 second)
 }

  if (lettura == 22 && audiotrack.isPlaying() || countRewind != 0){
//12 and 22 are respectively the signals for REWIND and FOWARD. Arduino sends 12 or 22 when the model is tilted (respectively) to the left or right
    if (audiotrack.isPlaying()) {
      audiotrack.pause();
      //imgtrack = loadImage("img0.gif");
    }
    countRewind = countRewind - 180;
 }
  if (lettura == 32 && audiotrack.isPlaying() || countFoward != 0){
//12 and 22 are respectively the signals for REWIND and FOWARD. Arduino sends 12 or 22 when the model is tilted (respectively) to the left or right
    if (audiotrack.isPlaying()) {audiotrack.pause();}
    countFoward = countFoward + 180;
 }
 if (lettura == 33 || lettura == 23){
    countRewFow = countRewind + countFoward;
    audiotrack.skip(countRewFow);
    countRewind=0;
    countFoward=0;
    audiotrack.play();
 }
    fill(255);
if ( audiotrack.isPlaying()){
  text("Audioguida in funzione", 665, 37);
    // show pause button
    textSize(16);
    fill(255);
  buttonPause.display();
  // riqua TEMP metti pausa
  rect(30, 149,2,12);
  rect(38, 149,2,12);
    textSize(12);
    fill(3);
}else{
  fill(255);
  text("Nessuna traccia audio attiva", 665, 37);
}
/* image(imgtrack, 690, 350); */
  image(loopingGif, 730, 310);
  //image(imgtrack[(int) (imgtrack.length / (float) (width) * mouseX)],690, 350);
// show progress bar
  if(animazionelayout!=0){
    buttonProgressFrameSfondo.display();
    buttonProgressFrameMain.display();
      if (!(meta==null)){
        //buttonProgressData.w = map(audiotrack.position(), 0, meta.length(), 0, width-240 );
        buttonProgressDataSfondo.w = map(audiotrack.position(), 0, meta.length(), 0, 960 );
        buttonProgressDataMain.w = map(audiotrack.position(), 0, meta.length(), 0, 320 );
        buttonProgressDataSfondo.display();
        buttonProgressDataMain.display();
      }
  }
    // end progress bar

  /* if(myPort.available() > 0){
    if (lettura >= 0 && lettura <= 11) {
      text("Stai toccando un punto d'interesse", 50, 60);
    }else{
      //text("Connesso", 50, 60);
    }
  }else{
    text("Non connesso", 50, 75);} */
    fill(3);
  showSidebar(indexForNames);
  
  textSize(10);
    image(loopingSponsor, 5, 410);
  
      fill(3);
   createLayout("sanbernardino");
  delay(5);
  
if(lettura>-1){
// @TODO  leggere il segnale 90 per il tocco multiplo
//#riquafix println(lettura);
//println(myPort);
//println(numerotraccia);
}
}

/******* Dispositivo SAN TOMMASO ********/

void santommasoPlayer(){

  if(mappattuale!=6){
    testiaudioguide = loadXML("data/santommaso/santi-guerrieri.xml");
    img = loadImage("santommaso/santommaso-big.png");
    loopingGif = new Gif(this, "santommaso/img0.gif");
    loopingComics = new Gif(this, "santommaso/comics0.gif");
    loopingDisegno = new Gif(this, "santommaso/disegno0.gif");
    loopingGif.loop();
    loopingComics.loop();
    loopingDisegno.loop();
    mappattuale=6;
  }
  textSize(12);
  numerotraccia = 0;
  int lettura = myPort.read();
  if (lettura == 88 || lettura == 22 || lettura == 12) {
    autorizz = 88;
  }else{
    autorizz = 99;
  }

  if (autorizz == 99 && (millis() - pausePlaying) > 1000){
    if (lettura >= 49 && lettura <= 54) {
// 1, 2, 3 and 4 are the signals to play the four specific audio-tracks
// 0 is general audio-track. The general track is activated the first time that the audioguide comes out of standby mode.
      if(!(lettura == 0 && audiotrack.isPlaying())){ //a NAND operation to prevent the play of general audio-track while a user is listening to another track
          indexForNames = lettura;
        if(nowPlaying !=lettura){ // if a user touches the sensor relative to the current track, the track is not charged again
          audiotrack.pause();
          //audiotrack = minim.loadFile("track"+indexForNames+".mp3");
          audiotrack = minim.loadFile("santommaso/track"+indexForNames+".mp3");
          imgtrack = Gif.getPImages(this, "santommaso/img"+indexForNames+".gif");
          loopingGif = new Gif(this, "santommaso/img"+indexForNames+".gif");
          loopingComics = new Gif(this, "santommaso/comics"+indexForNames+".gif");
          loopingGif.loop();
          loopingComics.loop();
          songLength = audiotrack.length();
          meta = audiotrack.getMetaData();
        }
        audiotrack.play();
        nowPlaying = lettura;
        //if(numerotraccia !=lettura){
        //if(numerotraccia != indexForNames){
           //numerotraccia = lettura;
        //}
      }
    }
  }

 if (lettura == 88){ // 88 is the STOP signal: Arduino sends 88, via serial, when the model is tilted downward
  if (audiotrack.isPlaying()) {
    audiotrack.pause();
    //imgtrack = loadImage("img0.gif");
  }
  pausePlaying = millis(); // is saved the moment of pause. We want, after pausing, it is impossible to start with a new play before the lapse of time (1 second)
 }

  if (lettura == 22 && audiotrack.isPlaying() || countRewind != 0){
//12 and 22 are respectively the signals for REWIND and FOWARD. Arduino sends 12 or 22 when the model is tilted (respectively) to the left or right
    if (audiotrack.isPlaying()) {
      audiotrack.pause();
      //imgtrack = loadImage("img0.gif");
    }
    countRewind = countRewind - 180;
 }
  if (lettura == 32 && audiotrack.isPlaying() || countFoward != 0){
//12 and 22 are respectively the signals for REWIND and FOWARD. Arduino sends 12 or 22 when the model is tilted (respectively) to the left or right
    if (audiotrack.isPlaying()) {audiotrack.pause();}
    countFoward = countFoward + 180;
 }
 if (lettura == 33 || lettura == 23){
    countRewFow = countRewind + countFoward;
    audiotrack.skip(countRewFow);
    countRewind=0;
    countFoward=0;
    audiotrack.play();
 }
  if (img!=null){
    background(img);
  }else{
    background(0);}
    fill(255);
if ( audiotrack.isPlaying()){
  text("Audioguida in funzione", 665, 37);
    // show pause button
    textSize(16);
    fill(255);
  buttonPause.display();
  //old show progress bar PRIMA era qui
    textSize(12);
    fill(3);
}else{
  fill(255);
  text("Nessuna traccia audio attiva", 665, 37);
}
/* image(imgtrack, 690, 350); */
image(loopingComics, 700, 275); // personalizzate per ortona #riqua
image(loopingGif, 722, 275); // personalizzate per ortona #riqua
  //image(imgtrack[(int) (imgtrack.length / (float) (width) * mouseX)],690, 350);
showMetaTrack(indexForNames);
// show progress bar
  buttonProgressFrame.display();
    if (!(meta==null)){
      //buttonProgressData.w = map(audiotrack.position(), 0, meta.length(), 0, width-240 );
      buttonProgressData.w = map(audiotrack.position(), 0, meta.length(), 0, 196 );
      buttonProgressData.display();
    }
    // end progress bar

  /* if(myPort.available() > 0){
    if (lettura >= 0 && lettura <= 11) {
      text("Stai toccando un punto d'interesse", 50, 60);
    }else{
      //text("Connesso", 50, 60);
    }
  }else{
    text("Non connesso", 50, 75);} */
    fill(3);
  showSidebar(indexForNames);
  
  textSize(10);
  
  
      image(imgon, diston, 595);
      image(imgoff, distoff, 595);
      fill(3);
      //createHeader();
      //image(header, 0, 0);
   buttonUno.display();
   buttonMicro.display();
     buttonStart2.display();
    image(startbutton, 886, 36);
    buttonImmagini.display();
    buttonTesti.display();
  delay(5);
  buttonImmagini.display();
    buttonTesti.display();
    if(viewimage){
  loopingDisegno = new Gif(this, "santommaso/disegno"+indexForNames+".gif");
  image(loopingDisegno, 235, 270);
}
  
if(lettura>-1){
// @TODO  leggere il segnale 90 per il tocco multiplo
//#riquafix println(lettura);
//println(myPort);
//println(numerotraccia);
}
}
