void maquina(){
  byte jug,c=1;
  
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
