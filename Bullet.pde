class Bullet extends Mover{
  float sp = 7;
  
  Bullet(float x, float y, float a) {
    super(x,y,1);
    float _x = sp * cos(a);
    float _y = sp * sin(a);
    speed = new PVector(_x,_y);
    angle = speed.heading();
    InitShape();
    collisionImmuneTimer = 10;
  }
  
  void InitShape(){
    shape.add(new PVector(-4,-4));
    shape.add(new PVector(5,0));
    shape.add(new PVector(-4,4));
    copyShape();
  }
  
}