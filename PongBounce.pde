//Nimun Bajwa
//Jan 29th 2019
//Pong Game using Processing
//Guidance/Information from: https://www.youtube.com/watch?v=SsZmuEEHcbU
import ddf.minim.*; //

Minim minim;//
AudioPlayer ding;//



int x, y, w, h, speedX, speedY;
int paddleXL, paddleYL, paddleW, paddleH, paddleS;
int paddleXR, paddleYR;
boolean upL, downL;
boolean upR, downR;

color colorL = color(234, 68, 126);
color colorR = color(229, 122, 41);

int scoreL = 0;
int scoreR = 0;

int winScore = 10;

void setup() {
  size(500,500);
  
  x=width/2;
  y=height/2;
  w=50;
  h=50;
  speedX=3;
  speedY=2;
  
  textSize(22);
  textAlign(CENTER, CENTER);
  
  rectMode(CENTER);
  paddleXL=40;
  paddleYL=height/2;
  
  paddleXR=width-40;
  paddleYR=height/2;
  
  paddleW=30;
  paddleH=100;
  paddleS=5;
  
  minim = new Minim(this); //
  ding = minim.loadFile("ding.wav", 2048); //
  
}

void draw(){
  background(0);
  
  drawCircle(); 
  moveCircle();
  bounceOff();
  
  drawPaddles();
  movePaddles();
  restrictPaddles();
  contactPaddles();
  
  scores();
  gameOver();
  
}

void drawPaddles(){
  fill (colorL);
  rect(paddleXL, paddleYL, paddleW, paddleH);
  fill (colorR);
  rect(paddleXR, paddleYR, paddleW, paddleH);
}

void movePaddles(){
  if(upL){ // can do upL=true OR just upL, same thing
    paddleYL = paddleYL - paddleS;
  }
  if(downL){ // can do downL=true OR just downL, same thing
    paddleYL = paddleYL + paddleS;
  }
  if(upR){ // can do upR =true OR just upL, same thing
    paddleYR = paddleYR - paddleS;
  }
  if(downR){ // can do downR=true OR just downL, same thing
    paddleYR = paddleYR + paddleS;
  }
}

void restrictPaddles() {
  if(paddleYL - paddleH/2 <0 ){
    paddleYL = paddleYL+paddleS;
  }
  if(paddleYL + paddleH/2 >height ){
    paddleYL = paddleYL-paddleS;
  }
  if(paddleYR - paddleH/2 <0 ){
    paddleYR = paddleYR+paddleS;
  }
  if(paddleYR + paddleH/2 >height ){
    paddleYR = paddleYR-paddleS;
  }
}

void contactPaddles() {
  if(x-w/2 < paddleXL + paddleW/2 && y-h/2 < paddleYL + paddleH/2 && y+h/2 > paddleYL - paddleH/2){
    if (speedX < 0){
      speedX = -speedX;
    }
  }
  
  else if(x+w/2 > paddleXR - paddleW/2 && y-h/2 < paddleYR + paddleH/2 && y+h/2 > paddleYR - paddleH/2){
    if (speedX > 0){
      speedX = -speedX;
    }
  }
}

void drawCircle() {
  fill(95, 232, 143);
  ellipse(x, y, w, h);
}

void moveCircle(){
    x = x + speedX;
    y = y + speedY;
}

void bounceOff(){
    
   if (x>width - w/2){
      setup();
      speedX = -speedX;
      scoreL = scoreL +1;
      ding.play();//
  }
  
  else if (x<0 + w/2) { 
    setup();
    scoreR = scoreR +1;
    ding.play();//
  }
  
  
  if (y>height - h/2){
    speedY = -speedY;
  }
  
  else if (y<0 + h/2) {
    speedY = -speedY;
  }
}

void scores() {
  fill(255);
  text(scoreL, 100, 50);
  text(scoreR, width-100, 50);
}

void gameOver() {
  if (scoreL == winScore) {
    gameOverPage("Pink Wins!", colorL);
  }
  if (scoreR == winScore) {
    gameOverPage("Orange Wins!", colorR);
    
  }
}

void gameOverPage(String text, color c) { //you can say anything instead of text or c
  speedX = 0;
  speedY = 0;
  
  fill(255);
  text("GAME OVER", width/2, height/3 - 40);
  text("Click to play again", width/2, height/3 + 40);
  fill(c);
  text(text, width/2, height/3);
  
  if(mousePressed) {
    scoreR = 0;
    scoreL = 0;
    speedX=3;
    speedY=2;
  }
}
void keyPressed(){
  if (key =='w' || key == 'W'){
    upL=true;
  }
  if (key =='s' || key == 'S'){
    downL=true;
  }
  if (keyCode == UP){
    upR=true;
  }
  if (keyCode == DOWN){
    downR=true;
  }
}

void keyReleased(){
  if (key =='w' || key == 'W'){
    upL=false;
  }
  if (key =='s' || key == 'S'){
    downL=false;
  }
  if (keyCode == UP){
    upR=false;
  }
  if (keyCode == DOWN){
    downR=false;
  }
}
