//THINGS TO ADD: fire at one ship, destroy all ships on screen, explosion sound

import processing.sound.*;
SoundFile file;

//GLOBAL VARIABLES
int enterx, entery, phaserx, phasery;
int score;
float spherex, spherey;
boolean up, down, left, right, start, explode, fire, firing;
Star[] shapes;
int numStars = 200;

Borg[] ships;
int numBorg = 10;

Sphere[] spheres;
int numSpheres = 1;

void setup(){
  size(700,500);
  background(0);
  enterx = 150;
  entery = 200;
  phaserx = enterx;
  phasery = entery;
  score = 0;
  
  shapes = new Star[numStars];
  for (int i = 0; i < shapes.length; i++) {
    shapes[i] = new Star(true);
    shapes[i] = new Star();
    shapes[i] = new Star(color(random(160,255), random(230,255), 255, random(100,255)));
  }
  
  ships = new Borg[numBorg];
  for(int i = 0; i < ships.length; i++){
   ships[i] = new Borg(true);
  }
  
  spheres = new Sphere[numSpheres];
  for(int i = 0; i < spheres.length; i++){
   spheres[i] = new Sphere();
  }
  
  file = new SoundFile(this, "Star_Trek_Theme.mp3");
  file.loop();
}

void draw(){
  background(0);
  
  for (int i = 0; i < shapes.length; i++){
    shapes[i].display();
    shapes[i].move();
    shapes[i].stopping();
    shapes[i].starting();
  }
  
  for (int i = 0; i < ships.length; i++){
   ships[i].display();
   ships[i].move();
  }
  
  for(int i = 0; i < spheres.length; i++){
   spheres[i].display();
   spheres[i].move();
   spheres[i].startstop();
   spheres[i].explode();
  }
  if(fire == true){
    firing = true;
  
  }if(firing == true){
    fill(255, 59, 0);
    rect(phaserx, phasery, 15, 5);
    phaserx += 9;
    if(phaserx >= spherex-10 && phaserx <= spherex+10 && phasery >= spherey-10 && phasery <= spherey +10){
      phaserx = enterx;
      phasery = entery;
      firing = false;
    } else if(phaserx > width){
      phaserx = enterx;
      phasery = entery;
      firing = false;
    }
  }
  fill(255);
  textSize(20);
  text(score, 300, 20);
  
  //Enterprise
  fill(150);
  noStroke();
  ellipse(enterx, entery, 80, 20);
  quad(enterx-40, entery+30, enterx-30, entery+5, enterx-20, entery+7, enterx-30, entery+30);
  ellipse(enterx-45, entery+30, 38, 10);
  ellipse(enterx-68, entery+10, 30, 5);
  rect(enterx-63, entery+10, 7, 20);
  
  //enterprise
  if(up == true){
   entery -= 5; 
  } else if (down == true){
   entery += 5; 
  } 

  for (int i = 0; i < ships.length; i++){
    ships[i].explode();
    ships[i].stopping();
    ships[i].starting();
  }
  
  if(start == true){
   explode = false;
   entery = 200; 
  }
}

class Star{
  //Attributes
  float size;
  float speed;
  float xpos, ypos;
  color colour;
  
  // DEFAULT Constructor
  Star() {
   size = 5;
   speed = random(2,8);
   xpos = random(-width,width);
   ypos = random(-height,height);
   colour = 255;   
  }
  //CUSTOM constructor
  Star(color custom_colour){
   size = 5;
   speed = random(2,8);
   xpos = random(-width,width);
   ypos = random(-height,height);
   colour = custom_colour;
  }
  
  Star(boolean random){
   if(random){
     size = int(random(2,7));
     speed = random(2, 10);
     xpos = random(-width,width);
     ypos = random(-height,height);
     colour = color(255, random(144,180), random(0,70), random(100,255));
   }
   else{
    size = 5;
    speed = random(2,8);
    xpos = random(-width, width);
    ypos = random(-height,height);
    colour = 255;
   }
  }
  
  //Functions
  void display(){
   fill(colour);
   ellipse(xpos, ypos, size, size); 
  }
  
  void move(){
    xpos -= speed;
    if (xpos < -width){
      xpos = width;
      ypos = random(-height, height);
    }
  }
  
  void stopping(){
   if(explode == true){
    speed = 0; 
   } 
  }
  
  void starting(){
   if(start == true){
     speed = random(2,8); 
   }
  }
}

class Borg{
  //Attributes
  float size;
  float xpos, ypos;
  float speed;
  color colour;
  
  // DEFAULT Constructor
  Borg() {
   size = 30;
   xpos = random(-width,width);
   ypos = random(-height,height);
   speed = 3.0;
   colour = color(0,76,1);   
  }
  //CUSTOM constructor
  Borg(boolean random){
   if(random){
     size = int(random(20,40));
     xpos = random(-width,width);
     ypos = random(-height,height);
     speed = random(2,5);
     colour = color(0,76,1, random(150,255));
   }
   else{
    size = 30;
    xpos = random(-width,width);
    ypos = random(-height,height);
    speed = 3.0;
    colour = color(0,76,1);
   }
  }
  
  //Functions
  void move(){
    xpos -= speed;
    if (xpos < 0){
      xpos = width;
      ypos = random(-height, height);
    }
  }
  
  void display(){
   fill(colour);
   rect(xpos, ypos, size, size); 
  }
  
  void explode(){
   if(enterx >= xpos && enterx <= xpos+size && entery >= ypos && entery <= ypos+size){
    speed = 0;
    explode = true;
    //explosion shapes
    fill(255,113,25);
    triangle(150,entery, 160,entery-25, 170,entery);
    triangle(150,entery+10, 160,entery+35, 170,entery+10);
    triangle(160,entery-5, 190, entery-15, 180, entery+10);
    triangle(160,entery+15, 190,entery+30, 175,entery);
    triangle(160,entery-5, 130, entery-15, 140, entery+10);
    triangle(160,entery+15, 130, entery+30, 140, entery);
    rect(140, entery, 40, 10);
    
    fill(255);
    textSize(30);
    text("GAME OVER", 250, 100);
    textSize(15);
    text("Press shift to play again", 250, 125);
   }
  }
  
  void stopping(){
   if(explode == true){
    speed = 0; 
   }
  }
  
  void starting(){
   if(start == true){
    speed = random(2,5); 
   }
  }
}

class Sphere{
 float size, speed, startx;
 
 Sphere(){
  size = 40;
  speed = 2.0;
  startx = width*3;
  spherex = startx;
  spherey = random(0,height);
 }
 
 void display(){
  fill(0,76,1);
  ellipse(spherex, spherey, size, size); 
  if(spherex >= 0 && spherex <= width){
   fill(255);
    textSize(13);
   text("Press z to fire at the sphere", 250, 450);
  }
 }
 
 void move(){
  spherex -= speed; 
  if(phaserx > spherex-10 && phaserx < spherex+10 && phasery > spherey-10 && phasery < spherey+10){
    fill(255,113,25);
    triangle(spherex,spherey, spherex+10,spherey-25, spherex+20,spherey);
    triangle(spherex,spherey+10, spherex+10,spherey+35, spherex+20,spherey+10);
    triangle(spherex+10,spherey-5, spherex+40, spherey-15, spherex+30, spherey+10);
    triangle(spherex+10,spherey+15, spherex+40,spherey+30, spherex+25,spherey);
    triangle(spherex+10,spherey-5, spherex-20, spherey-15, spherex-10, spherey+10);
    triangle(spherex+10,spherey+15, spherex-20, spherey+30, spherex-10, spherey);
    rect(spherex-10, spherey, 40, 10);
    spherex = startx;
    spherey = random(0, height);
    score += 1;
  } else if(spherex < 0){
    spherex = startx;
    spherey = random(0,height);
  }
 }
 
 void startstop(){
   if(explode == true){
    speed = 0; 
   } 
   if(start == true){
     speed = 2.0;
   }
 }
 
 void explode(){
   if(enterx >= spherex && enterx <= spherex+size && entery >= spherey && entery <= spherey+size){
    speed = 0;
    explode = true;
    //explosion shapes
    fill(255,113,25);
    triangle(150,entery, 160,entery-25, 170,entery);
    triangle(150,entery+10, 160,entery+35, 170,entery+10);
    triangle(160,entery-5, 190, entery-15, 180, entery+10);
    triangle(160,entery+15, 190,entery+30, 175,entery);
    triangle(160,entery-5, 130, entery-15, 140, entery+10);
    triangle(160,entery+15, 130, entery+30, 140, entery);
    rect(140, entery, 40, 10);
    
    fill(255);
    textSize(30);
    text("GAME OVER", 150, 100);
    textSize(15);
    text("Press shift to play again", 150, 125);
   }
  }
}

void keyPressed(){
 if(key == CODED){
  if(keyCode == UP){
    up = true;
  } if(keyCode == DOWN){
   down = true; 
  } if(keyCode == SHIFT){
    start = true;
  }}
 else if(key == 'a'){
   left = true; 
 } else if(key == 'd'){
   right = true; 
 } else if(key == 'z'){
   fire = true;
 }
}

void keyReleased(){
 if(key == CODED){
  if(keyCode == UP){
   up = false; 
  } if(keyCode == DOWN){
   down = false;
  } if(keyCode == SHIFT){
    start = false;
  }}
  else if(key == 'a'){
   left = false;
  } else if(key == 'd'){
   right = false; 
  } else if(key == 'z'){
    fire = false;
  }
 }
