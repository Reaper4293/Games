
void mainMenu()
{

  background(0);

  fill(255);
  textFont(myFont, 48);
  textAlign(CENTER, CENTER);
  text("Shape Survivor", width/2, height/20 * 5); 
  
  button10.Update1();
  button11.Update1();
  button12.Update1();
  
  if (!readyToPlay)
  {
    stroke(255,255,0);
    strokeWeight(2);
    noFill();
    rect(button11.posX, button11.posY, button11.myWidth, button11.myHeight);
    stroke(0);
    strokeWeight(1);
  }
}

void gameOver()
{

  background(0);

  fill(255, 0, 0);
  textFont(myFont, 48);
  textAlign(CENTER, CENTER);
  text("Game Over", width/2, height/20 * 5);
  
  textFont(myFont, 32);
  if(score == highScore)
  {
    fill(255,255,0);
    text("New high score!", width/2, height/20 * 7);
  }
  
  fill(255);
  text("You survived " + wave + " waves!", width/2, height/20 * 8);
  text("You had " + score + " points!", width/2, height/20 * 9);  
  
  textAlign(LEFT, CENTER);
  fill(0,255,0);
  text("Leaderboard", 25, 50);
  textFont(myFont, 18);
  fill(255);
  text("BC Waves: 30  Score: 247680", 25, 75);

  button9.Update1();
}

void rules()
{

  background(0);

  fill(255);
  textFont(myFont, 48);
  textAlign(CENTER, CENTER);
  text("Controls", width/2, height/20 * 6);
  textFont(myFont, 24);
  //text("Reduce the opposing player's heath to 0 to win", 60, 150);
  text("Shoot enemies and stay alive as long as possible", width/2, height/20 * 8);
  //text("You lose health when colliding with an enemy", width/2, 400);
  //text("When you run out of lives it's game over", width/2, 425);
  
  
  text("Use the Mouse to aim and shoot", width/2, height/20 * 9);
  text("WASD to move around", width/2, height/20 * 10);
  text("R to reload", width/2, height/20 * 11);
  text("Space to return to main menu", width/2, height/20 * 12);

  button9.Update1();
}

void shop()
{

  background(0);
  
  textAlign(CENTER, CENTER);
  
  fill(255);
  textFont(myFont, 48);
  text("Upgrades", width/2, height/20 * 2);
  fill(0, 255, 0);
  textFont(myFont, 36);
  text("Credits: $" + floor(player1.credits), 800, 100);
  textAlign(LEFT, CENTER);
  fill(255, 255, 0);
  text("Next Wave: " + (wave+1), width/2 + 100, button8.posY + button8.myHeight/2);
  textAlign(RIGHT, CENTER);
  text("Last Wave: " + wave , width/2 - 100, button8.posY + button8.myHeight/2);
  
  
  textAlign(CENTER, CENTER);
  textFont(myFont, 24);
  fill(0, 255, 0);
  text("Gain", button1.posX + button1.myWidth + 50, height/20*7/2);
  fill(255, 0, 0);
  text("Cost", button1.posX + button1.myWidth + 140, height/20*7/2);
  fill(0, 150, 255);
  text("Stats", button1.posX + button1.myWidth + 260, height/20*7/2);
  
  textAlign(LEFT, CENTER);
  fill(0, 150, 255);
  text(button1.myText + ": " + nf(player1.lives,1,0), button1.posX + button1.myWidth + 220, button1.posY + button1.myHeight/2);
  text("Health: " + nf(player1.health,0,0), button2.posX + button2.myWidth + 220, button2.posY + button2.myHeight/2);
  text(button3.myText + ": " + nf(player1.maxHealth,1,0), button3.posX + button3.myWidth + 220, button3.posY + button3.myHeight/2);
  text(button4.myText + ": " + player1.damage, button4.posX + button4.myWidth + 220, button4.posY + button4.myHeight/2);
  text(button5.myText + ": " + nf(player1.maxAmmo,1,0), button5.posX + button5.myWidth + 220, button5.posY + button5.myHeight/2);
  text(button6.myText + ": " + player1.fireRate, button6.posX + button6.myWidth + 220, button6.posY + button6.myHeight/2);
  text(button7.myText + ": " + player1.speed, button7.posX + button7.myWidth + 220, button7.posY + button7.myHeight/2);
  button1.Update();
  button2.Update();  
  button3.Update();  
  button4.Update();  
  button5.Update();  
  button6.Update(); 
  button7.Update();
  button8.Update1();
  
}
