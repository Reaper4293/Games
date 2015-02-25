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


  void Initialize(int tempPlayerNumber, int tempPositionX, int tempPositionY, float tempSpeed)
  {

    positionX = tempPositionX;
    positionY = tempPositionY;
    playerNumber = tempPlayerNumber;
    speed = tempSpeed;
  }

  void Update(int myColor1, int myColor2, int textPosition)
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

