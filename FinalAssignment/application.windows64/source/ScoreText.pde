class ScoreText
{
  
  float myText;
  float posX;
  float posY;
  int myAlpha = 255;
  
  boolean alive = true;
  
  ScoreText(float tempMyText, float tempPosX, float tempPosY)
  {
    myText = tempMyText;
    posX = tempPosX;
    posY = tempPosY;
    
  }
  
  void Update()
  {
    
    fill(0, 255, 0, myAlpha);
    textAlign(CENTER, CENTER);
    text("+" + nf(myText,2, 0), posX, posY);
    myAlpha-= 6;
    
    if(myAlpha <= 0)
    {
      alive = false;
    }
    
  }
  
}
