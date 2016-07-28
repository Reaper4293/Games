
class Room
{
  ArrayList<Enemy> enemyList = new ArrayList<Enemy>();

  int number;
  //0 = closed  1 = Open   2 = no door
  int doorState1 = 0;
  int doorState2 = 0;
  int doorState3 = 0;
  int doorState4 = 0;

  int doorSize = 100;
  int wallThickness = 30;

  boolean roomClear = false;
  int availableKeys = 1;

  int wallColor = 200;
  int doorColor = 200;

  float enemyHealth = 1;
  float enemySpeed = 3;
  float enemyDamage = 1;
  int enemyAmount = 3;
  

  Room(int tempNumber, int tempDoorState1, int tempDoorState2, int tempDoorState3, int tempDoorState4)
  {


    number = tempNumber;
    doorState1 = tempDoorState1;
    doorState2 = tempDoorState2;
    doorState3 = tempDoorState3;
    doorState4 = tempDoorState4;

    if (number == 02) enemyAmount = 0;


    //Add enemies equal to the amount in each room
    for (int i = 0; i < enemyAmount; i++)
    {

      enemyList.add(new Enemy(random(1 + wallThickness, width - wallThickness), random(1 + wallThickness, height - wallThickness), enemyHealth, enemySpeed, enemyDamage));
    }

    RandomizeRoomDoors();
  }

  void Update()
  {

    fill(wallColor);
    noStroke();
    //walls
    rect(0, 0, width, wallThickness);
    rect(0, 0, wallThickness, height);
    rect(width-wallThickness, 0, wallThickness, height);
    rect(0, height-wallThickness, width, wallThickness);


    DoorColors();

    WallLogic();

    for (int i = 0; i < trailList.size (); i++) 
    {
      trailList.get(i).Update();
    }

    //Cycle through enemies
    for (int e = 0; e < enemyList.size (); e++) 
    {
      //Update each enemy in this room
      enemyList.get(e).Update();
      
      //if sword collides with an enemy
      //if (AreWeColliding(player1.swingPosX + cos(player1.swingAngle) * player1.mySize/4*1, player1.swingPosY + sin(player1.swingAngle) * player1.mySize/4*1, player1.swingRange, enemyList.get(e).posX, enemyList.get(e).posY, enemyList.get(e).mySize)) enemyList.get(e).health -= player1.damage;
      //if (AreWeColliding(player1.swingPosX + cos(player1.swingAngle) * player1.mySize/4*2, player1.swingPosY + sin(player1.swingAngle) * player1.mySize/4*2, player1.swingRange, enemyList.get(e).posX, enemyList.get(e).posY, enemyList.get(e).mySize)) enemyList.get(e).health -= player1.damage;
      //if (AreWeColliding(player1.swingPosX + cos(player1.swingAngle) * player1.mySize/4*3, player1.swingPosY + sin(player1.swingAngle) * player1.mySize/4*3, player1.swingRange, enemyList.get(e).posX, enemyList.get(e).posY, enemyList.get(e).mySize)) enemyList.get(e).health -= player1.damage;
      //if (AreWeColliding(player1.swingPosX + cos(player1.swingAngle) * player1.mySize/4*4, player1.swingPosY + sin(player1.swingAngle) * player1.mySize/4*4, player1.swingRange, enemyList.get(e).posX, enemyList.get(e).posY, enemyList.get(e).mySize)) enemyList.get(e).health -= player1.damage;
      if (AreWeColliding(player1.swingPosX, player1.swingPosY, player1.swingRange, enemyList.get(e).posX, enemyList.get(e).posY, enemyList.get(e).mySize)) 
      {
        enemyList.get(e).health -= player1.damage;
      }
      
       //if a enemy collides with the player
      if (AreWeColliding(player1.positionX, player1.positionY, player1.mySize, enemyList.get(e).posX, enemyList.get(e).posY, enemyList.get(e).mySize) && player1.vulnerable == true)
      {
        player1.health -= enemyList.get(e).damage;
        player1.isHit = true;
        player1.vulnerable = false;

        if (enemyList.get(e).posX > player1.positionX)
        {
          player1.positionX -= 25;
        } else {
          player1.positionX += 25;
        }

        if (enemyList.get(e).posY > player1.positionY)
        {
          player1.positionY -= 25;
        } else {
          player1.positionY += 25;
        }
      }
      
      //IF AN ENEMY GETS KILLED
      if (enemyList.get(e).health <= 0)
      {

        enemyList.remove(e);
      }
      
    }

    


    

    //trail gets deleted
    for (int i = 0; i < trailList.size (); i++)
    {
      if (trailList.get(i).alive == false)
      {
        trailList.remove(i);
      }
    }

    if (enemyList.size() == 0) roomClear = true;

    if (roomClear && number != 42 && number != 02 && availableKeys == 1) 
    {
      availableKeys--;
      keyPositionX = 500;
    }
  }

  void RandomizeRoomDoors()
  {

    //randomize room 32's doors
    if (number == 32)
    {
      if (randomDoor1 == 1)
      {
        doorState2 = 2;
        doorState3 = 2;
      }
      if (randomDoor1 == 2)
      {
        doorState4 = 2;
        doorState2 = 2;
      }
      if (randomDoor1 == 3)
      {
        doorState4 = 2;
        doorState3 = 2;
      }
    }

    //randomize room 31's doors
    if (number == 31)
    {
      if (randomDoor1 != 1) doorState2 = 2;
    }

    //randomize room 33's doors
    if (number == 33)
    {
      if (randomDoor1 != 3) doorState4 = 2;
    }

    //randomize room 22's doors
    if (number == 22)
    {
      if (randomDoor1 != 2) doorState1 = 2;
      if (randomDoor2 != 2) doorState4 = 2;      
      if (randomDoor3 != 2) doorState2 = 2;
    }

    //randomize room 21's doors
    if (number == 21)
    {
      if (randomDoor2 == 1) doorState2 = 2;
      if (randomDoor2 == 2) doorState3 = 2;
    }

    //randomize room 23's doors
    if (number == 23)
    {
      if (randomDoor3 == 1) doorState4 = 2;
      if (randomDoor3 == 2) doorState3 = 2;
    }

    //randomize room 11's doors
    if (number == 11)
    {
      if (randomDoor2 == 2) doorState1 = 2;
    }

    //randomize room 13's doors
    if (number == 13)
    {
      if (randomDoor3 == 2) doorState1 = 2;
    }
  }

  void DoorColors()
  {

    //Top door 
    if (doorState1 == 0)
    {
      fill(doorColor, 0, 0);
    } else if (doorState1 == 1)
    {
      fill(0);
    } else if (doorState1 == 2)
    {
      fill(doorColor);
    }
    rect((width-doorSize)/2, 0, doorSize, wallThickness);

    //Right Door
    if (doorState2 == 0)
    {
      fill(doorColor, 0, 0);
    } else if (doorState2 == 1)
    {
      fill(0);
    } else if (doorState2 == 2)
    {
      fill(doorColor);
    }
    rect(width-wallThickness, (height-doorSize)/2, wallThickness, doorSize);

    //Bottom Door
    if (doorState3 == 0)
    {
      fill(doorColor, 0, 0);
    } else if (doorState3 == 1)
    {
      fill(0);
    } else if (doorState3 == 2)
    {
      fill(doorColor);
    }
    rect((width-doorSize)/2, height-wallThickness, doorSize, wallThickness);

    //Left Door
    if (doorState4 == 0)
    {
      fill(doorColor, 0, 0);
    } else if (doorState4 == 1)
    {
      fill(0);
    } else if (doorState4 == 2)
    {
      fill(doorColor);
    }
    rect(0, (height-doorSize)/2, wallThickness, doorSize);
  }

  void WallLogic()
  {

    //Left Wall
    if (doorState4 == 1) //Door Open
    {
      //is inside door
      if (player1.positionY >= (height - doorSize + player1.mySize)/2 && player1.positionY <= (height + doorSize - player1.mySize)/2 && player1.positionX < player1.mySize/2) 
      {
        player1.currentRoom -= 1;
        player1.positionX = width - player1.mySize;
      }
      //is not inside door
      if (player1.positionX < player1.mySize/2 + wallThickness && player1.positionY < (height - doorSize + player1.mySize)/2 || player1.positionX < player1.mySize/2 + wallThickness && player1.positionY > (height + doorSize - player1.mySize)/2) 
      {

        player1.positionX = player1.mySize/2 + wallThickness;
      }
    } else if (doorState4 == 0 && player1.amountKeys > 0)
    {
      if (player1.positionY >= (height - doorSize + player1.mySize)/2 && player1.positionY <= (height + doorSize - player1.mySize)/2 && player1.positionX <= player1.mySize/2 + wallThickness) 
      {
        doorState4 = 1;
        player1.amountKeys--;
        if (number == 12) room11.doorState2 = 1;
        if (number == 13) room12.doorState2 = 1;
        if (number == 22) room21.doorState2 = 1;
        if (number == 23) room22.doorState2 = 1;
        if (number == 32) room31.doorState2 = 1;
        if (number == 33) room32.doorState2 = 1;
      }
    }  
    if (doorState4 != 1) //Door not open
    { 
      if (player1.positionX < player1.mySize/2 + wallThickness)
      {

        player1.positionX = player1.mySize/2 + wallThickness;
      }
    }

    //Right Wall
    if (doorState2 == 1) //Door Open
    {
      //is inside door
      if (player1.positionY >= (height - doorSize + player1.mySize)/2 && player1.positionY <= (height + doorSize - player1.mySize)/2 && player1.positionX > width - player1.mySize/2) 
      {
        player1.currentRoom += 1;
        player1.positionX = player1.mySize;
      }
      //is not inside door
      if (player1.positionX > width - player1.mySize/2 - wallThickness && player1.positionY < (height - doorSize + player1.mySize)/2 || player1.positionX > width - player1.mySize/2 - wallThickness && player1.positionY > (height + doorSize - player1.mySize)/2) 
      {

        player1.positionX = width - player1.mySize/2 - wallThickness;
      }
    } else if (doorState2 == 0 && player1.amountKeys > 0)
    {
      if (player1.positionY >= (height - doorSize + player1.mySize)/2 && player1.positionY <= (height + doorSize - player1.mySize)/2 && player1.positionX >= width - player1.mySize/2 - wallThickness) 
      {
        doorState2 = 1;
        player1.amountKeys--;
        if (number == 11) room12.doorState4 = 1;
        if (number == 12) room13.doorState4 = 1;
        if (number == 21) room22.doorState4 = 1;
        if (number == 22) room23.doorState4 = 1;
        if (number == 31) room32.doorState4 = 1;
        if (number == 32) room33.doorState4 = 1;
      }
    } 
    if (doorState2 != 1) //Door not open
    {
      if (player1.positionX > width - player1.mySize/2 - wallThickness)
      {
        player1.positionX = width - player1.mySize/2 - wallThickness;
      }
    }

    //Top Wall
    if (doorState1 == 1)
    {
      //is inside door
      if (player1.positionX >= (width - doorSize + player1.mySize)/2 && player1.positionX <= (width + doorSize - player1.mySize)/2 && player1.positionY < player1.mySize/2) 
      {
        player1.currentRoom += 10;
        player1.positionY = height - player1.mySize;
      }
      //is not inside door
      if (player1.positionY < player1.mySize/2 + wallThickness && player1.positionX < (width - doorSize + player1.mySize)/2 || player1.positionY < player1.mySize/2 + wallThickness && player1.positionX > (width + doorSize - player1.mySize)/2) 
      {

        player1.positionY = player1.mySize/2 + wallThickness;
      }
    } else if (doorState1 == 0 && player1.amountKeys > 0)
    {
      if (player1.positionX >= (width - doorSize + player1.mySize)/2 && player1.positionX <= (width + doorSize - player1.mySize)/2 && player1.positionY <= player1.mySize/2 + wallThickness) 
      {
        doorState1 = 1;
        player1.amountKeys--;
        if (number == 11) room21.doorState3 = 1;
        if (number == 12) room22.doorState3 = 1;
        if (number == 13) room23.doorState3 = 1;
        if (number == 21) room31.doorState3 = 1;
        if (number == 22) room32.doorState3 = 1;
        if (number == 23) room33.doorState3 = 1;
      }
    }
    if (doorState1 != 1) //Door not open
    {
      if (player1.positionY < player1.mySize/2 + wallThickness)
      {

        player1.positionY = player1.mySize/2 + wallThickness;
      }
    }

    //Bottom Wall
    if (doorState3 == 1)
    {
      //is inside door
      if (player1.positionX >= (width - doorSize + player1.mySize)/2 && player1.positionX <= (width + doorSize - player1.mySize)/2 && player1.positionY > height - player1.mySize/2) 
      {
        player1.currentRoom -= 10;
        player1.positionY = player1.mySize;
      }
      //is not inside door
      if (player1.positionY > height - player1.mySize/2 - wallThickness && player1.positionX < (width - doorSize + player1.mySize)/2 || player1.positionY > height - player1.mySize/2 - wallThickness && player1.positionX > (width + doorSize - player1.mySize)/2) 
      {

        player1.positionY = height - player1.mySize/2 - wallThickness;
      }
    } else if (doorState3 == 0 && player1.amountKeys > 0)
    {
      if (player1.positionX >= (width - doorSize + player1.mySize)/2 && player1.positionX <= (width + doorSize - player1.mySize)/2 && player1.positionY >= height - player1.mySize/2 - wallThickness) 
      {
        doorState3 = 1;
        player1.amountKeys--;
        if (number == 21) room11.doorState1 = 1;
        if (number == 22) room12.doorState1 = 1;
        if (number == 23) room13.doorState1 = 1;
        if (number == 31) room21.doorState1 = 1;
        if (number == 32) room22.doorState1 = 1;
        if (number == 33) room23.doorState1 = 1;
      }
    }
    if (doorState3 != 1) //Door not open
    {
      if (player1.positionY > height - player1.mySize/2 - wallThickness)
      {
        player1.positionY = height - player1.mySize/2 - wallThickness;
      }
    }
  }
}

