class ParticleEmitter{
  ArrayList<Particle> particles = new ArrayList<Particle>();
  float t = 10;
    
  void spawn(float x, float y, PVector direction, float speed){
    if (t<=0){
      Particle p = new Particle(x,y);
      p.speed = direction.mult(speed);
      p.location.add(p.speed.copy().mult(4));
      particles.add(p);
      t = 10;
    }
    t -= speed;
  }
  
  void draw(){ 
    pushMatrix();
    //scale(1,-1);
    for(Particle p:particles){
      p.move(); 
      p.draw();
    }
    popMatrix();
    cleanup();
  }
  
  void cleanup(){
     for (int i = particles.size()-1; i>0;i--){
       Particle p = particles.get(i);
       if (!p.isEnabled)
         particles.remove(p);
     }
  }
}