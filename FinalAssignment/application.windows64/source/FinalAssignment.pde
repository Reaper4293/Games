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


void setup()
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

  enemySpeed = .9;
  enemyHealth = .9;
  enemyDamage = .9;

  player1 = new Player(width/2, height/2);

  //Shop buttons
  button1 = new Button(50, height/20 * 4, 150, 50, 1, 100, "Lives");
  button2 = new Button(50, height/20 * 6, 150, 50, player1.maxHealth, 25, "Heal");
  button3 = new Button(50, height/20 * 8, 150, 50, 1, 50, "Max Health");
  button4 = new Button(50, height/20 * 10, 150, 50, .5, 50, "Damage");
  button5 = new Button(50, height/20 * 12, 150, 50, 5, 50, "Max Ammo");
  button6 = new Button(50, height/20 * 14, 150, 50, .5, 50, "Fire Rate");
  button7 = new Button(50, height/20 * 16, 150, 50, .5, 50, "Mobility");

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

void draw()
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

        enemySpeed *= 1.1;
        enemyHealth *= 1.1;
        enemyDamage *= 1.1;

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

boolean AreWeColliding(float c1px, float c1py, float c1s, float c2px, float c2py, float c2s)
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

boolean IsMouseTouchingRect (int rx, int ry, int rWidth, int rHeight)
{

  if (mouseX > rx && mouseX < rx + rWidth && mouseY > ry && mouseY < ry + rHeight) //if a point is within the bounds of the rect
  {
    return true;
  } else {
    return false;
  }
}

