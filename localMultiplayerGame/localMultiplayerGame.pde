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

void setup()
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


void draw()
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

boolean IsMouseTouchingRect (int rx, int ry, int rWidth, int rHeight)
{

  if (mouseX > rx && mouseX < rx + rWidth && mouseY > ry && mouseY < ry + rHeight) //if a point is within the bounds of the rect
  {
    return true;
  }
  else {
    return false;
  }
}

boolean AreWeColliding(int c1px, int c1py, int c1s, int c2px, int c2py, int c2s)
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

void mousePressed() 
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

