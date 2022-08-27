//fichas
class Ficha{
  color colorFicha;
  PVector locacion,velocidad;
  char decision; float condicion;
  boolean movimiento=false;
  
  //constructor
  Ficha(int numJugador_){
    if(jugar){
      locacion = new PVector(margenx+largo/2,margeny*0.76);
      velocidad = new PVector(0,alto*0.01);
    }else {
      do{
        locacion = new PVector(random(width),random(10));
      }while(locacion.x > lm && locacion.x < LM);
      velocidad = new PVector(0,random(2,alto*0.05));
    }
      
    if(numJugador_ == 1){
      colorFicha = color(0,255,0,alpha);
    }else colorFicha = color(0,0,255,alpha);
  }
  
  void dibujar(){
    strokeWeight(1);
    fill(colorFicha,alpha);
    circle(locacion.x,locacion.y,diametro);
  }
  
  void mover(){
      while(myPort.available()==1 && !finJuego){    //si hay info en el Serial
        char decision = myPort.readChar();
        switch(decision){
          case 'I':
            locacion.x-=sepx;
              if(j1>j2){
                botonI = color(0,255,0,alpha);
              }else botonI = color(0,0,255,alpha);
              delay(100);
              botonI = color(0,alpha);
              aux--;
              
              break;
              
          case 'D':
            locacion.x+=sepx;
            if(j1>j2){
              botonD = color(0,255,0,alpha);
            }else botonD = color(0,0,255,alpha);
            delay(100);
            botonD = color(0,alpha);
            aux++;
            
            break;
            
          default:
            movimiento = true;
            condicion = (margeny*0.705 + int(decision-47)*sepy);
            if(j1>j2){
              botonS = color(0,255,0,alpha);
            }else botonS = color(0,0,255,alpha);
            delay(100);
            botonS = color(0,alpha);
            
            comandos+=aux;
            break;
          case 'R':
            comandos+='R';
            reset();
            break;
          case 'T':
            if(j1>j2){
              j2++;
              fichas.remove(0);
              fichas.add(new Ficha(2));
              aux=3;
            }else if(j1==j2){
              j1++;
              fichas.remove(0);
              fichas.add(new Ficha(1));
              aux=3;
            }
            break;
          case 'G':
            comandos+='R';
            finJuego=true;
            if(j1>j2){ 
              punt2++;
            }else punt1++;
            
            if(primerJ == 1) primerJ=2; else primerJ=1;
            
            if(playerJuego.isPlaying()) {
              playerJuego.pause(); 
              playerJuego.rewind();
            }
            playerVic.trigger();
            guardar();
        }
        if(textoGuardado!="") textoGuardado="";
     }
     if(movimiento){
       locacion.add(velocidad);
     }
    if(locacion.y > condicion && movimiento){
      movimiento = false;
      locacion.y = condicion;
      playerFicha.trigger();
    }
    
  }
  
  void display(){
    locacion.add(velocidad);
    strokeWeight(1);
    fill(colorFicha,alpha);
    circle(locacion.x,locacion.y,diametro);
  }
  
  boolean isDead(){
    if(locacion.y > height){
      return true;
    }else return false;
  }
  
  boolean validar(){
    if(locacion.y == condicion){
      return true;
    }else return false;
  }
}
