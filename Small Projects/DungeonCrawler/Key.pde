float keyPositionX = 9999;
float keyPositionY = 400;
float keySize = 15;


void Key()
{



  fill(255, 255, 0);
  ellipse(keyPositionX, keyPositionY, keySize, keySize);

  if (AreWeColliding(player1.positionX, player1.positionY, player1.mySize, keyPositionX, keyPositionY, keySize))
  {
    keyPositionX = 9999;
    player1.amountKeys++;
  }
  
  
}

