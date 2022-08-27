void cartelVic(){
  frameRate(60);
  textSize(t);
  text("VICTORIA",margenx+largo/2-t*2.75,margeny+alto/2-t*2);
  if(t<margeny*0.95)t++; else {
    frameRate(125);
      textSize(sepx*0.3);
      fill(200,250);
      text(" B: Volver al menú",margenx*0.02,margeny+alto/2-t*1.7);
      text("ENTER: Seguir",margenx+largo*1.02,margeny+alto/2-t*1.7);
  }
}

void guardar(){
  //;"pts1";"pts2";"comandos";
  if(comandos.length()>62){
    String aux = comandos.substring(1,comandos.indexOf('R')+1);
    comandos="";
    if(primerJ==2)comandos.concat("T").concat(aux); else comandos.concat("R").concat(aux);
  }
  
  if(flecha==0 && grosor1!=0){
    TableRow row = tablaPartidas.getRow(tablaPartidas.getRowCount()-1);
    row.setInt("pts1",punt1);
    row.setInt("pts2",punt2);
    row.setString("comandos",(comandos+':'));
    saveTable(tablaPartidas,"partidas.csv");
  }else if(grosor1!=0){
    TableRow row = tablaPartidas.getRow(flecha-1);
    row.setInt("pts1",punt1);
    row.setInt("pts2",punt2);
    row.setString("comandos",comandos+':');
    saveTable(tablaPartidas,"partidas.csv");
  }
}
