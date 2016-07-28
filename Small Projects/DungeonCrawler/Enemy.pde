class Enemy
{

  float posX = 0;
  float posY = 0;
  float mySize = 20;
  float health = 1;
  float speed = 3;
  float damage = 1;
  float mySize1 = 0; //for hollow circle
  float color1 = 0;
  float color2 = 127;
  float color3 = 255;

  float score = 120;

  int type = (int)random(1, 3);
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

      speed = speed * 1.5;
      mySize = mySize * 1.5;
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

  void Update()
  {



    //Chaser Enemies
    if (type == 1)
    {
      noFill();
      stroke(255, 0, 0);
      ellipse(posX, posY, mySize1, mySize1);
      mySize1++; 

      if (mySize1 >= mySize * 5)
      {
        mySize1 = 0;
      }

      if (AreWeColliding(player1.positionX, player1.positionY, player1.mySize, posX, posY, mySize1))
      {
        speed = room11.enemySpeed * 1.5;
        fill(255, 0, 0);
      } else {
        speed = room11.enemySpeed;
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



      if (type == 2)
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

        if (posY >= height - mySize/2 - room11.wallThickness)
        {
          mu = true;
          md = false;
        }

        if (posY <= 0 + mySize/2 + room11.wallThickness)
        {
          mu = false;
          md = true;
        }

        if (posX >= width - mySize/2 - room11.wallThickness)
        {
          ml = true;
          mr = false;
        }

        if (posX <= 0 + mySize/2 + room11.wallThickness)
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

