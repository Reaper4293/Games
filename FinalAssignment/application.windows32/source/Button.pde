
class Button 
{

  int posX;
  int posY;
  int myWidth;
  int myHeight;
  
  float statIncrease;
  float cost;

  String myText;
  

  Button(int tempPosX, int tempPosY, int tempMyWidth, int tempMyHeight, float tempStatIncrease, float tempCost, String tempMyText)
  {
    posX = tempPosX;
    posY = tempPosY;
    myWidth = tempMyWidth;
    myHeight = tempMyHeight;
    statIncrease = tempStatIncrease;
    cost = tempCost;

    myText = tempMyText;
  }
  
  Button(int tempPosX, int tempPosY, int tempMyWidth, int tempMyHeight, String tempMyText)
  {
    posX = tempPosX;
    posY = tempPosY;
    myWidth = tempMyWidth;
    myHeight = tempMyHeight;
    myText = tempMyText;
  }

  void Update()
  {

    fill(255);
    strokeWeight(2);
    
    if (player1.credits >= cost) //rect 2 values
    {

      stroke(0, 200, 0);
    }
    else if(player1.credits < cost)
    {
      stroke(255, 0, 0);
    }
    
    
    if (IsMouseTouchingRect(posX, posY, myWidth, myHeight) && player1.credits >= cost) //rect 2 values
    {

      fill(100, 255, 100);
    }
    else if(IsMouseTouchingRect(posX, posY, myWidth, myHeight) && player1.credits < cost)
    {
      fill(255, 100, 100);
    }else{
      fill(255);
    }

    textAlign(CENTER, CENTER);
    rect(posX, posY, myWidth, myHeight); //rect 2
    fill(0);
    textFont(myFont, 24);
    text(myText, posX + myWidth/2, posY + myHeight/2);
    fill(0, 255, 0);
    text("+" + nf(statIncrease, 0, 0), posX + myWidth + 50, posY + myHeight/2);
    //textAlign(LEFT, CENTER);
    fill(255, 0, 0);
    text("$" + nf(cost, 2, 0), posX + myWidth + 140, posY + myHeight/2);
    stroke(0);
    strokeWeight(1);
  }
  
  void Update1()
  {

    if (IsMouseTouchingRect(posX, posY, myWidth, myHeight)) //rect 2 values
    {

      fill(255, 255, 0);
    }
    else {
      fill(255);
    }

    textAlign(CENTER, CENTER);
    rect(posX, posY, myWidth, myHeight); //rect 2
    fill(0);
    textFont(myFont, 24);
    text(myText, posX + myWidth/2, posY + myHeight/2);
    
    
  }

  
  
}

