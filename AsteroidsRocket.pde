Ship ship;
ArrayList<Mover> projectives = new ArrayList<Mover>();
ArrayList<Mover> toAdd = new ArrayList<Mover>();
PGraphics background;
char k;

void setup(){
  size(800,600, P3D);
  //fullScreen(P3D);
  InitBackground();
  ship = new Ship(width/2, height/2, 10);
  textSize(32);
  textAlign(CENTER);
  restart();
}

void InitBackground(){
  background = createGraphics(width,height);
  background.beginDraw();
  background.background(0,0,0);
  background.loadPixels();
  for (int i = 0; i < 100; i++)
    background.pixels[floor(random(background.pixels.length))] = color(255,255,255);
  background.updatePixels();
  background.endDraw();
}

void mousePressed(){
  Bullet bullet = new Bullet(ship.location.x, ship.location.y, ship.angle);
  projectives.add(bullet);
}

void spawnExplosion(Mover o, int count){
  for (int i = 0; i<count; i++){
     Decal decal = new Decal(o.location.x, o.location.y, random(TWO_PI));
     toAdd.add(decal);
  }
}

void explodeShip(){
  ship.isEnabled = false;
  spawnExplosion(ship,100);
}

void spawnAsteroids(int count){
  for (int i = 0; i<count;i++){
    Asteroid a = new Asteroid(random(width), random(height), 5, null);
    projectives.add(a);  
  }
}

void collapseAsteroid(Asteroid a){
  if (a.asize > 1){
    Asteroid p1 = new Asteroid(a.location.x, a.location.y, a.asize-2, a.speed.copy().rotate(PI/4).mult(1.1));
    Asteroid p2 = new Asteroid(a.location.x, a.location.y, a.asize-2, a.speed.copy().rotate(-PI/4).mult(1.1));
    toAdd.add(p1);
    toAdd.add(p2);
  }
  spawnExplosion(a,50);
}

void keyPressed(){
  if (key == CODED){
    //if (keyCode == LEFT){
    //  k='l';
    //}
    //if (keyCode == RIGHT){
    //  k='r';
    //}
    if (keyCode == UP){
      k='u';
    }
  }
  else{
    if (key == ' ' && !ship.isEnabled)
      restart();
  }
}

void keyReleased(){
  if (key == CODED){
    if (//keyCode == LEFT || keyCode == RIGHT || 
    keyCode == UP){
      k=' ';
    }
  }
}

void restart(){
 ship.isEnabled = true;
 projectives.clear();
 spawnAsteroids(1); 
}


void draw(){
  if (keyPressed){
    //if (k=='l')
    //    ship.angle -= 0.25;
    //if (k=='r')
    //    ship.angle += 0.25;
    if (k == 'u'){
        float x = 2 * cos(ship.angle);
        float y = 2 * sin(ship.angle);
        ship.applyForce(new PVector(x,y));
        ship.thruster.spawn(ship.location.x, ship.location.y, ship.acceleration.copy().mult(-50), ship.speed.mag());
      }
   }
  image(background,0,0);
  if (ship.isEnabled){
    ship.angle = new PVector(mouseX - ship.location.x, mouseY - ship.location.y).heading();
    ship.move();
    ship.draw();
  }
  else{
    text("GAME OVER. Press `space` to restart", width/2, height/2); 
  }
  for(Mover b : projectives){
      b.move();
      b.draw();
      //Check collisions:
      //With ship
      if (b.isHitTest && b.collisionImmuneTimer == 0){
      if (ship.isEnabled)
        if (b.Intersects(ship)){
          b.isEnabled = false;
          explodeShip();
        }
      //With other objects
      for(Mover c : projectives){
        if (c!= b && c.isHitTest && c.collisionImmuneTimer == 0 && b.Intersects(c)){
          if (c instanceof Asteroid){
             c.isEnabled = false;
             b.isEnabled = false;
             collapseAsteroid((Asteroid)c);
          }
      }
    }
   }
  }
  cleanup();
}

void cleanup(){
  for (Mover m : toAdd)
    projectives.add(m);
  toAdd.clear();
  for (int i = projectives.size()-1; i >= 0; i--){
    Mover m = projectives.get(i);
    if (!m.isEnabled)
      projectives.remove(m);
  }
}