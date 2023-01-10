#include <Arduino.h>
#include "../lib/pines.h"

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

//*-------------------------------FUNCTIONS----------------------------------*//
//***************************Condicion Victoria*******************************//
boolean victoria(){
  boolean vic=false;
  for(int x=0; x<7; x++){
    for(int y=5; y>=0; y--){
      if(matriz[y][x] == jugador){
        //condicion vertical
        if( y-3>=0 && (jugador == matriz[y-1][x]) && (jugador == matriz[y-2][x]) && (jugador == matriz[y-3][x]) ){
          vic=true;
        }
        //condicion oblicua der hacia arriba
        if( y-3>=0 && x+3<7 && (jugador == matriz[y-1][x+1]) && (jugador == matriz[y-2][x+2]) && (jugador == matriz[y-3][x+3]) ){
          vic=true;
        }
        //condicion horizontal
        if( x+3<7 && (jugador == matriz[y][x+1]) && (jugador == matriz[y][x+2]) && (jugador == matriz[y][x+3]) ){
          vic=true;
        }
        //condicion oblicua der hacia abajo
        if( y+3<6 && x+3<7 && (jugador == matriz[y+1][x+1]) && (jugador == matriz[y+2][x+2]) && (jugador == matriz[y+3][x+3])){
          vic=true;
        }
      }
    }
  }
  if(!cambio){
  if(jugador==1){
      jugador=2;
      analogWrite(azul,255);
      analogWrite(verde,0);
   }else {
    jugador=1;
    analogWrite(verde,255);
    analogWrite(azul,0);
   }
  }
    return vic;
}

void limpiar(){
  for(int f=0; f<6; f++){
    for(int c=0; c<7; c++){
      matriz[f][c] = 0;
    }
  }
  cambio=false;
}
//*****************************Elegir partida*********************************//
void carga(){
  while(!guardado){
    if(Serial.available()){
      char c = Serial.read();
      if(c != ':') comandos+=c; else guardado=true;
    }
  }
}

void elegirpartida(){
  byte elec_part=0;
  boolean parar=false;
  guardado=false;
  //obliga a leer el serial-> cantidad de partidas disponibles
  while(menu){
    if(Serial.available()){
      limite = (byte)Serial.read();
      menu=false;
    }        
  }
  //selecciona si nueva o cargar partida
  while(!parar){
    if(digitalRead(botonIzq)==HIGH){
      if(elec_part>0){
      elec_part--;
      Serial.write('I');
      delay(150);
      }
    }
    if(digitalRead(botonDer)==HIGH){
      if(elec_part<limite){
      elec_part++;
      Serial.write('D');
      delay(150);
      }
    }
    if(digitalRead(botonSelect)==HIGH){
      Serial.write('S');
      delay(150);
      //se eligió cargar una partida
      if(elec_part>=1){
        carga();
      }
      parar=true;
      delay(2150);
    }
  }
}

//***************************Seleccion maquina********************************//
void select_ia(int jug){
  maqui=false;
  int c;
  
  for(int x=0; x<7; x++){
    for(int y=5; y>=0; y--){
      for(int d=0;d<3;d++){
        if(d==2) c=1; else c=0;
        if(matriz[y][x] == jug){
          if( y-3>=0 && (jug == matriz[y-1][x]) && (jug == matriz[y-2][x]) && (0 == matriz[y-3][x])&&(!maqui) ){
              maqui=true;
              elec=x;
          }
          
          if((jug == matriz[y-1-c][x+1+c]) && (jug == matriz[y-2-d+c][x+2+d-c])&&(y-2>=0 && x+2<7)&&(!maqui)){
              if((0 == matriz[y-3+d][x+3-d])&&(y-3>0 && x+3<7)&&(0 != matriz[y-2][x+3] )){
                  maqui=true;
                  elec=x+3-d;
              }
              
              if((0 == matriz[y+1][x-1])&&(y+1<5 && x-1>=0)&&((0 != matriz[y+1][x-2]&&y+2<6)||y+2>=6 )&&(!maqui)&&(d==0)){
                  maqui=true;
                  elec=x-1;
              }
          }
          
          if( x+2<7 && (jug == matriz[y][x+1+c]) && (jug == matriz[y][x+2+d-c])&&(!maqui)){
              if((0==matriz[y][x+3-d]) &&  x+3<7 && (((y+1<6)&&(0!=matriz[y+1][x+3-d]))||y+1>=6)){
                  maqui=true;
                  elec=x+3-d;
              }
              
              if((0==matriz[y][x-1]) &&  x-1>=0 && (((y+1<6)&&(0!=matriz[y+1][x-1]))||y+1>=6)&&(!maqui)&&(d==0)){
                  maqui=true;
                  elec=x-1;
              }
          }
          
          if((y+2<6 && x+2<=7)&& (jug == matriz[y+1+c][x+1+c]) && (jug== matriz[y+2+d-c][x+2+d-c]) && (!maqui)){
              if((0==matriz[y+3-d][x+3-d])&&(y+3<6 && x+3<7)&&(((y+4<6)&&0!=matriz[y+4][x+3-d])||(y+4>=6))){
                  maqui=true;
                  elec=x+3-d;
              }
              
              if((0==matriz[y-1][x-1])&&(y-1>=0 && x-1>=0)&&(0!=matriz[y][x-1])&&(!maqui)&&(d==0)){
                  maqui=true;
                  elec=x-1;
              }
              
          }
        }
      }
    }
  }
}

void selec2_ia(byte *jug2){
  for(int x=0; x<7; x++){
    for(int y=5; y>=0; y--){
      if(matriz[y][x] == *jug2){
        if( y-3>=0 && (*jug2 == matriz[y-1][x]) && (0 == matriz[y-2][x])&&(!maqui) ){
          elec=x;
          maqui=true;
        }
        
        if((*jug2 == matriz[y-1][x+1]) && (0 == matriz[y-2][x+2])&&(y-3>=0 && x+3<7)&&(!maqui)){
          elec=x+2;
          maqui=true;
        }
        
        if ( x+3<7 && (*jug2 == matriz[y][x+1]) && (0 == matriz[y][x+2])&&(!maqui)){
          elec=x+2;
          maqui=true;
        }
        
        if((y+3<6 && x+3<=7)&& (*jug2 == matriz[y+1][x+1]) && (0== matriz[y+2][x+2]) && (!maqui)){
          elec=x+2;
          maqui=true;
        }
      }
    }
  }
}

//***********************************IA***************************************//
int modificar_matriz(int Col){
  byte y;
  for(y=5; y>=0 && matriz[y][Col]!=0; y--);
  matriz[y][Col] = jugador;
  Serial.write(y+48);
}

void tirar_maqui(int xSelec){
  delay(1000);
  switch(xSelec){
    case 0:
      Serial.write('I');
      delay(500);
    case 1:
      Serial.write('I');
      delay(500);
    case 2:
      Serial.write('I');
      delay(500);
    break;
    case 6:
      Serial.write('D');
      delay(500);
    case 5:
      Serial.write('D');
      delay(500);
    case 4:
      Serial.write('D');
      delay(500);
    break;
    }
   modificar_matriz(xSelec);
   delay(2150);
  }

void maquina(){
  byte c=1;
  
  select_ia(jugador);
  
  if(!maqui){
    if(jugador == 2){
      c=-1;
    }
    select_ia(byte(jugador+c));
  }
  
  if(!maqui){
    selec2_ia(&(jugador));
  }
  
  if(!maqui){
    do{
      elec=random(0,7);
    }while(0!=matriz[0][elec]);
  }
  
  tirar_maqui(elec);
}

//**********************************MENU**************************************//
//se eligen los modos 1vs1,1vspc,pcvspc
void menu_seleccionar(){
  boolean seleccion=true;
  while(seleccion){
    if(digitalRead(botonIzq)==HIGH){
      if(menuelec>1){
      menuelec--;
      Serial.write('I');
      delay(150);
      }
    }
    if(digitalRead(botonDer)==HIGH){
      if(menuelec<3){
      menuelec++;
      Serial.write('D');
      delay(150);
      }
    }
    if(digitalRead(botonSelect)==HIGH){
      seleccion=false;
      delay(150);
      Serial.write('S');
      if(menuelec==1){
        //menú de cargar-crear partida
        elegirpartida();
      }
      menu=false;
    }
  }
}

//*******************************Seleccionar**********************************//
void seleccionar(){
  boolean seleccion=true;
  byte aux=3;
  while(seleccion){
    if(digitalRead(botonIzq)==HIGH){
      if(aux-1>=0){
      aux--;
      Serial.write('I');
      delay(150);
      }
    }
    if(digitalRead(botonDer)==HIGH){
      if(aux+1<7){
      aux++;
      Serial.write('D');
      delay(150);
      }
    }
    if(digitalRead(botonSelect)==HIGH && matriz[0][aux]==0){
      seleccion=false;
      modificar_matriz(aux);
      delay(2150);
    }
  }
}



//*------------------------------MAIN CODE----------------------------------*//
void setup() {
  	// put your setup code here, to run once:
	Serial.begin(9600);   //velocidad serial
  
	pinMode(rojo,OUTPUT);
	pinMode(verde,OUTPUT);
	pinMode(azul,OUTPUT);
	pinMode(botonDer,INPUT);
	pinMode(botonIzq,INPUT);
	pinMode(botonSelect,INPUT);
}

void loop() {
  	// put your main code here, to run repeatedly:
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