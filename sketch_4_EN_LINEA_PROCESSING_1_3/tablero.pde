//dibuja el tablero
void tablero(){
  
  strokeWeight(4);
  fill(#FF0D0D,alpha);
  stroke(0);
  rect(margenx,margeny,largo,alto);
  
  //tabla puntajes
  rect(margenx*1.5,0,largo-margenx,alto*0.075);
  fill(#FF0D0D,alpha*0.8);
  stroke(0);
  rect(margenx*1.5,alto*0.075,largo-margenx,alto*0.075);
  strokeWeight(2);
  line(margenx*0.25+largo*0.75,0,margenx*0.25+largo*0.75,alto*0.15);
  //jugadores de la tabla
  textSize(sepx*0.25);
  fill(0,255,0,alpha);
  text(jugador1,margenx*1.55,alto*0.05);
  fill(0,0,255,alpha);
  text(jugador2,margenx*2.55,alto*0.05);
  
  fill(200,220);
  text(textoGuardado,margenx*0.02,margeny);
   
  //puntos de los jugadores
  textSize(sepx*0.3);
  fill(255,alpha);
  puntos1 = str(punt1);
  puntos2 = str(punt2);
  text(puntos1,margenx*1.9,alto*0.125);
  text(puntos2,margenx*2.9,alto*0.125);
  
  //dibuja las "casillas"
  for(float x=margenx+sepx/2; x<margenx+largo; x+=sepx){
    for(float y=margeny+sepy/2; y<margeny+alto; y+=sepy){
      fill(255);
      strokeWeight(2);
      circle(x,y,diametro);
    }
  }
  //rect(49,72,602,516);
  //subdivisiones del tablero
   for(float x=margenx;x<margenx+largo;x+=sepx){
    line(x,margeny,x,margeny+alto);
  }
  for(float y=margeny;y<margeny+alto;y+=sepy){
    line(margenx,y,margenx+largo,y);
  }
}
