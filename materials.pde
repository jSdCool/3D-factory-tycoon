abstract class Material{
 int roataion;
 int spawnDelay;
 float value;
 String type;
 Material(){
   roataion=(int)random(0,360);
 }
 void draw(){};
 int getSpawnDelay(){return spawnDelay;};
 Material NEW(){return this;};
 float getValue(){return value;};
 String getType(){return type;};
 
}

class ExampleMaterail extends Material{
  ExampleMaterail(){
   super(); 
   type="example";
   spawnDelay=4;
   value=5;
  }
  
  void draw(){
    
   rotateY(radians(roataion)); 
   translate(0,0,-10);
   shape(ingot);
   translate(0,0,10);
   rotateY(-radians(roataion)); 
  }
  Material NEW(){
   return new ExampleMaterail();
  }
}

class IronOre extends Material{
  IronOre(){
   super(); 
   type="iron ore";
   spawnDelay=4;
   value=5;
  }
  
  void draw(){
    
   rotateY(radians(roataion)); 
   translate(0,0,-10);
   shape(iron_ore);
   translate(0,0,10);
   rotateY(-radians(roataion)); 
  }
  Material NEW(){
   return new IronOre();
  }
}

class CopperOre extends Material{
  CopperOre(){
   super(); 
   type="copper ore";
   spawnDelay=4;
   value=5;
  }
  
  void draw(){
    
   rotateY(radians(roataion)); 
   translate(0,0,-10);
   shape(copper_ore);
   translate(0,0,10);
   rotateY(-radians(roataion)); 
  }
  Material NEW(){
   return new CopperOre();
  }
}

class IronIngot extends Material{
  IronIngot(){
   super(); 
   type="iron ingot";
   spawnDelay=4;
   value=10;
  }
  
  void draw(){
    
   rotateY(radians(roataion)); 
   translate(0,-1,-10);
   shape(iron_ingot);
   translate(0,1,10);
   rotateY(-radians(roataion)); 
  }
  Material NEW(){
   return new IronIngot();
  }
}

class CopperIngot extends Material{
  CopperIngot(){
   super(); 
   type="copper ingot";
   spawnDelay=4;
   value=10;
  }
  
  void draw(){
    
   rotateY(radians(roataion)); 
   translate(0,-1,-10);
   shape(copper_ingot);
   translate(0,1,10);
   rotateY(-radians(roataion)); 
  }
  Material NEW(){
   return new CopperIngot();
  }
}

class Coal extends Material{
  Coal(){
   super(); 
   type="coal";
   spawnDelay=6;
   value=6;
  }
  
  void draw(){
    
   rotateY(radians(roataion)); 
   translate(0,-1,-10);
   shape(coal);
   translate(0,1,10);
   rotateY(-radians(roataion)); 
  }
  Material NEW(){
   return new Coal();
  }
}

class Steel extends Material{
  Steel(){
   super(); 
   type="steel";
   spawnDelay=24;
   value=20;
  }
  
  void draw(){
    
   rotateY(radians(roataion)); 
   translate(0,-1,-10);
   shape(steel);
   translate(0,1,10);
   rotateY(-radians(roataion)); 
  }
  Material NEW(){
   return new Steel();
  }
}

class SteelPlate extends Material{
  SteelPlate(){
   super(); 
   type="steel plate";
   spawnDelay=24;
   value=45;
  }
  
  void draw(){
    
   rotateY(radians(roataion)); 
   translate(0,-1,-10);
   shape(steel_plate);
   translate(0,1,10);
   rotateY(-radians(roataion)); 
  }
  Material NEW(){
   return new SteelPlate();
  }
}

class CopperPlate extends Material{
  CopperPlate(){
   super(); 
   type="copper plate";
   spawnDelay=24;
   value=25;
  }
  
  void draw(){
    
   rotateY(radians(roataion)); 
   translate(0,-1,-10);
   shape(copper_Plate);
   translate(0,1,10);
   rotateY(-radians(roataion)); 
  }
  Material NEW(){
   return new CopperPlate();
  }
}

class IronRod extends Material{
  IronRod(){
   super(); 
   type="iron rod";
   spawnDelay=8;
   value=6;
  }
  
  void draw(){
    
   rotateY(radians(roataion)); 
   translate(0,-1,-10);
   shape(iron_rod);
   translate(0,1,10);
   rotateY(-radians(roataion)); 
  }
  Material NEW(){
   return new IronRod();
  }
}

class Screw extends Material{
  Screw(){
   super(); 
   type="screw";
   spawnDelay=8;
   value=3;
  }
  
  void draw(){
    
   rotateY(radians(roataion)); 
   translate(0,-1,-10);
   shape(screw);
   translate(0,1,10);
   rotateY(-radians(roataion)); 
  }
  Material NEW(){
   return new Screw();
  }
}

class BimetalicPlate extends Material{
  BimetalicPlate(){
   super(); 
   type="bumetalic plate";
   spawnDelay=24;
   value=90;
  }
  
  void draw(){
    
   rotateY(radians(roataion)); 
   translate(0,-1,-10);
   shape(biMetalic_plate);
   translate(0,1,10);
   rotateY(-radians(roataion)); 
  }
  Material NEW(){
   return new BimetalicPlate();
  }
}
