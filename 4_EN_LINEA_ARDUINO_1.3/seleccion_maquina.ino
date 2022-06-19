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
