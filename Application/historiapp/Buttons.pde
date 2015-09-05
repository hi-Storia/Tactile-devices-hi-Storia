// Buttons 

void defineButtons() {
  
  buttonDuomoteramo = new Button (18, 155, 290, 210, 
  false, color (204,51,51), 
  false, color (150), 
  " ", 
  " ", 
  1);
  
  buttonMappateramo = new Button (333, 155, 290, 210, 
  false, color (204,51,51), 
  false, color (150), 
  " ", 
  " ", 
  1);
  
  buttonSantiguerrieri = new Button (649, 155, 290, 210, 
  false, color (204,51,51), 
  false, color (150), 
  " ", 
  " ", 
  1);
  
  buttonSanbernardino = new Button (333, 394, 290, 210, 
  false, color (204,51,51), 
  false, color (150), 
  " ", 
  " ", 
  1);
  
  buttonSanTommaso = new Button (649, 394, 290, 210, 
  false, color (204,51,51), 
  false, color (150), 
  " ", 
  " ", 
  1);
  
  buttonReset = new Button (858, 10, 75, 75, 
  false, color (204,51,51), 
  false, color (150), 
  " ", 
  " ", 
  1);
  
    buttonReset2 = new Button (858, 10, 75, 75, 
  false, color (204,51,51), 
  false, color (150), 
  " ", 
  " ", 
  1);
  
  buttonMappa = new Button (150, 15, 118, 38, 
  true, color (204,51,51,40), 
  false, color (150), 
  " ", 
  " ", 
  1);
  
  buttonLista = new Button (330, 15, 128, 38, 
  true, color (204,51,51,40), 
  false, color (150), 
  " ", 
  " ", 
  1);
  
  buttonMode = new Button (520, 15, 98, 38, 
  true, color (204,51,51,40), 
  false, color (150), 
  " ", 
  " ", 
  1);
  
    buttonStart = new Button (770, 10, 75, 75, 
  false, color (51,201,51), 
  false, color (150), 
  " ", 
  " ", 
  1);
  
  buttonStart2 = new Button (858, 10, 75, 75, 
  false, color (51,201,51), 
  false, color (150), 
  " ", 
  " ", 
  1);

  buttonUno = new Button (734, 581, 110, 36, 
  false, color (204,51,51), 
  false, color (150), 
  "Hi-Storia [l-1]", 
  "Due", 
  1);
  
  buttonMicro = new Button (844, 581, 110, 36, 
  false, color (0), 
  false, color (150), 
  "Hi-Storia [0]", 
  "", 
  1);
  // define buttons
  buttonPause = new Button (35, 155, 30, 30, 
  true, color (0,0,0,20), 
  true, color (255), 
  "", 
  "", 
  0);
  buttonPause.hasImage=true;
  buttonPause.imageType=buttonPause.imgPause;
  buttonPause.colorImgFill=color (255, 0, 0);

  //
  buttonProgressFrame = new Button ( 15, 435, 
  200, 22, 
  true, color (220), 
  true, color (220), 
  "", 
  "Click to set play position", 
  1); 
  //
  buttonProgressData = new Button ( 17, 437, 
  0, 18, 
  //true, color (3), 
  true, color (57, 177, 183), 
  false, color (200), 
  "", 
  "", 
  -1);
  buttonProgressFrameSfondo = new Button ( 0, 178, 
  960, 3, 
  true, color (225,225,225,70), 
  false, color (221), 
  "", 
  "Click to set play position", 
  1); 
    buttonProgressDataSfondo = new Button ( 0, 178, 
  0, 3, 
  //true, color (3), 
  true, color (57, 177, 183), 
  false, color (200), 
  "", 
  "", 
  -1);
  buttonProgressFrameMain = new Button ( 70, 156, 
  320, 6, 
  true, color (225,225,225,70), 
  false, color (221), 
  "", 
  "Click to set play position", 
  1); 
    buttonProgressDataMain = new Button ( 70, 156, 
  0, 6, 
  //true, color (3), 
  true, color (242), 
  false, color (200), 
  "", 
  "", 
  -1);
  //
  buttonPrevious = new Button (  width/2-70, 65, 
  20, 20, 
  false, color (255, 0, 0), 
  true, color (255), 
  "", 
  "Previous song", 
  2);
  buttonPrevious.hasImage=true;
  buttonPrevious.imageType=buttonPrevious.imgTriangleLeft;
  buttonPrevious.colorImgFill=color (255, 0, 0);

  buttonNext = new Button (  width/2+50, 65, 
  20, 20, 
  false, color (255, 0, 0), 
  true, color (255), 
  "", 
  "Next song", 
  3);
  buttonNext.hasImage=true;
  buttonNext.imageType= buttonNext.imgTriangleRight;
  buttonNext.colorImgFill=color (255, 0, 0);

  // list or meta
  buttonShowSongListOrOneSong = new Button ( 10, 65, 
  34, 20, 
  false, color (0), 
  true, color (255), 
  "List", 
  "Show song list", 
  5);
  // change button accordingly 
  changeButtonSongList();
  //
  buttonFolderUp= new Button ( width-50, 95, 
  40, 20, 
  false, color (0), 
  true, color (255), 
  "", 
  "Folder Up", 
  6);
  buttonFolderUp.hasImage  = true;
  buttonFolderUp.imageType = buttonFolderUp.imgFolderUp;
  buttonFolderUp.colorImgFill=color (0, 255, 0);
  //
  buttonHome = new Button ( width-98, 95, 
  40, 20, 
  false, color (0), 
  true, color (255), 
  "", 
  "Go to home folder", 
  7);
  buttonHome.hasImage  = true;
  buttonHome.imageType = buttonFolderUp.imgHome;
  buttonHome.hasColorImgFill=false;    // no fill 
  buttonHome.colorImgFill=color (255); // not in use
  buttonHome.hasColorImgStroke=true;   // stroke
  buttonHome.colorImgStroke=color (0, 255, 0); // green 
  //
  buttonPreviousFolder = new Button ( width-190, 95, 
  20, 20, 
  false, color (0), 
  true, color (255), 
  "", 
  "Previous Folder", 
  8);
  buttonPreviousFolder.hasImage=true;
  buttonPreviousFolder.imageType=buttonPrevious.imgTriangleLeft;
  buttonPreviousFolder.colorImgFill=color (0, 255, 0);

  buttonNextFolder = new Button ( width-165, 95, 
  20, 20, 
  false, color (0), 
  true, color (255), 
  "", 
  "Next Folder", 
  9);
  buttonNextFolder.hasImage=true;
  buttonNextFolder.imageType= buttonNext.imgTriangleRight;
  buttonNextFolder.colorImgFill=color (0, 255, 0);
  
  
  buttonTesti = new Button (794, 225, 110, 36, 
  false, color (204,51,51), 
  false, color (150), 
  "Testi", 
  "Due", 
  1);
  
  buttonImmagini = new Button (694, 225, 110, 36, 
  false, color (204,51,51), 
  false, color (150), 
  "Immagini", 
  "Due", 
  1);
} // func 

// ----------------------------------------------------------------------



/* 
void checkMouseOver() {
  // show mouse over text (tool tip text)
  if (millis() - timeSinceLastMouseMoved > 800) {
    
    switch (state) {
    case stateNormal: 
      checkMouseOverForStateNormal () ;
      break;
    case stateFileManager:  
      if (buttonFolder.over()) {
        buttonFolder.showMouseOver();
      } // if
      else if (buttonFolderUp.over()) {
        buttonFolderUp.showMouseOver();
      } // if
      else if (buttonHome.over()) {
        buttonHome.showMouseOver();
      } // if      
      break;
    case stateDrives:
      if (buttonHome.over()) {
        buttonHome.showMouseOver();
      } // if      
      break;
    default:
      println ("Missing state, error 106, tab Buttons");
      exit();
      break;
    } // switch
    
  } // if 
  //
} // func 

void checkMouseOverForStateNormal () {

  // which button
  if (buttonPause.over()) {
    buttonPause.showMouseOver() ;
  }
  else if (buttonProgressFrame.over()) {
    buttonProgressFrame.showMouseOver() ;
  }
  else if (buttonNext.over()) {
    buttonNext.textMouseOver2 = "";
    try {
      if (indexFile==namesFiles.length-1) {
        buttonNext.textMouseOver2 = showSongWithoutFolder2 (namesFiles [0]) 
          + " (from beginning)";
      }
      else 
        buttonNext.textMouseOver2 = showSongWithoutFolder2 (namesFiles [indexFile+1]) ;
    }
    catch (Exception e) {
      //
      buttonNext.textMouseOver2 = "";
    }
    finally {
      // buttonNext.textMouseOver2 = "";
    }
    buttonNext.showMouseOver() ;
  }
  else if (buttonPrevious.over()) {
    buttonPrevious.textMouseOver2 = "";
    try {
      if (indexFile==0) {
        buttonPrevious.textMouseOver2 = showSongWithoutFolder2 (namesFiles [indexFile]) 
          + " (playing)";
      }
      else 
        buttonPrevious.textMouseOver2 = showSongWithoutFolder2 (namesFiles [indexFile-1]) ;
    }
    catch (Exception e) {
      //
      buttonPrevious.textMouseOver2 = "";
    }
    finally {
      // 
    }
    buttonPrevious.showMouseOver() ;
  }
  else if (buttonFolderUp.over()) {
  } 
  else if (buttonShowSongListOrOneSong.over()) {
    buttonShowSongListOrOneSong.showMouseOver() ;
  }  
  else {
    //
  } // else
} // func 
 */
void changeButtonSongList() {
  // this is for one special button
  // change button accordingly:
  // it can show the word Song or the word List 
  if (showSongList)
  {
    // showing the list, make button the opposite
    buttonShowSongListOrOneSong.text="Song";
    buttonShowSongListOrOneSong.textMouseOver="Show the data of current song";
    buttonShowSongListOrOneSong.w=40;
  }
  else
  {
    buttonShowSongListOrOneSong.text="List";
    buttonShowSongListOrOneSong.textMouseOver="Show the song list";
    buttonShowSongListOrOneSong.w=31;
  }
}
 
// =======================================================================

class Button {
  // represents a button 
  float x;    // position
  float y;
  float w=0;  // size
  float h=0;

  // color for button  
  boolean hasColorFill=true;   // if it has filling 
  color colorFill;             // what is its color?
  //
  boolean hasColorStroke=true; // if it has an outline 
  color  colorStroke;          // what is it?
  // color for images 
  boolean hasColorImgFill=true;   // if image has filling 
  color colorImgFill;             // what is its color?
  // not in use: 
  boolean hasColorImgStroke=true; // if it has an outline 
  color  colorImgStroke;          // what is it?

  // other 
  String text="";           // text to display
  String textMouseOver =""; // text for mouse over I.
  String textMouseOver2=""; // text for mouse over II.
  int commandNumber;        // each button has a command number that gets executed when clicked
  //
  // image button (for prev, next, play/pause)
  final int imgProvokeError  = -2;   // image types (consts)
  final int imgUndefined     = -1;   // image types (consts)
  final int imgTriangleLeft  = 0;
  final int imgTriangleRight = 1;
  final int imgPause         = 2;
  final int imgFolderUp      = 3;
  final int imgHome          = 4;  
  int imageType = imgProvokeError;  // current type (one of the previous)
  boolean hasImage = false;         // yes/no
  //

  // constructor
  Button (  
  float x_, float y_, 
  float w_, float h_, 
  boolean hasColorFill_, color cFill_, 
  boolean hasColorStroke_, color cStroke_, 
  String text_, 
  String textMouseOver_, 
  int commandNumber_) {
    x=x_;
    y=y_;
    w=w_;
    h=h_;
    // color fill
    hasColorFill=hasColorFill_;
    colorFill=cFill_;
    // color stroke 
    hasColorStroke = hasColorStroke_;
    colorStroke = cStroke_;
    // 
    text=text_;
    textMouseOver=textMouseOver_;
    commandNumber=commandNumber_;
  } // constructor
  //
  void display () {
    if (hasColorFill){
      fill(colorFill);
    }else {
      noFill();}
    if (hasColorStroke){
      stroke(colorStroke);
      strokeWeight(2);
    }
    else 
      noStroke();
    if(hasColorStroke){ //#riqua lo faccio tondo :)
      ellipse(x, y, w, h);
      fill(3);
    }else{
      rect(x, y, w, h );      
    }
    fill(255);
      text(text, x+22, y+25);
   
  } // method 
  //
  /* void showImage() {
    if (hasColorImgFill)
      fill(colorImgFill);
    else 
      noFill();
    //
    if (hasColorImgStroke)
      stroke(colorImgStroke);
    else 
      noStroke();

    switch (imageType) {
    case imgUndefined:
      // do nothing
      break;
    case imgTriangleLeft:
      trianglePointingLeft(int(x)+13, int(y)+10);
      break;
    case imgTriangleRight:
      trianglePointingRight(int(x)+9, int(y)+10);
      break;
    case imgPause:
      // pause
      signPause(int(x), int(y)+5);
      break;
    case imgFolderUp:
      signFolderUp(int(x), int(y));
      break;
    case imgHome:
      signHome(int(x), int(y));
      break;  
    default:
      // error 
      println ("error 268: no such image type (tab Buttons) : " + imageType);
      exit();
      break;
    } // switch
  } // method 
  // */
  boolean over() {
    return (mouseX>x && mouseX<x+w&& mouseY>y&&mouseY<y+h);
  } // method
  //
  void showMouseOver() {
    // yellow mouse over help text 
    if (!textMouseOver.equals("")) {
      float pos=x; // or  mouseX;
      // right screen border? 
      if (pos+textWidth(textMouseOver)+10>width) {
        pos=width-textWidth(textMouseOver)-12;
      }
      fill(255, 255, 44);
      noStroke();
      rect(pos, y+h+14, textWidth(textMouseOver)+5, 20);
      fill(0);
      text ( textMouseOver, pos+2, y+48 );
    }
    //
    if (!textMouseOver2.equals("")) {
      float pos=x; // or  mouseX;
      // right screen border? 
      if (pos+textWidth(textMouseOver2)+10>width) {
        pos=width-textWidth(textMouseOver2)-12;
      }
      fill(255, 255, 44);
      noStroke(); 
      rect(pos, y+h+14+17, textWidth(textMouseOver2)+5, 20);
      fill(0);
      text ( textMouseOver2, pos+2, y+48+17 );
    }
    //
  } // method  
  //
} // class 
//
// ---------------------------------
