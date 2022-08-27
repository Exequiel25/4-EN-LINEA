//-----------------------------------------------------------FICHA-------------------------------------//
//fichas existentes de los jugadores (0)=1;
int j1=0,j2=-1;
int fichaAct=0;
int cant=5;
float lm,LM;
//-------------------------------------------------------TABLERO Y TURNOS------------------------------------------//
//escalas
float margenx,margeny,alto,largo;
float sepx,sepy,diametro;
//colores botonera
color botonI = color(0);
color botonS = color(0);
color botonD = color(0);
float alpha=255;
//-------------------------------------------------ESTADOS DE LA PARTIDA-----------------------------------------//
boolean finJuego=false;
boolean jugar=false;
boolean preparacion=false;
boolean creando=false;
//-------------------------------------------------------MENU PPAL-----------------------------------------------//
color colorMargen1,colorMargen2,colorMargen3;
int grosor1 = 0,grosor2 = 8,grosor3 = 0;
//---------------------------------------------------VICTORIA-----------------------------------------------------//
int t=2,primerJ=1;
//-------------------------------------------------TABLA-------------------------------------------------------//
int punt1=0,punt2=0;
String jugador1="",jugador2="";
String puntos1,puntos2;
//----------------------------------------------PREPARACION PARTIDA--------------------------------------------//
String fecha,hora,comandos="",textoGuardado="";
int flecha=0,nombActual=1;
byte aux=3;
//------------------------------------------------MUSICA--------------------------------------------------------//
boolean reproducir=true;
