void keyPressed()
{

  if (key == 'W' || key == 'w') //keyCode == UP
  {
    player1.boost = true;
  }
  
  if (key == 'S' || key == 's') //keyCode == UP
  {
    player1.reverse = true;
  }
  
  if (key == 'A' || key == 'a') //keyCode == UP
  {
    player1.rotateLeft = true;
  }
  
  if (key == 'D' || key == 'd') //keyCode == UP
  {
    player1.rotateRight = true;
  }
  
}

void keyReleased()
{
  
  if (key == 'W' || key == 'w') //keyCode == UP
  {
    player1.boost = false;
  }
  
  if (key == 'S' || key == 's') //keyCode == UP
  {
    player1.reverse = false;
  }

  if (key == 'A' || key == 'a') //keyCode == UP
  {
    player1.rotateLeft = false;
  }
  
  if (key == 'D' || key == 'd') //keyCode == UP
  {
    player1.rotateRight = false;
  }
}
