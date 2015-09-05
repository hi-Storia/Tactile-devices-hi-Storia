void mappaLuoghi(){
  background(100);
    map.draw();
    
    int MarkerDaVedere = locationMarkers.length;
    ImageMarker[] daVedere = new ImageMarker[6];
    daVedere[0]= new ImageMarker(locationLaquila, loadImage("marker.png"));
    daVedere[1]= new ImageMarker(locationTeramo, loadImage("marker.png"));
    daVedere[2]= new ImageMarker(locationCentroTeramo, loadImage("marker.png"));
    daVedere[3]= new ImageMarker(locationFossacesia, loadImage("marker.png"));
    daVedere[4]= new ImageMarker(locationSantiGuerrieri, loadImage("marker.png"));
    daVedere[5]= new ImageMarker(locationOrtona, loadImage("marker.png"));
    ImageMarker[] doveDormire = new ImageMarker[2];
    doveDormire[0]= new ImageMarker(locationLaquila, loadImage("marker.png"));
    doveDormire[1]= new ImageMarker(locationTeramo, loadImage("marker.png"));
    /*ImageMarker imgMarker1 = new ImageMarker(locationLaquila, loadImage("marker.png"));
    ImageMarker imgMarker2 = new ImageMarker(locationTeramo, loadImage("marker.png"));
    ImageMarker imgMarker3 = new ImageMarker(locationFossacesia, loadImage("marker.png"));
    ImageMarker imgMarker4 = new ImageMarker(locationSantiGuerrieri, loadImage("marker.png"));
    ImageMarker imgMarker5 = new ImageMarker(locationOrtona, loadImage("marker.png"));
    ImageMarker imgMarker6 = new ImageMarker(locationHiStoria, loadImage("marker_giallo.png"));
    ImageMarker imgMarker7 = new ImageMarker(locationRiqua, loadImage("marker_giallo.png")); 
    if(viewmarker==0){
    map.addMarkers(imgMarker1, imgMarker2, imgMarker3, imgMarker4, imgMarker5);
     viewmarker=1;
    }
    */
checkmappa.show();
if(viewmarker==0){
  for(int i = 0; i <daVedere.length; i++) {
    map.addMarkers(daVedere[i]);
  }
  viewmarker=1;
}
  /*  checkButtonFiltro.update();
  filtroRes=checkButtonFiltro.getValues();
  
  if(filtroLuoghi[checkButtonFiltro.getLastPicked()].equals("Attività ricettive")){
    if(viewmarker==1){
    map.getDefaultMarkerManager().clearMarkers(); 
    map.addMarkers(imgMarker6, imgMarker7);
     viewmarker=2;
    }else{
    map.getDefaultMarkerManager().removeMarker(imgMarker6);
    map.getDefaultMarkerManager().removeMarker(imgMarker7);
    }
  }
  
  text(filtroLuoghi[checkButtonFiltro.getLastPicked()], (width-textWidth(filtroLuoghi[checkButtonFiltro.getLastPicked()]))/2, height-20); */

  /*barrarect = createShape(RECT,0,560,960,60);
  barrarect.setFill(color(0,0,0,70));
  shape(barrarect);*/
  

}

void mappaLuoghiTondi(){
  background(100);
  map.draw();

  // Draws locations on screen positions according to their geo-locations.

  // Fixed-size marker
  ScreenPosition posLaquila = map.getScreenPosition(locationLaquila);
  fill(30, 100, 0, 100);
  ellipse(posLaquila.x, posLaquila.y, 15, 15);
  
  
   // Fixed-size marker
  ScreenPosition posTeramo = map.getScreenPosition(locationTeramo);
  fill(100, 20, 0, 100);
  ellipse(posTeramo.x, posTeramo.y, 15, 15);
  
    // Fixed-size marker
  ScreenPosition posFossacesia = map.getScreenPosition(locationFossacesia);
  fill(0, 100, 30, 100);
  ellipse(posFossacesia.x, posFossacesia.y, 15, 15);

  // Zoom dependent marker size
  ScreenPosition posSantiGuerrieri = map.getScreenPosition(locationSantiGuerrieri);
  fill(20, 0, 100, 100);
  //float s = map.getZoom();
  //ellipse(posSantiGuerrieri.x, posSantiGuerrieri.y, s, s);
  ellipse(posSantiGuerrieri.x, posSantiGuerrieri.y, 40, 40);
   
    //createHeader();
    //image(header_mappa, 0, 0);
}

void controlEvent(ControlEvent theEvent) {
  if (theEvent.isFrom(checkmappa)) {
    // checkbox uses arrayValue to store the state of 
    // individual checkbox-items. usage:
    println(checkmappa.getArrayValue());
    int col = 0;
    for (int i=0;i<checkmappa.getArrayValue().length;i++) {
      int n = (int)checkmappa.getArrayValue()[i];
      print(n);
      if(n==1) {
        //myColorBackground += checkmappa.getItem(i).internalValue();
      }
    }
    println();    
  }
}

/*
void controlEvent(ControlEvent theEvent) {
  if (theEvent.isFrom(checkmappa)) {
    myColorBackground = 0;
    print("got an event from "+checkmappa.getName()+"\t\n");
    // checkbox uses arrayValue to store the state of 
    // individual checkbox-items. usage:
    println(checkmappa.getArrayValue());
    int col = 0;
    for (int i=0;i<checkmappa.getArrayValue().length;i++) {
      int n = (int)checkmappa.getArrayValue()[i];
      print(n);
      if(n==1) {
        myColorBackground += checkmappa.getItem(i).internalValue();
      }
    }
    println();    
  }
}
*/

void checkMappa(float[] a) {
  println(a);
}
