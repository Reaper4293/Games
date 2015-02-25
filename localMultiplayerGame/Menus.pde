
void mainMenu()
{

  background(0);

  fill(255);
  textFont(myFont, 48);
  text("The Best Game 2: The Second Game", 100, 250); 

  if (IsMouseTouchingRect(300, 400, 150, 50)) //rect 1 values
  {

    fill(255, 0, 0);
  }
  else {
    fill(255);
  }

  rect(300, 400, 150, 50); //rect 1
  fill(0);
  textFont(myFont, 24);
  text("Play", 350, 435); 

  if (IsMouseTouchingRect(550, 400, 150, 50)) //rect 2 values
  {
    fill(255, 0, 0);
  }
  else {
    fill(255);
  }

  rect(550, 400, 150, 50); //rect 2
  fill(0);
  textFont(myFont, 24);
  text("Rules", 595, 435);
}

void rules()
{

  background(0);

  fill(255);
  textFont(myFont, 48);
  text("Rules", 425, 100);
  textFont(myFont, 24);
  text("Reduce the opposing player's heath to 0 to win", 60, 150);
  text("Walls can block bullets but will be destroyed after 5 hits", 60, 175);
  text("Ammo starts at 5, regenerates every second and soft caps at 20", 60, 200);
  text("Health starts at 15 and is capped at 30", 60, 225);
  
  text("Power Ups spawn in the center of the arena every 5 seconds", 60, 275);
  text("Health +5, Ammo +10, Speed +1, Shrink -5, Damage +1, Wall Repair", 60, 300);
  
  
  text("Player 1 Moves with WASD and shoots with F", 60, 350);
  text("Player 2 Moves with arrow keys and shoots with 0", 60, 375);

  if (IsMouseTouchingRect(420, 400, 150, 50)) //rect 1 values
  {

    fill(255, 0, 0);
  }
  else {
    fill(255);
  }

  rect(420, 400, 150, 50); //rect 1
  fill(0);
  textFont(myFont, 24);
  text("Main Menu", 437, 435);
}

void win()
{

  background(0);

  fill(255);
  textFont(myFont, 48);
  text(winner + " Wins!", 320, 100);
  textFont(myFont, 24);
  text("", 60, 275);
  
  

  if (IsMouseTouchingRect(420, 400, 150, 50)) //rect 1 values
  {

    fill(255, 0, 0);
  }
  else {
    fill(255);
  }

  rect(420, 400, 150, 50); //rect 1
  fill(0);
  textFont(myFont, 24);
  text("Main Menu", 437, 435);
}

