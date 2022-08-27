void prepararPartida(){
  fuente = createFont("Kristen ITC",sepx);
  textFont(fuente);
  textSize(sepx*0.5);
  fill(155,0,0);
  stroke(125,0,0);
  text("CARGAR/CREAR PARTIDA",margenx,margeny*0.55);
  strokeWeight(sepy*0.1);
  line(margenx,margeny*0.65,margenx*4.25,margeny*0.65);
  rect(margenx,margeny*0.8,largo,margeny*0.45);
  triangle( margenx*0.12+sepx,margeny*0.9+sepy*0.1+sepy*flecha, margenx*0.12+sepx*1.645,margeny*0.9+sepy*0.25+sepy*flecha, margenx*0.12+sepx,margeny*0.9+sepy*0.4+sepy*flecha );
  fill(232);
  text("NUEVA PARTIDA",margenx*1.15,margeny*1.1);
  
  for(int i=0; i<tablaPartidas.getRowCount(); i++){
    fill(155,0,0);
    rect(margenx,margeny*0.8+(sepy*(i+1)),largo,margeny*0.45);
    TableRow row = tablaPartidas.getRow(i);
    textSize(sepx*0.3);
    fill(232);
    text(row.getString("nombre1")+" vs "+row.getString("nombre2")+"         "+row.getString("fecha")+" "+row.getString("hora"),margenx*1.1,margeny*0.55 + sepy + sepy*(i+1));
  }
}

void tablaSetup(){
  tablaPartidas = loadTable("partidas.csv","header");
  if(tablaPartidas == null){
    tablaPartidas = new Table();
    tablaPartidas.addColumn("nombre1");
    tablaPartidas.addColumn("nombre2");
    tablaPartidas.addColumn("pts1");
    tablaPartidas.addColumn("pts2");
    tablaPartidas.addColumn("fecha");
    tablaPartidas.addColumn("hora");
    tablaPartidas.addColumn("comandos");
    
    saveTable(tablaPartidas,"partidas.csv");
  }
}

void nuevaPartida(){
  textSize(sepx*0.5);
  fill(155,0,0);
  stroke(125,0,0);
  text("INGRESO DE LOS NOMBRES\n(por teclado)",margenx,margeny*0.55);
  textSize(sepx*0.3);
  if(nombActual == 1){
    float sw = textWidth(jugador1)*0.75;
    strokeWeight(sepy*0.01);
    line(sw+margenx+largo*0.35, sepy*0.5+margeny+alto*0.275,sw+margenx+largo*0.35, sepy+alto*0.4);

    fill(100);
    textSize(25);
    text("Jugador 1",margenx+largo*0.35,margeny+alto*0.15);
    text(jugador1,margenx+largo*0.35,margeny+alto*0.35);
  }else{
    float sw = textWidth(jugador2)*0.75;
    line(sw+margenx+largo*0.35, sepy*0.5+margeny+alto*0.275,sw+margenx+largo*0.35, sepy+alto*0.4);

    fill(100);
    textSize(25);
    text("Jugador 2",margenx+largo*0.35,margeny+alto*0.15);
    text(jugador2,margenx+largo*0.35,margeny+alto*0.35);
  }
}

void serialPreparacion(){
  while(myPort.available()==1){
      switch(myPort.readChar()){
        case 'I':
             if(flecha>=0){
               flecha--;
             }
          break;
        case 'D':
             if(flecha<=5){
               flecha++;
             }
          break;
        case 'S':
        if(flecha == 0){
          //ingresar los nombres
          creando=true;
          jugador1="";
          jugador2="";
        }else{
         //cargar la partida getRow(flecha-1)-> si flecha es 1 obtiene la fila 0
         cargarTabla();
         jugar=true;
         reset();
        }
        preparacion=false;
        flecha=0;
      }
    }
}

void teclado(){
  if(nombActual == 1){
    if(jugador1.length() < 15 && keyCode != 8 && keyCode!=ENTER){
      jugador1+=key;
    }
    if((keyCode == 8 || keyCode == 127) && keyCode != ENTER && jugador1.length()>0){
      jugador1 = jugador1.substring(0,jugador1.length()-1);
    }
    if(keyCode == ENTER){
      nombActual=2;
    }
  }else{
    if(jugador2.length() < 15 && keyCode != 8 && keyCode!=ENTER){
      jugador2+=key;
    }
    if((keyCode == 8 || keyCode == 127) && keyCode != ENTER && jugador1.length()>0){
      jugador2 = jugador2.substring(0,jugador2.length()-1);
    }
    if(keyCode == ENTER){
      jugar=true;
      creando=false;
      nombActual=1;
      //"nombre1";"nombre2";"fecha";"hora"
      fecha = str(day())+"/"+str(month())+"/"+str(year());
      hora = str(hour())+":"+str(minute())+":"+str(second());
      if(tablaPartidas.getRowCount()>4){
        tablaPartidas.removeRow(0);
      }
      TableRow row = tablaPartidas.addRow();
      row.setString("nombre1",jugador1);
      row.setString("nombre2",jugador2);
      row.setString("fecha",fecha);
      row.setString("hora",hora);
      saveTable(tablaPartidas,"partidas.csv");
      reset();
    }
  }
}

void cargarTabla(){
  TableRow row=tablaPartidas.getRow(flecha-1);
  jugador1 = row.getString("nombre1");
  jugador2 = row.getString("nombre2");
  punt1 = row.getInt("pts1");
  punt2 = row.getInt("pts2");
  comandos = row.getString("comandos");
  for(int i=0; i<comandos.length(); i++){
    myPort.write(comandos.charAt(i));
  }
  comandos="";
}
