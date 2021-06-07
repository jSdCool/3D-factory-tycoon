abstract class Placeable{
 int rotation;
 String type;
 ArrayList <Material> inventory=new ArrayList<Material>(),inputBuffer=new ArrayList<Material>();
 float value;
 
  void draw(){};
  void tick(int x,int z){};
  boolean insertMaterial(Material m,int r){return false;};
  void flushInputBuffer(){};
  float getValue(){return value;};
  String getType(){return type;};
  Placeable setRecipie(String recipie){return this;};
  String getRecipie(){return "";};
  int getRotation(){return rotation;}
}

class Belt extends Placeable{
  ArrayList <Material> slot1=new ArrayList <Material>(),slot2=new ArrayList <Material>(),slot3=new ArrayList <Material>(),slot4=new ArrayList <Material>();
  Belt(int rot){
    rotation=rot;
    type="belt";
    value=100;
  }
  void draw(){
    
    if(rotation==0){//rotate ans position the belts correctly
      translate(0,5.5,0);
    }
    if(rotation==1){
      translate(-20,5.5,20);
    }
    if(rotation==2){
      translate(0,5.5,40);
    }
    if(rotation==3){
      translate(20,5.5,20);
    }
   rotateY(radians(90*rotation));
   shape(belt);//draw the belt
   
   translate(0,-28,0);
  
  
  translate(0,0,10);
  try{
   for(int i=0;i<slot1.size();i++){
     slot1.get(i).draw();
   }
   }catch(Throwable e){
    e.printStackTrace();
  }
  translate(0,0,-10);
  
  translate(0,0,20);
  try{
   for(int i=0;i<slot2.size();i++){
     slot2.get(i).draw();
   }
   }catch(Throwable e){
    e.printStackTrace();
  }
  translate(0,0,-20);
  
  translate(0,0,30);
  try{
   for(int i=0;i<slot3.size();i++){
     slot3.get(i).draw();
   }
   }catch(Throwable e){
    e.printStackTrace();
  }
  translate(0,0,-30);
  
  translate(0,0,40);
  try{
   for(int i=0;i<slot4.size();i++){
     slot4.get(i).draw();
   }
   }catch(Throwable e){
    e.printStackTrace();
  }
  translate(0,0,-40);
  
   translate(0,28,0);
   
   
   rotateY(radians(-90*rotation));
   if(rotation==0){
      translate(0,-5.5,0);
    }
    if(rotation==1){
      translate(20,-5.5,-20);
    }
    if(rotation==2){
      translate(0,-5.5,-40);
    }
    if(rotation==3){
      translate(-20,-5.5,-20);
    }
  }
  void tick(int x,int z){
    if(rotation==0){
        z++;
      }
      if(rotation==1){
        x++;
      }
      if(rotation==2){
        z--;
      }
      if(rotation==3){
        x--;
      }
      if(!(x<0||x>=tiles.length||z<0||z>=tiles[x].length)){
       
        if(tiles[x][z]!=null){
          for(int i=slot4.size()-1;i>=0;i--){
            if(tiles[x][z].insertMaterial(slot4.get(i),rotation)){
               slot4.remove(i); 
            }
          }
        }
      }
  
  for(int i=slot3.size()-1;i>=0;i--){
   slot4.add(slot3.remove(i)); 
  }
  for(int i=slot2.size()-1;i>=0;i--){
   slot3.add(slot2.remove(i)); 
  }
  for(int i=slot1.size()-1;i>=0;i--){
   slot2.add(slot1.remove(i)); 
  }
  
  
  }
  boolean insertMaterial(Material m,int r){
    inputBuffer.add(m);
    return true;
  }
  
  void flushInputBuffer(){
    for(int i=inputBuffer.size()-1;i>=0;i--){
     slot1.add(inputBuffer.remove(i));
    }
  }
  float getValue(){return value;};
}




class Seller extends Placeable{
  Seller(){
    rotation=0;
    type="seller";
    value=-1;
  }
  void draw(){
    
    if(rotation==0){//rotate ans position the belts correctly
      translate(0,5,0);
    }
    
   rotateY(radians(90*rotation));
   shape(seller);//draw the seller
   rotateY(radians(-90*rotation));
   if(rotation==0){
      translate(0,-5,0);
    }
    
  }
  
  boolean insertMaterial(Material m,int r){
    balance+=m.getValue();
    return true;
  }
  float getValue(){return value;};
}




class Spawner extends Placeable{
  Spawner(int rot){
    rotation=rot;
    type="spawner";
    value=500;
  }
  int spawnCooldown=0;
  Material spawnMaterial;
  String recipie="";
  void draw(){
    
    if(rotation==0){//rotate ans position the belts correctly
      translate(0,5,0);
    }
    if(rotation==1){
      translate(-20,5,20);
    }
    if(rotation==2){
      translate(0,5,40);
    }
    if(rotation==3){
      translate(20,5,20);
    }
   rotateY(radians(90*rotation));
   shape(spawner);//draw the spawner5
   rotateY(radians(-90*rotation));
   if(rotation==0){
      translate(0,-5,0);
    }
    if(rotation==1){
      translate(20,-5,-20);
    }
    if(rotation==2){
      translate(0,-5,-40);
    }
    if(rotation==3){
      translate(-20,-5,-20);
    }
  }
  
  void tick(int x,int z){
    if(spawnMaterial==null)
    return;
    if(spawnCooldown==0){
      spawnCooldown=spawnMaterial.getSpawnDelay();
      if(rotation==0){
        if(tiles[x][z+1]!=null&&tiles[x][z+1].insertMaterial(spawnMaterial.NEW(),rotation)){
         balance-=spawnMaterial.getValue();
        }
      }
      if(rotation==1){
        if(tiles[x+1][z]!=null&&tiles[x+1][z].insertMaterial(spawnMaterial.NEW(),rotation)){
         balance-=spawnMaterial.getValue(); 
        }
      }
      if(rotation==2){
        if(tiles[x][z-1]!=null&&tiles[x][z-1].insertMaterial(spawnMaterial.NEW(),rotation)){
         balance-=spawnMaterial.getValue(); 
        }
      }
      if(tiles[x-1][z]!=null&&rotation==3){
        if(tiles[x-1][z].insertMaterial(spawnMaterial.NEW(),rotation)){
         balance-=spawnMaterial.getValue(); 
        }
      }
      
    }else{
      spawnCooldown--;
    }
  }
  float getValue(){return value;};
  
  Placeable setRecipie(String r){
    recipie=r;
    if(r.equals("iron ore")){
      spawnMaterial=new IronOre();
    }
    if(r.equals("copper ore")){
      spawnMaterial=new CopperOre();
    }
    if(r.equals("coal")){
      spawnMaterial=new Coal();
    }
    return this;
  }
  
  String getRecipie(){
   return recipie; 
  }
}

class Smelter extends Placeable{
  Smelter(int rot){
    rotation=rot;
    type="smelter";
    value=1000;
  }
  int cooldown=0;
  
  void draw(){
    
    if(rotation==0){//rotate ans position the belts correctly
      translate(0,5,0);
    }
    if(rotation==1){
      translate(-20,5,20);
    }
    if(rotation==2){
      translate(0,5,40);
    }
    if(rotation==3){
      translate(20,5,20);
    }
   rotateY(radians(90*rotation));
   shape(smelter);//draw the spawner5
   rotateY(radians(-90*rotation));
   if(rotation==0){
      translate(0,-5,0);
    }
    if(rotation==1){
      translate(20,-5,-20);
    }
    if(rotation==2){
      translate(0,-5,-40);
    }
    if(rotation==3){
      translate(-20,-5,-20);
    }
  }
  float getValue(){return value;};
  
  boolean insertMaterial(Material m,int r){
    if(r!=rotation){
    return false;
    }
    if(m.getType().equals("iron ore")||m.getType().equals("copper ore")){
     inputBuffer.add(m); 
     return true;
    }
    
    return false;
  }
  
  void flushInputBuffer(){
  for(int i=inputBuffer.size()-1;i>=0;i--){
     inventory.add(inputBuffer.remove(i));
    }
  }
  
  void tick(int x,int z){
   if(inventory.size()==0)
   return;
   if(inventory.get(0).getSpawnDelay()<=cooldown){
     Material out=null;
     if(inventory.get(0).getType().equals("iron ore")){
       out=new IronIngot();
     }
     if(inventory.get(0).getType().equals("copper ore")){
       out=new CopperIngot();
     }
    int tx=0,tz=0;
    if(rotation==0){
        tx=x;
        tz=z+1;
      }
      if(rotation==1){
        tx=x+1;
        tz=z;
      }
      if(rotation==2){
        tx=x;
        tz=z-1;
      }
      if(rotation==3){
        tx=x-1;
        tz=z;
      }
      if(!(tx<0||tz<0||tx>=tiles.length||tx>=tiles[0].length)){
        if(tiles[tx][tz]!=null&&tiles[tx][tz].insertMaterial(out,rotation)){
          inventory.remove(0);
          cooldown=0;
        }
      }
   }else{
     cooldown++;
   }
   
  }

}

class Electric_Arc_Furnace extends Placeable{
  Electric_Arc_Furnace(int rot){
    rotation=rot;
    type="electric arc furnace";
    value=10000;
  }
  String recipie="";
  int cooldown=0,maxdelay,product=0;
  
  void draw(){
    
    if(rotation==0){//rotate ans position the belts correctly
      translate(0,5,0);
    }
    if(rotation==1){
      translate(-20,5,20);
    }
    if(rotation==2){
      translate(0,5,40);
    }
    if(rotation==3){
      translate(20,5,20);
    }
   rotateY(radians(90*rotation));
   shape(electric_arc_furnace);//draw the spawner5
   rotateY(radians(-90*rotation));
   if(rotation==0){
      translate(0,-5,0);
    }
    if(rotation==1){
      translate(20,-5,-20);
    }
    if(rotation==2){
      translate(0,-5,-40);
    }
    if(rotation==3){
      translate(-20,-5,-20);
    }
  }
  
  void flushInputBuffer(){
  for(int i=inputBuffer.size()-1;i>=0;i--){
     inventory.add(inputBuffer.remove(i));
    }
  }
  
  boolean insertMaterial(Material m,int r){
    if(r!=rotation){
    return false;
    }
    if(recipie.equals("steel")){
      if(m.getType().equals("iron ingot")||m.getType().equals("coal")){
       inputBuffer.add(m); 
       return true;
      }
    }
    
    return false;
  }
  
  String getRecipie(){
   return recipie; 
  }
  
  Placeable setRecipie(String r){
    recipie=r;
    if(recipie.equals("steel")){
      maxdelay=new Steel().getSpawnDelay();
    }
    return this;
  }
  
  void tick(int x,int z){
   int material1=0,material2=0;
   if(recipie.equals("steel")){
    for(int i=0;i<inventory.size();i++){
     if(inventory.get(i).getType().equals("iron ingot")){
       material1++;
     }
     if(inventory.get(i).getType().equals("coal")){
       material2++;
     }
    }
     
     if(material1>=6&&material2>=4){
       if(cooldown<maxdelay){
         cooldown++;
       }else{
         cooldown=0;
         
      product+=6;
        for(int i=0;i<inventory.size();i++){
         if(inventory.get(i).getType().equals("iron ingot")&&material1>0){
           inventory.remove(i);
           material1--;
         }
         if(inventory.get(i).getType().equals("coal")&&material2>0){
           inventory.remove(i);
           material2--;  
       }
        }
      }
      
      
     }
      if(product!=0){
       int tx=0,tz=0;
    if(rotation==0){
        tx=x;
        tz=z+1;
      }
      if(rotation==1){
        tx=x+1;
        tz=z;
      }
      if(rotation==2){
        tx=x;
        tz=z-1;
      }
      if(rotation==3){
        tx=x-1;
        tz=z;
      } 
      if(tiles[tx][tz]!=null&&tiles[tx][tz].insertMaterial(new Steel(),rotation)){
        product--;
      }
         
       }
   }//end of if recipie is steel
  }
}

class Spliter extends Placeable{
  Spliter(int rot){
    rotation=rot;
    type="spliter";
    value=2000;
  }
  int lastAttempt=0;
  
  void draw(){
    
    if(rotation==0){//rotate ans position the belts correctly
      translate(0,5,0);
    }
    if(rotation==1){
      translate(-20,5,20);
    }
    if(rotation==2){
      translate(0,5,40);
    }
    if(rotation==3){
      translate(20,5,20);
    }
   rotateY(radians(90*rotation));
   shape(spliter);//draw the spawner5
   rotateY(radians(-90*rotation));
   if(rotation==0){
      translate(0,-5,0);
    }
    if(rotation==1){
      translate(20,-5,-20);
    }
    if(rotation==2){
      translate(0,-5,-40);
    }
    if(rotation==3){
      translate(-20,-5,-20);
    }
  }
  
  void tick(int x,int z){
    if(inventory.size()!=0){
    int sendDir=lastAttempt+1;
    for(int i=inventory.size()-1;i>=0;i--){
      boolean tryAgain=true,endloop=false;
      while(tryAgain){
        if(lastAttempt>=4){
             lastAttempt-=4;
           }
           if(sendDir>=4){
             sendDir-=4;
           }
        if(sendDir==oppRot(rotation)){
          sendDir=nextRot(sendDir);
        }
        
        if(sendDir==lastAttempt){
          endloop=true;
          break;
        }
        int tx=0,tz=0;
        if(sendDir==0){
            tx=x;
            tz=z+1;
          }
          if(sendDir==1){
            tx=x+1;
            tz=z;
          }
          if(sendDir==2){
            tx=x;
            tz=z-1;
          }
          if(sendDir==3){
            tx=x-1;
            tz=z;
          } 
          if(tiles[tx][tz]!=null&&tiles[tx][tz].insertMaterial(inventory.get(i),sendDir)){

           inventory.remove(i);
           lastAttempt=sendDir;
           sendDir=nextRot(sendDir);
           
           if(lastAttempt>=4){
             lastAttempt-=4;
           }
           tryAgain=false;
           if(sendDir>=4)
            sendDir-=4;

          }else{

            sendDir=nextRot(sendDir);
            if(sendDir>=4)
            sendDir-=4;

          }
        
      }
      if(endloop){
       break;
      }
    }
  }
  }
  boolean insertMaterial(Material m,int r){
    if(r!=rotation){
    return false;
    }
    inputBuffer.add(m);
    return true;
  }
  
  void flushInputBuffer(){
  for(int i=inputBuffer.size()-1;i>=0;i--){
     inventory.add(inputBuffer.remove(i));
    }
  }
}


class Crafter extends Placeable{
  Crafter(int rot){
    rotation=rot;
    type="crafter";
    value=11000;
  }
  String recipie="";
  int cooldown=0,maxdelay,product=0;
  Material outputMaterial;
  
  void draw(){
    
    if(rotation==0){//rotate ans position the belts correctly
      translate(0,5,0);
    }
    if(rotation==1){
      translate(-20,5,20);
    }
    if(rotation==2){
      translate(0,5,40);
    }
    if(rotation==3){
      translate(20,5,20);
    }
   rotateY(radians(90*rotation));
   shape(crafter);//draw the spawner5
   rotateY(radians(-90*rotation));
   if(rotation==0){
      translate(0,-5,0);
    }
    if(rotation==1){
      translate(20,-5,-20);
    }
    if(rotation==2){
      translate(0,-5,-40);
    }
    if(rotation==3){
      translate(-20,-5,-20);
    }
  }
  
  void flushInputBuffer(){
  for(int i=inputBuffer.size()-1;i>=0;i--){
     inventory.add(inputBuffer.remove(i));
    }
  }
  
  boolean insertMaterial(Material m,int r){
    if(r!=rotation){
    return false;
    }
    if(recipie.equals("steel plate")){
      if(m.getType().equals("steel")){
       inputBuffer.add(m); 
       return true;
      }
    }
    if(recipie.equals("copper plate")){
      if(m.getType().equals("copper ingot")){
       inputBuffer.add(m); 
       return true;
      }
    }
    if(recipie.equals("iron rod")){
      if(m.getType().equals("iron ingot")){
       inputBuffer.add(m); 
       return true;
      }
    }
    if(recipie.equals("screw")){
      if(m.getType().equals("iron rod")){
       inputBuffer.add(m); 
       return true;
      }
    }
    if(recipie.equals("bimetalic plate")){
      if(m.getType().equals("screw")||m.getType().equals("copper plate")||m.getType().equals("steel plate")){
       inputBuffer.add(m); 
       return true;
      }
    }
    
    return false;
  }
  
  String getRecipie(){
   return recipie; 
  }
  
  Placeable setRecipie(String r){
    recipie=r;
    if(recipie.equals("steel plate")){
      outputMaterial=new SteelPlate();
    }
    if(recipie.equals("copper plate")){
      outputMaterial=new CopperPlate();
    }
    if(recipie.equals("iron rod")){
      outputMaterial=new IronRod();
    }
    if(recipie.equals("screw")){
      outputMaterial=new Screw();
    }
    if(recipie.equals("bimetalic plate")){
      outputMaterial=new BimetalicPlate();
    }
    return this;
  }
  
  void tick(int x,int z){
    
    if(recipie.equals("steel plate")||recipie.equals("copper plate")){
     if(inventory.size()>=2){
      if(cooldown==outputMaterial.getSpawnDelay()){
        cooldown=0;
        inventory.remove(0);
        inventory.remove(0);
        product+=1;
      }else{
        cooldown++;
      }
     }
    }
    
    if(recipie.equals("iron rod")||recipie.equals("screw")){
     if(inventory.size()>=1){
      if(cooldown==outputMaterial.getSpawnDelay()){
        cooldown=0;
        inventory.remove(0);
        product+=2;
      }else{
        cooldown++;
      }
     }
    }
    if(recipie.equals("bimetalic plate")){
      int material1=0,material2=0,material3=0;
      for(int i=0;i<inventory.size();i++){
        Material tpe=inventory.get(i);
        if(tpe.getType().equals("screw")){
          material1++;
        }
        if(tpe.getType().equals("steel plate")){
          material2++;
        }
        if(tpe.getType().equals("copper plate")){
          material3++;
        }
      }
      
      if(material1>=4&&material2>=1&&material3>=1){
      if(cooldown==outputMaterial.getSpawnDelay()){
        int amm1=4,amm2=1,amm3=1;
        for(int i=inventory.size()-1;i>=0;i--){
           Material tpe=inventory.get(i);
           if(tpe.getType().equals("screw")&&amm1>0){
            inventory.remove(i);
            amm1--;
            }
           if(tpe.getType().equals("steel plate")&&amm2>0){
            inventory.remove(i);
            amm2--;
            }
            if(tpe.getType().equals("copper plate")&&amm3>0){
            inventory.remove(i);
            amm3--;
            }
          }
        cooldown=0;
        product+=1;
      }else{
        cooldown++;
      }
     }
    }
   
      if(product!=0){
       int tx=0,tz=0;
    if(rotation==0){
        tx=x;
        tz=z+1;
      }
      if(rotation==1){
        tx=x+1;
        tz=z;
      }
      if(rotation==2){
        tx=x;
        tz=z-1;
      }
      if(rotation==3){
        tx=x-1;
        tz=z;
      } 
      if(tiles[tx][tz]!=null&&tiles[tx][tz].insertMaterial(outputMaterial.NEW(),rotation)){
        product--;
      }
         
       }
   
  }
}
