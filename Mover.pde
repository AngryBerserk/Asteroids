abstract class Mover {
  boolean isEnabled = true;
  boolean isHitTest = true;
  PVector location;
  PVector speed;
  PVector acceleration;
  float mass;
  float size = 20;
  float angle;
  float angularAcceleration;
  float angularVelocity;
  float maxspeed = 20;
  int collisionImmuneTimer = 30;
  ArrayList<PVector> shape = new ArrayList<PVector>();
  ArrayList<PVector> worldShape = new ArrayList<PVector>();

  Mover(float x, float y, float m) {
    location = new PVector(x,y);
    speed = new PVector(0,0);
    acceleration = new PVector();
    mass = m;
  }
  
  boolean Intersects(Mover s1){
    for (int i = 0; i<worldShape.size(); i++)
      if (IsIntersect(s1.worldShape, worldShape.get(i))){
        return true;
      }
    return false;
  }
  
  float getMult(PVector v1, PVector v0, PVector dest){
    PVector v = v1.copy().add(-v0.x,-v0.y);
    PVector vd = dest.copy().add(-v0.x,-v0.y);
    float x = modelX(v.x,v.y,0);
    float y = modelY(v.x,v.y,0);
    PVector v_ = new PVector(x,y);
    float xd = modelX(vd.x,vd.y,0);
    float yd = modelY(vd.x,vd.y,0);
    PVector vd_ = new PVector(xd,yd);
    float res = v_.cross(vd_).z;
    return res;
  }

  boolean IsIntersect(ArrayList<PVector> s, PVector dest){
    float z = Float.MAX_VALUE;
    for (int i = 1; i < s.size(); i++){
      float res = getMult(s.get(i), s.get(i-1), dest);
      if (z != Float.MAX_VALUE)
        if (Math.signum(res)!=Math.signum(z))
          return false;
      z = res;
    }
    //last one
    float res = getMult(s.get(0), s.get(s.size()-1), dest);
    if (Math.signum(res)!=Math.signum(z))
      return false;
    return true;
  }
  
  abstract void InitShape();
  
  void copyShape(){
   for (PVector v : shape) 
    worldShape.add(v);
  }

  void applyForce(PVector force) {
    PVector f = force.copy().div(mass);
    acceleration.add(f.div(mass));
  }
  
  void checkEdges(){
      if (location.x < 0){
         location.x = width; 
      }else
      if (location.x > width){
         location.x = 0;
      }
      if (location.y < 0){
         location.y = height; 
      }else
      if (location.y > height){
         location.y = 0;
      }
  }
  
  void move(){
    if (collisionImmuneTimer>0)
      collisionImmuneTimer--;
    speed.add(acceleration);
    location.add(speed.limit(maxspeed));
    angularVelocity += angularAcceleration;
    angularAcceleration = 0;
    angle += angularVelocity;
    acceleration.mult(0);
    checkEdges();
  }

  void draw() {
    fill(255);
    stroke(255);
    pushMatrix();
    translate(location.x, location.y);
    rotate(angle);
    if (shape.size()>0){
      noFill();
      beginShape();
      for (int i = 0; i < shape.size(); i++){
        PVector s = shape.get(i);
        vertex(s.x, s.y);
        worldShape.set(i,new PVector(modelX(s.x,s.y,s.z), modelY(s.x,s.y,s.z)));
      }
      endShape(CLOSE);
    }
    popMatrix();
  }
}