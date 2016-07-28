
void keyPressed()
{

  if (key == 'w')
  {
    player1.mu = true;
  }

  if (key == 's')
  {
    player1.md = true;
  }

  if (key == 'a')
  {
    player1.ml = true;
  }

  if (key == 'd')
  {
    player1.mr = true;
  }
}


void keyReleased()
{
  if (key == 'w')
  {
    player1.mu = false;
  }

  if (key == 's')
  {
    player1.md = false;
  }

  if (key == 'a')
  {
    player1.ml = false;
  }

  if (key == 'd')
  {
    player1.mr = false;
  }
}

void mouseReleased()
{
  player1.swing = false;
  player1.swingTime = 0;
}

void mousePressed()
{
  player1.swing = true;
  
}
