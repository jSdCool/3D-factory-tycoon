void settings(){
  size(1920,1080,P3D);
}

void setup(){
  
  println(width,height);
  tile=loadShape("data/modles/ground_tile/tinker.obj");
  belt=loadShape("data/modles/belt/tinker.obj");
  ingot=loadShape("data/modles/Intest_ingot/tinker.obj");
  arrow=loadShape("data/modles/direction_arrow/tinker.obj");
  tile_selected=loadShape("data/modles/ground_tile_selected/tinker.obj");
  missingTexture=loadShape("data/modles/missing_texture/tinker.obj");
  spawner=loadShape("data/modles/spawner/tinker.obj");
  smelter=loadShape("data/modles/smelter/tinker.obj");
  seller=loadShape("data/modles/sell/tinker.obj");
  iron_ingot=loadShape("data/modles/iron_ingot/tinker.obj");
  iron_ore=loadShape("data/modles/iron_ore/tinker.obj");
  copper_ore=loadShape("data/modles/copper_ore/tinker.obj");
  copper_ingot=loadShape("data/modles/copper_ingot/tinker.obj");
  steel=loadShape("data/modles/steel/tinker.obj");
  spliter=loadShape("data/modles/spliter/tinker.obj");
  coal=loadShape("data/modles/coal/tinker.obj");
  electric_arc_furnace=loadShape("data/modles/electric_arc_furnace/tinker.obj");
  
  steel_plate=loadShape("data/modles/steel_plate/tinker.obj");
  copper_Plate=loadShape("data/modles/copper_plate/tinker.obj");
  iron_rod=loadShape("data/modles/iron_rod/tinker.obj");
  screw=loadShape("data/modles/screw/tinker.obj");
  crafter=loadShape("data/modles/crafter/tinker.obj");
  biMetalic_plate=loadShape("data/modles/bimetalic_plate/tinker.obj");
  outline=loadShape("data/modles/outline/tinker.obj");
  
  ingot.scale(4);
  iron_ingot.scale(2);
  iron_ore.scale(2);
  copper_ore.scale(2);
  copper_ingot.scale(2);
  coal.scale(2);
  steel.scale(2);
  steel_plate.scale(2);
  copper_Plate.scale(2);
  iron_rod.scale(2);
  screw.scale(2);
  biMetalic_plate.scale(2);
  //theese need to be tested
  shapeMode(CENTER);
  img=loadImage("cbi.png");
  ptsW=100;
  ptsH=100;
  // Parameters below are the number of vertices around the width and height
  initializeSphere(ptsW, ptsH);
  initaliseMap(40,40);
  thread("gameTick");
  
}
float camX=0,camY=0,camZ=0,eyeX,eyeY,eyeZ,dist=615,Rx=200,Ry=-45,camSpeed=5;//camera position coords
boolean xu=false,yu=false,zu=false,xd=false,yd=false,zd=false,rxu=false,ryu=false,rxd=false,ryd=false;//camera movemetnt stuffs
float mouseInterfaceDivisor=1.5,mousePointX=0,mousePointY=0,mousePointZ=0;
PShape tile,belt,ingot,arrow,tile_selected,missingTexture,spawner,smelter,seller,iron_ore,iron_ingot,copper_ore,copper_ingot,steel,spliter,coal,electric_arc_furnace,steel_plate,copper_Plate,iron_rod,screw,crafter,biMetalic_plate,outline;
Placeable tiles[][];
boolean inGame=true,building=false,buildings1Menue=false,ticking=true,tileSelected=false,deleteting=false,gamePaused=false,gameSpeed1=false,gameSpeed2=true,gameSpeed3=false,pauseMenue=false,savingAs=false,loadingLevel=false,helpInformationScreen=false;//general booleans
int buildRotation=0,tickRateMsLimit=50,ptt=0,selectedTileX=0,selectedTileZ=0,selectedFileNumber=0;
String buildingThing ="belt",fileName="",namesOfPossibleFiles[];
float balance=2000,loan=0;


void draw(){
  if(start_wate<2){
    noStroke();
    drawlogo();
  }else{
  
    if(inGame){
  background(#15A7FF);
  
  if(xu){//camera movement
    camZ-=cos(radians(Rx+90))*camSpeed;
    camX-=sin(radians(Rx+90))*camSpeed;
  }
  if(yu){
    camY-=camSpeed;
  }
  if(zu){
    camZ+=cos(radians(Rx))*camSpeed;
    camX+=sin(radians(Rx))*camSpeed;
  }
  if(xd){
    camZ+=cos(radians(Rx+90))*camSpeed;
    camX+=sin(radians(Rx+90))*camSpeed;
  }
  if(yd){
    camY+=camSpeed;
  }
  if(zd){
    camZ-=cos(radians(Rx))*camSpeed;
    camX-=sin(radians(Rx))*camSpeed;
  }
  if(ryu){
    if(Ry>-88)
   Ry--; 
  }
  if(ryd){
    if(Ry<88)
   Ry++; 
  }
  if(rxu){
   Rx--; 
  }
  if(rxd){
   Rx++; 
  }//end of camera movement
  hint(ENABLE_DEPTH_TEST); 
  eyeY=sin(radians(Ry))*dist+camY;//calulate the position of the camera
  float hd=cos(radians(Ry))*dist;
  eyeX=sin(radians(Rx))*hd+camX;
  eyeZ=cos(radians(Rx))*hd+camZ;
  camera(eyeX,eyeY,eyeZ,camX,camY,camZ,0,1,0);
  ambientLight(180,180,180);
  directionalLight(240,240,240,0.5,1,0.6);
 
  fill(#838586);
  noStroke();
  
  
  //stroke(255,0,0);//axis lines
  //strokeWeight(10);
  //line(-100,0,100,0);
  //stroke(0,255,0);
  //line(0,-100,0,100);
  //stroke(0,0,255);
  //line(0,0,-100,0,0,100);
  
  noStroke();
  
  translate(camX,camY,camZ);//box at the camera focal point
  box(5);
  translate(-camX,-camY,-camZ);
  
  calcMousePoint();
  //fill(255,0,0);//cercal at the location the mouse is pointing
  //translate(0,-0.01,0);
  //rotateX(radians(90));
  //ellipse(calcX(),calcZ(),30,30);
  //rotateX(radians(-90));
  //translate(0,0.01,0);
  
  //stroke(3);
  //stroke(0,0,255);
  //line(calcX(),-100,calcZ(),calcX(),100,calcZ());//draw a line at the position the mouse is pointing at
  noStroke();
  int tlex=(int)(calcX()/40),tlez=(int)(calcZ()/40);//get the coods of the tile the mouse is overing over
  
  for(int x=0;x<tiles.length;x++){
   for(int z=0;z<tiles[0].length;z++){
      translate(x*40+20,6,z*40);
     if(x==tlex&&z==tlez){
       shape(tile_selected);
       if(tiles[x][z]!=null){
         translate(2,0,-1);
         shape(outline);
         translate(-2,0,1);
       }
     }else{
     shape(tile);
     }
     if(tiles[x][z]!=null){
       translate(1,0,0);
       tiles[x][z].draw();
       translate(-1,0,0);
       
     }
     translate(-(x*40+20),-6,-(z*40));
   }
  }
  
  if(building){
    if(tlex>=0&&tlex<tiles.length){
     if(tlez>=0&&tlez<tiles[0].length){
       if(tiles[tlex][tlez]==null){
      translate(tlex*40+20,0,tlez*40);
      if(buildRotation==1){
       translate(-20,0,20); 
      }
      if(buildRotation==2){
       translate(0,0,40); 
      }
      if(buildRotation==3){
       translate(20,0,20); 
      }
      rotateY(radians(90*buildRotation));
      shape(arrow);
      rotateY(-radians(90*buildRotation));
      if(buildRotation==1){
       translate(20,0,-20); 
      }
      if(buildRotation==2){
       translate(0,0,-40); 
      }
      if(buildRotation==3){
       translate(-20,0,-20); 
      }
      translate(-(tlex*40+20),0,-(tlez*40));
       }
     }
    }
  }//end of if building
  
  
  
  
      //HUD
      camera();
      hint(DISABLE_DEPTH_TEST);//no idea what this does but apperently it makes the HUD stuff appear on top
      textAlign(CENTER,CENTER);
      noLights();
      
      fill(#00E8FF);
      rect(0,height-(height/25.0),width,height/25.0);
      if(deleteting){
        fill(#95F7FF);
        rect(width*0.07,height-(height/25.0),width*0.05,height/25.0);
      }
      fill(0);
      textSize(20*height/1080.0);
      text("buildings 1",width*0.035,height-(height/25.0)+(height/25.0)/2);
      text("delete",width*0.095,height-(height/25.0)+(height/25.0)/2);
      stroke(0);
      strokeWeight(1);
      line(width*0.07,height-(height/25.0),width*0.07,height);
      line(width*0.12,height-(height/25.0),width*0.12,height);
      if(buildings1Menue){
        fill(#25C1CE);
        rect(0,height-(height/25.0)*2,width,height/25.0);
        fill(#67EFFA);
        if(buildingThing.equals("belt")){
         rect(0,height-(height/25.0)*2,width*0.07,height/25.0);
        }
        if(buildingThing.equals("spawner")){
         rect(width*0.07,height-(height/25.0)*2,width*0.09,height/25.0);
        }
        if(buildingThing.equals("smelter")){
         rect(width*0.16,height-(height/25.0)*2,width*0.09,height/25.0);
        }
        if(buildingThing.equals("spliter")){
         rect(width*0.25,height-(height/25.0)*2,width*0.09,height/25.0);
        }
        if(buildingThing.equals("electric arc furnace")){
         rect(width*0.34,height-(height/25.0)*2,width*0.16,height/25.0);
        }
        if(buildingThing.equals("crafter")){
         rect(width*0.5,height-(height/25.0)*2,width*0.1,height/25.0);
        }
        fill(0);
        line(width*0.07,height-(height/25.0)*2,width*0.07,height-(height/25.0));
        text("belt ($100)",width*0.035,height-(height/25.0)-(height/25.0)/2);
        line(width*0.16,height-(height/25.0)*2,width*0.16,height-(height/25.0));
        text("spawner ($500)",width*0.115,height-(height/25.0)-(height/25.0)/2);
        line(width*0.25,height-(height/25.0)*2,width*0.25,height-(height/25.0));
        text("smelter ($1000)",width*0.205,height-(height/25.0)-(height/25.0)/2);
        line(width*0.34,height-(height/25.0)*2,width*0.34,height-(height/25.0));
        text("spliter ($2000)",width*0.295,height-(height/25.0)-(height/25.0)/2);
        line(width*0.5,height-(height/25.0)*2,width*0.5,height-(height/25.0));
        text("eletric arc furnace ($10000)",width*0.42,height-(height/25.0)-(height/25.0)/2);
        line(width*0.60,height-(height/25.0)*2,width*0.60,height-(height/25.0));
        text("crafter ($11000)",width*0.55,height-(height/25.0)-(height/25.0)/2);
      }//end of buildings1 menue
      
      if(tileSelected){
        fill(#05FF88);
        rect(0,height-(height/25.0)*2,width,height/25.0);
        if(tiles[selectedTileX][selectedTileZ].getType().equals("spawner")){
          String recipie=tiles[selectedTileX][selectedTileZ].getRecipie();
          fill(#9DFFD0);
          if(recipie.equals("iron ore")){
            rect(0,height-(height/25.0)*2,width*0.07,height/25.0);
          }
          if(recipie.equals("copper ore")){
            rect(width*0.07,height-(height/25.0)*2,width*0.09,height/25.0);
          }
          if(recipie.equals("coal")){
            rect(width*0.16,height-(height/25.0)*2,width*0.05,height/25.0);
          }
          fill(0);
          line(width*0.07,height-(height/25.0)*2,width*0.07,height-(height/25.0));
          text("iron ore ($5)",width*0.035,height-(height/25.0)-(height/25.0)/2);
          line(width*0.16,height-(height/25.0)*2,width*0.16,height-(height/25.0));
          text("copper ore ($5)",width*0.115,height-(height/25.0)-(height/25.0)/2);
          line(width*0.21,height-(height/25.0)*2,width*0.21,height-(height/25.0));
          text("coal ($6)",width*0.185,height-(height/25.0)-(height/25.0)/2);
        }
        if(tiles[selectedTileX][selectedTileZ].getType().equals("electric arc furnace")){
          String recipie=tiles[selectedTileX][selectedTileZ].getRecipie();
          fill(#9DFFD0);
          if(recipie.equals("steel")){
            rect(0,height-(height/25.0)*2,width*0.16,height/25.0);
          }
          fill(0);
          line(width*0.16,height-(height/25.0)*2,width*0.16,height-(height/25.0));
          text("6X iron ingot + 4x coal = steel",width*0.08,height-(height/25.0)-(height/25.0)/2);
        }
        
        if(tiles[selectedTileX][selectedTileZ].getType().equals("crafter")){
          String recipie=tiles[selectedTileX][selectedTileZ].getRecipie();
          fill(#9DFFD0);
          if(recipie.equals("steel plate")){
            rect(0,height-(height/25.0)*2,width*0.12,height/25.0);
          }
          if(recipie.equals("copper plate")){
            rect(width*0.12,height-(height/25.0)*2,width*0.17,height/25.0);
          }
          if(recipie.equals("iron rod")){
            rect(width*0.26+width*0.03,height-(height/25.0)*2,width*0.14,height/25.0);
          }
          if(recipie.equals("screw")){
            rect(width*0.4+width*0.03,height-(height/25.0)*2,width*0.12,height/25.0);
          }
          if(recipie.equals("bimetalic plate")){
            rect(width*0.52+width*0.03,height-(height/25.0)*2,width*0.34,height/25.0);
          }
          fill(0);
          line(width*0.12,height-(height/25.0)*2,width*0.12,height-(height/25.0));
          text("2X steel = steel plate",width*0.06,height-(height/25.0)-(height/25.0)/2);
          line(width*0.26+width*0.03,height-(height/25.0)*2,width*0.26+width*0.03,height-(height/25.0));
          text("2X copper ingot = copper plate",width*0.19+width*0.015,height-(height/25.0)-(height/25.0)/2);
          line(width*0.40+width*0.03,height-(height/25.0)*2,width*0.40+width*0.03,height-(height/25.0));
          text("1X iron ingot = 2X iron rod",width*0.33+width*0.03,height-(height/25.0)-(height/25.0)/2);
          line(width*0.52+width*0.03,height-(height/25.0)*2,width*0.52+width*0.03,height-(height/25.0));
          text("1X iron rod = 2X screw",width*0.46+width*0.03,height-(height/25.0)-(height/25.0)/2);
          line(width*0.86+width*0.03,height-(height/25.0)*2,width*0.86+width*0.03,height-(height/25.0));
          text("1X steel plate + 1X copper plate + 4X screw = 1X bimetalic plate",width*0.69+width*0.03,height-(height/25.0)-(height/25.0)/2);
        }
      }
      fill(#95F7FF);
      if(gamePaused){
        rect(width*0.9,height-(height/25.0),width*0.025,height/25.0);
      }else{
        if(gameSpeed1){
          rect(width*0.925,height-(height/25.0),width*0.025,height/25.0);
        }
        if(gameSpeed2){
          rect(width*0.95,height-(height/25.0),width*0.025,height/25.0);
        }
        if(gameSpeed3){
          rect(width*0.975,height-(height/25.0),width*0.025,height/25.0);
        }
        
      }
      
      line(width*0.975,height-(height/25.0),width*0.975,height);
      line(width*0.95,height-(height/25.0),width*0.95,height);
      line(width*0.925,height-(height/25.0),width*0.925,height);
      line(width*0.9,height-(height/25.0),width*0.9,height);
      fill(0);
      rect(width*0.905,height-(height/25.0)+(height*0.006),width*0.005,(height*0.03));
      rect(width*0.915,height-(height/25.0)+(height*0.006),width*0.005,(height*0.03));
      triangle(width*0.934,height-(height/25.0)+(height*0.006),width*0.934,height-(height*0.006),width*0.944,height-(height*0.02));
      triangle(width*0.955,height-(height/25.0)+(height*0.006),width*0.955,height-(height*0.006),width*0.962,height-(height*0.02));
      triangle(width*0.962,height-(height/25.0)+(height*0.006),width*0.962,height-(height*0.006),width*0.969,height-(height*0.02));
      triangle(width*0.979,height-(height/25.0)+(height*0.006),width*0.979,height-(height*0.006),width*0.984,height-(height*0.02));
      triangle(width*0.984,height-(height/25.0)+(height*0.006),width*0.984,height-(height*0.006),width*0.989,height-(height*0.02));
      triangle(width*0.989,height-(height/25.0)+(height*0.006),width*0.989,height-(height*0.006),width*0.994,height-(height*0.02));
      
      fill(255);
      if(balance<0)
       fill(255,0,0);
      textAlign(LEFT,TOP);
      textSize(40*height/1080.0);
      text("$"+balance,0,0);
        
        if(pauseMenue){
          textAlign(CENTER,CENTER);
          noStroke();
        fill(100,128);
        rect(0,0,width,height);
        fill(#0891FF);
        rect(width/2-width*0.08,height*0.2,width*0.16,height*0.05);
        rect(width/2-width*0.08,height*0.28,width*0.16,height*0.05);
        rect(width/2-width*0.08,height*0.36,width*0.16,height*0.05);
        rect(width/2-width*0.08,height*0.44,width*0.16,height*0.05);
        rect(width/2-width*0.08,height*0.52,width*0.16,height*0.05);
        rect(width/2-width*0.08,height*0.60,width*0.16,height*0.05);
        fill(0);
        textSize(100*(height/1920.0));
        text("PAUSED",width/2,height*0.1);
        textSize(80*(height/1920.0));
        text("resume",width/2,height*0.225);
        text("save",width/2,height*0.305);
        text("save as",width/2,height*0.385);
        text("load",width/2,height*0.465);
        text("help",width/2,height*0.545);
        text("exit",width/2,height*0.625);
        if(helpInformationScreen){
          fill(#00DEF0);
         rect(width/2-(width*0.3),height*0.2,width*0.6,height*0.6); 
         fill(0);
         textSize(100*(height/1080.0));
         text("for help/information\nin the game files\nopen the help.html file",width/2,height*0.4);
         fill(#9F00F0);
         rect(width/2-(width*0.05),height*0.65,width*0.1,height*0.05);
         fill(0);
         textSize(50*(height/1080.0));
         text("OK",width/2,height*0.675);
        }
      }//end of if game paused
        
    }//end of if in game
    
    if(savingAs){
      hint(DISABLE_DEPTH_TEST);//no idea what this does but apperently it makes the HUD stuff appear on top
      background(#15A7FF);
      fill(#7A08FF);
      rect(width/2.0-(width*0.1),height*0.7,width*0.2,height*0.1);
      fill(0);
      textSize(150*(height/1920.0));
      text(fileName,width/2,height*0.5);
      text("type what you want to name your save",width/2,height*0.2);
      text("save",width/2,height*0.75);
    }//end of saving as
    
    if(loadingLevel){
      background(#15A7FF);
      if(namesOfPossibleFiles.length==0){
        fill(0);
        textSize(150*(height/1920.0));
        text("you have no saves",width/2,height/2);
      }else{
        fill(#B5c7FF);
        rect(0,(height*0.08)*selectedFileNumber+height*0.035,width/2,height*0.08);
        fill(0);
        noStroke();
        textSize(100*(height/1920.0));
        for(int i=0;i<namesOfPossibleFiles.length;i++){//displays 12 saves
         text(namesOfPossibleFiles[i].substring(0,namesOfPossibleFiles[i].length()-5),width*0.25,(height*0.08)*i+height*0.07);
        }
        stroke(0);
        strokeWeight(2);
        line(width*0.5,0,width*0.5,height);
        noStroke();
        text("select the level you want to load\nnote: only 12 are shown",width*3/4,height*0.07);
        fill(#7A08FF);
        rect(width*0.65,height*0.8,width*0.2,height*0.1);
        fill(0);
        text("load",width*0.75,height*0.85);
      }
    }//end of loading level
  
  
  
  }//ebd of not start wate block
}//end of draw function


void mouseClicked(){
  if(inGame){
    if(pauseMenue){
     if(helpInformationScreen){
       //rect(width/2-(width*0.05),height*0.65,width*0.1,height*0.05);
       if(mouseX>=width/2-(width*0.05)&&mouseX<=width/2+(width*0.05)&&mouseY>=height*0.65&&mouseY<=height*0.7){
         helpInformationScreen=false;
       }
     }else{
      if(mouseX>=width/2-width*0.08&&mouseX<=(width/2-width*0.08)+width*0.16){
        if(mouseY>=height*0.2&&mouseY<=height*0.25){//resume button
          pauseMenue=false;
        }
        if(mouseY>=height*0.28&&mouseY<=height*0.33){//save button
          if(fileName==""){
            savingAs=true;
            inGame=false;
          }else{
            save();
          }
        }
        if(mouseY>=height*0.36&&mouseY<=height*0.41){//save as button
          savingAs=true;
          inGame=false;
        }
        if(mouseY>=height*0.44&&mouseY<=height*0.49){//load button
          
          inGame=false;
          String[] files=new File(System.getenv("AppData")+"/CBi-games/3D_Factory_Tycoon").list();
          int numofjsons=0;
          for(int i=0;i<files.length;i++){
            if(files[i].contains(".json")){
              numofjsons++;
            }
          }
          namesOfPossibleFiles=new String[numofjsons];
          int pointer=0;
          for(int i=0;i<files.length;i++){
            if(files[i].contains(".json")){
             namesOfPossibleFiles[pointer]=files[i];
             pointer++;
            }
          }
          loadingLevel=true;
        }
        if(mouseY>=height*0.52&&mouseY<=height*0.57){//help button
          helpInformationScreen=true;
        }
        if(mouseY>=height*0.60&&mouseY<=height*0.65){//exit button
          exit();
        }

      }
     }
      return;
    }
    if(mouseY>=height-(height/25.0)){
      if(mouseX>=0&&mouseX<=width*0.07){
       if(buildings1Menue){
         buildings1Menue=false;
         building=false;
       }else{
         buildings1Menue=true;
         buildingThing="";
         deleteting=false;
         tileSelected=false;
       }
      }//building menue 1 button
      
      if(mouseX>=width*0.07&&mouseX<=width*0.12){
        if(deleteting){
         deleteting=false;
       }else{
         deleteting=true;
         buildings1Menue=false;
         building=false;
         tileSelected=false;
       }
      }
      //time controll buttons
      if(mouseX>=width*0.9&&mouseX<=width*0.925){
        gamePaused=true;
        gameSpeed1=false;
        gameSpeed2=false;
        gameSpeed3=false;
      }
      if(mouseX>=width*0.925&&mouseX<=width*0.95){
        gamePaused=false;
        gameSpeed1=true;
        gameSpeed2=false;
        gameSpeed3=false;
        tickRateMsLimit=100;
      }
      if(mouseX>=width*0.95&&mouseX<=width*0.975){
        gamePaused=false;
        gameSpeed1=false;
        gameSpeed2=true;
        gameSpeed3=false;
        tickRateMsLimit=50;
      }
      if(mouseX>=width*0.975&&mouseX<=width){
        gamePaused=false;
        gameSpeed1=false;
        gameSpeed2=false;
        gameSpeed3=true;
        tickRateMsLimit=-1;
      }
     return; 
    }//end of bar at the bottem of the screen
    if(buildings1Menue){
      if(mouseY>=height-(height/25.0)*2&&mouseY<=height-(height/25.0)){
        if(mouseX>=0&&mouseX<=width*0.07){
          building=true;
          buildingThing="belt";
        }
 
        if(mouseX>=width*0.07&&mouseX<=width*0.16){
          building=true;
          buildingThing="spawner";
        }
        if(mouseX>=width*0.16&&mouseX<=width*0.25){
          building=true;
          buildingThing="smelter";
        }
        if(mouseX>=width*0.25&&mouseX<=width*0.34){
          building=true;
          buildingThing="spliter";
        }
        if(mouseX>=width*0.34&&mouseX<=width*0.5){
          building=true;
          buildingThing="electric arc furnace";
        }
        if(mouseX>=width*0.5&&mouseX<=width*0.6){
          building=true;
          buildingThing="crafter";
        }
        return;
        
      }//end of mouse in the buttons bar
    }//end of building menue 1
    
    if(deleteting){
      int tx=(int)(calcX()/40),tz=(int)(calcZ()/40);
      if(tx>=0&&tz>=0&&tx<tiles.length&&tz<tiles[0].length){
       if(tiles[tx][tz]==null||tiles[tx][tz].getType().equals("seller")){
         return;
       }
       balance+=tiles[tx][tz].getValue();
       tiles[tx][tz]=null;
      }
      
    }
    calcMousePoint();
    int tlex=(int)(calcX()/40),tlez=(int)(calcZ()/40);
    if(building){
      if(tlex>=0&&tlex<tiles.length){
     if(tlez>=0&&tlez<tiles[0].length){
       if(tiles[tlex][tlez]==null){
         if(buildingThing.equals("belt")&&balance>=new Belt(0).getValue()){
           tiles[tlex][tlez]=new Belt(buildRotation);
           balance-=tiles[tlex][tlez].getValue();
         }//end of thing = belt
         if(buildingThing.equals("spawner")&&balance>=new Spawner(0).getValue()){
           tiles[tlex][tlez]=new Spawner(buildRotation);
           balance-=tiles[tlex][tlez].getValue();
         }//end of thing = spawner
         if(buildingThing.equals("smelter")&&balance>=new Smelter(0).getValue()){
           tiles[tlex][tlez]=new Smelter(buildRotation);
           balance-=tiles[tlex][tlez].getValue();
         }//end of if thing = smelter
         if(buildingThing.equals("spliter")&&balance>=new Spliter(0).getValue()){
           tiles[tlex][tlez]=new Spliter(buildRotation);
           balance-=tiles[tlex][tlez].getValue();
         }//end of if thing = spliter
         if(buildingThing.equals("electric arc furnace")&&balance>=new Electric_Arc_Furnace(0).getValue()){
           tiles[tlex][tlez]=new Electric_Arc_Furnace(buildRotation);
           balance-=tiles[tlex][tlez].getValue();
         }//end of if thing = electric arc furnace
         if(buildingThing.equals("crafter")&&balance>=new Crafter(0).getValue()){
           tiles[tlex][tlez]=new Crafter(buildRotation);
           balance-=tiles[tlex][tlez].getValue();
         }//end of if thing = crafter
       }//end of if this mtile is empty
     }}//end of valid tile checking
     return;
    }//end of if building
    
    if(tileSelected){
      if(mouseY>=height-(height/25.0)*2&&mouseY<=height-(height/25.0)){
        if(tiles[selectedTileX][selectedTileZ].getType().equals("spawner")){
         if(mouseX>=0&&mouseX<=width*0.07){
            tiles[selectedTileX][selectedTileZ].setRecipie("iron ore");
          }
          if(mouseX>=width*0.07&&mouseX<=width*0.16){
            tiles[selectedTileX][selectedTileZ].setRecipie("copper ore");
           }
           if(mouseX>=width*0.16&&mouseX<=width*0.21){
               tiles[selectedTileX][selectedTileZ].setRecipie("coal");
           }
          
        }//end of if seleted thing is the spawner
        
        if(tiles[selectedTileX][selectedTileZ].getType().equals("electric arc furnace")){
          if(mouseX>=0&&mouseX<=width*0.16){
            tiles[selectedTileX][selectedTileZ].setRecipie("steel");
          }
        }//end of if elected ting is electric arc furnace
        if(tiles[selectedTileX][selectedTileZ].getType().equals("crafter")){
          if(mouseX>=0&&mouseX<=width*0.12){
            tiles[selectedTileX][selectedTileZ].setRecipie("steel plate");
          }
          if(mouseX>=width*0.12&&mouseX<=width*0.29){
            tiles[selectedTileX][selectedTileZ].setRecipie("copper plate");
          }
          if(mouseX>=width*0.26+width*0.03&&mouseX<=width*0.4+width*0.03){
            tiles[selectedTileX][selectedTileZ].setRecipie("iron rod");
          }
          if(mouseX>=width*0.4+width*0.03&&mouseX<=width*0.52+width*0.03){
            tiles[selectedTileX][selectedTileZ].setRecipie("screw");
          }
          if(mouseX>=width*0.52+width*0.03&&mouseX<=width*0.86+width*0.03){
            tiles[selectedTileX][selectedTileZ].setRecipie("bimetalic plate");
          }
        }//end of if elected ting is cr\after
        return;
      }
    }//end of if tile selected
    
    int tx=(int)(calcX()/40),tz=(int)(calcZ()/40);
    if(!buildings1Menue&&!deleteting){
    if(tx>=0&&tz>=0&&tx<tiles.length&&tz<tiles[0].length){
      if(tiles[tx][tz]==null){
        tileSelected=false;
      }else{
        String TType=tiles[tx][tz].getType();
        if(TType.equals("spawner")||TType.equals("electric arc furnace")||TType.equals("crafter")){
          tileSelected=true;
          selectedTileX=tx;
          selectedTileZ=tz;
        } 
        else{
          tileSelected=false;
        }
      }
    }
    }//end of if not building menues
  }//end of if in game
  //rect(width/2.0-(width*0.1),height*0.7,width*0.2,height*0.1);
  if(savingAs){
    if(mouseX>=width/2.0-(width*0.1)&&mouseX<=width/2.0+(width*0.1)&&mouseY>=height*0.7&&mouseY<=height*0.8){
      if(!fileName.equals("")){
      save();
      inGame=true;
      savingAs=false;
      }//if the file name is valid
    }//end of clicking on save button
  }//end if if saving as
  
  if(loadingLevel){
    if(mouseX<width/2){
      //rect(0,(height*0.08)*selectedFileNumber+height*0.035,width/2,height*0.08);
      if(mouseY>=height*0.035&&mouseY<=height*0.115){
        selectedFileNumber=0;
      }
      if(mouseY>=height*0.115&&mouseY<=height*0.195){
        selectedFileNumber=1;
      }
      if(mouseY>=height*0.195&&mouseY<=height*0.275){
        selectedFileNumber=2;
      }
      if(mouseY>=height*0.275&&mouseY<=height*0.355){
        selectedFileNumber=3;
      }
      if(mouseY>=height*0.355&&mouseY<=height*0.435){
        selectedFileNumber=4;
      }
      if(mouseY>=height*0.435&&mouseY<=height*0.515){
        selectedFileNumber=5;
      }
      if(mouseY>=height*0.515&&mouseY<=height*0.595){
        selectedFileNumber=6;
      }
      if(mouseY>=height*0.595&&mouseY<=height*0.675){
        selectedFileNumber=7;
      }
      if(mouseY>=height*0.675&&mouseY<=height*0.755){
        selectedFileNumber=8;
      }
      if(mouseY>=height*0.755&&mouseY<=height*0.835){
        selectedFileNumber=9;
      }
      if(mouseY>=height*0.835&&mouseY<=height*0.915){
        selectedFileNumber=10;
      }
      if(mouseY>=height*0.915&&mouseY<=height*0.995){
        selectedFileNumber=11;
      }
      if(mouseY>=height*0.995&&mouseY<=height){
        selectedFileNumber=12;
      }
    }
    
    //rect(width*0.65,height*0.8,width*0.2,height*0.1);
   
    if(mouseX>=width*0.65&&mouseX<=width*0.85&&mouseY>=height*0.8&&mouseY<=height*0.9){
      if(selectedFileNumber>=namesOfPossibleFiles.length){
       return; 
      }
      println("loading");
      JSONArray loaded=loadJSONArray(System.getenv("AppData")+"/CBi-games/3D_Factory_Tycoon/"+namesOfPossibleFiles[selectedFileNumber]);
      JSONObject obj=loaded.getJSONObject(0);
      tiles=new Placeable[obj.getInt("lengthX")][obj.getInt("lengthZ")];
      balance=obj.getFloat("balance");
      for(int i=1;i<loaded.size();i++){
        obj=loaded.getJSONObject(i);
        String type=obj.getString("type");
        if(type.equals("seller")){
          tiles[obj.getInt("x")][obj.getInt("z")] =new Seller().setRecipie(obj.getString("recipie"));
        }
        if(type.equals("belt")){
          tiles[obj.getInt("x")][obj.getInt("z")] =new Belt(obj.getInt("rotation")).setRecipie(obj.getString("recipie"));
        }
        if(type.equals("smelter")){
          tiles[obj.getInt("x")][obj.getInt("z")] =new Smelter(obj.getInt("rotation")).setRecipie(obj.getString("recipie"));
        }
        if(type.equals("spawner")){
          tiles[obj.getInt("x")][obj.getInt("z")] =new Spawner(obj.getInt("rotation")).setRecipie(obj.getString("recipie"));
        }
        if(type.equals("electric arc furnace")){
          tiles[obj.getInt("x")][obj.getInt("z")] =new Electric_Arc_Furnace(obj.getInt("rotation")).setRecipie(obj.getString("recipie"));
        }
        if(type.equals("spliter")){
          tiles[obj.getInt("x")][obj.getInt("z")] =new Spliter(obj.getInt("rotation")).setRecipie(obj.getString("recipie"));
        }
        if(type.equals("crafter")){
          tiles[obj.getInt("x")][obj.getInt("z")] =new Crafter(obj.getInt("rotation")).setRecipie(obj.getString("recipie"));
        }
      }
      loadingLevel=false;
      inGame=true;
      fileName=namesOfPossibleFiles[selectedFileNumber].substring(0,namesOfPossibleFiles[selectedFileNumber].length()-5);
      
    }
  }//end of loading level
}//end of mouse clicked

void mouseWheel(MouseEvent e){
  if(dist<30&&e.getCount()<0){
   return; 
  }
  dist+=e.getCount()*10;
}

void keyPressed(){
  if(inGame){
  if(key==ESC){
   key=0;
    if(inGame){
      tileSelected=false;
      buildings1Menue=false;
      deleteting=false;
      building=false;
      if(pauseMenue){
        pauseMenue=false;
      }else{
        pauseMenue=true;
      }
      gamePaused=true;
    }
    return;
  }

 if(keyCode==87){
   zd=true;
 }
 if(keyCode==65){
   xu=true;
 }
 if(keyCode==83){
   zu=true;
 }
 if(keyCode==68){
   xd=true;
 }
 if(keyCode==32){
  yu=true; 
 }
 if(keyCode==16){
  yd=true; 
 }
 if(keyCode==38){
   ryu=true;
 }
 if(keyCode==40){
   ryd=true;
 }
 if(keyCode==37){
   rxu=true;
 }
 if(keyCode==39){
   rxd=true;
 }
 if(keyCode==82){//R key
   buildRotation++;
   if(buildRotation==4){
     buildRotation=0;
   }
 }
 
 
}
 if(savingAs){
   fileName=getInput(fileName,0);
 }
 

}//end of key pressed
void keyReleased(){
  if(keyCode==87){
   zd=false;
 }
 if(keyCode==65){
   xu=false;
 }
 if(keyCode==83){
   zu=false;
 }
 if(keyCode==68){
   xd=false;
 }
 if(keyCode==32){
  yu=false; 
 }
 if(keyCode==16){
  yd=false; 
 }
 if(keyCode==38){
   ryu=false;
 }
 if(keyCode==40){
   ryd=false;
 }
 if(keyCode==37){
   rxu=false;
 }
 if(keyCode==39){
   rxd=false;
 }
 
}

float calcX(){//calcuate the x postion the mouse is pointing at at y=0
  float m=(eyeY-mousePointY)/(eyeX-mousePointX);
  float b=-m*mousePointX+mousePointY;
  return -b/m;
}

float calcZ(){//calcuate the z postion the mouse is pointing at at y=0
  float m=(eyeY-mousePointY)/(eyeZ-mousePointZ);
  float b=-m*mousePointZ+mousePointY;
  return -b/m;
}

void calcMousePoint(){//get a 3d point that is at the same postition as the mouse curser
  float camCentercCalcX,camCentercCalcY,camCentercCalcZ;//get a point that is a certain distance from where the camera eyes are in the center if the screen
  camCentercCalcY=sin(radians(Ry))*-615+eyeY;
  float hd2=cos(radians(Ry))*-615;
  camCentercCalcX=sin(radians(Rx))*hd2+eyeX;
  camCentercCalcZ=cos(radians(Rx))*hd2+eyeZ;
  
  float midDistX=(mouseX-width/2)/mouseInterfaceDivisor,midDistY=(mouseY-height/2)/mouseInterfaceDivisor;
  float nz=sin(radians(-Rx))*midDistX,nx=cos(radians(-Rx))*midDistX;
  float ny=cos(radians(-Ry))*midDistY,nd=sin(radians(-Ry))*midDistY;
  nz+=cos(radians(Rx))*nd;
  nx+=sin(radians(Rx))*nd;
  mousePointX=camCentercCalcX+nx;
  mousePointY=camCentercCalcY+ny;
  mousePointZ=camCentercCalcZ+nz;
}

void initaliseMap(int w,int h){//initalise that grid of the factory
 tiles=new Placeable[w][h];
 int sellers=(int)Math.sqrt(w*h)/4+1;
 int x1=0,z1=0;
 for(int i=0;i<sellers;i++){
   do{
     x1=(int)random(0,w-1);
     z1=(int)random(0,h-1);
   }while(tiles[x1][z1]!=null);
   tiles[x1][z1]=new Seller();
 }
}

void gameTick(){
  while(ticking){
    if(!gamePaused){
    if(millis()-ptt>=tickRateMsLimit){
      ptt=millis();
      for(int x=0;x<tiles.length;x++){
       for(int z=0;z<tiles[x].length;z++){
         if(tiles[x][z]!=null){
           tiles[x][z].tick(x,z);
         }
       }
      }//end of tick every tile section
      for(int x=0;x<tiles.length;x++){
       for(int z=0;z<tiles[x].length;z++){
         if(tiles[x][z]!=null){
           tiles[x][z].flushInputBuffer();
         }
       }
      }//end of flush input bufferr section
    }//end of check if enough time has pased to let the next tick happen
  }else{//end of if game not paused
    random(2);//prevent the thread from auto stoping if there is no activity
  }//end of if game paused
  }//end of while ticking
}//end of game tick function

int oppRot(int r){
 switch(r){
  case 0:
  return 2;
  case 1:
  return 3;
  case 2:
  return 0;
  case 3:
  return 1;
 }
  return -1;
}

int nextRot(int r){
 switch(r){
  case 0:
  return 1;
  case 1:
  return 2;
  case 2:
  return 3;
  case 3:
  return 0;
 }
  return -1;
}

void save(){
  JSONArray saves=new JSONArray();
  JSONObject obj=new JSONObject();
  obj.setInt("lengthX",tiles.length);
  obj.setInt("lengthZ",tiles[0].length);
  obj.setFloat("balance",balance);
  saves.setJSONObject(0,obj);
  int index=1;
  for(int x=0;x<tiles.length;x++){
   for(int z=0;z<tiles[x].length;z++){
     if(tiles[x][z]!=null){
       obj=new JSONObject();
       obj.setString("type",tiles[x][z].getType());
       obj.setInt("rotation",tiles[x][z].getRotation());
       obj.setInt("x",x);
       obj.setInt("z",z);
       obj.setString("recipie",tiles[x][z].getRecipie());
       saves.setJSONObject(index,obj);
       index++;
     }
   }
  }
  saveJSONArray(saves,System.getenv("AppData")+"/CBi-games/3D_Factory_Tycoon/"+fileName+".json");
}

char getCh(int mode){
  if(mode==0){
  if(Character.isLetter(key)||key==' '){
   return key; 
 }
 if(keyCode==32){
  return ' '; 
 }
  
 if(key=='1'||key=='2'||key=='3'||key=='4'||key=='5'||key=='6'||key=='7'||key=='8'||key=='9'||key=='0')
 return key;
}
if(mode==1){
  if(key=='1'||key=='2'||key=='3'||key=='4'||key=='5'||key=='6'||key=='7'||key=='8'||key=='9'||key=='0')
 return key;
}
if(mode==2){
  if(key=='1'||key=='2'||key=='3'||key=='4'||key=='5'||key=='6'||key=='7'||key=='8'||key=='9'||key=='0'||key=='.')
 return key;
}

 return 0;
}

String doBackspace(String imp){
  if(keyCode==8){
   if(imp.length()>1){
    return imp.substring(0,imp.length()-1); 
   }
   else if(imp.length()==1){
    return ""; 
   }
  }
  return imp;
}

String getInput(String in,int x){
  if(getCh(x)!=0){
    in+=getCh(x);
  }
  in=doBackspace(in);
  return in;
}
