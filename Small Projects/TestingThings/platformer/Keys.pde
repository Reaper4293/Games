void keyPressed()
{

  if (key == ' ' && player1.canJump) //keyCode == UP
  {
    player1.jumping = true;
  }
  
  if (key == 'd' || key == 'D') //keyCode == UP
  {
    player1.movingRight = true;
    player1.movingLeft = false;
    player1.recentlyRight = true;
    player1.recentlyLeft = false;
  }
  
  if (key == 'a' || key == 'A') //keyCode == UP
  {
    player1.movingLeft = true;
    player1.movingRight = false;
    player1.recentlyLeft = true;
    player1.recentlyRight = false;
  }
  
  if (keyCode == SHIFT)
  {
    player1.sprint = true;    
  }
}

void keyReleased()
{

  if (key == ' ' )
  {
    player1.jumping = false;
    player1.canJump = false;
    player1.jumpTime = 0;
  }
  
  if (key == 'd' || key == 'D' ) //keyCode == UP
  {
    player1.movingRight = false;
  }
  
  if (key == 'a' || key == 'A') //keyCode == UP
  {
    player1.movingLeft = false;
  }
  
  if (keyCode == SHIFT)
  {
    player1.sprint = false;    
  }
  
}
