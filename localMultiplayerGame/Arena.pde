class Wall
{
  int positionX = 0;
  int positionY = 0;
  int myHeight = 80;
  int myWidth = 10;
  int health = 5;
  boolean alive = true;


  void makeWall(int tempPositionX, int tempPositionY)
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

