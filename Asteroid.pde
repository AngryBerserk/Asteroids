class Asteroid extends Mover{
  float di = TWO_PI/20;
  float t = random(1000);
  float NOISE_LEVEL = 20;
  float aspeed = 2;
  int asize = 5;
  
 Asteroid(float x, float y, int generation, PVector sp){
   super(x,y, 1000);
   asize = generation;
   if (sp == null)
     speed = PVector.random2D().mult(aspeed);
     else
     speed =sp;
   angularVelocity = random(0.01,0.05);
   InitShape();
 }
 
 void InitShape(){
    for (float i = 0; i < TWO_PI - (di); i+=di){
      float u = noise(i+t)*NOISE_LEVEL;
      float x = (u+(asize*2))*cos(i);
      float y = (u+(asize*2))*sin(i);
      shape.add(new PVector(x,y));
    }
    float u = noise(0 +t)*NOISE_LEVEL;
    float x = (u+(asize*2))*cos(TWO_PI - di );
    float y = (u+(asize*2))*sin(TWO_PI - di );
    shape.add(new PVector(x,y));
    copyShape();
  }
}