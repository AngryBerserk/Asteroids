class Particle{
  boolean isEnabled = true;
  int ttl = 255;
  PVector location;
  PVector speed;
  PVector acceleration;
  float mass;
  float size = 20;
  float angle;
  float angularAcceleration;
  float angularVelocity;
  float maxspeed = 20;
  ArrayList<PVector> shape = new ArrayList<PVector>();
  
  Particle(float x, float y){
    location = new PVector(x,y);
    speed = new PVector();
    mass = 1;
    acceleration = new PVector();
    InitShape();
  }
  
  void InitShape(){
    shape.add(new PVector(0,0));
  }
  
  void applyForce(PVector force) {
    PVector f = force.copy().div(mass);
    acceleration.add(f.div(mass));
  }
  
  void move(){
    speed.add(acceleration);
    location.add(speed.limit(maxspeed));
    angularVelocity += angularAcceleration;
    angularAcceleration = 0;
    angle += angularVelocity;
    acceleration.mult(0);
    ttl--;
    isEnabled = ttl>0; 
  }
  
  void draw() {
    fill(255);
    stroke(255);
    pushMatrix();
    translate(location.x, location.y);
    rotate(angle);
    noFill();
    point(0,0);
    //if (shape.size()>0){
    //  noFill();
    //  beginShape();
    //  for (int i = 0; i < shape.size(); i++){
    //    PVector s = shape.get(i);
    //    vertex(s.x, s.y);
    //  }
    //  endShape(CLOSE);
    //}
    popMatrix();
  }
}