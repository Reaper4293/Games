PImage ammo;
PImage health;
PImage wall;
PImage speed;
PImage damage;
PImage shrink;

void randomPowerUps()
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

