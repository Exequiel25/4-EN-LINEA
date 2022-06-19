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
