/* 
Name: Darius Vanagevicius Student Number: 20103104 Programme Name: Information Technology Level 7 - Programming Concepts
Description of the animation: Ball with interactable physics (bounching, gravity and friction) ball can be dragged with left click and thrown with velocity, right click teleports ball to mouse location and can also be thrown. console has text detailing ball movement statistics
Known bugs/problems: none (at current variable settings)

NOTE!!!!   -   MAKE SURE TO HAVE "arUP.png" IN THE SAME FOLDER AS "physics.pde"

*/


float x;  // ball x locations
float y; //bal y location
float vX=0; //ball 1 X velocity
float vY=0; //ball 1 Y velocity
float gravPer=9.81/60;  //permenant gravity - divided by framerate
float grav=gravPer;  //gravity temp

float vel=0;   //velocity of ball in a direction A

float tutTime=120;   //tutorial time 2 seconds

int yForceOld=0;   //mouse y old pos
int yForceNew=0;   //mouse y new pos
int yForceChanged=0;   //mouse y movement between frame

int xForceOld=0;   //mouse x old pos
int xForceNew=0;   //mouse x new pos
int xForceChanged=0;   //mouse x movement between frame

float highScoreTemp=0;
float highScore=0;

float oneTime=0;

String outBounds = "Ball is in Space";

PImage arrow;

void setup() {
  size(1200,600);
  x=width/2;
  y=height/8;
  arrow = loadImage("arUP.png");
}

void draw() {
  background(254);
  
  yForceOld=yForceNew;
  yForceNew=mouseY;
  yForceChanged=yForceNew-yForceOld;  //gets mouse differeance on y coor
  
  xForceOld=xForceNew;
  xForceNew=mouseX;
  xForceChanged=xForceNew-xForceOld;  //gets mouse differeance on x coor
  
  if(mousePressed==true&&mouseButton==RIGHT) { //instantly teleports ball to mouse
  x=mouseX;
  y=mouseY;  //ball is move to mouse location
  vY=0;
  vX=0;    //all velocity is removed
  
  tutTime--;  //reduce turorial text time
  
  vY=vY-yForceChanged;   //applies mouse differnace to y velociy
  vX=vX-xForceChanged;   //applies mouse differnace to x velociy
  
  grav=0;
  } else { grav=gravPer; }
  
  if(y-100<=mouseY&&mouseY<=y+100  &&  x-100<=mouseX&&mouseX<=x+100  &&   mousePressed==true&&mouseButton==LEFT) {   //detect mouse in and around ball at radius 100
  vY=0;
  vX=0;
  
  tutTime--;  //reduce turorial text time
  
  vY=vY-yForceChanged;   //applies mouse differnace to y velociy
  vX=vX-xForceChanged;   //applies mouse differnace to x velociy
  
  x=mouseX;
  y=mouseY;
  grav=0;
  } else { grav=gravPer; }
   
  if(y>=height-30) {   //ground collision check for circle 1
    vY=vY*0.66;        //energy loss upon impact
    vY=-vY;           //bounce
    y=height-30;       //ball not pass floor
    
    if(vX<0) {
      vX=vX+0.09;   //ball sliding on gravity horizontal energy loss
    } else { vX=vX-0.09; }
    
    if(abs(vX)<=0.1) {
      vX=0;      //make ball stop if ball slows down to a certain threshold 
    }
    
    if(abs(vY)<=1) {
      vY=0;          //have ball make no veritcal movement under a certain threshold
    }
  grav=0;
  } else {
    grav=gravPer;  //return gravity when no collision
  }

  
    if(x>=width-30) {   //right wall collision check for circle 1
    vX=vX*0.85;        //energy loss upon impact
    vX=-vX;           //bounce
    x=width-30;       //ball not pass wall
    
    }
    
    if(x<=30) {   //left wall collision check for circle 1
    vX=vX*0.75;        //energy loss upon impact
    vX=-vX;           //bounce
    x=30;       //ball not pass wall
    
    }
    
  vY=vY-grav*2; //gravity effect on ball's velocity multiplyed by weight
  y=y-vY;    // end; poistion change
  x=x-vX;
  
  
  fill(255,80,80);
  ellipse(x,y,50,50);
  
  
  if(tutTime>=0) {     //creates tutorial text until tutorial time variable hits 0
   textSize((width/height)*20);
   fill(0);
   text("Hold LEFT mouse button to move ball with cursor.",width/3.5,height/12);
   text("Hold RIGHT mouse button to teleport ball to cursor.",width/3.5,height/7);
  }
  
  
  if(y+50<0) {
  textSize((width/height)*20);  // add text to warn user if ball is out of bounds
  fill(202,45,45);
  text(outBounds,50,50);
  
  if(highScoreTemp<-y) {
    highScoreTemp=-y;
    highScore=round(-y/200);
  }
  
  textSize((width/height)*12);
  text(-round(y/200) +" meter(s) in the sky",50,80); // tell user distance of ball above the screen with arrow
  image(arrow,x-27.5,100,(width/height)*30,(width/height)*35);
  
  textSize((width/height)*12);
  text(highScore +" meter(s) highscore",50,100); // tell user highest reached vertical height of ball
  }
  
  if(abs(vX)>0 || abs(vY)>0) {
  vel=(sqrt(sq(abs(vX)))+(sq(abs(vY))));   // gets velocity of ball in any direction
   if(vel>0.01) {
     if(vel<5 && vel>0) {
     println("current veloctiy is around or under 5/s " + vel);
     } else if(vel<10 && vel>5) {
     println("current veloctiy is around or under 10/s " + vel);
     } else if(vel<15 && vel>10) {
     println("current veloctiy is around or under 15/s " + vel);
     } else if(vel>15) {
     println("current veloctiy is around or over 15m/s " + vel);
     }
     oneTime=0;
   }
  } else if(oneTime==0) {  //prints "ball is not moving" once until the ball moves and oneTime variable gets reset to 0
    println("");
    println("ball is not moving");
    oneTime=1;
  }
  
   if(vY<0){
   println("ball is moving down  " + abs(vY));  //lists raw speed of ball moving down
   } 
   else if(vY>0) {
   println("ball is moving up    " + vY);  //lists raw speed of ball moving up
   }
   
   if(vX<0) {
   println("ball is moving right " + abs(vX));  //lists raw speed of ball moving right
   } 
   else if(vX>0) {
   println("ball is moving left  " + vX);  //lists raw speed of ball moving left
   }
}
