#include "pines.h"

byte jugador=2,elec,menuelec=2,limite;
unsigned int index;
//matriz de datos del juego
byte matriz[6][7]={
  0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,
  0,0,0,0,0,0,0
};

boolean maqui,menu=true,cambio=false,guardado=false;
String comandos="";

void setup() {
  Serial.begin(9600);   //velocidad serial
  
  pinMode(rojo,OUTPUT);
  pinMode(verde,OUTPUT);
  pinMode(azul,OUTPUT);
  pinMode(botonDer,INPUT);
  pinMode(botonIzq,INPUT);
  pinMode(botonSelect,INPUT);
}

void loop() {
  if(menu){
    //modos
     menu_seleccionar();
     index=0;
  }else{
  //mientras que ninguno gane
     while(!victoria()){
       switch(menuelec){
         case 1:
            if(guardado){
              if(comandos.charAt(index)!='R' && comandos.charAt(index)!='T')tirar_maqui( int(comandos.charAt(index)-48) ); else {Serial.write(comandos.charAt(index)); limpiar();}
              index++;
              if(index>=comandos.length()){
                index=0;
                guardado=false;
              }
            }else {
              seleccionar();
            }
            break;
         case 2:
            if(jugador==1){
             seleccionar();
            }else maquina();
            break;
         case 3:
            maquina();
      }
     }
      if(!cambio && !guardado){
        Serial.write('G');
        if(jugador==1){
          jugador=2;
        }else jugador=1;
        cambio=true;
      }
      if(Serial.available()){
        char decision = Serial.read();
        if(decision=='C'){
          limpiar();
          
        }else if(decision=='B'){
          menu=true;
          limpiar();
          analogWrite(verde,0);
          analogWrite(azul,0);
        }
      }
   }
}
