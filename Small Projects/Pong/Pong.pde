PFont myFont;
int neg = 1;

int scorePlayer1 = 0;
int scorePlayer2 = 0;

int ballPositionX = 400;
int ballPositionY = 300;

int ballSize = 10;
float ballVelocityX = (int)random(2,7);
float ballVelocityY = (int)random(2,7);

int paddle1PositionX = 5;
int paddle1PositionY = 260;

int paddle2PositionX = 780;
int paddle2PositionY = 260;

int paddleHeight = 100;
int paddleWidth = 15;

int paddleSpeed = 10;

boolean player1MovingUp = false;
boolean player1MovingDown = false;
boolean player2MovingUp = false;
boolean player2MovingDown = false;

void setup()
{
  textAlign(CENTER);
  size(800, 600);
  myFont = loadFont("ComicSans.vlw");
  textFont(myFont, 48);
}


void draw()
{

  background(0);
  
  text(scorePlayer1, 150, 100);
  text(scorePlayer2, 650, 100);
  
  //gameover logic
  if(scorePlayer1 == 10 || scorePlayer2 == 10)
  { 
    scorePlayer1 = 0;
    scorePlayer2 = 0;
  }

  //paddle1
  rect(paddle1PositionX, paddle1PositionY, paddleWidth, paddleHeight);

  //paddle2
  rect(paddle2PositionX, paddle2PositionY, paddleWidth, paddleHeight);
  
  //center line
  rect(width/2 - 1, 0, 2, height);

  //ball
  ellipse(ballPositionX, ballPositionY, ballSize, ballSize);
  
  if(player1MovingUp)
  {
    paddle1PositionY -= paddleSpeed;
  }
  
  if(player1MovingDown)
  {
    paddle1PositionY += paddleSpeed;
  }
  
  if(player2MovingUp)
  {
    paddle2PositionY -= paddleSpeed;
  }
  
  if(player2MovingDown)
  {
    paddle2PositionY += paddleSpeed;
  }
  
  if(paddle1PositionY < 0)
  {
    paddle1PositionY = 0;
  }
  
  if(paddle2PositionY < 0)
  {
    paddle2PositionY = 0;
  }
  
  if(paddle1PositionY > height-paddleHeight)
  {
    paddle1PositionY = height - paddleHeight;
  }
  
  if(paddle2PositionY > height-paddleHeight)
  {
    paddle2PositionY = height - paddleHeight;
  }
  
  //ball movement logic
  ballPositionX += ballVelocityX;
  ballPositionY += ballVelocityY;
  
  //ball bounce off top and bottom of the screen
  if(ballPositionY < 0)
  {
    ballVelocityY = -ballVelocityY;
    ballPositionY = 0;
  }
  
  if(ballPositionY > height)
  {
    ballVelocityY = -ballVelocityY;
    ballPositionY = height;
  }
  
  //ball off the sides of the screen - score a point and reset
  
  if(ballPositionX < 0)
  {
   
    scorePlayer2++;
    ballPositionX = width/2;
    ballPositionY = height/2;
    
    //randomize positive or negative
    neg = (int)random(0,2);
    if(neg == 1)
    {
      neg = 1;
    }else{
      neg = -1;
    }
    
    ballVelocityX = neg * (int)random(2,7);
    
    //randomize positive or negative
    neg = (int)random(0,2);
    if(neg == 1)
    {
      neg = 1;
    }else{
      neg = -1;
    }
    ballVelocityY = neg * (int)random(2,7);
  }
  
  if(ballPositionX > width)
  {
    
    scorePlayer1++;
    ballPositionX = width/2;
    ballPositionY = height/2;
    
    //randomize positive or negative
   neg = (int)random(0,2);
    if(neg == 1)
    {
      neg = 1;
    }else{
      neg = -1;
    }
    ballVelocityX = neg * (int)random(2,7);
     
     //randomize positive or negative
     neg = (int)random(0,2);
    if(neg == 1)
    {
      neg = 1;
    }else{
      neg = -1;
    }
    ballVelocityY = neg * (int)random(2,7);
  }
  
  //ball bounce off of paddles
  if (ballPositionX < paddle1PositionX + paddleWidth)
  {
    if(ballPositionY > paddle1PositionY && ballPositionY < paddle1PositionY + paddleHeight)
    {
      ballVelocityX = -ballVelocityX;
      ballPositionX = paddle1PositionX + paddleWidth;
      
      //speed up ball
      if(ballVelocityX > 0)
      {
        ballVelocityX += 1;
      }else{
        ballVelocityX -= 1;
      }
      
      if(ballVelocityY > 0)
      {
        ballVelocityY += .5;
      }else{
        ballVelocityY -= .5;
      }
      
      //top half
      if(ballPositionY > paddle1PositionY && ballPositionY < paddle1PositionY + paddleHeight/2)
      {
        ballVelocityY = -1 * abs(ballVelocityY);
      }
      
      //bot half
      if(ballPositionY > paddle1PositionY + paddleHeight/2 && ballPositionY < paddle1PositionY + paddleHeight)
      {
        ballVelocityY = abs(ballVelocityY);
      }
      
    }
  }
  
  if (ballPositionX > paddle2PositionX)
  {
    if(ballPositionY > paddle2PositionY && ballPositionY < paddle2PositionY + paddleHeight)
    {
      ballVelocityX = -ballVelocityX;
      ballPositionX = paddle2PositionX;
      
      //speed up ball
      if(ballVelocityX > 0)
      {
        ballVelocityX += 1;
      }else{
        ballVelocityX -= 1;
      }
      
      if(ballVelocityY > 0)
      {
        ballVelocityY += .5;
      }else{
        ballVelocityY -= .5;
      }
      
      //top half
      if(ballPositionY > paddle2PositionY && ballPositionY < paddle2PositionY + paddleHeight/2)
      {
        ballVelocityY = -1 * abs(ballVelocityY);
      }
      
      //bot half
      if(ballPositionY > paddle2PositionY + paddleHeight/2 && ballPositionY < paddle2PositionY + paddleHeight)
      {
        ballVelocityY = abs(ballVelocityY);
      }
      
    }
  }
  
}

void keyPressed()
{

  if (keyCode == UP)
  {

    player2MovingUp = true;
  }

  if (keyCode == DOWN)
  {

    player2MovingDown = true;
  }
  
  if(key == 'w')
  {
    player1MovingUp = true;
  }
  
  if(key == 's')
  {
    player1MovingDown = true;
  }
}

void keyReleased()
{

  if (keyCode == UP)
  {

    player2MovingUp = false;
  }

  if (keyCode == DOWN)
  {

    player2MovingDown = false;
  }
  
  if(key == 'w')
  {
    player1MovingUp = false;
  }
  
  if(key == 's')
  {
    player1MovingDown = false;
  }
}

