import ddf.minim.*;
import processing.serial.*;

Serial myPort;
ArrayList<Ficha> fichas;

PFont fuente;
PImage cara,parlante;

Minim musicaMenu;
Minim musicaJuego;
Minim efectoFicha;
Minim efectoVic;

AudioPlayer playerMenu;
AudioPlayer playerJuego;

AudioSample playerFicha;
AudioSample playerVic;

Table tablaPartidas;

void setup(){
  //size(800,600);
  fullScreen();
  noCursor();
  printArray(Serial.list()); //devuleve todos los puertos serial disponibles
  myPort = new Serial(this,"COM4",9600);  //definimos puerto que utilizamos (punteroThis,nombre_del_puerto,velocidad)
  
  cara = loadImage("carita.png");
  parlante = loadImage("parlante.png");
  
  musicaMenu = new Minim(this);
  musicaJuego = new Minim(this);
  efectoFicha = new Minim(this);
  efectoVic = new Minim(this);
  
  playerMenu = musicaMenu.loadFile("menu.mp3");
  playerJuego = musicaJuego.loadFile("juego.mp3");
  playerFicha = efectoFicha.loadSample("efectficha.mp3");
  playerVic = efectoVic.loadSample("victoria.mp3");
  
  //escalas de la ventana
  margenx = width*0.2;
  margeny = height*0.215;
  largo = width - margenx*2;
  alto = height - margeny*1.15;
  sepx = largo/7;
  sepy = alto/6;
  if(height > width){
     diametro = sepx*0.7442;
  }else diametro = sepy*0.7442;
  
  LM = margenx*4;
  lm = margenx*1.2;
  
  fichas = new ArrayList<Ficha>();
  fichas.add(new Ficha(1));
  for(int i=0; i<15; i++){
      fichas.add(new Ficha(int(random(1,3))));
  }
  
  colorMargen2 = color(#78F2E7);
  
  playerMenu.loop();
  
  frameRate(150);
  
  tablaSetup();
    
}
void draw(){
  background(#FFF181);
  image(parlante,width-margenx*0.45,height-margeny*0.5,sepx,sepy);
  strokeWeight(3);
  stroke(255,0,0);
  if(!reproducir)line(width-margenx*0.45,height-margeny*0.5,width-margenx*0.45+sepx,height-margeny*0.5+sepy);
  
  if(jugar){
    //---------------------------------------------JUEGO-------------------------------------//
    if(playerMenu.isPlaying()){
      playerMenu.pause();
      playerMenu.rewind();
      t=1;
    }    
    if(!finJuego){
      if(!reproducir)playerJuego.pause(); else playerJuego.play();
      if(playerJuego.position() == playerJuego.length()){
        playerJuego.pause();
        playerJuego.rewind();
      }
        tablero();
        turnos();
    }else{
        alpha = 50;
        tablero();
        turnos();
        botones1();
        botones2();
    if(j1>j2){
        textSize(sepx*0.4);
        fill(0,255,0);
        text("   PIERDE   ",margenx*0.0158,margeny+alto*0.15);
        fill(0,0,255);
        text("   GANA   ",largo*1.35+margenx*0.0158,margeny+alto*0.15);
        cartelVic();
    }else {
        textSize(sepx*0.4);
        fill(0,0,255);
        text("   PIERDE   ",largo*1.35+margenx*0.0158,margeny+alto*0.15);
        fill(0,255,0);
        text("   GANA   ",margenx*0.0158,margeny+alto*0.15);
        cartelVic();
      }
    }
  }else {
    //---------------------------------------------MENU-------------------------------------//
    if(playerJuego.isPlaying()){
      playerJuego.pause();
      playerJuego.rewind();
      playerMenu.play();
      for(int i=0; i<15; i++){
        fichas.add(new Ficha(int(random(1,3))));
      }
      t=1;
    }
    if(!reproducir)playerMenu.pause(); else playerMenu.play();
    if(!preparacion && !creando){
      fuente = createFont("Kristen ITC",sepx);
      textFont(fuente);
      textSize(sepx);
      fill(0);
      stroke(0);
      text("4 EN RAYA",margenx*1.2,margeny);
      textSize(sepx*0.4);
      text("1 VS 1",margenx*1, margeny*3.5);
      text("1 VS PC ",margenx*2.25, margeny*3.5);
      text("PC VS PC",margenx*3.55, margeny*3.5);
      image(cara,width*0.4,margeny*1.65);
      
      noFill();
      strokeWeight(grosor1);
      stroke(colorMargen1);
      rect(margenx*0.95, margeny*3.2,sepx*1.5,sepy,10);
      
      stroke(colorMargen2);
      strokeWeight(grosor2);
      rect(margenx*2.2, margeny*3.2,sepx*1.8,sepy,10);
      
      strokeWeight(grosor3);
      stroke(colorMargen3);
      rect(margenx*3.5, margeny*3.2,sepx*2.2,sepy,10);
    }else if(!creando){
      prepararPartida();
    }else nuevaPartida();
    
    if(!jugar && !finJuego){
      for(int i=fichas.size()-1 ; i>=0 && i<fichas.size(); i--){
        Ficha F = fichas.get(i);
        F.display();
        if(F.isDead()){
          fichas.remove(i);
          fichas.add(new Ficha(int(random(1,3))));
        }
      }
    }        
  }
  
}

void serialEvent(Serial p){
  //habilitar movimientos de ficha
  if(jugar){
    if(j1>j2){
      Ficha f = fichas.get(fichaAct);
      f.mover();
    
    } else {
      Ficha f = fichas.get(fichaAct);
      f.mover();    
    }
  }else if(!preparacion){
    while(myPort.available()==1){
      switch(myPort.readChar()){
        case 'I':
          if(colorMargen2 == color(#78F2E7)){
            colorMargen2 = color(0);
            grosor2 = 0;
            colorMargen1 = color(#78F2E7);
            grosor1 = 8;
          }
          if(colorMargen3 == color(#78F2E7)){
            colorMargen3 = color(0);
            grosor3 = 0;
            colorMargen2 = color(#78F2E7);
            grosor2 = 8;
          }          
          break;
        case 'D':
          if(colorMargen2 == color(#78F2E7)){
            colorMargen2 = color(0);
            grosor2 = 0;
            colorMargen3 = color(#78F2E7);
            grosor3 = 8;
          }
          if(colorMargen1 == color(#78F2E7)){
            colorMargen1 = color(0);
            grosor1 = 0;
            colorMargen2 = color(#78F2E7);
            grosor2 = 8;
          }
        
          break;
        case 'S':
        if(grosor1!=0){
          preparacion = true;
          myPort.write((byte(tablaPartidas.getRowCount())));
        }else{
          jugar=true;
          if(grosor2!=0){jugador1="JUGADOR";jugador2="PC"; }else{ jugador1="PC";jugador2="PC";}
          reset();
        }
      }
    }
  }else{
    serialPreparacion();
  }
}

void keyPressed(){
  if(creando){
     teclado(); 
  }
   if(keyCode == ENTER && finJuego){
     myPort.write('C');
     finJuego = false;
     reset();
     t=1;
   }
   if((key == 'b' || key == 'B')&& finJuego){
     myPort.write('B');
     jugar=false;
     for(int i=fichas.size()-1; i>=0; i--){
        fichas.remove(i);
     }
     redraw();
     alpha=255;
     finJuego = false;
     punt1=0;
     punt2=0;
     j1=0;
     j2=-1;
   }
   if(key == 's' && jugar && grosor1!=0){
     guardar();
     textoGuardado = "Guardado";
   }
   if((key == 'm' || key == 'M') && !creando){
     reproducir = !reproducir;
   }
}

void reset(){
  fichaAct=0;
  alpha=255;
  
  for(int i=fichas.size()-1; i>=0; i--){
    fichas.remove(i);
  }
  
  if(j1>j2 && jugar){
      j1=0;
      j2=-1;
      fichas.add(new Ficha(1));
    }
    if(j1==j2 && jugar){
      j2=0;
      j1=0;
      fichas.add(new Ficha(2));
  }
  
  redraw();
}
