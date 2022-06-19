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

void carga(){
  while(!guardado){
    if(Serial.available()){
      char c = Serial.read();
      if(c != ':') comandos+=c; else guardado=true;
    }
  }
}
