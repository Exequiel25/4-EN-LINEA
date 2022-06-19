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
