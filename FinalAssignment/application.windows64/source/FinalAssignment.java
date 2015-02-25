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

public class FinalAssignment extends PApplet {

Player player1;

Button button1;
Button button2;
Button button3;
Button button4;
Button button5;
Button button6;
Button button7;
Button button8;
Button button9;
Button button10;
Button button11;
Button button12;

PFont myFont;

ArrayList<Bullet> bulletList = new ArrayList<Bullet>();
ArrayList<Enemy> enemyList = new ArrayList<Enemy>();
ArrayList<ScoreText> scoreList = new ArrayList<ScoreText>();
ArrayList<Trail> trailList = new ArrayList<Trail>();

int enemyAmount;

int score = 0;
int highScore = 0;
boolean freeze;

float multiplier = 1;
int multiplierTimer = 0;
int multiplierTime = 180;

int gameState = 0;
int wave = 1;

float enemySpeed;
float enemyHealth;
float enemyDamage;
boolean allPurple = false;
boolean readyToPlay = true;

boolean musicPlaying = false;

int backgroundColor = 0;


public void setup()
{

  size(1000, 800);
  smooth();


  soundSetup();

  //control music with SETUP()
  if (musicPlaying == false)
  {
    menuMusic.pause();
    menuMusic.rewind();
    menuMusic.loop();

    musicPlaying = true;
  }

  enemySpeed = .9f;
  enemyHealth = .9f;
  enemyDamage = .9f;

  player1 = new Player(width/2, height/2);

  //Shop buttons
  button1 = new Button(50, height/20 * 4, 150, 50, 1, 100, "Lives");
  button2 = new Button(50, height/20 * 6, 150, 50, player1.maxHealth, 25, "Heal");
  button3 = new Button(50, height/20 * 8, 150, 50, 1, 50, "Max Health");
  button4 = new Button(50, height/20 * 10, 150, 50, .5f, 50, "Damage");
  button5 = new Button(50, height/20 * 12, 150, 50, 5, 50, "Max Ammo");
  button6 = new Button(50, height/20 * 14, 150, 50, .5f, 50, "Fire Rate");
  button7 = new Button(50, height/20 * 16, 150, 50, .5f, 50, "Mobility");

  //Buttons
  button8 = new Button(width/2 - 75, height/20 * 18, 150, 50, "Next Wave");
  button9 = new Button(width/2 - 75, height/20 * 14, 150, 50, "Main Menu");
  button10 = new Button(width/2 - 75, height/20 * 8, 150, 50, "Play Game");
  button11 = new Button(width/2 - 75, height/20 * 10, 150, 50, "Controls");
  button12 = new Button(width/2 - 75, height/20 * 12, 150, 50, "Quit");


  myFont = loadFont("Arial.vlw");

  enemyAmount = 5;
  player1.health = 5;
  wave = 0;
  score = 0;
  backgroundColor = 0;
  enemyList.clear();
  bulletList.clear();
  scoreList.clear();
  trailList.clear();
  

  for (int i = 0; i < enemyAmount; i++)
  {

    enemyList.add(new Enemy(random(1, width), random(1, height), enemyHealth, enemySpeed, enemyDamage));
  }
}

public void draw()
{

  //Main Menu
  if (gameState == 0) mainMenu();

  //Lose Screen
  if (gameState == 4) gameOver();

  //Rules
  if (gameState == 3) rules();

  //shop Screen
  if (gameState == 2) shop();

  //Game Screen
  if (gameState == 1)
  {

    background(backgroundColor);

   

    frame.setTitle(""+frameRate);

    //scoring
    if (score > highScore)
    {
      highScore = score;
    }

    //Score multiplier based on kill frequency
    if (multiplier > 1)
    {
      multiplierTimer++;

      if (multiplierTimer >= multiplierTime)
      {
        multiplier = 1;
        multiplierTimer = 0;
      }
    }

    allPurple = true;
    for (int i = 0; i < enemyList.size (); i++) 
    {

      if (enemyList.get(i).type != 2)
      {
        allPurple = false;
      }
    }

    for (int i = 0; i < trailList.size (); i++) 
    {
      trailList.get(i).Update();
    }

    //update enemies
    for (int i = 0; i < enemyList.size (); i++) 
    {
      enemyList.get(i).Update();
    }

    //Update Score Text
    for (int i = 0; i < scoreList.size (); i++) 
    {
      scoreList.get(i).Update();
    }



    //update Player
    player1.Update(200, 0, 15);

    //update bullets
    for (int i = 0; i < bulletList.size (); i++) 
    {
      bulletList.get(i).Update();
    }

    //cycle through bullets and enemies
    for (int i = 0; i < bulletList.size (); i++)
    {
      for (int e = 0; e < enemyList.size (); e++)
      {

        //if a bullet collides with an enemy
        if (AreWeColliding(bulletList.get(i).posX, bulletList.get(i).posY, bulletList.get(i).mySize, enemyList.get(e).posX, enemyList.get(e).posY, enemyList.get(e).mySize))
        {
          bulletList.get(i).alive = false;
          enemyList.get(e).health -= player1.damage;

          hit.pause();
          hit.rewind();
          hit.play();
        }
      }
    }

    //cycle through enemies
    for (int e = 0; e < enemyList.size (); e++)
    {

      //if a enemy collides with the player
      if (AreWeColliding(player1.positionX, player1.positionY, player1.mySize, enemyList.get(e).posX, enemyList.get(e).posY, enemyList.get(e).mySize) && player1.vulnerable == true)
      {
        player1.health -= enemyList.get(e).damage;
        player1.isHit = true;
        player1.vulnerable = false;

        hurt.pause();
        hurt.rewind();
        hurt.play();

        if (enemyList.get(e).posX > player1.positionX)
        {
          player1.positionX -= 15;
        } else {
          player1.positionX += 15;
        }

        if (enemyList.get(e).posY > player1.positionY)
        {
          player1.positionY -= 15;
        } else {
          player1.positionY += 15;
        }
      }
    }

    //END OF ROUND LOGIC AND STUFF
    if (enemyList.size() == 0)
    {
      backgroundColor+=3;
      
      
      if(backgroundColor == 3)
      {
        waveClear.pause();
        waveClear.rewind();
        waveClear.play();
      }

      if (backgroundColor >= 255)
      {
        
        enemyAmount += 2;
        wave++;
        multiplierTimer = 180;
        allPurple = false;

        enemySpeed *= 1.1f;
        enemyHealth *= 1.1f;
        enemyDamage *= 1.1f;

        player1.positionX = width/2;
        player1.positionY = height/2;
        player1.health = ceil(player1.health);  
        player1.ammo = player1.maxAmmo;

        backgroundColor = 0;
        gameState = 2;
        
      }
    }

    DeleteDeadObjects();
  }
}

public boolean AreWeColliding(float c1px, float c1py, float c1s, float c2px, float c2py, float c2s)
{

  float distanceBetweenCircles = dist(c1px, c1py, c2px, c2py);
  float halfOfCircleSizes = (c1s + c2s) / 2;

  if (distanceBetweenCircles < halfOfCircleSizes)
  {
    return true;
  } else {
    return false;
  }
}

public boolean IsMouseTouchingRect (int rx, int ry, int rWidth, int rHeight)
{

  if (mouseX > rx && mouseX < rx + rWidth && mouseY > ry && mouseY < ry + rHeight) //if a point is within the bounds of the rect
  {
    return true;
  } else {
    return false;
  }
}


class Bullet 
{

  float posX = 0;
  float posY = 0;
  float mySize = 4;
  float speed = 10;


  float distanceX = 0;
  float distanceY = 0;
  float angleInDegrees = 0;
  float angleInRadians = 0;
  float vectorY = 0;
  float vectorX = 0;
  
  int trailColor = 255;
  int myColor1 = 0;
  int myColor2 = 0;
  boolean alive = true;
  int timer = 0;


  Bullet(float tempPosX, float tempPosY, int tempColor1, int tempColor2, float tempdistanceX, float tempdistanceY)
  {

    posX = tempPosX;
    posY = tempPosY;
    myColor1 = tempColor1;
    myColor2 = tempColor2;
    distanceX = tempdistanceX;
    distanceY = tempdistanceY;
  } 

  public void Update()
  {
    if(player1.fireRate >= 2)
    {
      trailColor = 0;
    }else{
      trailColor = 255;
    }
    
    if(player1.maxAmmo >= 20)
    {
      mySize = 6;
    }else{
      mySize = 4;
    }
    
    trailList.add(new Trail(posX, posY, mySize, 255, 255, trailColor));
    
    noStroke();
    
    
    fill(0, myColor1, myColor2);
    if(player1.damage >= 2)
    {
      fill(255,0,0);
    }
    
    ellipse(posX, posY, mySize, mySize);

    //angle in degrees
    angleInDegrees = atan2(distanceY, distanceX) * 180 / PI;

    if (angleInDegrees<0) 
    { 
      angleInDegrees *= -1;
    } 
    else if (angleInDegrees > 0) 
    {
      angleInDegrees = 180 + (180-angleInDegrees);
    }

    angleInRadians = -angleInDegrees*0.01747722222222222222222f;
    vectorY = sin(angleInRadians);
    vectorX = cos(angleInRadians);

    //X and Y velocity
    posY += vectorY * speed;
    posX += vectorX * speed;

    timer++;

    if (timer > 120) alive = false;
  }
}

public void DeleteDeadObjects()
{
  //bullets have a lifetime
  for (int i =0; i < bulletList.size(); i++)
  {
    if (bulletList.get(i).alive == false)
    {
      bulletList.remove(i);
    }
  }

  for (int e = 0; e < enemyList.size(); e++)
  {
    //IF AN ENEMY GETS KILLED
    if (enemyList.get(e).health <= 0)
    {
      scoreList.add(new ScoreText(enemyList.get(e).score * multiplier, enemyList.get(e).posX, enemyList.get(e).posY));
      
      score += enemyList.get(e).score * multiplier;
      player1.credits += enemyList.get(e).score/10 * multiplier;
      multiplier += 0.1f;
      multiplierTimer = 0;
      
      enemyList.remove(e);
      kill.pause();
      kill.rewind();
      kill.play();
      
      
    }
  }
  
  //trail gets deleted
  for(int i = 0; i < trailList.size(); i++)
  {
    if(trailList.get(i).alive == false)
    {
      trailList.remove(i);
    }
  }
  
  //scores get deleted
  for (int i =0; i < scoreList.size(); i++)
  {
    if (scoreList.get(i).alive == false)
    {
      scoreList.remove(i);
    }
  }
}


class Button 
{

  int posX;
  int posY;
  int myWidth;
  int myHeight;
  
  float statIncrease;
  float cost;

  String myText;
  

  Button(int tempPosX, int tempPosY, int tempMyWidth, int tempMyHeight, float tempStatIncrease, float tempCost, String tempMyText)
  {
    posX = tempPosX;
    posY = tempPosY;
    myWidth = tempMyWidth;
    myHeight = tempMyHeight;
    statIncrease = tempStatIncrease;
    cost = tempCost;

    myText = tempMyText;
  }
  
  Button(int tempPosX, int tempPosY, int tempMyWidth, int tempMyHeight, String tempMyText)
  {
    posX = tempPosX;
    posY = tempPosY;
    myWidth = tempMyWidth;
    myHeight = tempMyHeight;
    myText = tempMyText;
  }

  public void Update()
  {

    fill(255);
    strokeWeight(2);
    
    if (player1.credits >= cost) //rect 2 values
    {

      stroke(0, 200, 0);
    }
    else if(player1.credits < cost)
    {
      stroke(255, 0, 0);
    }
    
    
    if (IsMouseTouchingRect(posX, posY, myWidth, myHeight) && player1.credits >= cost) //rect 2 values
    {

      fill(100, 255, 100);
    }
    else if(IsMouseTouchingRect(posX, posY, myWidth, myHeight) && player1.credits < cost)
    {
      fill(255, 100, 100);
    }else{
      fill(255);
    }

    textAlign(CENTER, CENTER);
    rect(posX, posY, myWidth, myHeight); //rect 2
    fill(0);
    textFont(myFont, 24);
    text(myText, posX + myWidth/2, posY + myHeight/2);
    fill(0, 255, 0);
    text("+" + nf(statIncrease, 0, 0), posX + myWidth + 50, posY + myHeight/2);
    //textAlign(LEFT, CENTER);
    fill(255, 0, 0);
    text("$" + nf(cost, 2, 0), posX + myWidth + 140, posY + myHeight/2);
    stroke(0);
    strokeWeight(1);
  }
  
  public void Update1()
  {

    if (IsMouseTouchingRect(posX, posY, myWidth, myHeight)) //rect 2 values
    {

      fill(255, 255, 0);
    }
    else {
      fill(255);
    }

    textAlign(CENTER, CENTER);
    rect(posX, posY, myWidth, myHeight); //rect 2
    fill(0);
    textFont(myFont, 24);
    text(myText, posX + myWidth/2, posY + myHeight/2);
    
    
  }

  
  
}


class Enemy
{

  float posX = 0;
  float posY = 0;
  float mySize = 20;
  float health = 1;
  float speed = 1;
  float damage = 1;
  float mySize1 = 0; //for hollow circle
  float color1 = 0;
  float color2 = 127;
  float color3 = 255;
  
  float score = 120;

  int type = (int)random(1, 4);
  int direction = (int)random(1, 5);

  int expandTimer = 0;

  boolean mu;
  boolean md;
  boolean ml;
  boolean mr;

  Enemy(float tempPosX, float tempPosY, float tempHealth, float tempSpeed, float tempDamage)
  {
    //Chasers
    posX = tempPosX;
    posY = tempPosY;
    health = tempHealth;
    speed = tempSpeed;
    damage = tempDamage;
    

    //avoid spawning in the center
    while (posX > width/20 * 7 && posX < width/20 * 13 && posY > height/20 * 6 && posY < height/20 * 14)
    {
      posX = (int)random(1, width);
      posY = (int)random(1, height);
    }
   

    //Expanders
    if (type == 3)
    {
      health = health * 4;
      mySize = mySize * 4;
      score = score - 40;
    }

    //Runners
    if (type == 2)
    {

      speed = speed * 1.5f;
      mySize = mySize * 1.5f;
      score = score - 20;
      if (direction == 1)
      {
        mu = true;
        md = false;
        ml = true;
        mr = false;
      } else if (direction == 2)
      {
        mu = false;
        md = true;
        ml = true;
        mr = false;
      } else if (direction == 3)
      {
        mu = true;
        md = false;
        ml = true;
        mr = false;
      } else if (direction == 4)
      {
        mu = false;
        md = true;
        ml = false;
        mr = true;
      }
    }
  }




  public void Update()
  {

    //Fat Enemies
    if (type == 3)
    {
      fill(color1, color2, color3);
      ellipse(posX, posY, mySize, mySize);
      textAlign(CENTER, CENTER);
      fill(0);
      text(nf(health, 1, 1), posX, posY);

      expandTimer++;
      
      if (expandTimer >= 3)
      {
        mySize += 3;
        expandTimer = 0;
      }
      
      color1 += .25f;
      color2 -= .125f;
      color3 -= .25f;
      

      //expand within boundaries unless you're in the center
      if (posY != height/2 && posX != width/2)
      {
        if (posY >= height - mySize/2)
        {
          posY = height - mySize/2;
        }

        if (posY <= 0 + mySize/2)
        {
          posY = 0 + mySize/2;
        }

        if (posX >= width - mySize/2)
        {
          posX = width - mySize/2;
        }

        if (posX <= 0 + mySize/2)
        {
          posX = 0 + mySize/2;
        }
      }
    }

    //Chaser Enemies
    if (type == 1)
    {
      noFill();
      stroke(255, 0, 0);
      ellipse(posX, posY, mySize1, mySize1);
      mySize1++;
      
      if(mySize1 >= mySize * 5)
      {
        mySize1 = 0;
      }
      
      if (AreWeColliding(player1.positionX, player1.positionY, player1.mySize, posX, posY, mySize1))
      {
        speed = enemySpeed * 1.5f;
        fill(255, 0, 0);
      }else{
        speed = enemySpeed;
        fill(255, 255, 0);
      } 
        
      
      noStroke();
      
      ellipse(posX, posY, mySize, mySize);
      textAlign(CENTER, CENTER);
      fill(0);
      text(nf(health, 1, 1), posX, posY);

      if (posX > player1.positionX)
      {
        posX-= speed;
      } else if (posX < player1.positionX)
      {
        posX+= speed;
      }

      if (posY > player1.positionY)
      {
        posY-= speed;
      } else if (posY < player1.positionY)
      {
        posY+= speed;
      }
    }

    //Runner Enemies
    if (type == 2)
    {

      trailList.add(new Trail(posX, posY, mySize, 127, 0, 255));
      
      fill(127, 0, 255);
      ellipse(posX, posY, mySize, mySize);
      textAlign(CENTER, CENTER);
      fill(0);
      text(nf(health, 1, 1), posX, posY);
      
      
      
      if (allPurple == false)
      {
        if (mu)
        {
          posY -= speed;
        } else if (md)
        {
          posY += speed;
        }

        if (ml)
        {
          posX -= speed;
        } else if (mr)
        {
          posX += speed;
        }

        if (posY >= height - mySize/2)
        {
          mu = true;
          md = false;
        }

        if (posY <= 0 + mySize/2)
        {
          mu = false;
          md = true;
        }

        if (posX >= width - mySize/2)
        {
          ml = true;
          mr = false;
        }

        if (posX <= 0 + mySize/2)
        {
          ml = false;
          mr = true;
        }
      } else {
        if (posX > player1.positionX)
        {
          posX-= speed;
        } else if (posX < player1.positionX)
        {
          posX+= speed;
        }

        if (posY > player1.positionY)
        {
          posY-= speed;
        } else if (posY < player1.positionY)
        {
          posY+= speed;
        }
      }
    }
  }
}

public void keyPressed()
{

  if (key == 'w' && player1.canMove == true || key == 'W' && player1.canMove == true || keyCode == UP && player1.canMove == true)
  {
    player1.mu = true;
  }

  if (key == 's' && player1.canMove == true || key == 'S' && player1.canMove == true || keyCode == DOWN && player1.canMove == true)
  {
    player1.md = true;
  }

  if (key == 'a' && player1.canMove == true || key == 'A' && player1.canMove == true || keyCode == LEFT && player1.canMove == true)
  {
    player1.ml = true;
  }

  if (key == 'd' && player1.canMove == true || key == 'D' && player1.canMove == true || keyCode == RIGHT && player1.canMove == true)
  {
    player1.mr = true;
  }

  if (key == ' ')
  {
    gameState = 0;

    if (musicPlaying == false)
    {
      menuMusic.pause();
      menuMusic.rewind();
      menuMusic.loop();

      musicPlaying = true;
    }

    mainMusic.pause();
    music1.pause();
    music2.pause();
  }

  if (key == 'r' && player1.ammo < player1.maxAmmo || keyCode == SHIFT && player1.ammo < player1.maxAmmo || keyCode == ALT && player1.ammo < player1.maxAmmo)
  {
    if (!player1.reloading && player1.health > 0)
    {
      player1.reloading = true;

      reload.pause();
      reload.rewind();
      reload.play();
    }
  }
}

public void mouseReleased()
{
  player1.shooting = false;
}

public void mousePressed()
{
  

  if (gameState == 1 && mouseButton == LEFT)
  {
    player1.shooting = true;
  } else if (gameState == 1 && player1.ammo <= 0 && player1.reloading == false)
  {

    emptyShot.pause();
    emptyShot.rewind();
    emptyShot.play();
  } else {
    player1.shooting = false;
  }


  if (IsMouseTouchingRect(button10.posX, button10.posY, button10.myWidth, button10.myHeight) && gameState == 0 && readyToPlay) //press play button
  { 
    menuMusic.pause();

    menu.pause();
    menu.rewind();
    menu.play();


    setup();

    gameState = 1;  //Set gamestate to play


    musicPlaying = false;    

    mainMusic.pause();
    mainMusic.rewind();
    mainMusic.loop();
  } else if (IsMouseTouchingRect(button10.posX, button10.posY, button10.myWidth, button10.myHeight) && gameState == 0 && !readyToPlay)
  {

    error.pause();
    error.rewind();
    error.play();
  }


  if (IsMouseTouchingRect(button11.posX, button11.posY, button11.myWidth, button11.myHeight) && gameState == 0) //press rules button
  {
    menu.pause();
    menu.rewind();
    menu.play();
    readyToPlay = true;

    gameState = 3; //set gamestate to rules
  }

  if (IsMouseTouchingRect(button9.posX, button9.posY, button9.myWidth, button9.myHeight) && gameState == 4 || IsMouseTouchingRect(button9.posX, button9.posY, button9.myWidth, button9.myHeight) && gameState == 3) //press main menu button
  {
    menu.pause();
    menu.rewind();
    menu.play();

    gameState = 0; //set gamestate to main menu
  }

  if (IsMouseTouchingRect(button12.posX, button12.posY, button12.myWidth, button12.myHeight) && gameState == 0) //press quit button
  {

    exit(); //quit game
  }

  if (IsMouseTouchingRect(button1.posX, button1.posY, button1.myWidth, button1.myHeight) && gameState == 2) //press lives button
  {
    if (player1.credits >= button1.cost)
    {
      player1.credits -= button1.cost;
      player1.lives += button1.statIncrease;
      button1.cost += 20;
      upgrade.pause();
      upgrade.rewind();
      upgrade.play();
    } else {
      error.pause();
      error.rewind();
      error.play();
    }
  }

  if (IsMouseTouchingRect(button2.posX, button2.posY, button2.myWidth, button2.myHeight) && gameState == 2) //press health button
  {
    if (player1.credits >= button2.cost && player1.health < player1.maxHealth)
    {
      player1.credits -= button2.cost;
      player1.health += player1.maxHealth;
      upgrade.pause();
      upgrade.rewind();
      upgrade.play();

      if (player1.health > player1.maxHealth)
      {
        player1.health = player1.maxHealth;
      }
    } else {
      error.pause();
      error.rewind();
      error.play();
    }
  }

  if (IsMouseTouchingRect(button3.posX, button3.posY, button3.myWidth, button3.myHeight) && gameState == 2) //press max health button
  {
    if (player1.credits >= button3.cost)
    {
      player1.credits -= button3.cost;
      player1.maxHealth += button3.statIncrease;
      player1.health += button3.statIncrease;
      button2.statIncrease += button3.statIncrease;
      button3.cost += 10;
      button2.cost += 5;
      upgrade.pause();
      upgrade.rewind();
      upgrade.play();
    } else {
      error.pause();
      error.rewind();
      error.play();
    }
  }

  if (IsMouseTouchingRect(button4.posX, button4.posY, button4.myWidth, button4.myHeight) && gameState == 2) //press damage button
  {
    if (player1.credits >= button4.cost)
    {
      player1.credits -= button4.cost;
      player1.damage += button4.statIncrease;
      button4.cost += 10;
      upgrade.pause();
      upgrade.rewind();
      upgrade.play();
    } else {
      error.pause();
      error.rewind();
      error.play();
    }
  }

  if (IsMouseTouchingRect(button5.posX, button5.posY, button5.myWidth, button5.myHeight) && gameState == 2) //press max ammo button
  {
    if (player1.credits >= button5.cost)
    {
      player1.credits -= button5.cost;
      player1.maxAmmo += button5.statIncrease;
      player1.ammo += button5.statIncrease;
      button5.cost += 10;
      upgrade.pause();
      upgrade.rewind();
      upgrade.play();
    } else {
      error.pause();
      error.rewind();
      error.play();
    }
  }

  if (IsMouseTouchingRect(button6.posX, button6.posY, button6.myWidth, button6.myHeight) && gameState == 2) //press fire rate button
  {
    if (player1.credits >= button6.cost)
    {
      player1.credits -= button6.cost;
      player1.fireRate += button6.statIncrease;
      button6.cost += 10;
      upgrade.pause();
      upgrade.rewind();
      upgrade.play();
    } else {
      error.pause();
      error.rewind();
      error.play();
    }
  }

  if (IsMouseTouchingRect(button7.posX, button7.posY, button7.myWidth, button7.myHeight) && gameState == 2) //press mobility button
  {
    if (player1.credits >= button7.cost)
    {
      player1.credits -= button7.cost;
      player1.speed += button7.statIncrease;
      button7.cost += 10;
      upgrade.pause();
      upgrade.rewind();
      upgrade.play();
    } else {
      error.pause();
      error.rewind();
      error.play();
    }
  }

  if (IsMouseTouchingRect(button8.posX, button8.posY, button8.myWidth, button8.myHeight) && gameState == 2) //press next wave button
  {
    enemyList.clear();
    bulletList.clear();
    scoreList.clear();
    trailList.clear();

    for (int i = 0; i < enemyAmount; i++)
    {

      enemyList.add(new Enemy(random(1, width), random(1, height), enemyHealth, enemySpeed, enemyDamage));
    }
    
    menu.pause();
    menu.rewind();
    menu.play();
    
    if (wave == 9)
    {
      mainMusic.pause();
      music1.pause();
      music1.rewind();
      music1.loop();
    }
    
    if (wave == 19)
    {
      music1.pause();
      music2.pause();
      music2.rewind();
      music2.loop();
    }

    gameState = 1;
  }
}





public void keyReleased()
{

  if (key == 'w' || key == 'W' && player1.canMove == true || keyCode == UP && player1.canMove == true)
  {
    player1.mu = false;
  }

  if (key == 's' || key == 'S' && player1.canMove == true || keyCode == DOWN && player1.canMove == true)
  {
    player1.md = false;
  }

  if (key == 'a' || key == 'A' && player1.canMove == true || keyCode == LEFT && player1.canMove == true)
  {
    player1.ml = false;
  }

  if (key == 'd' || key == 'D' && player1.canMove == true || keyCode == RIGHT && player1.canMove == true)
  {
    player1.mr = false;
  }
}


public void mainMenu()
{

  background(0);

  fill(255);
  textFont(myFont, 48);
  textAlign(CENTER, CENTER);
  text("Shape Survivor", width/2, height/20 * 5); 
  
  button10.Update1();
  button11.Update1();
  button12.Update1();
  
  if (!readyToPlay)
  {
    stroke(255,255,0);
    strokeWeight(2);
    noFill();
    rect(button11.posX, button11.posY, button11.myWidth, button11.myHeight);
    stroke(0);
    strokeWeight(1);
  }
}

public void gameOver()
{

  background(0);

  fill(255, 0, 0);
  textFont(myFont, 48);
  textAlign(CENTER, CENTER);
  text("Game Over", width/2, height/20 * 5);
  
  textFont(myFont, 32);
  if(score == highScore)
  {
    fill(255,255,0);
    text("New high score!", width/2, height/20 * 7);
  }
  
  fill(255);
  text("You survived " + wave + " waves!", width/2, height/20 * 8);
  text("You had " + score + " points!", width/2, height/20 * 9);  
  
  textAlign(LEFT, CENTER);
  fill(0,255,0);
  text("Leaderboard", 25, 50);
  textFont(myFont, 18);
  fill(255);
  text("BC Waves: 30  Score: 247680", 25, 75);

  button9.Update1();
}

public void rules()
{

  background(0);

  fill(255);
  textFont(myFont, 48);
  textAlign(CENTER, CENTER);
  text("Controls", width/2, height/20 * 6);
  textFont(myFont, 24);
  //text("Reduce the opposing player's heath to 0 to win", 60, 150);
  text("Shoot enemies and stay alive as long as possible", width/2, height/20 * 8);
  //text("You lose health when colliding with an enemy", width/2, 400);
  //text("When you run out of lives it's game over", width/2, 425);
  
  
  text("Use the Mouse to aim and shoot", width/2, height/20 * 9);
  text("WASD to move around", width/2, height/20 * 10);
  text("R to reload", width/2, height/20 * 11);
  text("Space to return to main menu", width/2, height/20 * 12);

  button9.Update1();
}

public void shop()
{

  background(0);
  
  textAlign(CENTER, CENTER);
  
  fill(255);
  textFont(myFont, 48);
  text("Upgrades", width/2, height/20 * 2);
  fill(0, 255, 0);
  textFont(myFont, 36);
  text("Credits: $" + floor(player1.credits), 800, 100);
  textAlign(LEFT, CENTER);
  fill(255, 255, 0);
  text("Next Wave: " + (wave+1), width/2 + 100, button8.posY + button8.myHeight/2);
  textAlign(RIGHT, CENTER);
  text("Last Wave: " + wave , width/2 - 100, button8.posY + button8.myHeight/2);
  
  
  textAlign(CENTER, CENTER);
  textFont(myFont, 24);
  fill(0, 255, 0);
  text("Gain", button1.posX + button1.myWidth + 50, height/20*7/2);
  fill(255, 0, 0);
  text("Cost", button1.posX + button1.myWidth + 140, height/20*7/2);
  fill(0, 150, 255);
  text("Stats", button1.posX + button1.myWidth + 260, height/20*7/2);
  
  textAlign(LEFT, CENTER);
  fill(0, 150, 255);
  text(button1.myText + ": " + nf(player1.lives,1,0), button1.posX + button1.myWidth + 220, button1.posY + button1.myHeight/2);
  text("Health: " + nf(player1.health,0,0), button2.posX + button2.myWidth + 220, button2.posY + button2.myHeight/2);
  text(button3.myText + ": " + nf(player1.maxHealth,1,0), button3.posX + button3.myWidth + 220, button3.posY + button3.myHeight/2);
  text(button4.myText + ": " + player1.damage, button4.posX + button4.myWidth + 220, button4.posY + button4.myHeight/2);
  text(button5.myText + ": " + nf(player1.maxAmmo,1,0), button5.posX + button5.myWidth + 220, button5.posY + button5.myHeight/2);
  text(button6.myText + ": " + player1.fireRate, button6.posX + button6.myWidth + 220, button6.posY + button6.myHeight/2);
  text(button7.myText + ": " + player1.speed, button7.posX + button7.myWidth + 220, button7.posY + button7.myHeight/2);
  button1.Update();
  button2.Update();  
  button3.Update();  
  button4.Update();  
  button5.Update();  
  button6.Update(); 
  button7.Update();
  button8.Update1();
  
}

class Player
{

  float positionX = 0;
  float positionY = 0;
  int mySize = 40;
  int myAlpha = 255;

  boolean mu = false;
  boolean md = false;
  boolean ml = false;
  boolean mr = false;
  boolean canMove = true;

  float lives = 2;
  float health = 5;
  float maxHealth = 5;
  float damage = 1;
  float speed = 3;
  
  float ammo = 10;
  float maxAmmo = 10;
  int reloadTimer = 0;
  boolean reloading = false;
  int reloadTextTimer = 0;
  boolean playingSound = false;
  boolean shooting = false;


  boolean canFire = true;
  float fireRate = 1;
  int fireTimer = 0;
  int reloadTime = 60;

  float credits = 0;

  boolean isHit = false;
  boolean vulnerable = true;
  int hitTimer = 0;
  int vulnerableTimer = 0;
  
  float healthBarIncrement = mySize / maxHealth;
  float ammoBarIncrement = mySize / maxAmmo;
  
  float healthAuraSize = 10;

  Player( float tempPositionX, float tempPositionY)
  {

    positionX = tempPositionX;
    positionY = tempPositionY;
  }

  public void Update(int myColor1, int myColor2, int textPosition)
  {
    //if hit turn red and make invulnerable
    if (isHit)
    {
      fill(255, 0, 0, myAlpha);
      hitTimer++;

      //after time change color back to normal
      if (hitTimer > 10)
      {
        hitTimer = 0;
        isHit = false;
      }
    } else {
      fill(0, myColor1, myColor2, myAlpha);
    }
    
    //Trail based on player speed
    if (speed >= 4)
    {
      
      trailList.add(new Trail(positionX, positionY, mySize, 0, myColor1, myColor2));
    }
    
    //fire rate timer
    if (canFire == false)
    {
      fireTimer++;

      if (fireTimer > 30/fireRate)
      {
        fireTimer = 0;
        canFire = true;
      }
    }

    //Reload timer
    if (reloading)
    {
      reloadTimer++;

      if (reloadTimer >= reloadTime)
      {
        reloading = false;
        reloadTimer = 0;
        ammo = maxAmmo;
      }
    }
    
    //Shooting by holding down
    if(shooting && canFire && !reloading && ammo > 0 && health > 0)
    {
      bulletList.add(new Bullet(player1.positionX, player1.positionY, 200, 0, mouseX-player1.positionX, mouseY-player1.positionY));
      player1.ammo--;
      player1.canFire = false;

      shoot.pause();
      shoot.rewind();
      shoot.play();
    }

    //if invincible start timer
    if (vulnerable == false)
    {
      vulnerableTimer++;

      //after time make vulnerable
      if (vulnerableTimer > 30)
      {
        vulnerableTimer = 0;
        vulnerable = true;
      }
    }

    //Health cannot be higher than max Health
    if (health > maxHealth)
    {
      health = maxHealth;
    }
    if (health < 0)
    {
      health = 0;
    }

    //If you run out of lives its game over
    if (lives == -1 )
    {
      music1.pause();
      music2.pause();
      mainMusic.pause();
      mainMusic.rewind();
      gameState = 4;
      menuMusic.rewind();
      menuMusic.loop();
      musicPlaying = true;
    }

    //if you run out of health u lose a life and respawn
    if (health <= 0)
    {

      //death animation
      mu = false;
      md = false;
      ml = false;
      mr = false;
      canMove = false;
      canFire = false;
      vulnerable = false;
      myAlpha -= 2;
      fill(255, 0, 0, myAlpha);
      
      //death sound
      if(playingSound == false)
      {
        dying.pause();
        dying.rewind();
        dying.loop(3);
        playingSound = true;
      }
      
      //respawn
      if (myAlpha <= 0)
      {
        health = maxHealth;
        ammo = maxAmmo;
        lives--;
        positionX = 500;
        positionY = 500;
        multiplierTimer = multiplierTime;
        canMove = true;
        canFire = true;
        myAlpha = 255;
        vulnerableTimer = -90;
        playingSound = false;
      }
    }



    //If out of ammo say RELOAD
    if (ammo == 0)
    {
      reloadTextTimer++;
      if (reloadTextTimer > 15)
      {
        textFont(myFont, 48);
        textAlign(CENTER, CENTER);
        text("RELOAD", width/2, 200);
      }

      if (reloadTextTimer > 60)
      {
        reloadTextTimer = 0;
      }
    }
    
    healthBarIncrement = mySize / maxHealth;
    ammoBarIncrement = mySize / maxAmmo;
    
    //invincibility queue outlines character in white
    if(vulnerable == false && canMove)
    {
      stroke(255);
    }
    
    //Draw player
    ellipse(positionX, positionY, mySize, mySize);
        
    stroke(0);
    noFill();
    //ellipse(positionX, positionY, mySize/4*3, mySize/4*3);
    
    if(health >= maxHealth/3*2)
    {
      stroke(0, 255, 255, myAlpha);
    }else if(health >= maxHealth/3*1)
    {
      stroke(255, 255, 0, myAlpha);
    }else{
      stroke(255, 0, 0, myAlpha);
    }
    
    healthAuraSize+= .25f;
    if (healthAuraSize > mySize)
    {
      healthAuraSize = 10;
    }
    noFill();
    ellipse(positionX, positionY, healthAuraSize, healthAuraSize/2);
    ellipse(positionX, positionY, healthAuraSize/2, healthAuraSize);
    
    if(health >= maxHealth/3*2)
    {
      fill(0, 255, 255, myAlpha);
    }else if(health >= maxHealth/3*1)
    {
      fill(255, 255, 0, myAlpha);
    }else{
      fill(255, 0, 0, myAlpha);
    }
    ellipse(positionX, positionY, mySize/8, mySize/8*2);
    ellipse(positionX, positionY, mySize/8*2, mySize/8);
    
    //health bar
    stroke(255);
    noFill();
    rect(positionX - mySize/2, positionY - 4 - mySize/2, maxHealth * healthBarIncrement, 2);
    
    noStroke();
    fill(0, myColor1, myColor2, myAlpha);
    rect(positionX - mySize/2, positionY - 4 - mySize/2, health * healthBarIncrement, 2);
    
    //ammo bar
    //stroke(255);
    //noFill();
    //rect(positionX + 4 + mySize/2, positionY - mySize/2, 2, maxAmmo * ammoBarIncrement);
    
    noStroke();
    fill(255, 255, 0, myAlpha);
    rect(positionX + 4 + mySize/2, positionY + ((maxAmmo - ammo) * ammoBarIncrement) - mySize/2, 2, ammo * ammoBarIncrement);
    
    //Hud Stuff
    textAlign(CENTER, CENTER);
    textFont(myFont, 14);
    fill(255);
    //text(nf(health, 1, 1), positionX, positionY);
    MovementLogic();

    fill(0, myColor1, myColor2);
    textAlign(LEFT);
    //text("Score: " + score, textPosition, 16);
    text("Credits: " + floor(credits), textPosition, 16);
    text("Lives: " + lives, textPosition, 32);
    text("Ammo: " + ammo, textPosition, 48);
    //text("Bullet: " + bulletSize, textPosition, 75);

    textAlign(RIGHT);
    text("High Score: " + highScore, width - textPosition, 16);
    text("Score: " + score, width - textPosition, 32);
    //text("Multiplier: " + multiplier, width - textPosition, 48);
    textFont(myFont, 12);
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
    } else if (positionX > width - mySize/2)
    {
      positionX = width - mySize/2;
    }

    if (positionY < mySize/2)
    {
      positionY = mySize/2;
    } else if (positionY > height - mySize/2)
    {
      positionY = height - mySize/2;
    }
  }
}

class ScoreText
{
  
  float myText;
  float posX;
  float posY;
  int myAlpha = 255;
  
  boolean alive = true;
  
  ScoreText(float tempMyText, float tempPosX, float tempPosY)
  {
    myText = tempMyText;
    posX = tempPosX;
    posY = tempPosY;
    
  }
  
  public void Update()
  {
    
    fill(0, 255, 0, myAlpha);
    textAlign(CENTER, CENTER);
    text("+" + nf(myText,2, 0), posX, posY);
    myAlpha-= 6;
    
    if(myAlpha <= 0)
    {
      alive = false;
    }
    
  }
  
}


AudioPlayer menuMusic;
AudioPlayer mainMusic;
AudioPlayer shoot;
AudioPlayer reload;
AudioPlayer emptyShot;
AudioPlayer menu;
AudioPlayer error;
AudioPlayer hit;
AudioPlayer hurt;
AudioPlayer kill;
AudioPlayer upgrade;
AudioPlayer dying;
AudioPlayer waveClear;
AudioPlayer music1;
AudioPlayer music2;

Minim minim;

public void soundSetup()
{

  minim = new Minim(this);

  mainMusic = minim.loadFile("mainMusic.mp3");
  menuMusic = minim.loadFile("menuMusic.mp3");
  music1 = minim.loadFile("music1.mp3");
  music2 = minim.loadFile("music2.mp3");
  
  shoot = minim.loadFile("shoot.wav");
  waveClear = minim.loadFile("waveClear.wav");
  reload = minim.loadFile("reload.wav");
  emptyShot = minim.loadFile("emptyShot.wav");
  menu = minim.loadFile("menu.wav");
  error = minim.loadFile("error.wav");
  hit = minim.loadFile("hit.wav");
  hurt = minim.loadFile("hurt.wav");
  kill = minim.loadFile("kill.wav");
  upgrade = minim.loadFile("upgrade.wav");
  dying = minim.loadFile("dying.wav");
  
  menuMusic.setGain(-5);
  mainMusic.setGain(-5);
  music1.setGain(-5);
  music2.setGain(-5);
  shoot.setGain(-10);
  error.setGain(14);
}

class Trail
{

  float posX = 0;
  float posY = 0;
  float mySize = 40;
  int myAlpha = 50;
  int myColor1 = 0;
  int myColor2 = 0;
  int myColor3 = 0;
  boolean alive = true;
  int timer = 0;


  Trail(float tempPosX, float tempPosY, float tempSize, int tempColor1, int tempColor2, int tempColor3)
  {

    posX = tempPosX;
    posY = tempPosY;
    mySize = tempSize;
    myColor1 = tempColor1;
    myColor2 = tempColor2;
    myColor3 = tempColor3;
  } 

  public void Update()
  {

    noStroke();
    fill(myColor1, myColor2, myColor3, myAlpha);
    ellipse(posX, posY, mySize, mySize);

    myAlpha -= 1;
    mySize *= .92f;

    timer++;
    if (timer > 20) alive = false;
  }
}

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--full-screen", "--bgcolor=#666666", "--stop-color=#cccccc", "FinalAssignment" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
