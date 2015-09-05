import processing.serial.*;


// *****************************************************
final String pathGlobalDefault = "C:\\Test\\";
final String pathGlobalHome    = "C://Test//";
boolean showSongList = false;  // list or meta
boolean showFFT      = true;   // show fft yes/no  
// end of config 
// *****************************************************

//import cc.arduino.*;

import de.fhpotsdam.unfolding.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.utils.*;
import de.fhpotsdam.unfolding.marker.*;
import de.fhpotsdam.unfolding.marker.MarkerManager;
import de.fhpotsdam.unfolding.providers.*;
import controlP5.*;

UnfoldingMap map;
ControlP5 filtromappa;
CheckBox checkmappa;
String[] filtroLuoghi = {"Cose da vedere","Dove mangiare","Dove dormire","Dove acquistare"}; 
boolean[] filtroRes;
ADCheck checkButtonFiltro;

Location[][] locationMarkers;
String[][] descriptionMarkers;
String[][] titleMarkers;
int zoomMap;
float latCenterMap;
float lonCenterMap;
int versione;

Location locationLaquila = new Location(42.350f, 13.402f);
Location locationSantiGuerrieri = new Location(42.299f, 13.683f);
Location locationTeramo = new Location(42.669f, 13.703f);
Location locationCentroTeramo = new Location(42.669f, 13.705f);
Location locationFossacesia = new Location(42.255f, 14.450f);
Location locationOrtona = new Location(42.357f, 14.404f);
Location locationHiStoria = new Location(42.455f, 14.201f);
Location locationRiqua = new Location(42.750839f, 13.962244f);

//import processing.data.*;
import gifAnimation.*;
import ddf.minim.*;
import ddf.minim.analysis.*;

import java.awt.Image;

import processing.video.*;
Movie myMovie, introDuomo, introSantanna, postDuomo;

//Arduino arduino;
Minim minim;
AudioPlayer audiotrack;
AudioMetaData meta;
int songLength=0;

Gif loopingGif;
Gif loopingComics;
Gif loopingDisegno;
Gif loopingSponsor;

/* Elementi grafici di default */
int animazionelayout=0;
int sfondox =61;
int barrarectY = 213;
int sfondoavatarsize=170;
// parte inferiore
String guida;
// parte superiore
PShape intro_play, intro_pause, intro_touch;
PShape button_Map;
PShape button_List;
PShape button_Mode;
PShape barracurva;
PShape barrarect;
PShape pulsanteplay;
PShape ombrapulsanteplay;
PShape adminbar;
int pulsazionebottone = 60;

int fsize = 12;
boolean cell_1 = false;
boolean starttrack = false;
/* serial */
int connessoCOM = -1;
Serial myPort;
boolean found = false;
int lettura;
Serial  arduinoPort; // Usually the last port 
int     portNumber = 2;
String  portName ;
String  buffer;      //String for testing serial communication
/* fine serial */
int autorizz;
int indexForNames = 0;
int nowPlaying;
int pausePlaying;
int countRewind;
int countFoward;
int countRewFow;
int diston = 740;
int distoff = 850;

PImage img, avatar, ombra;
PImage imgon;
PImage imgoff;
PImage[] imgtrack;
PImage logo, header, header_mappa, header_lista, adminbar_shadow;
PImage corpo_lista;
PImage footer;
PImage startbutton;
PImage resetbutton;

PShape pulsantepausa;
Button buttonTesti;
Button buttonImmagini;
Button buttonPause;
Button buttonStart;
Button buttonReset;
Button buttonStart2;
Button buttonReset2;
Button buttonProgressFrame, buttonProgressDataMain, buttonProgressFrameMain; 
Button buttonProgressData, buttonProgressDataSfondo, buttonProgressFrameSfondo;
Button buttonPrevious;
Button buttonNext;
Button buttonMappa, buttonLista, buttonMode;
Button buttonShowSongListOrOneSong;
Button buttonFolderUp;
Button buttonHome;
Button buttonPreviousFolder;
Button buttonNextFolder;
Button buttonUno; 
Button buttonMicro;

Button buttonMappateramo;
Button buttonSanbernardino;
Button buttonDuomoteramo;
Button buttonSantiguerrieri;
Button buttonSanTommaso;

processing.data.XML testiaudioguide; 
processing.data.XML locationmap; 

int numerotraccia;

//pause -> play = false; stop = false;
boolean videoplay = false;
boolean videostop = true;
boolean haisbloccato = false;
boolean viewimage = false;

boolean duomoiniziato, duomofinito, piazzainiziata, piazzafinita, museoiniziato = false;

//boolean PROVA = false;
PFont lobster, opensans12, opensansB12, opensans16, opensansB16;

// states 
final int statePlayer      =0;        // play song 
// this is the state for file manager / when no song is found in the 
// folder:
final int stateLista =1;        // dir exists but has no mp3
final int stateMappa        =3;        // show help
final int statePlayerSanbernardino =4;
final int statePlayerSantiguerrieri =5;
final int statePlayerSanTommaso =6;
final int stateUndefined   =-1;       // state Undefined
final int stateDrives      =4;        // state Drives

//int state = statePlayer;              // current state 
int state = statePlayerSantiguerrieri;              // current state 

int tracciaAudio =0;
final int tracciauno =1;        // dir exists but has no mp3
final int tracciadue =2;        // show help
final int tracciatre =3;
final int tracciaquattro =4;
final int tracciacinque =5;
final int tracciasei   =6;       // state Undefined
final int tracciasette =7;        // state Drives

// test quiz
String[] options = {"Giotto", "Botticelli", "Raffaello"}; 
ADRadio radioButton;
boolean quizdemo = false;

int viewmarker=0;
int mappattuale = 0;

void setup() {
  //size(684, 500);
  size(960, 620);
  nowPlaying = 0;
  autorizz = 99;
  countRewFow=0;
  pausePlaying = -1000; //milliseconds that must pass after a pause input, before it can be made again a play
//println(arduino.list());
//println(Serial.list());
// NANO 
//myPort = new Serial(this, Serial.list()[Serial.list().length-1], 9600);
// TERAMO e Uno-based!
//myPort = new Serial(this, Serial.list()[0], 9600);
//myPort = new Serial(this, Serial.list()[1], 9600);
  //println(myPort);
  //myPort.clear(); //1.1
  //findPort();
  scanPort();
  println("Connesso al dispositivo!");
  //println(myPort);
  minim = new Minim(this);
  println("Caricamento audio...");
  //audiotrack = minim.loadFile("data/track"+indexForNames+".mp3");
  audiotrack = minim.loadFile("data/track"+indexForNames+".wav");
  println("Caricamento testi...");
  testiaudioguide = loadXML("data/santi-guerrieri.xml");
  //testiaudioguide = loadXML("data/san-bernardino.xml");
  println("Caricamento immagini...");
  //img = loadImage("bkg.jpg");
  img = loadImage("santi-guerrieri.png");
  //img = loadImage("san-bernardino-big.png");
  defineButtons();
  PImage icon = loadImage("ic_launcher.png");
  frame.setIconImage((Image) icon.getNative());
  frame.setTitle("Hi-Storia - il patrimonio culturale a portata di mano (versione 0.9.1)"); 
  //ImageIcon titlebaricon = new ImageIcon(loadBytes("ic_launcher.png"));
  //frame.setIconImage(titlebaricon.getImage());
  /* ########## @TODO ##########*/
  // qui da fare un ciclo che conta il numero di tracce nell'xml
  // e carica il relativo numero di immagini
  //imgtrack = loadImage("img0.gif");
  imgon = loadImage("on.png");
  imgoff = loadImage("off.png");
  logo = loadImage("logo.png");
  adminbar_shadow = loadImage("adminbar_shadow.png");
  header = loadImage("header.png");
  header_mappa = loadImage("header_mappa.png");
  header_lista = loadImage("header_lista.png");
  corpo_lista  = loadImage("corpo_lista.png");
  footer = loadImage("footer.png");
  startbutton = loadImage("playbutton.png");
  resetbutton = loadImage("resetbutton.png");
  loopingGif = new Gif(this, "img0.gif");
  loopingGif.loop();
  loopingSponsor = new Gif(this, "santiguerrieri/sponsor.gif");
  loopingSponsor.loop();
  imgtrack = Gif.getPImages(this, "img2.gif");
  /* Elementi video, da mettere un condizionale se il modellino presenta video */
  /*println("Caricamento video...");
  introDuomo = new Movie(this, "introduomo.3gp");
  introSantanna = new Movie(this, "introsantanna.3gp");
  postDuomo = new Movie(this, "postduomo.3gp");
  myMovie = new Movie(this, "postduomo.3gp");*/
  /* Elementi grafici di default */
  println("Caricamento vettoriali...");
  button_Map = loadShape("buttonMap.svg");
  button_List = loadShape("buttonList.svg");
  button_Mode = loadShape("buttonMode.svg");
  intro_play = loadShape("intro_play.svg");
  intro_touch = loadShape("intro_touch.svg");
  intro_pause = loadShape("intro_pause.svg");
  noStroke();
  ombrapulsanteplay = createShape(ELLIPSE,mouseX,mouseY,71,71);
  ombrapulsanteplay.setFill(color(0,40));
  pulsanteplay = createShape(ELLIPSE,858,12,71,71);
  pulsanteplay.setFill(color(244,255,120));
  adminbar = createShape(RECT,0,0,960,72);
  adminbar.setFill(color(255));
  barrarect = createShape(RECT,0,213,960,48);
  barrarect.setFill(color(255,255,255,60));
  //ombrapulsanteplay.setStroke(color(0,0,0,0));
  //ombrapulsanteplay.setStrokeWeight(0);

  // mappa
  println("Caricamento mappa...");
  filtromappa = new ControlP5(this);
  checkButtonFiltro = new ADCheck(20,526, filtroLuoghi, "radioButton"); 
  locationmap = loadXML("data/mappa.xml");
  getMakersFromXML(locationmap);
  filtroRes = new boolean[checkButtonFiltro.length()];
  map = new UnfoldingMap(this, new Google.GoogleMapProvider());
  map.setTweening(true);
  //map.zoomToLevel(6);
  //map.panTo(new Location(54.00f, 11.00f));
  //map.zoomToLevel(6);
  map.zoomAndPanTo(zoomMap, new Location(latCenterMap, lonCenterMap));
  //map.zoomAndPanTo(9, new Location(42.299f, 13.683f));
  MapUtils.createDefaultEventDispatcher(this, map);
  
  
  //setta filtro mappa
  checkmappa = filtromappa.addCheckBox("checkMappa")
                .setPosition(50, 500)
                .setSize(15, 15)
                .setItemsPerRow(1)
                .setSpacingColumn(90)
                .setSpacingRow(10)
                .addItem(filtroLuoghi[0], 0)
                .addItem(filtroLuoghi[1], 1)
                .addItem(filtroLuoghi[2], 2)
                .addItem(filtroLuoghi[3], 3)
                .setColorBackground(160)
                .setColorLabel(color(30,30,30))
                .setColorForeground(color(57,177,183))
                .setBackgroundHeight(100)
                .setBackgroundColor(color(242))
                .activate(0)
                .hide();
    if (key=='R') {
    checkmappa.deactivateAll();
  } 
  else {
    for (int i=1;i<5;i++) {
      // check if key 1-4 have been pressed and toggle
      // the checkbox item accordingly.
      if (keyCode==(48 + i)) { 
        // the index of checkbox items start at 0
        checkmappa.toggle(i);
        println("toggle "+checkmappa.getItem(i).getName());
        // also see 
        // checkbox.activate(index);
        // checkbox.deactivate(index);
      }
    }
  }
  
  
  
  //da spostare su chiamata della tab corretta
  // test quiz demo
  radioButton = new ADRadio(265, 365, options, "radioButton"); 
  radioButton.setDebugOn();
  radioButton.setBoxFillColor(#F7ECD4);  
  radioButton.setValue(0);
  println("Caricamento font...");
  lobster = loadFont("LobsterTwo-BoldItalic-30.vlw");
  opensans12 = loadFont("OpenSans-12.vlw");
  opensans16 = loadFont("OpenSans-16.vlw");
  opensansB12 = loadFont("OpenSans-Bold-12.vlw");
  opensansB16 = loadFont("OpenSans-Bold-16.vlw");
  println("Dispositivo pronto!");
}
void draw() {
  switch (state) {
  case statePlayer:
    videoPlayer ();
    break; 
  case stateLista: 
    listaLuoghi();
    break; 
  case stateMappa:
    mappaLuoghi();
    break;
  case statePlayerSanbernardino:
    sanbernardinoPlayer();
    break;
   case statePlayerSantiguerrieri:
   santiguerrieriPlayer();
   break;
   case statePlayerSanTommaso:
    santommasoPlayer();
    break;
  default:
    println ("Missing state, error 111, tab Main");
    exit();
    break;
  } // switch
  createHeader();
}

void stop()
{
  audiotrack.close();
  minim.stop();
  super.stop();
}

void showSidebar(int traccia) {
    XML[] testotraccia = testiaudioguide.getChildren("track");
  //XML[] contenutotraccia=testotraccia[1].getChildren("content");
  if(traccia>0 && (state==6||state==4)){
    //sostituirlo con riferimento a modello
    traccia=traccia-48;
  }
   if ( animazionelayout != 0) {
  XML[] contenutotraccia=testotraccia[traccia].getChildren("content");
  String traaa = contenutotraccia[0].getContent();
  XML[] titolotraccia=testotraccia[traccia].getChildren("title");
  String titolo = titolotraccia[0].getContent();
  String numtraccia = "Traccia "+traccia;
  textFont(opensansB12);
  text(titolo, 405, 162, 510, 15);
  textFont(opensans12);
  textSize(fsize);
  text(traaa, 258, 195, 420, 365);
  //textSize(12);
  text(numtraccia, 405, 145, 510, 15);
  fill(3);
    String mancante = strFromMillis ( audiotrack.position() );
    textFont(opensans12);
    fill(255);
    text(mancante, 69, 141, 90, 70);
    String totale = strFromMillis(meta.length());
    fill(170);
    text(totale, 365, 141, 90, 70);
    fill(0);
    // qui metto i vecchi contenuti di ShowMeta
    int ys = 225;  // y start-pos
    int yi = 16;   // y line difference
    //
    int y = ys;
    XML[] autoretraccia=testotraccia[traccia].getChildren("autore");
    if(autoretraccia != null){
      String autore = autoretraccia[0].getContent();
      textFont(opensans12);
      text("Testi:", 15, y+=yi);
      textFont(opensansB12);
      text(autore, 95, y);
      textFont(opensans12);
    }
    XML[] speakertraccia=testotraccia[traccia].getChildren("speaker");
    if(speakertraccia != null){
      String speaker = speakertraccia[0].getContent();
      textFont(opensans12);
      text("Voce:", 15, y=y+(yi*3));
      textFont(opensansB12);
      text(speaker, 95, y);
      textFont(opensans12);
    }
  }else{
    shape(intro_play, 280, 270);
    shape(intro_touch, 580, 390);
    shape(intro_pause, 280, 510); 
    textFont(opensans16);
    String intro_play_t ="Avvia la traccia introduttiva cliccando sull'icona del monumento in alto a sinistra";
    String intro_touch_t ="Tocca i sensori di colore nero sulla superificie della stampa 3D per attivare i contenuti multimediali";
    String intro_pause_t ="Metti in pausa la traccia audio cliccando sulla barra spaziatrice";
    text(intro_play_t, 380, 290, 340, 365);
    text(intro_touch_t, 280, 420, 320, 365);
    text(intro_pause_t, 380, 550, 320, 365);
    textFont(opensans12);
  }
}

void showMeta() {
  int ys = 225;  // y start-pos
  int yi = 16;   // y line difference
  //
  int y = ys;
  fill(3);
  if (!(meta==null)) {
    //textTab("File Name: \t" + showSongWithoutFolder(), 5, y);
    //textTab("Durata: \t" + strFromMillis(meta.length()), 15, y+=yi);
    /*textTab("Title: \t" + meta.title(), 5, y+=yi);
    textTab("Author: \t" + meta.author(), 5, y+=yi);
    textTab("Album: \t" + meta.album(), 5, y+=yi);
    textTab("Date: \t" + meta.date(), 5, y+=yi);
    textTab("Comment: \t" + meta.comment(), 5, y+=yi);*/
    //textTab("Autore: \t" + "Lida Bonolis", 15, y+=yi);
    textTab("Testi: \t" + "A. Amadio, L. Bonolis, ", 15, y+=yi);
    textTab(". \t" + "D. Ruggieri", 15, y+=yi);
    textTab("Voce: \t" + "A. Amadio, L. Bonolis", 15, y=y+(yi*3));
    //textTab("Revisione: \t" + "Emanuela Amadio", 15, y+=yi);
  } // if
}

void showMetaTrack(int traccia) {
  tracciaAudio=traccia-48;
  int ys = 465;  // y start-pos
  int yi = 16;   // y line difference
  //
  int y = ys;
  fill(3);
  if (!(meta==null)) {
    //textTab("File Name: \t" + showSongWithoutFolder(), 5, y);
    //textTab("Durata: \t" + strFromMillis(meta.length()), 15, y+=yi);
    /*textTab("Title: \t" + meta.title(), 5, y+=yi);
    textTab("Author: \t" + meta.author(), 5, y+=yi);
    textTab("Album: \t" + meta.album(), 5, y+=yi);
    textTab("Date: \t" + meta.date(), 5, y+=yi);
    textTab("Comment: \t" + meta.comment(), 5, y+=yi);*/
    //textTab("Autore: \t" + "Lida Bonolis", 15, y+=yi);
      switch (tracciaAudio) {
  case tracciauno:
    textTab("Autrice: \t" + "Benedetta Verna", 15, y+=yi);
    textTab("Speaker: \t" + "Benedetta Verna", 15, y+=yi);
    textTab("Illustratore: \t" + "Pietro di Leve", 15, y+=yi);
    textTab("Supervisori: \t" + "A. Amadio, L. Bonolis", 15, y+=yi);
    textTab(". \t" + "Prof.ssa F. Di Castelnuovo", 15, y+=yi);
    //textTab("Revisione: \t" + "Emanuela Amadio", 15, y+=yi);
    break; 
  case tracciadue: 
    textTab("Autrice: \t" + "Fracesca Recchini", 15, y+=yi);
    textTab("Speaker: \t" + "Francesco Martelli", 15, y+=yi);
    textTab("Illustratore: \t" + "Kleanthi Bracciali", 15, y+=yi);
    textTab("Supervisori: \t" + "A. Amadio, L. Bonolis", 15, y+=yi);
    textTab(". \t" + "Prof.ssa F. Di Castelnuovo", 15, y+=yi);
    //textTab("Revisione: \t" + "Emanuela Amadio", 15, y+=yi);
    break; 
  case tracciatre:
    textTab("Autrice: \t" + "Alessia Di Francesco", 15, y+=yi);
    textTab("Speaker: \t" + "Maria Chiara Di Martino", 15, y+=yi);
    textTab("Illustratore: \t" + "Pietro Di Leve", 15, y+=yi);
    textTab("Supervisori: \t" + "A. Amadio, L. Bonolis", 15, y+=yi);
    textTab(". \t" + "Prof.ssa F. Di Castelnuovo", 15, y+=yi);
    //textTab("Revisione: \t" + "Emanuela Amadio", 15, y+=yi);
    break;
  case tracciaquattro:
    textTab("Autrice: \t" + "Giulia D’Attanasio", 15, y+=yi);
    textTab("Speaker: \t" + "Francesco Martelli", 15, y+=yi);
    textTab("Illustratrice: \t" + "Ylenia Di Ghionno", 15, y+=yi);
    textTab("Supervisori: \t" + "A. Amadio, L. Bonolis", 15, y+=yi);
    textTab(". \t" + "Prof.ssa F. Di Castelnuovo", 15, y+=yi);
    //textTab("Revisione: \t" + "Emanuela Amadio", 15, y+=yi);
    break;
   case tracciacinque:
    textTab("Autrice: \t" + "Chiara Quintiliani", 15, y+=yi);
    textTab("Speaker: \t" + "Chiara Quintiliani", 15, y+=yi);
    textTab("Illustratrice: \t" + "Sharon Minchilli", 15, y+=yi);
    textTab("Supervisori: \t" + "A. Amadio, L. Bonolis", 15, y+=yi);
    textTab(". \t" + "Prof.ssa F. Di Castelnuovo", 15, y+=yi);
    //textTab("Revisione: \t" + "Emanuela Amadio", 15, y+=yi);
    break;
   case tracciasei:
    textTab("Autrice: \t" + "Alessia D’Andrea", 15, y+=yi);
    textTab("Speaker: \t" + "Kleanthi Bracciali", 15, y+=yi);
    textTab("Illustratrice: \t" + "Laura Gnagnarelli", 15, y+=yi);
    textTab("Supervisori: \t" + "A. Amadio, L. Bonolis", 15, y+=yi);
    textTab(". \t" + "Prof.ssa F. Di Castelnuovo", 15, y+=yi);
    //textTab("Revisione: \t" + "Emanuela Amadio", 15, y+=yi);
    break;
  default:
    textTab("Autore: \t" + "G. Amadio, L. Bonolis, ", 15, y+=yi);
    textTab("Speaker: \t" + "A. Amadio, L. Bonolis", 15, y+=yi);
    textTab("Illustratore: \t" + "A. Amadio, L. Bonolis", 15, y+=yi);
    textTab("Supervisori: \t" + "A. Amadio, L. Bonolis", 15, y+=yi);
    textTab(". \t" + "Prof.ssa F. Di Castelnuovo", 15, y+=yi);
    //textTab("Revisione: \t" + "Emanuela Amadio", 15, y+=yi);    exit();
    break;
  } // switch
  } // if
}

void textTab (String s, float x, float y)
{
  // makes \t as tab for a table for one line
  // only for 2 columns yet
  // indent:  
  int indent = 90;
  //
  s=trim ( s );
  String [] texts = split (s, "\t");
  s=null;
  texts[0]=trim(texts[0]);
  text (texts[0], x, y);
  //
  // do we have a second part?
  if (texts.length>1&&texts[1]!=null) {
    // is the indent too small
    if (textWidth(texts[0]) > indent) {
      indent = int (textWidth(texts[0]) + 10);
    } // if
    //
    texts[1]=trim(texts[1]);
    text (texts[1], x+indent, y);
  }
} // func

String strFromMillis ( int m ) {
  // returns a string that represents a given millis m as hrs:minute:seconds
  float sec;
  int min;
  //
  sec = m / 1000;
  min = floor(sec / 60); 
  sec = floor(sec % 60);
  // over one hour?
  if (min>59) {
    int hrs = floor(min / 60);
    min = floor (min % 60);
    return  hrs+":"+nf(min, 2)+":"+nf(int(sec), 2);
  }
  else
  {
    return min+":"+nf(int(sec), 2);
  }
}

void mouseClicked() {
  if(state==statePlayerSanTommaso){
  if (buttonStart2.over()){ //ORTONA
    println("Okkk!");
      if (audiotrack.isPlaying()) {audiotrack.pause();}
      indexForNames=49;
      audiotrack = minim.loadFile("santommaso/track1.mp3");
          imgtrack = Gif.getPImages(this, "santommaso/img1.gif");
          loopingGif = new Gif(this, "santommaso/img1.gif");
          loopingComics = new Gif(this, "santommaso/comics1.gif");
          loopingGif.loop();
          loopingComics.loop();
          songLength = audiotrack.length();
          meta = audiotrack.getMetaData();
        audiotrack.play();
        nowPlaying = 1;
        showMetaTrack(indexForNames);
        showSidebar(indexForNames);
    }
    if (buttonTesti.over()){
      viewimage = false;
    }
    if (buttonImmagini.over()){
      viewimage = true;
    }// fine ortona
  }
  if(state==statePlayer||(3 < state && state < 7)){
    if (buttonPause.over()) {
      if (audiotrack.isPlaying()) {audiotrack.pause();}
      pausePlaying = millis(); // is saved the moment of pause. We want, after pausing, it is impossible to start with a new play before the lapse of time (1 second)
    }
    if (buttonUno.over()) {
      if (!audiotrack.isPlaying()) {
        myPort = new Serial(this, Serial.list()[Serial.list().length-1], 9600); //myPort = new Serial(this, Serial.list()[0], 9600);
        myPort.clear(); //1.1
        diston = 740;
        distoff = 850;
      }
    }
    if (buttonMicro.over()) {
      if (!audiotrack.isPlaying()) {
        myPort = new Serial(this, Serial.list()[0], 9600); //myPort = new Serial(this, Serial.list()[Serial.list().length-1], 9600);
        distoff = 740; // questa è la funzione per vedere il quiz === quizdemo= true;
        diston = 850;
      }
    }
    if (buttonReset.over()) {
        imgtrack = Gif.getPImages(this, "img0.gif");
        loopingGif = new Gif(this, "img0.gif");
        loopingGif.loop();
        
         nowPlaying = 0;
        
        indexForNames = 0;
        showSidebar(0);
        
        // VIDEO
        if(!starttrack){
          audiotrack.close();
              videoplay = true;
              //videoplay = !videoplay;
              videostop = false;
              myMovie.stop();
              myMovie = introDuomo;
              myMovie.play();
        
      starttrack=true;
        }else{
      starttrack=false;
      museoiniziato = false;
      piazzainiziata = false;
      duomoiniziato = false;
      
      //VIDEO
      videostop();
      }
    }
  }
  if (buttonMappa.over()) {
    state = stateMappa;
  }
  if (buttonLista.over()) {
    state = stateLista;
  }
  if(state==stateLista){
    checkmappa.hide();
    if (buttonMappateramo.over()) {
      state = statePlayer;
    }
    if (buttonSanbernardino.over()) {
      state = statePlayerSanbernardino;
    }
    if (buttonSantiguerrieri.over()){
      state = statePlayerSantiguerrieri;
    }
    if (buttonSanTommaso.over()){
      state = statePlayerSanTommaso;
    }
  }
  
      if( (mouseX > 200 && mouseX < 350) && (mouseY > 0 && mouseY < 250) ) {
    //image(myMovie, 0, 0);
    //myMovie.pause(); 
    //audiotrack.pause();
    }else if( (mouseX > 0 && mouseX < 150) && (mouseY > 0 && mouseY < 200) ){ 
    /*myMovie.read();
    image(myMovie, 0, 0);
    myMovie.play();    */
    //videoplay = true;
    //videoplay = !videoplay;
    //videostop = false;
    //audiotrack.play();
    }
}

/* void mousePressed(){ 
  if (!audiotrack.isPlaying()) {
    if( (mouseX > 200 && mouseX < 350) && (mouseY > 0 && mouseY < 250) ) {
      fill(50,255,255);
      rect(200, 0, 150, 250);
    }else if( (mouseX > 0 && mouseX < 150) && (mouseY > 0 && mouseY < 200) ){ 
       fill(250,55,255);
      rect(0, 0, 150, 200);
    }
  }
} */


void keyPressed() {
  // zoom
  //if (keyCode == UP) zoom += 0.05;
  //if (keyCode == DOWN) zoom -= 0.05;  
  if (key == 'p') fsize += 2;
  if (key == 'o') fsize -= 2; 
  if (key == 'q'){
    //image(myMovie, 0, 0);
    myMovie.stop(); 
    audiotrack.close();
      minim.stop();
  super.stop();
  }
  if (keyCode == LEFT){
    if (audiotrack.isPlaying()) {audiotrack.pause();}
    countRewind = countRewind - 180;
  }
  if (keyCode == RIGHT){
    if (audiotrack.isPlaying()) {audiotrack.pause();}
    countFoward = countFoward + 180;
  } 
  if (keyCode == ' '){
    if (audiotrack.isPlaying()) {
      audiotrack.pause();
    }
    pausePlaying = millis(); // is saved the moment of pause. We want, after pausing, it is impossible to start with a new play before the lapse of time (1 second)
  }
 }
 
 void keyReleased() {
   if (keyCode == RIGHT || keyCode == LEFT){
      countRewFow = countRewind + countFoward;
      audiotrack.skip(countRewFow);
      countRewind=0;
      countFoward=0;
      audiotrack.play();
   }
 }
 
void movieEvent(Movie m) {
  m.read();
}

void videostop(){
    myMovie.stop();
    videoplay = false;
    videostop = true;
}

void createLayout(String guida){
if(animazionelayout==0){
  barrarectY = 213;
  fill(225,225,225,70);
  rect(0, 258, 960, 3);
  ombra = loadImage("ombra.png");
  image(ombra, 10, 225);
  barrarect = createShape(RECT,0,barrarectY,960,48);
  barrarect.setFill(color(255,255,255,60));
  shape(barrarect);
  fill(255,255,255);
  ellipse(116,222,170,170);
  guida = guida+"/avatar.png";
  avatar = loadImage(guida);
  image(avatar, 30, 135);
  //shape(ombrapulsanteplay, mouseX, mouseY);
}else{
  if(barrarectY>140){
    barrarectY = barrarectY-20;
  }
  if(sfondoavatarsize>0){
    fill(255,255,255);
    ellipse(116,222,sfondoavatarsize,sfondoavatarsize);
    sfondoavatarsize=sfondoavatarsize-30;
  }else{
  pulsantiComandi();
  }
  barrarect = createShape(RECT,0,barrarectY,960,48);
  barrarect.setFill(color(255,255,255,60));
  shape(barrarect);
}
shape(pulsanteplay);
}

void createHeader(){
image(adminbar_shadow, 0, 0);
shape(adminbar);
image(logo, 0, 0);
shape(button_Map, 150, 20);
shape(button_List, 330, 20);
shape(button_Mode, 520, 20);
  buttonMappateramo.display();
  buttonSanbernardino.display();
}

void createBackground(String guida){
  guida = guida+"/sfondo.jpg";
  img = loadImage(guida);
  if(animazionelayout==0){
    sfondox=61;
    fill(234);
    rect(0, 220, 238, 420);
    rect(719, 220, 241, 420);
  }else{
    fill(234);
    rect(0, 170, 238, 470);
    rect(719, 170, 241, 470);
    if(sfondox>-10){
      sfondox=sfondox-20;
    }
    //createHeader();
  }
  image(img, 0, sfondox);
  textFont(lobster);
  fill(255);
  textAlign(CENTER);
  switch(mappattuale){
    case(5):
    text("Territorio di Santi e Guerrieri", 480, 120);
    if(animazionelayout==0){
      textFont(opensansB16);
      text("Audioguida di livello base", 480, 165);
    }
    break;
    case(6):
    text("Basilica di San Bernardino", 480, 120);
    if(animazionelayout==0){
      textFont(opensansB16);
      text("Audioguida di livello base", 480, 165);
    }
    break;
  }
  //textFont(arial);
  textFont(opensans12);
  textAlign(LEFT);
}

/* void pulsazionebottone(){
    fill(255,255,255,35);
  //fill(c1,c2,c3,t);
  int f = pulsazionebottone-10;
  ellipse(mouseX,mouseY,f,f);
  ellipse(mouseX,mouseY,pulsazionebottone,pulsazionebottone);
  pulsazionebottone= pulsazionebottone+5;
  ellipse(mouseX,mouseY,pulsazionebottone,pulsazionebottone);
  if(pulsazionebottone>90){pulsazionebottone=60;}
  delay(100);} */

void animazioneLayout(){

}

void pulsantiComandi(){
  /*pulsantepausa = createShape(ELLIPSE,20,130,30,30);
  pulsantepausa.setFill(color(255,255,255,0));
  pulsantepausa.setStroke(true);
  pulsantepausa.setStroke(color(255,255,255));
  pulsantepausa.setStrokeWeight(2);
  shape(pulsantepausa);*/
}

void findPort(){
  // NANO 
  //myPort = new Serial(this, Serial.list()[Serial.list().length-1], 9600);
  // TERAMO e Uno-based!
  myPort = new Serial(this, Serial.list()[0], 9600);
  //myPort = new Serial(this, Serial.list()[1], 9600);
  //println(myPort);
  if ( myPort.available() < 0){
  myPort = new Serial(this, Serial.list()[Serial.list().length-1], 9600);
  }
  myPort.clear(); //1.1
  lettura = myPort.read();
}

void scanPort(){
println ("Scan porte COM aperte...");
 
  //int lastPort = Serial.list().length -1;
  int lastPort = 0;
 
  //while (lastPort<0)
  while ((lastPort>Serial.list().length -1)||(lastPort<0))
  {
    println("Nessuna porta seriale utilizzata. Rescanning...");
    delay(1000);
    //lastPort = Serial.list().length -1;
    lastPort = 0;
  }
 
 println("Localizzando i dispositivi...");
 
  println(Serial.list());
 
  while (!found)
  {
    portName = Serial.list()[lastPort];
    println("Connettendo a -> " + portName);
    delay(200);
 
    try {
      arduinoPort = new Serial(this, portName, 9600);
      arduinoPort.clear();
      connessoCOM=lastPort;
      delay(150);
      arduinoPort.bufferUntil(90);// lettera Z
      arduinoPort.write(90);
 //String inString = arduinoPort.readString();
 //println(inString);
      int l = 50;
      while (!found && l >0)
      {
        delay(200);
        println("Aspettando la risposta dal dispositivo sulla " + portName);
        l--;
      }
 
      if (!found)
      {
        println("Nessuna risposta dal dispositivo sulla porta " + portName);
        arduinoPort.clear();
        arduinoPort.stop();
        delay(200);
      }
 
    }
    catch (Exception e) {
      println("Errore sulla " + portName);
      println(e);
    }
   if(lastPort==0){
     lastPort=Serial.list().length -1;
   }else{
     lastPort--;
   }
    //lastPort--;
    //lastPort++;
    /*if (lastPort <0){
      lastPort = Serial.list().length -1;}*/
    /*if (lastPort >(Serial.list().length -1)){
      lastPort = 0;}*/
  }
  arduinoPort.clear();
  arduinoPort.write('I');
}

void serialEvent(Serial p) {
  if(connessoCOM!=-1){
    String inString = arduinoPort.readString();
    if (inString.equals("Z") == true) {
      myPort=arduinoPort;
      lettura=99;
      arduinoPort.clear();
      //println(inString);
      arduinoPort.write('Z');
      found=true;
    }
  }
}

void getMakersFromXML(XML locationmap) {
  XML[] contentmap = locationmap.getChildren("datimappa");
  zoomMap = contentmap[0].getInt("zoom");
  latCenterMap = contentmap[0].getFloat("lat");
  lonCenterMap = contentmap[0].getFloat("lon");
  versione = contentmap[0].getInt("versione");
  XML[] contentmarker = locationmap.getChildren("location");
  int n = contentmarker.length;
  locationMarkers = new Location[4][n];
  descriptionMarkers = new String[4][n];
  titleMarkers = new String[4][n];
  int daVedere = 0;
  int doveMangiare = 0;
  int doveDormire = 0;
  int doveComprare = 0;
  for(int i = 0; i < n; i++) {
    contentmarker[i].getChildren("lat");
    float lat = contentmarker[i].getFloat("lat");
    int tipologia = contentmarker[i].getInt("type");
    float lon = contentmarker[i].getFloat("lon");
    XML[] titolotraccia=contentmarker[i].getChildren("title");
    String titolo = titolotraccia[0].getContent();
    XML[] descrizionetraccia=contentmarker[i].getChildren("desc");
    String descrizione = descrizionetraccia[0].getContent();
    switch(tipologia){
      case 0:
        locationMarkers[tipologia][daVedere]= new Location(lat, lon);
        titleMarkers[tipologia][daVedere]= titolo;
        descriptionMarkers[tipologia][daVedere]= descrizione;
        daVedere++;
      break;
      case 1:
        locationMarkers[tipologia][doveMangiare]= new Location(lat, lon);
        titleMarkers[tipologia][doveMangiare]= titolo;
        descriptionMarkers[tipologia][doveMangiare]= descrizione;
        doveMangiare++;
      break;
      case 2:
        locationMarkers[tipologia][doveDormire]= new Location(lat, lon);
        titleMarkers[tipologia][doveDormire]= titolo;
        descriptionMarkers[tipologia][doveDormire]= descrizione;
        doveDormire++;
      break;
      case 3:
        locationMarkers[tipologia][doveComprare]= new Location(lat, lon);
        titleMarkers[tipologia][doveComprare]= titolo;
        descriptionMarkers[tipologia][doveComprare]= descrizione;
        doveComprare++;
      break;
      }
  }
  //println(locationMarkers[1]);
}
