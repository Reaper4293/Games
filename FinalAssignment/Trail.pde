class Trail
{

  float posX = 0;
  float posY = 0;
  float mySize = 40;
  int myAlpha = 50;
  int myColor1 = 0;
  int myColor2 = 0;
  int myColor3 = 0;
  boolean alive = true;
  int timer = 0;


  Trail(float tempPosX, float tempPosY, float tempSize, int tempColor1, int tempColor2, int tempColor3)
  {

    posX = tempPosX;
    posY = tempPosY;
    mySize = tempSize;
    myColor1 = tempColor1;
    myColor2 = tempColor2;
    myColor3 = tempColor3;
  } 

  void Update()
  {

    noStroke();
    fill(myColor1, myColor2, myColor3, myAlpha);
    ellipse(posX, posY, mySize, mySize);

    myAlpha -= 1;
    mySize *= .92;

    timer++;
    if (timer > 20) alive = false;
  }
}

