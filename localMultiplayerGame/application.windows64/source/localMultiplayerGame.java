import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import ddf.minim.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class localMultiplayerGame extends PApplet {

Player player1;
Player player2;

ArrayList<ParticleSpread> particleSpreadList = new ArrayList<ParticleSpread>();
ArrayList<Trail> trailList = new ArrayList<Trail>();

Wall wall11;
Wall wall12;
Wall wall13;

Wall wall21;
Wall wall22;
Wall wall23;

int gameState = 0;
String winner = "hi";

PFont myFont;

//player 1's bullets
float[] player1BulletXList = new float[50];
float[] player1BulletYList = new float[50];
int bulletToUse1 = 0;

//player 2's bullets
float[] player2BulletXList = new float[50];
float[] player2BulletYList = new float[50];
int bulletToUse2 = 0;

float time;

float powerTime;
int powerUp;
int powerSize;
int powerPosX; 
int powerPosY;

public void setup()
{

  size(1000, 600);
  time = millis();
  powerTime = millis();

  myFont = loadFont("Arial.vlw");

  ammo = loadImage("ammo.jpg");
  health = loadImage("health.png");
  wall = loadImage("wall.jpg");
  speed = loadImage("speed.jpg");
  damage = loadImage("damage.jpg");
  shrink = loadImage("shrink.png");

  soundSetup();
  powerPosX = 9999;

  player1 = new Player();
  player2 = new Player();

  wall11 = new Wall();
  wall12 = new Wall();
  wall13 = new Wall();

  wall21 = new Wall();
  wall22 = new Wall();
  wall23 = new Wall();

  player1.Initialize(1, 50, 50, 3);
  player2.Initialize(2, 950, 550, 3);

  //initialize player 1's and player 2's bullets positions off screen
  for (int i = 0; i < player1BulletXList.length; i++)
  {

    player1BulletXList[i] = 9999;
    player1BulletYList[i] = 9999;

    player2BulletXList[i] = -9999;
    player2BulletYList[i] = -9999;
  }
}


public void draw()
{
  //Main Menu
  if (gameState == 0) mainMenu();

  //Rules
  if (gameState == 3) rules();

  //Win Screen
  if (gameState == 2) win();

  //Game Screen
  if (gameState == 1)
  {

    music.play();
    //if 1 second passes, give both sides 1 ammo
    if (millis() - time > 1000)
    {

      time = millis();
      if (player1.ammo < 20)
      {
        player1.ammo++;
      }
      if (player2.ammo < 20)
      {
        player2.ammo++;
      }
    }

    background(0);
    textFont(myFont, 12);

    fill(255);
    rect(500, 0, 2, 600);  

    //Green Side (posX, posY) 
    wall11.makeWall(200, 60);
    wall12.makeWall(350, 260);
    wall13.makeWall(200, 460);
    //Blue Side
    wall21.makeWall(800 - wall21.myWidth, 60);
    wall22.makeWall(650 - wall22.myWidth, 260);
    wall23.makeWall(800 - wall23.myWidth, 460);

    //Player Trails
    trailList.add(new Trail(player1.positionX, player1.positionY, player1.mySize, 200, 0));
    trailList.add(new Trail(player2.positionX, player2.positionY, player2.mySize, 150, 255));
    for (int i = 0; i < trailList.size(); i++) 
    {
      trailList.get(i).Update();
    }

    //(Green,Blue,textXPos)
    player1.Update(200, 0, 15);
    player2.Update(150, 255, 930);

    //Timer and effects of power ups
    randomPowerUps();

    //player1+2's bullets are constantly moving circles
    for (int i = 0; i < player1BulletXList.length; i++)
    {    
      player1BulletXList[i] += 10;
      fill(0, 200, 0);
      ellipse(player1BulletXList[i], player1BulletYList[i], player1.bulletSize, player1.bulletSize);

      player2BulletXList[i] -= 10;
      fill(0, 150, 255);
      ellipse(player2BulletXList[i], player2BulletYList[i], player2.bulletSize, player2.bulletSize);
    }

    //for each bullet
    for (int b = 0; b < player1BulletXList.length; b++)
    {
      //distance + radii of players and bullets
      float distP1BP2 = dist(player1BulletXList[b], player1BulletYList[b], player2.positionX, player2.positionY);
      float distP2BP1 = dist(player2BulletXList[b], player2BulletYList[b], player1.positionX, player1.positionY);

      float radiusP1BP2 = player1.bulletSize / 2 + player2.mySize / 2;
      float radiusP2BP1 = player2.bulletSize / 2 + player1.mySize / 2;


      //if player 1's bullets hit player 2
      if (distP1BP2 < radiusP1BP2)
      {
        player1BulletXList[b] = 9999;
        player1BulletYList[b] = 9999;
        player2.isHit = true;
        player2.hitTimer = 0;
        player2.health -= player1.damage;
        hit.rewind();
        hit.play();
      }

      //if player 2's bullets hit player 1
      if (distP2BP1 < radiusP2BP1)
      {
        player2BulletXList[b] = -9999;
        player2BulletYList[b] = -9999;
        player1.isHit = true;
        player1.hitTimer = 0;
        player1.health -= player2.damage;
        hit.rewind();
        hit.play();
      }
    }

    for (int b = 0; b < player1BulletXList.length; b++)
    {
      for (int c = 0; c < player2BulletXList.length; c++)
      {
        //if player 1's bullets hits player 2's bullet
        float distP1BP2B = dist(player1BulletXList[b], player1BulletYList[b], player2BulletXList[c], player2BulletYList[c]);
        float radiusP1BP2B = (player1.bulletSize + 4) / 2 + (player2.bulletSize + 4) / 2;
        if (distP1BP2B < radiusP1BP2B)
        {
          particleSpreadList.add(new ParticleSpread(player1BulletXList[b], player1BulletYList[b], 255));
          particleSpreadList.add(new ParticleSpread(player2BulletXList[b], player2BulletYList[b], 255));  
          player1BulletYList[b] = 9999;
          player2BulletYList[c] = -9999;        
          hit.rewind();
          hit.play();
        }
      }
    }
    for (int i = 0; i < particleSpreadList.size (); i++) {
      particleSpreadList.get(i).Update();
    }



    //win conditions
    if (player1.health < 1)
    {
      gameState = 2;
      winner = "Blue Team";
      music.pause();
      win.rewind();
      win.play();
    }
    else if (player2.health < 1)
    {
      gameState = 2;
      winner = "Green Team";
      music.pause();
      win.rewind();
      win.play();
    }

    DeleteDeadObjects();
  }
}

public boolean IsMouseTouchingRect (int rx, int ry, int rWidth, int rHeight)
{

  if (mouseX > rx && mouseX < rx + rWidth && mouseY > ry && mouseY < ry + rHeight) //if a point is within the bounds of the rect
  {
    return true;
  }
  else {
    return false;
  }
}

public boolean AreWeColliding(int c1px, int c1py, int c1s, int c2px, int c2py, int c2s)
{

  float distanceBetweenCircles = dist(c1px, c1py, c2px, c2py);
  float halfOfCircleSizes = (c1s + c2s) / 2;

  if (distanceBetweenCircles < halfOfCircleSizes)
  {

    return true;
  }
  else {
    return false;
  }
}

public void mousePressed() 
{

  if (IsMouseTouchingRect(300, 400, 150, 50) && gameState == 0) //press play button
  { 
    setup();    
    gameState = 1;  //Set gamestate to play
    menu.rewind();
    menu.play();
  }

  if (IsMouseTouchingRect(420, 400, 150, 50) && gameState == 3 || IsMouseTouchingRect(420, 400, 150, 50) && gameState == 2) //press main menu button
  {
    gameState = 0; //set gamestate to main menu
    menu.rewind();
    menu.play();
  }

  if (IsMouseTouchingRect(550, 400, 150, 50) && gameState == 0) //press rules button
  {
    gameState = 3; //set gamestate to rules
    menu.rewind();
    menu.play();
  }
}

class Wall
{
  int positionX = 0;
  int positionY = 0;
  int myHeight = 80;
  int myWidth = 10;
  int health = 5;
  boolean alive = true;


  public void makeWall(int tempPositionX, int tempPositionY)
  {
    positionX = tempPositionX;
    positionY = tempPositionY;

    if (health == 5)
    {
      fill(255);
    }
    else if (health == 4)
    {
      fill(200);
    }
    else if (health == 3)
    {
      fill(150);
    }
    else if (health == 2)
    {
      fill(100);
    }
    else if (health == 1)
    {
      fill(50);
    }
    else if (health == 0)
    {
      fill(0);
      alive = false;
    }

    rect(tempPositionX, tempPositionY, myWidth, myHeight);

    for (int b = 0; b < player1BulletXList.length; b++)
    {
      if (alive)
      {
        //if player 1's bullets hit wall
        if (player1BulletXList[b] > positionX - player1.bulletSize/2 && player1BulletXList[b] < positionX + myWidth)
        {
          if (player1BulletYList[b] > positionY && player1BulletYList[b] < positionY + myHeight)
          {
            player1BulletXList[b] = 9999;
            player1BulletYList[b] = 9999;
            health--;
            hit.rewind();
            hit.play();
          }
        }

        //if player 2's bullets hit wall
        if (player2BulletXList[b] > positionX && player2BulletXList[b] < positionX + myWidth + player2.bulletSize/2)
        {
          if (player2BulletYList[b] > positionY && player2BulletYList[b] < positionY + myHeight)
          {
            player2BulletXList[b] = 9999;
            player2BulletYList[b] = 9999;
            health--;
            hit.rewind();
            hit.play();
          }
        }
      }
    }
  }
}

public void keyPressed()
{
  //player 1 shoot
  if (key == 'f' && player1.ammo > 0)
  {
    player1BulletXList[bulletToUse1] = player1.positionX;
    player1BulletYList[bulletToUse1] = player1.positionY;  
    bulletToUse1++;
    player1.ammo--;
    shoot.rewind();
    shoot.play();

    if (bulletToUse1 >= player1BulletXList.length)
    {
      bulletToUse1 = 0;
    }
  }

  //player 2 shoot
  if (key == '0' && player2.ammo > 0)
  {
    player2BulletXList[bulletToUse2] = player2.positionX;
    player2BulletYList[bulletToUse2] = player2.positionY;  
    bulletToUse2++;
    player2.ammo--;
    shoot.rewind();
    shoot.play();
    
    if (bulletToUse2 >= player2BulletXList.length)
    {
      bulletToUse2 = 0;
    }
  }

  if (key == ' ' && gameState == 1)
  {
    gameState = 0;
    music.pause();
    music.rewind();
  }

  if (key == 'w')
  {
    player1.mu = true;
  }

  if (key == 's')
  {
    player1.md = true;
  }

  if (key == 'a')
  {
    player1.ml = true;
  }

  if (key == 'd')
  {
    player1.mr = true;
  }

  if (keyCode == UP) player2.mu = true;
  if (keyCode == DOWN) player2.md = true;
  if (keyCode == LEFT) player2.ml = true;
  if (keyCode == RIGHT) player2.mr = true;
}

public void keyReleased()
{

  if (key == 'w')
  {
    player1.mu = false;
    
  }

  if (key == 's')
  {
    player1.md = false;
  }

  if (key == 'a')
  {
    player1.ml = false;
  }

  if (key == 'd')
  {
    player1.mr = false;
  }

  if (keyCode == UP) player2.mu = false;
  if (keyCode == DOWN) player2.md = false;
  if (keyCode == LEFT) player2.ml = false;
  if (keyCode == RIGHT) player2.mr = false;
}

public void mainMenu()
{

  background(0);

  fill(255);
  textFont(myFont, 48);
  text("The Best Game 2: The Second Game", 100, 250); 

  if (IsMouseTouchingRect(300, 400, 150, 50)) //rect 1 values
  {

    fill(255, 0, 0);
  }
  else {
    fill(255);
  }

  rect(300, 400, 150, 50); //rect 1
  fill(0);
  textFont(myFont, 24);
  text("Play", 350, 435); 

  if (IsMouseTouchingRect(550, 400, 150, 50)) //rect 2 values
  {
    fill(255, 0, 0);
  }
  else {
    fill(255);
  }

  rect(550, 400, 150, 50); //rect 2
  fill(0);
  textFont(myFont, 24);
  text("Rules", 595, 435);
}

public void rules()
{

  background(0);

  fill(255);
  textFont(myFont, 48);
  text("Rules", 425, 100);
  textFont(myFont, 24);
  text("Reduce the opposing player's heath to 0 to win", 60, 150);
  text("Walls can block bullets but will be destroyed after 5 hits", 60, 175);
  text("Ammo starts at 5, regenerates every second and soft caps at 20", 60, 200);
  text("Health starts at 15 and is capped at 30", 60, 225);
  
  text("Power Ups spawn in the center of the arena every 5 seconds", 60, 275);
  text("Health +5, Ammo +10, Speed +1, Shrink -5, Damage +1, Wall Repair", 60, 300);
  
  
  text("Player 1 Moves with WASD and shoots with F", 60, 350);
  text("Player 2 Moves with arrow keys and shoots with 0", 60, 375);

  if (IsMouseTouchingRect(420, 400, 150, 50)) //rect 1 values
  {

    fill(255, 0, 0);
  }
  else {
    fill(255);
  }

  rect(420, 400, 150, 50); //rect 1
  fill(0);
  textFont(myFont, 24);
  text("Main Menu", 437, 435);
}

public void win()
{

  background(0);

  fill(255);
  textFont(myFont, 48);
  text(winner + " Wins!", 320, 100);
  textFont(myFont, 24);
  text("", 60, 275);
  
  

  if (IsMouseTouchingRect(420, 400, 150, 50)) //rect 1 values
  {

    fill(255, 0, 0);
  }
  else {
    fill(255);
  }

  rect(420, 400, 150, 50); //rect 1
  fill(0);
  textFont(myFont, 24);
  text("Main Menu", 437, 435);
}

class ParticleSpread{
  
  PVector startingPos = new PVector(0, 0);
  
  PVector movePerTurn1 = new PVector(1, 1);
  PVector movePerTurn2 = new PVector(-1, 1);
  PVector movePerTurn3 = new PVector(1, -1);
  PVector movePerTurn4 = new PVector(-1, -1);
  PVector movePerTurn5 = new PVector(0, 1.5f);
  PVector movePerTurn6 = new PVector(0, -1.5f);
  PVector movePerTurn7 = new PVector(1.5f, 0);
  PVector movePerTurn8 = new PVector(-1.5f, 0);
  
  int timer = 0;
  boolean alive = true;
  int colorAlpha = 255;
  int myColor = 0;
  int color1 = 255;
  
  ParticleSpread(float posX, float posY, int tempColor)
  {
    color1 = tempColor;
    startingPos = new PVector(posX, posY);
  }
  
  public void Update()
  {
    
    PVector myLocation = new PVector(0, 0);
    for(int i = 0; i < 8; i++)
    {
      if(i == 0) myLocation = PVector.add(startingPos, PVector.mult(movePerTurn1, timer));
      else if(i == 1) myLocation = PVector.add(startingPos, PVector.mult(movePerTurn2, timer));
      else if(i == 2) myLocation = PVector.add(startingPos, PVector.mult(movePerTurn3, timer));
      else if(i == 3) myLocation = PVector.add(startingPos, PVector.mult(movePerTurn4, timer));
      else if(i == 4) myLocation = PVector.add(startingPos, PVector.mult(movePerTurn5, timer));
      else if(i == 5) myLocation = PVector.add(startingPos, PVector.mult(movePerTurn6, timer));
      else if(i == 6) myLocation = PVector.add(startingPos, PVector.mult(movePerTurn7, timer));
      else if(i == 7) myLocation = PVector.add(startingPos, PVector.mult(movePerTurn8, timer));
      fill(color1, myColor, 0, colorAlpha);
      ellipse(myLocation.x, myLocation.y, 3, 3);
    }
    colorAlpha -= 5;
    myColor += 10;
    
    timer++;
    if(timer > 60) alive = false;
  }
}

public void DeleteDeadObjects()
{
  
  for(int i =0; i < particleSpreadList.size(); i++)
  {
    if(particleSpreadList.get(i).alive == false)
    {
      particleSpreadList.remove(i);
    }
  }
  
  for(int i =0; i < trailList.size(); i++)
  {
    if(trailList.get(i).alive == false)
    {
      trailList.remove(i);
    }
  }
  
}
class Player
{

  int positionX = 0;
  int positionY = 0;
  int mySize = 40;
  int playerNumber = 0;
  float speed = 0;
  boolean mu = false;
  boolean md = false;
  boolean ml = false;
  boolean mr = false;
  int health = 15;
  int bulletSize = 4;
  int ammo = 5;
  int damage = 1;
  boolean isHit = false;
  int hitTimer = 0;
  
  int hudDirection;
  int hudOffset = 0;


  public void Initialize(int tempPlayerNumber, int tempPositionX, int tempPositionY, float tempSpeed)
  {

    positionX = tempPositionX;
    positionY = tempPositionY;
    playerNumber = tempPlayerNumber;
    speed = tempSpeed;
  }

  public void Update(int myColor1, int myColor2, int textPosition)
  {
    if(isHit)
    {
      fill(255, 0, 0);
      hitTimer++;
      
      if (hitTimer > 5)
      {
        hitTimer = 0;
        isHit = false;
      }
      
    }else{
    fill(0, myColor1, myColor2);
    }
    
    ellipse(positionX, positionY, mySize, mySize);
    
    textAlign(CENTER, CENTER);
    fill(255);
    text(health, positionX, positionY);
    MovementLogic();
    
    fill(0, myColor1, myColor2);
    textAlign(LEFT);
    text("Ammo: " + ammo, textPosition, 15);
    //text("Speed: " + speed, textPosition, 30);
    //text("Size: " + mySize, textPosition, 45);
    //text("Damage: " + damage, textPosition, 60);
    //text("Bullet: " + bulletSize, textPosition, 75);
    
    if (textPosition > 100)
    {
      hudDirection = -10;
      hudOffset = 45;
    }else{
      hudDirection = 10;
    }
    
    for (int i = 0; i < ammo; i++)
    {
      rect(textPosition + hudOffset + hudDirection * i, 16, 9, 15);
    }
  }

  public void MovementLogic()
  {

    if (mu)
    { 
      positionY -= speed;
    }

    if (md)
    { 
      positionY += speed;
    }

    if (ml)
    { 
      positionX -= speed;
    }

    if (mr)
    { 
      positionX += speed;
    }

    //Keep the player within the boundaries
    if (positionX < mySize/2)
    {
      positionX = mySize/2;
    }
    else if (positionX > width - mySize/2)
    {
      positionX = width - mySize/2;
    }

    if (positionY < mySize/2)
    {
      positionY = mySize/2;
    }
    else if (positionY > height - mySize/2)
    {
      positionY = height - mySize/2;
    }
  }
}

PImage ammo;
PImage health;
PImage wall;
PImage speed;
PImage damage;
PImage shrink;

public void randomPowerUps()
{

  if (millis() - powerTime > 5000)
  {

    powerTime = millis();
    powerUp = (int)random(1, 7);
    powerSize = 20;
    powerPosX = (int)random(400, 601);
    powerPosY = (int)random(powerSize/2, 601 - powerSize/2);
    powerUpSound.rewind();
  }


  //Power Ups and stat changes for each player upon collision
  if (powerUp == 1) //heal
  {
    fill(255, 0, 0);
    ellipse(powerPosX, powerPosY, powerSize, powerSize);
    image(health, powerPosX-powerSize/2, powerPosY-powerSize/2);


    if (AreWeColliding(powerPosX, powerPosY, powerSize, player1.positionX, player1.positionY, player1.mySize))
    {
      particleSpreadList.add(new ParticleSpread(powerPosX, powerPosY, 0));
      player1.health += 5;
      powerPosX = 9999;
      powerUpSound.play();
      

      if (player1.health > 30)
      {
        player1.health = 30;
      }
    }

    if (AreWeColliding(powerPosX, powerPosY, powerSize, player2.positionX, player2.positionY, player2.mySize))
    {
      particleSpreadList.add(new ParticleSpread(powerPosX, powerPosY, 0));
      player2.health += 5;
      powerPosX = 9999;
      powerUpSound.play();
      

      if (player2.health > 30)
      {
        player2.health = 30;
      }
    }
  }
  else if (powerUp == 2)//speed up
  {
    fill(255, 255, 0);
    ellipse(powerPosX, powerPosY, powerSize, powerSize);
    image(speed, powerPosX-powerSize/2, powerPosY-powerSize/2);

    if (AreWeColliding(powerPosX, powerPosY, powerSize, player1.positionX, player1.positionY, player1.mySize))
    {
      player1.speed += 1;
      particleSpreadList.add(new ParticleSpread(powerPosX, powerPosY, 0));
      powerPosX = 9999;
      powerUpSound.play();
    }

    if (AreWeColliding(powerPosX, powerPosY, powerSize, player2.positionX, player2.positionY, player2.mySize))
    {
      player2.speed += 1;
      particleSpreadList.add(new ParticleSpread(powerPosX, powerPosY, 0));
      powerPosX = 9999;
      powerUpSound.play();
    }
  }
  else if (powerUp == 3)//ammo
  {
    fill(255, 127, 0);
    ellipse(powerPosX, powerPosY, powerSize, powerSize);
    image(ammo, powerPosX-powerSize/2, powerPosY-powerSize/2);

    if (AreWeColliding(powerPosX, powerPosY, powerSize, player1.positionX, player1.positionY, player1.mySize))
    {
      player1.ammo += 10;
      particleSpreadList.add(new ParticleSpread(powerPosX, powerPosY, 0));
      powerPosX = 9999;
      powerUpSound.play();
    }

    if (AreWeColliding(powerPosX, powerPosY, powerSize, player2.positionX, player2.positionY, player2.mySize))
    {
      player2.ammo += 10;
      particleSpreadList.add(new ParticleSpread(powerPosX, powerPosY, 0));
      powerPosX = 9999;
      powerUpSound.play();
    }
  }
  else if (powerUp == 4)//shrink
  {
    fill(127, 0, 255);
    ellipse(powerPosX, powerPosY, powerSize, powerSize);
    image(shrink, powerPosX-powerSize/2, powerPosY-powerSize/2);

    if (AreWeColliding(powerPosX, powerPosY, powerSize, player1.positionX, player1.positionY, player1.mySize))
    {
      if (player1.mySize > 5)
      {
        player1.mySize -= 5;
      }

      particleSpreadList.add(new ParticleSpread(powerPosX, powerPosY, 0));
      powerPosX = 9999;
      powerUpSound.play();
    }

    if (AreWeColliding(powerPosX, powerPosY, powerSize, player2.positionX, player2.positionY, player2.mySize))
    {
      if (player2.mySize > 5)
      {
        player2.mySize -= 5;
      }
      particleSpreadList.add(new ParticleSpread(powerPosX, powerPosY, 0));
      powerPosX = 9999;
      powerUpSound.play();
    }
  }
  else if (powerUp == 5)//damage
  {
    fill(100);
    ellipse(powerPosX, powerPosY, powerSize, powerSize);
    image(damage, powerPosX-powerSize/2, powerPosY-powerSize/2);

    if (AreWeColliding(powerPosX, powerPosY, powerSize, player1.positionX, player1.positionY, player1.mySize))
    {
      player1.damage += 1;
      player1.bulletSize += 4;
      particleSpreadList.add(new ParticleSpread(powerPosX, powerPosY, 0));
      powerPosX = 9999;
      powerUpSound.play();
    }

    if (AreWeColliding(powerPosX, powerPosY, powerSize, player2.positionX, player2.positionY, player2.mySize))
    {
      player2.damage += 1;
      player2.bulletSize += 4;
      particleSpreadList.add(new ParticleSpread(powerPosX, powerPosY, 0));
      powerPosX = 9999;
      powerUpSound.play();
    }
  }
  else if (powerUp == 6)//wall repair
  {
    fill(255);
    ellipse(powerPosX, powerPosY, powerSize, powerSize);
    image(wall, powerPosX-powerSize/2, powerPosY-powerSize/2);

    if (AreWeColliding(powerPosX, powerPosY, powerSize, player1.positionX, player1.positionY, player1.mySize))
    {
      wall11.health = 5;
      wall11.alive = true;
      wall12.health = 5;
      wall12.alive = true;
      wall13.health = 5;
      wall13.alive = true;
      particleSpreadList.add(new ParticleSpread(powerPosX, powerPosY, 0));
      powerPosX = 9999;
      powerUpSound.play();
    }

    if (AreWeColliding(powerPosX, powerPosY, powerSize, player2.positionX, player2.positionY, player2.mySize))
    {
      wall21.health = 5;
      wall21.alive = true;
      wall22.health = 5;
      wall22.alive = true;
      wall23.health = 5;
      wall23.alive = true;
      particleSpreadList.add(new ParticleSpread(powerPosX, powerPosY, 0));
      powerPosX = 9999;
      powerUpSound.play();
    }
  }
}



AudioPlayer powerUpSound;
AudioPlayer shoot;
AudioPlayer hit;
AudioPlayer music;
AudioPlayer win;
AudioPlayer menu;
Minim minim;

public void soundSetup()
{
  
  minim = new Minim(this);
  powerUpSound = minim.loadFile("powerUp.wav");
  shoot = minim.loadFile("shoot.wav");
  hit = minim.loadFile("hit.aiff");
  music = minim.loadFile("music.wav");
  win = minim.loadFile("win.wav");
  menu = minim.loadFile("menu.wav");
  
  
}
class Trail
{
  
  int posX = 0;
  int posY = 0;
  int mySize = 40;
  int myAlpha = 50;
  int myColor1 = 0;
  int myColor2 = 0;
  boolean alive = true;
  int timer = 0;
  
  
  Trail(int tempPosX, int tempPosY, int tempSize, int tempColor1, int tempColor2)
  {
    
    posX = tempPosX;
    posY = tempPosY;
    mySize = tempSize;
    myColor1 = tempColor1;
    myColor2 = tempColor2;
  } 
  
  public void Update()
  {
    
    noStroke();
    fill(0, myColor1, myColor2, myAlpha);
    ellipse(posX, posY, mySize, mySize);
    
    myAlpha -= 1;
    mySize *= .9999999f;
    
    timer++;
    if(timer > 30) alive = false;
  }
  
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--full-screen", "--bgcolor=#666666", "--stop-color=#cccccc", "localMultiplayerGame" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
