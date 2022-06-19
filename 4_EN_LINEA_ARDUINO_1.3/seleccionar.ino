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

int modificar_matriz(int Col){
  byte y;
  for(y=5; y>=0 && matriz[y][Col]!=0; y--);
  matriz[y][Col] = jugador;
  Serial.write(y+48);
}
