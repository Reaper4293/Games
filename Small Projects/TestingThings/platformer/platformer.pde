Player player1;

void setup()
{

  size(800, 600);
  player1 = new Player();
}

void draw()
{

  background(255);
  drawEnvironment();
  player1.Update();
  player1.Animations();
  
}

