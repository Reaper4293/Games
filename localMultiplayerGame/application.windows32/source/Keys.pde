void keyPressed()
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

void keyReleased()
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
