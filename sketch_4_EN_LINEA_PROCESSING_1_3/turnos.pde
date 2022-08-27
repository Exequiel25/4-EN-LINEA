void turnos(){
  
  //cambia de turno
    if(j1>j2 && fichas.get(fichaAct).validar()){
      fichaAct++;
      j2++;
      fichas.add(new Ficha(2));
      aux=3;
    }
    if(j1==j2 && fichas.get(fichaAct).validar()){
      j1++;
      fichaAct++;
      fichas.add(new Ficha(1));
      aux=3;
    }
    
  //habilitar movimientos de ficha y aparicion botonera virtual
  if(j1>j2){
    Ficha f = fichas.get(fichaAct);
    f.mover();
    botones1();
    
  } else {
    Ficha f = fichas.get(fichaAct);
    f.mover();
    botones2();  
    
  }
  
  stroke(0);
  for(int i=0; i<fichas.size(); i++){
    Ficha f = fichas.get(i);
    f.dibujar();
  }
  
}

void botones1(){
    fill(0,alpha);
    rect(margenx*0.015,margeny+alto*0.5,sepx,sepy*0.5,10); //izq
    rect(margenx*0.05 + sepx,margeny+alto*0.5,sepx,sepy*0.5,10); //select
    rect(margenx*0.25,margeny+alto*0.4,sepx,sepy*0.5,10); //der
    
    stroke(0,255,0,alpha);
    fill(botonI);
    triangle( margenx*0.015+sepx*0.75,margeny+alto*0.5+sepy*0.1, margenx*0.075,margeny+alto*0.5+sepy*0.25, margenx*0.015+sepx*0.75,margeny+alto*0.5+sepy*0.4 ); //izq
    fill(botonD);
    triangle( margenx*0.15+sepx,margeny+alto*0.5+sepy*0.1, margenx*0.15+sepx*1.645,margeny+alto*0.5+sepy*0.25, margenx*0.15+sepx,margeny+alto*0.5+sepy*0.4 ); //der
    fill(botonS);
    circle(margenx*0.25+sepx*0.5,margeny+alto*0.442,sepy*0.35); //select    
    
    fill(0,200,0);
    textSize(sepx*0.3);
    text(jugador1,margenx*0.0158,margeny+alto*0.3);
}

void botones2(){
    fill(0,alpha);
    rect(largo*1.51+margenx*0.015,margeny+alto*0.5,sepx,sepy*0.5,10); //der
    rect(largo*1.2+margenx*0.05 + sepx,margeny+alto*0.5,sepx,sepy*0.5,10);
    rect(largo*1.35+margenx*0.25,margeny+alto*0.4,sepx,sepy*0.5,10);
    
    stroke(0,0,255,alpha);
    fill(botonI);
    triangle( largo*1.35+margenx*0.015+sepx*0.75,margeny+alto*0.5+sepy*0.1, largo*1.35+margenx*0.075,margeny+alto*0.5+sepy*0.25, largo*1.35+margenx*0.015+sepx*0.75,margeny+alto*0.5+sepy*0.4 ); //izq
    fill(botonD);
    triangle( largo*1.35+margenx*0.15+sepx,margeny+alto*0.5+sepy*0.1, largo*1.35+margenx*0.15+sepx*1.645,margeny+alto*0.5+sepy*0.25, largo*1.35+margenx*0.15+sepx,margeny+alto*0.5+sepy*0.4 ); //der
    fill(botonS);
    circle(largo*1.35+margenx*0.25+sepx*0.5,margeny+alto*0.442,sepy*0.35);    
    
    fill(0,0,200);
    textSize(sepx*0.3);
    text(jugador2,largo*1.35+margenx*0.0158,margeny+alto*0.3);
}
