
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

  void Update(int myColor1, int myColor2, int textPosition)
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
    
    healthAuraSize+= .25;
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

  void MovementLogic()
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

