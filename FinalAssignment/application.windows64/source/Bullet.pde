
class Bullet 
{

  float posX = 0;
  float posY = 0;
  float mySize = 4;
  float speed = 10;


  float distanceX = 0;
  float distanceY = 0;
  float angleInDegrees = 0;
  float angleInRadians = 0;
  float vectorY = 0;
  float vectorX = 0;
  
  int trailColor = 255;
  int myColor1 = 0;
  int myColor2 = 0;
  boolean alive = true;
  int timer = 0;


  Bullet(float tempPosX, float tempPosY, int tempColor1, int tempColor2, float tempdistanceX, float tempdistanceY)
  {

    posX = tempPosX;
    posY = tempPosY;
    myColor1 = tempColor1;
    myColor2 = tempColor2;
    distanceX = tempdistanceX;
    distanceY = tempdistanceY;
  } 

  void Update()
  {
    if(player1.fireRate >= 2)
    {
      trailColor = 0;
    }else{
      trailColor = 255;
    }
    
    if(player1.maxAmmo >= 20)
    {
      mySize = 6;
    }else{
      mySize = 4;
    }
    
    trailList.add(new Trail(posX, posY, mySize, 255, 255, trailColor));
    
    noStroke();
    
    
    fill(0, myColor1, myColor2);
    if(player1.damage >= 2)
    {
      fill(255,0,0);
    }
    
    ellipse(posX, posY, mySize, mySize);

    //angle in degrees
    angleInDegrees = atan2(distanceY, distanceX) * 180 / PI;

    if (angleInDegrees<0) 
    { 
      angleInDegrees *= -1;
    } 
    else if (angleInDegrees > 0) 
    {
      angleInDegrees = 180 + (180-angleInDegrees);
    }

    angleInRadians = -angleInDegrees*0.01747722222222222222222;
    vectorY = sin(angleInRadians);
    vectorX = cos(angleInRadians);

    //X and Y velocity
    posY += vectorY * speed;
    posX += vectorX * speed;

    timer++;

    if (timer > 120) alive = false;
  }
}

void DeleteDeadObjects()
{
  //bullets have a lifetime
  for (int i =0; i < bulletList.size(); i++)
  {
    if (bulletList.get(i).alive == false)
    {
      bulletList.remove(i);
    }
  }

  for (int e = 0; e < enemyList.size(); e++)
  {
    //IF AN ENEMY GETS KILLED
    if (enemyList.get(e).health <= 0)
    {
      scoreList.add(new ScoreText(enemyList.get(e).score * multiplier, enemyList.get(e).posX, enemyList.get(e).posY));
      
      score += enemyList.get(e).score * multiplier;
      player1.credits += enemyList.get(e).score/10 * multiplier;
      multiplier += 0.1;
      multiplierTimer = 0;
      
      enemyList.remove(e);
      kill.pause();
      kill.rewind();
      kill.play();
      
      
    }
  }
  
  //trail gets deleted
  for(int i = 0; i < trailList.size(); i++)
  {
    if(trailList.get(i).alive == false)
    {
      trailList.remove(i);
    }
  }
  
  //scores get deleted
  for (int i =0; i < scoreList.size(); i++)
  {
    if (scoreList.get(i).alive == false)
    {
      scoreList.remove(i);
    }
  }
}

