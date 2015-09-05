/*
 * ----------------------------------
 *  Radio Button Class for Processing 2.0
 * ----------------------------------
 *
 * this is a simple radio button class. The following shows 
 * you how to use it in a minimalistic way.
 *
 * DEPENDENCIES:
 *   N/A
 *
 * Created:  April, 12 2012
 * Author:   Alejandro Dirgan
 * Version:  0.14
 *
 * License:  GPLv3
 *   (http://www.fsf.org/licensing/)
 *
 * Follow Us
 *    adirgan.blogspot.com
 *    twitter: @ydirgan
 *    https://www.facebook.com/groups/mmiiccrrooss/
 *    https://plus.google.com/b/111940495387297822358/
 *
 * DISCLAIMER **
 * THIS SOFTWARE IS PROVIDED TO YOU "AS IS," AND WE MAKE NO EXPRESS OR IMPLIED WARRANTIES WHATSOEVER 
 * WITH RESPECT TO ITS FUNCTIONALITY, OPERABILITY, OR USE, INCLUDING, WITHOUT LIMITATION, ANY IMPLIED 
 * WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, OR INFRINGEMENT. WE EXPRESSLY 
 * DISCLAIM ANY LIABILITY WHATSOEVER FOR ANY DIRECT, INDIRECT, CONSEQUENTIAL, INCIDENTAL OR SPECIAL 
 * DAMAGES, INCLUDING, WITHOUT LIMITATION, LOST REVENUES, LOST PROFITS, LOSSES RESULTING FROM BUSINESS 
 * INTERRUPTION OR LOSS OF DATA, REGARDLESS OF THE FORM OF ACTION OR LEGAL THEORY UNDER WHICH THE LIABILITY 
 * MAY BE ASSERTED, EVEN IF ADVISED OF THE POSSIBILITY OR LIKELIHOOD OF SUCH DAMAGES.
*/


/*
 this is a simple radio button class. The following shows you how to use it in a minimalistic way.


String[] options = {"First","Second","Third", "Fourth"}; 
ADradio radioButton;
int radio;


PFont output; 

void setup()
{
  size(300,300);
  smooth();
  output = createFont("Arial",24,true);  

  radioButton = new ADradio(117, 78, options, "radioButton"); 
  radioButton.setDebugOn();
  radioButton.setBoxFillColor(#F7ECD4);  
  radioButton.setValue(1);

}

void draw()
{
  background(#FFFFFF);

  radioButton.update();

  textFont(output,24);   
  text(options[radioButton.getValue()], (width-textWidth(options[radioButton.getValue()]))/2, height-20);

}


*/

class ADRadio
{
  
  color externalCircleColor=#000000;
  color externalFillCircleColor=#FFFFFF;
  color internalCircleColor=#000000;
  color internalFillCircleColor=#000000;
  
  boolean fillExternalCircle=false;
  
  PFont rText;
  color textColor=#000000;
  color textShadowColor=#7E7E7E;
  boolean textShadow=false;
  int textPoints=14;
  
  int xTextOffset=20;
  int yTextSpacing=14;
  
  int circleRadius=16;
  float circleLineWidth=0.5;
 
  float boxLineWidth=0.2;
  boolean boxFilled=false;
  color boxLineColor=#000000;
  color boxFillColor=#F4F5D7;
  boolean boxVisible=true;
  
  String[] radioText;
  boolean[] radioChoose; 
  
  int over=0;
  int nC;
  
  int rX, rY;
  
  float maxTextWidth=0;
  
  String radioLabel;
  
  boolean debug=false;
  
  int boxXMargin=5;
  int boxYMargin=5;
  
  int bX, bY, bW, bH;
  boolean pressOnlyOnce=true;
  int deb=0;    
  
///////////////////////////////////////////////////////  
  ADRadio(int x, int y, String[] op, String id)
  {
    rX=x;
    rY=y;
    radioText=op;
    
    nC=op.length;
    radioChoose = new boolean[nC];
        
    rText = createFont("Arial",16,true);      
    textFont(rText,textPoints);   
    textAlign(LEFT);
    
    for (int i=0; i<nC; i++) 
    {
      if (textWidth(radioText[i]) > maxTextWidth) maxTextWidth=textWidth(radioText[i]);
      radioChoose[i]=false;
    }
    
    radioChoose[over]=true;
    
    radioLabel=id;
    
    calculateBox();
    
  }
  
///////////////////////////////////////////////////////  
  void calculateBox()
  {
    bX=rX-circleRadius/2-boxXMargin;
    bY=rY-circleRadius/2-boxYMargin;
    bW=circleRadius*2+xTextOffset+(int )maxTextWidth;
    bH=radioText.length*circleRadius + (radioText.length-1)*yTextSpacing + boxYMargin*2;
  }  
///////////////////////////////////////////////////////  
  void setValue(int n)
  {
    if (n<0) n=0;
    if (n>(nC-1)) n=nC-1;
    
   for (int i=0; i<nC; i++) radioChoose[i]=false;
   radioChoose[n]=true;  
   over=n; 
  }
///////////////////////////////////////////////////////  
  void deBounce(int n)
  {
    if (pressOnlyOnce) 
      return;
    else
      
    if (deb++ > n) 
    {
      deb=0;
      pressOnlyOnce=true;
    }
    
  }  ///////////////////////////////////////////////////////  
  boolean mouseOver()
  {
    boolean result=false; 
    
    if (debug)
      if ((mouseX>=bX) && (mouseX<=bX+bW) && (mouseY>=bY) && (mouseY<=bY+bH))
      {
        if (mousePressed && mouseButton==LEFT && keyPressed)
        {
          if (keyCode==CONTROL)
          {
            rX=rX+(int )((float )(mouseX-pmouseX)*1);
            rY=rY+(int )((float )(mouseY-pmouseY)*1);
            calculateBox();
          }
          if (keyCode==SHIFT && pressOnlyOnce) 
          {
            printGeometry();
            pressOnlyOnce=false;
          }
          deBounce(5);
          
        }
      }
      
    for (int i=0; i<nC; i++)
    {
      if ((mouseX>=(rX-circleRadius)) && (mouseX<=(rX+circleRadius)) && (mouseY>=(rY+(i*(yTextSpacing+circleRadius))-circleRadius)) && (mouseY<=(rY+(i*(yTextSpacing+circleRadius))+circleRadius)))
      {
        result=true;
        
        if (mousePressed && mouseButton==LEFT && pressOnlyOnce)
        {
          over=i;
          setValue(over);
          pressOnlyOnce=false;
        }
        deBounce(5);
        i=nC;
      }
      else
      {
        result=false;
      }
    } 
    return result;
  }
///////////////////////////////////////////////////////  
  void drawBox()
  {
    if (!boxVisible) return;
    if (boxFilled)
      fill(boxFillColor);
    else
      noFill();
    strokeWeight(boxLineWidth);
    stroke(boxLineColor);

    rect(bX, bY, bW, bH);

  }  
///////////////////////////////////////////////////////  
  void drawCircles()
  {
    strokeWeight(circleLineWidth);
    for (int i=0; i<nC; i++)
    {
      if (!fillExternalCircle) 
        noFill();
      else
        fill(externalFillCircleColor);  
      stroke(externalCircleColor);  
      ellipse(rX, rY+(i*(yTextSpacing+circleRadius)), circleRadius, circleRadius);

      fill(internalFillCircleColor);
      stroke(internalCircleColor);  

      if (radioChoose[i])
         ellipse(rX, rY+(i*(yTextSpacing+circleRadius)), circleRadius-8, circleRadius-8);
    }
    mouseOver();
   
  }
///////////////////////////////////////////////////////  
  void drawText()
  {
    float yOffset=rY+textPoints/3+1;
    stroke(textColor);
    textFont(rText,textPoints);   
    textAlign(LEFT);

    for (int i=0; i<nC; i++)
    {
      if (textShadow)
      {
        stroke(textShadowColor);
        text(radioText[i], rX+xTextOffset+1, yOffset+(i*(yTextSpacing+circleRadius))+1);
        stroke(textColor);
      }
      text(radioText[i], rX+xTextOffset, yOffset+(i*(yTextSpacing+circleRadius)));
    }
    
  }  
  
///////////////////////////////////////////////////////  
  int update()
  {
    drawBox();
    drawCircles();
    drawText();
    
    return over;
  }

///////////////////////////////////////////////////////  
  int getValue()
  {
    return over;
  }
 
///////////////////////////////////////////////////////  
  void setDebugOn()
  {
    debug=true;
  }
///////////////////////////////////////////////////////  
  void setDebugOff()
  {
    debug=false;
  }
///////////////////////////////////////////////////////  
  void printGeometry()
  {
    println("radio = new ADradio("+rX+", "+rY+", arrayOfOptions"+", \""+radioLabel+"\");");

  }
///////////////////////////////////////////////////////  
  void setExternalCircleColor(color c)
  {
    externalCircleColor=c;
  }
///////////////////////////////////////////////////////  
  void setExternalFillCircleColor(color c)
  {
    externalFillCircleColor=c;
  }
///////////////////////////////////////////////////////  
  void setInternalCircleColorr(color c)
  {
    externalFillCircleColor=c;
  }
///////////////////////////////////////////////////////  
  void setInternalFillCircleColor(color c)
  {
    externalFillCircleColor=c;
  }
///////////////////////////////////////////////////////  
  void setTextColor(color c)
  {
    textColor=c;
  }
///////////////////////////////////////////////////////  
  void setTextShadowColor(color c)
  {
    textShadowColor=c;
  }
///////////////////////////////////////////////////////  
  void setShadowOn()
  {
    textShadow=true;
  }
///////////////////////////////////////////////////////  
  void setShadowOff()
  {
    textShadow=false;
  }
///////////////////////////////////////////////////////  
  void setTextSize(int s)
  {
    textPoints=s;
  }
///////////////////////////////////////////////////////  
  void setXTextOffset(int s)
  {
    xTextOffset=s;
  }
///////////////////////////////////////////////////////  
  void setyTextSpacing(int s)
  {
    yTextSpacing=s;
  }
///////////////////////////////////////////////////////  
  void setCircleRadius(int s)
  {
    circleRadius=s;
  }
///////////////////////////////////////////////////////  
  void setBoxLineWidth(int s)
  {
    boxLineWidth=s;
  }
///////////////////////////////////////////////////////  
  void setBoxLineColor(color c)
  {
    boxLineColor=c;
  }
///////////////////////////////////////////////////////  
  void setBoxFillColor(color c)
  {
    boxFillColor=c;
    setBoxFilledOn();
  }
///////////////////////////////////////////////////////  
  void setBoxFilledOn()
  {
    boxFilled=true;
  }
///////////////////////////////////////////////////////  
  void setBoxFilledOff()
  {
    boxFilled=false;
  }
///////////////////////////////////////////////////////  
  void setBoxVisibleOn()
  {
    boxVisible=true;
  }
///////////////////////////////////////////////////////  
  void setBoxVisibleOff()
  {
    boxVisible=false;
  }
///////////////////////////////////////////////////////  
  void setLabel(String l)
  {
    radioLabel=l;
  }

}

