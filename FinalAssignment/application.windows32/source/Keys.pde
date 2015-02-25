void keyPressed()
{

  if (key == 'w' && player1.canMove == true || key == 'W' && player1.canMove == true || keyCode == UP && player1.canMove == true)
  {
    player1.mu = true;
  }

  if (key == 's' && player1.canMove == true || key == 'S' && player1.canMove == true || keyCode == DOWN && player1.canMove == true)
  {
    player1.md = true;
  }

  if (key == 'a' && player1.canMove == true || key == 'A' && player1.canMove == true || keyCode == LEFT && player1.canMove == true)
  {
    player1.ml = true;
  }

  if (key == 'd' && player1.canMove == true || key == 'D' && player1.canMove == true || keyCode == RIGHT && player1.canMove == true)
  {
    player1.mr = true;
  }

  if (key == ' ')
  {
    gameState = 0;

    if (musicPlaying == false)
    {
      menuMusic.pause();
      menuMusic.rewind();
      menuMusic.loop();

      musicPlaying = true;
    }

    mainMusic.pause();
    music1.pause();
    music2.pause();
  }

  if (key == 'r' && player1.ammo < player1.maxAmmo || keyCode == SHIFT && player1.ammo < player1.maxAmmo || keyCode == ALT && player1.ammo < player1.maxAmmo)
  {
    if (!player1.reloading && player1.health > 0)
    {
      player1.reloading = true;

      reload.pause();
      reload.rewind();
      reload.play();
    }
  }
}

void mouseReleased()
{
  player1.shooting = false;
}

void mousePressed()
{
  

  if (gameState == 1 && mouseButton == LEFT)
  {
    player1.shooting = true;
  } else if (gameState == 1 && player1.ammo <= 0 && player1.reloading == false)
  {

    emptyShot.pause();
    emptyShot.rewind();
    emptyShot.play();
  } else {
    player1.shooting = false;
  }


  if (IsMouseTouchingRect(button10.posX, button10.posY, button10.myWidth, button10.myHeight) && gameState == 0 && readyToPlay) //press play button
  { 
    menuMusic.pause();

    menu.pause();
    menu.rewind();
    menu.play();


    setup();

    gameState = 1;  //Set gamestate to play


    musicPlaying = false;    

    mainMusic.pause();
    mainMusic.rewind();
    mainMusic.loop();
  } else if (IsMouseTouchingRect(button10.posX, button10.posY, button10.myWidth, button10.myHeight) && gameState == 0 && !readyToPlay)
  {

    error.pause();
    error.rewind();
    error.play();
  }


  if (IsMouseTouchingRect(button11.posX, button11.posY, button11.myWidth, button11.myHeight) && gameState == 0) //press rules button
  {
    menu.pause();
    menu.rewind();
    menu.play();
    readyToPlay = true;

    gameState = 3; //set gamestate to rules
  }

  if (IsMouseTouchingRect(button9.posX, button9.posY, button9.myWidth, button9.myHeight) && gameState == 4 || IsMouseTouchingRect(button9.posX, button9.posY, button9.myWidth, button9.myHeight) && gameState == 3) //press main menu button
  {
    menu.pause();
    menu.rewind();
    menu.play();

    gameState = 0; //set gamestate to main menu
  }

  if (IsMouseTouchingRect(button12.posX, button12.posY, button12.myWidth, button12.myHeight) && gameState == 0) //press quit button
  {

    exit(); //quit game
  }

  if (IsMouseTouchingRect(button1.posX, button1.posY, button1.myWidth, button1.myHeight) && gameState == 2) //press lives button
  {
    if (player1.credits >= button1.cost)
    {
      player1.credits -= button1.cost;
      player1.lives += button1.statIncrease;
      button1.cost += 20;
      upgrade.pause();
      upgrade.rewind();
      upgrade.play();
    } else {
      error.pause();
      error.rewind();
      error.play();
    }
  }

  if (IsMouseTouchingRect(button2.posX, button2.posY, button2.myWidth, button2.myHeight) && gameState == 2) //press health button
  {
    if (player1.credits >= button2.cost && player1.health < player1.maxHealth)
    {
      player1.credits -= button2.cost;
      player1.health += player1.maxHealth;
      upgrade.pause();
      upgrade.rewind();
      upgrade.play();

      if (player1.health > player1.maxHealth)
      {
        player1.health = player1.maxHealth;
      }
    } else {
      error.pause();
      error.rewind();
      error.play();
    }
  }

  if (IsMouseTouchingRect(button3.posX, button3.posY, button3.myWidth, button3.myHeight) && gameState == 2) //press max health button
  {
    if (player1.credits >= button3.cost)
    {
      player1.credits -= button3.cost;
      player1.maxHealth += button3.statIncrease;
      player1.health += button3.statIncrease;
      button2.statIncrease += button3.statIncrease;
      button3.cost += 10;
      button2.cost += 5;
      upgrade.pause();
      upgrade.rewind();
      upgrade.play();
    } else {
      error.pause();
      error.rewind();
      error.play();
    }
  }

  if (IsMouseTouchingRect(button4.posX, button4.posY, button4.myWidth, button4.myHeight) && gameState == 2) //press damage button
  {
    if (player1.credits >= button4.cost)
    {
      player1.credits -= button4.cost;
      player1.damage += button4.statIncrease;
      button4.cost += 10;
      upgrade.pause();
      upgrade.rewind();
      upgrade.play();
    } else {
      error.pause();
      error.rewind();
      error.play();
    }
  }

  if (IsMouseTouchingRect(button5.posX, button5.posY, button5.myWidth, button5.myHeight) && gameState == 2) //press max ammo button
  {
    if (player1.credits >= button5.cost)
    {
      player1.credits -= button5.cost;
      player1.maxAmmo += button5.statIncrease;
      player1.ammo += button5.statIncrease;
      button5.cost += 10;
      upgrade.pause();
      upgrade.rewind();
      upgrade.play();
    } else {
      error.pause();
      error.rewind();
      error.play();
    }
  }

  if (IsMouseTouchingRect(button6.posX, button6.posY, button6.myWidth, button6.myHeight) && gameState == 2) //press fire rate button
  {
    if (player1.credits >= button6.cost)
    {
      player1.credits -= button6.cost;
      player1.fireRate += button6.statIncrease;
      button6.cost += 10;
      upgrade.pause();
      upgrade.rewind();
      upgrade.play();
    } else {
      error.pause();
      error.rewind();
      error.play();
    }
  }

  if (IsMouseTouchingRect(button7.posX, button7.posY, button7.myWidth, button7.myHeight) && gameState == 2) //press mobility button
  {
    if (player1.credits >= button7.cost)
    {
      player1.credits -= button7.cost;
      player1.speed += button7.statIncrease;
      button7.cost += 10;
      upgrade.pause();
      upgrade.rewind();
      upgrade.play();
    } else {
      error.pause();
      error.rewind();
      error.play();
    }
  }

  if (IsMouseTouchingRect(button8.posX, button8.posY, button8.myWidth, button8.myHeight) && gameState == 2) //press next wave button
  {
    enemyList.clear();
    bulletList.clear();
    scoreList.clear();
    trailList.clear();

    for (int i = 0; i < enemyAmount; i++)
    {

      enemyList.add(new Enemy(random(1, width), random(1, height), enemyHealth, enemySpeed, enemyDamage));
    }
    
    menu.pause();
    menu.rewind();
    menu.play();
    
    if (wave == 9)
    {
      mainMusic.pause();
      music1.pause();
      music1.rewind();
      music1.loop();
    }
    
    if (wave == 19)
    {
      music1.pause();
      music2.pause();
      music2.rewind();
      music2.loop();
    }

    gameState = 1;
  }
}





void keyReleased()
{

  if (key == 'w' || key == 'W' && player1.canMove == true || keyCode == UP && player1.canMove == true)
  {
    player1.mu = false;
  }

  if (key == 's' || key == 'S' && player1.canMove == true || keyCode == DOWN && player1.canMove == true)
  {
    player1.md = false;
  }

  if (key == 'a' || key == 'A' && player1.canMove == true || keyCode == LEFT && player1.canMove == true)
  {
    player1.ml = false;
  }

  if (key == 'd' || key == 'D' && player1.canMove == true || keyCode == RIGHT && player1.canMove == true)
  {
    player1.mr = false;
  }
}

