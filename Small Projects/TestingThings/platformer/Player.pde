class Player
{
  int posX;
  int posY;
  int myLength;
  int myWidth;
  
  boolean movingRight = false;
  boolean movingLeft = false;
  boolean recentlyRight = true;
  boolean recentlyLeft = false;

  float speed = 5;
  boolean sprint = false;

  boolean jumping = false;
  boolean canJump = true;
  int jumpTimeLimit = 20;
  int jumpTime = 0;
  float verticalSpeed = 0;

  PImage idleR;
  PImage w1R;
  PImage w2R;
  PImage idleL;
  PImage w1L;
  PImage w2L;
  int animTimer = 0;
  int animFramerate = 8;

  Player()
  {
    posX = width/2;
    posY = height - 100 - myLength;
    myLength = 56;
    myWidth = 32;
    idleR = loadImage("idleR.png");
    w1R = loadImage("walk1R.png");
    w2R = loadImage("walk2R.png");
    idleL = loadImage("idleL.png");
    w1L = loadImage("walk1L.png");
    w2L = loadImage("walk2L.png");
  }

  void Update()
  {
    
    if(sprint && movingRight || sprint && movingLeft)
    {
      speed+=.1;
      if(speed >= 10) speed = 10;
      
    }else{
      speed = 5;
    }

    //Moving Right
    if (movingRight)
    {
      posX+=speed;
    }

    //Moving Left
    if (movingLeft)
    {
      posX-=speed;
    }
    
    
    posY -= verticalSpeed;
    text(animTimer, 5, 17);

    //While jumping
    if (jumping)
    {
      verticalSpeed = 10;
      jumpTime++;
      if (jumpTime >= jumpTimeLimit)
      {
        canJump = false;
        jumping = false;
        jumpTime = 0;
      }
    } else { //While falling 
      if (posY < height - 100 - myLength)
      {
        verticalSpeed -= 1;
      }
      //When on the ground
      if (posY >= height - 100 - myLength)
      {
        canJump = true;
        verticalSpeed = 0;
        posY = height - 100 - myLength;
      }
    }
    
    fill(0);
    rect(posX, posY, myWidth, myLength);
    
  }

  void Animations()
  {
    //animation while moving right
    if (movingRight) 
    {
      animTimer++;
      if (animTimer >= animFramerate * 3) animTimer = 0;
      if (animTimer < animFramerate * 1) image(w1R, posX, posY);
      else if (animTimer < animFramerate * 2) image(w2R, posX, posY);
      else if (animTimer < animFramerate * 3) image(idleR, posX, posY);
    } 
    
    //Animation while not moving
    if(!movingRight && !movingLeft)
    {
      animTimer = 0;
      if(recentlyRight){ image(idleR, posX, posY);}else
      if(recentlyLeft){ image(idleL, posX, posY);}
    }
    
    //animation while moving left
    if (movingLeft) 
    {
      animTimer++;
      if (animTimer >= animFramerate * 3) animTimer = 0;
      if (animTimer < animFramerate * 1) image(w1L, posX, posY);
      else if (animTimer < animFramerate * 2) image(w2L, posX, posY);
      else if (animTimer < animFramerate * 3) image(idleL, posX, posY);
    } 
  }
  
}

