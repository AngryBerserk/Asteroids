class Decal extends Mover{
  float sp = 5;
  
  Decal(float x, float y, float a) {
    super(x,y,1);
    isHitTest = false;
    float _x = (sp + random(5)) * cos(a);
    float _y = (sp + random(5)) * sin(a);
    speed = new PVector(_x,_y);
    angle = speed.heading();
    InitShape();
  }
  
  void checkEdges(){
      if (location.x < 0 || location.x > width || location.y < 0 || location.y > height)
         isEnabled = false;
  }
  
  void InitShape(){
    shape.add(new PVector(-2-random(4),0));
    shape.add(new PVector(0,2+random(4)));
    shape.add(new PVector(2+random(4),0));
    shape.add(new PVector(0,-2-random(4)));
    copyShape();
  }  
  
  
}