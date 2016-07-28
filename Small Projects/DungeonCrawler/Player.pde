
class Player
{

  float positionX = 0;
  float positionY = 0;
  int mySize = 40;
  int currentRoom = 02;
  int myAlpha = 255;

  int myColor1 = 255;
  int myColor2 = 15;
  
  boolean visited11 = false;
  boolean visited12 = false;
  boolean visited13 = false;
  boolean visited21 = false;
  boolean visited22 = false;
  boolean visited23 = false;
  boolean visited31 = false;
  boolean visited32 = false;
  boolean visited33 = false;
  int visitedColor = 150;
  int currentColor = 250;

  boolean mu = false;
  boolean md = false;
  boolean ml = false;
  boolean mr = false;

  int maxHealth = 6;
  int health = 6;
  float speed = 5;
  float damage = 1;
  int amountKeys = 0;

  boolean swing = false;
  float swingPosX;
  float swingPosY;
  int swingRange = 60;
  float swingAngle;
  float swingTimer = 3;
  float swingTime = 0;

  boolean isHit = false;
  boolean vulnerable = true;
  int hitTimer = 0;
  int vulnerableTimer = 0;


  Player( float tempPositionX, float tempPositionY)
  {

    positionX = tempPositionX;
    positionY = tempPositionY;
  }

  void Update()
  {

    DrawHUD();


    if (player1.currentRoom == 02)
    {
      room02.Update();
    }
    if (player1.currentRoom == 11)
    {
      room11.Update();
      visited11 = true;
    } else if (player1.currentRoom == 12)
    {
      room12.Update();
      visited12 = true;
    } else if (player1.currentRoom == 13)
    {
      room13.Update();
      visited13 = true;
    } else if (player1.currentRoom == 21)
    {
      room21.Update();
      visited21 = true;
    } else if (player1.currentRoom == 22)
    {
      room22.Update();
      visited22 = true;
    } else if (player1.currentRoom == 23)
    {
      room23.Update();
      visited23 = true;
    } else if (player1.currentRoom == 31)
    {
      room31.Update();
      visited31 = true;
    } else if (player1.currentRoom == 32)
    {
      room32.Update();
      visited32 = true;
    } else if (player1.currentRoom == 33)
    {
      room33.Update();
      visited33 = true;
    } else if (player1.currentRoom == 42)
    {
      room42.Update();

    }


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

    if (vulnerable == false)
    {
      stroke(255);
    }

    ellipse(positionX, positionY, mySize, mySize);

    textFont(myFont, 16);
    text(amountKeys, 100, 100);

    if (swing)
    {
      
      player1.swingAngle = atan2(mouseY-player1.positionY, mouseX-player1.positionX) * 180/PI;

      if (player1.swingAngle < 0)
      {
        player1.swingAngle *= -1;
      } else {
        player1.swingAngle = 180 + (180-player1.swingAngle);
      }

      player1.swingAngle = -player1.swingAngle * 0.01747722222222222222222;
      player1.swingPosY = player1.positionY + sin(player1.swingAngle) * player1.mySize/2;
      player1.swingPosX = player1.positionX + cos(player1.swingAngle) * player1.mySize/2;

      fill(255, 127, 0, 100);
      ellipse(swingPosX, swingPosY, swingRange, swingRange);
      //ellipse(swingPosX + cos(player1.swingAngle) * player1.mySize/4, swingPosY + sin(player1.swingAngle) * player1.mySize/4, swingRange, swingRange);
      //ellipse(swingPosX + cos(player1.swingAngle) * player1.mySize/2, swingPosY + sin(player1.swingAngle) * player1.mySize/2, swingRange, swingRange);
      //ellipse(swingPosX + cos(player1.swingAngle) * player1.mySize/4*3, swingPosY + sin(player1.swingAngle) * player1.mySize/4*3, swingRange, swingRange);
      //ellipse(swingPosX + cos(player1.swingAngle) * player1.mySize, swingPosY + sin(player1.swingAngle) * player1.mySize, swingRange, swingRange);
     

      swingTime++;
    } else {
      swingPosX = -100;
      swingPosY = -100;
    }

    if (swingTime > swingTimer)
    {
      swing = false;
      swingTime = 0;
    }



    MovementLogic();
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
  }

  void DrawHUD()
  {

    for (int i=0; i < maxHealth/2 * 22; i+=22)
    {
      image(emptyHeart, 40+i, 40);
    }

    if (health%2 == 0)
    {
      for (int i=0; i < health/2 * 22; i+=22)
      {
        image(fullHeart, 40+i, 40);
      }
    } else {

      for (int i=0; i < (health-1)/2 * 22; i+=22)
      {
        image(fullHeart, 40+i, 40);
      }

      if (health > 0) image(halfHeart, 40 + health/2 * 22, 40);
    }
    
    fill(0);
    if(visited11) fill(visitedColor);
    if(currentRoom == 11) fill(currentColor);
    rect(900, 70, 14, 9);
    
    fill(0);
    if(visited12) fill(visitedColor);
    if(currentRoom == 12) fill(currentColor);
    rect(916, 70, 14, 9);
    
    fill(0);
    if(visited13) fill(visitedColor);
    if(currentRoom == 13) fill(currentColor);
    rect(932, 70, 14, 9);
    
    fill(0);
    if(visited21) fill(visitedColor);
    if(currentRoom == 21) fill(currentColor);
    rect(900, 59, 14, 9);
    
    fill(0);
    if(visited22) fill(visitedColor);
    if(currentRoom == 22) fill(currentColor);
    rect(916, 59, 14, 9);
    
    fill(0);
    if(visited23) fill(visitedColor);
    if(currentRoom == 23) fill(currentColor);
    rect(932, 59, 14, 9);
    
    fill(0);
    if(visited31) fill(visitedColor);
    if(currentRoom == 31) fill(currentColor);
    rect(900, 48, 14, 9);
    
    fill(0);
    if(visited32) fill(visitedColor);
    if(currentRoom == 32) fill(currentColor);
    rect(916, 48, 14, 9);
    
    fill(0);
    if(visited33) fill(visitedColor);
    if(currentRoom == 33) fill(currentColor);
    rect(932, 48, 14, 9);
    
    
    /*for(int x=0; x<45; x+=16)
    {
      fill(0);
      for(int y=0; y<30; y+=11)
      {
        fill(255);
        rect(900+x, 70-y, 14, 9);
        
      } 
    }*/
    
    
    
  }
}

