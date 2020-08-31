class Ship extends Mover{
  
  ParticleEmitter thruster;
  
  Ship(float x, float y, float m){
    super(x,y,m);
    thruster = new ParticleEmitter();
    InitShape();
  }
  
  void InitShape(){
    shape.add(new PVector(-8,-8));
    shape.add(new PVector(11,0));
    shape.add(new PVector(-8,8));
    copyShape();
  }
  
  void draw(){
    super.draw();
    thruster.draw();
  }
}