class Trail
{
  
  int posX = 0;
  int posY = 0;
  int mySize = 40;
  int myAlpha = 50;
  int myColor1 = 0;
  int myColor2 = 0;
  boolean alive = true;
  int timer = 0;
  
  
  Trail(int tempPosX, int tempPosY, int tempSize, int tempColor1, int tempColor2)
  {
    
    posX = tempPosX;
    posY = tempPosY;
    mySize = tempSize;
    myColor1 = tempColor1;
    myColor2 = tempColor2;
  } 
  
  void Update()
  {
    
    noStroke();
    fill(0, myColor1, myColor2, myAlpha);
    ellipse(posX, posY, mySize, mySize);
    
    myAlpha -= 1;
    mySize *= .9999999;
    
    timer++;
    if(timer > 30) alive = false;
  }
  
}
