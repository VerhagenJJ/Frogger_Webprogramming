// Final assignment  - project
// This program is a remake of the game frogger. You can control your frog using the arrow keys. 
// Reach the top of the screen but don't get run over! Please turn on your sound to hear the sound effects.

// @author Jasmin Verhagen
// 30.10.2020: Created


boolean show_instructions = true;
int time_to_end_instructions;

PImage img; // declare variable

//Initial Global variables
int NumberofCars=2; //how many cars there are

float [] xCoord=new float[NumberofCars];
float [] yCoord=new float[NumberofCars];
float [] xMove=new float[NumberofCars];
float [] yMove=new float[NumberofCars];

int xFrog = width/2;
int yFrog = 480;  //starting point frog

//imports sounds files
import processing.sound.*;
SoundFile gameover;                      
SoundFile jump;

void setup() {
  img = loadImage("Frogger.png");        //loading welcome screen image
  size(400, 500);                       
  time_to_end_instructions = millis() + 5000;

  gameover = new SoundFile(this, "gameover.wav");
  jump = new SoundFile(this, "jump.wav");

  size(400, 500);                       //sets canvas size

  xCoord[0]=10;
  yCoord[1]=10;
  for (int i = 0; i < NumberofCars; i++) {  
    xCoord[i]= random(width);           //placing the cars along the x coordinate
    yCoord[i]= i*250+50;                //placing the cars in a specific spot along the y coordinate
    xMove[i]=random(-4, 5);             //speed of the cars
  }
}

void draw () { 
  if ( show_instructions ) {
    image(img, 0, 0);     
    if (millis() > time_to_end_instructions) {
      show_instructions = false;
    }
    return;
  }
  drawBackground();                     //drawing the background

  //draws the frog
  fill(255, 255, 0);                    //yellow, color of the frog
  ellipse(xFrog+5, yFrog-9, 30, 30);    //head frog
  fill(0);                              //color eyes frog
  ellipse(xFrog-1, yFrog-9, 5, 5);      //eyes frog
  ellipse(xFrog+11, yFrog-9, 5, 5);     //eyes frog
  noStroke();
  noFill();

  //draw the cars at their location 
  for (int i = 0; i < NumberofCars; i++) {
    fill(0, 0, 205);                                 //purple, color roof
    rect(xCoord[i], yCoord[i], 33, 20, 5);           //size and coordinates car roof
    fill(255, 0, 255);                               //pink, color car frames
    rect(xCoord[i]-16, yCoord[i]+16, 66, 26, 5);     //size and coordinates car frames
    fill(0, 0, 0);                                   //black, color wheels
    ellipse(xCoord[i], yCoord[i]+43, 17, 17);        //size and coordinates car wheels
    ellipse(xCoord[i]+33, yCoord[i]+43, 17, 17);     //size and coordinates car wheels

    //moves cars across screen 
    xCoord[i]= xCoord[i] + xMove[i];
    noFill();                                        //let the cars have no stroke
    if (xCoord[i]>width) {
      xCoord[i]=0;
    }
    if (xCoord[i]<0) {
      xCoord[i]=width;
    }

    //hit test 
    if (dist(xFrog, yFrog, xCoord[i], yCoord[i]) < 55) {
      gameover.play();
      xFrog = width/2;
      yFrog = 450;                //Starting place frog at retry
    }
  }
}

void drawBackground() {
  background(124, 252, 0);        //background color

  //start line
  fill(255, 0, 255);              //pink, color start line
  rect(0, 460, 400, 50);          //size start line
  fill(255, 255, 0);              //yellow, text color
  text("Start", 185, 485);        //text alignment
  textSize(15);                   //size text

  //roads
  fill(131, 139, 131);            //road color
  stroke(255, 255, 255); 
  strokeWeight(2);

  //road size and place
  rect(-2, 50, 402, 50);          
  rect(-2, 300, 402, 50);        

  //stripes road 1
  fill(255, 255, 255);            //white, stripe color

  //size and alignment stripes
  rect(25, 75, 40, 3);            
  rect(100, 75, 40, 3);
  rect(175, 75, 40, 3);
  rect(250, 75, 40, 3);
  rect(325, 75, 40, 3);

  //stripes road 2
  fill(255, 255, 255);             //white, stripe color

  //size and alignment stripes
  rect(25, 325, 40, 3);            
  rect(100, 325, 40, 3);
  rect(175, 325, 40, 3);
  rect(325, 325, 40, 3);
  rect(250, 325, 40, 3);

  //Water
  noStroke();
  fill(135, 206, 235);             //water color
  rect(0, 190, 400, 80);           // water size
}

//controlkeys moving the frog
void keyPressed() {

  {
    if (key == CODED) {
      if (keyCode == UP)           //when key is pressed the frog moves up
      {
        yFrog-=25;                 //moves 25 pixels up
        jump.play();               //when key is pressed plays sound
      } else if (keyCode == DOWN)  //when key is pressed the frog moves down
      {
        yFrog+=25;
        jump.play();
      } else if (keyCode == RIGHT) //when key is pressed the frog moves right
      {
        xFrog+=25; 
        jump.play();
      } else if (keyCode == LEFT)  //when key is pressed the frog moves left
      {
        xFrog-=25; 
        jump.play();
      }
    }
  }
}

// When mouse is pressed welcome screen/instructions appears
void mousePressed() {
  show_instructions = true;
  time_to_end_instructions = millis() + 5000; //5 seconds
}
