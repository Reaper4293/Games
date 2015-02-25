class ParticleSpread{
  
  PVector startingPos = new PVector(0, 0);
  
  PVector movePerTurn1 = new PVector(1, 1);
  PVector movePerTurn2 = new PVector(-1, 1);
  PVector movePerTurn3 = new PVector(1, -1);
  PVector movePerTurn4 = new PVector(-1, -1);
  PVector movePerTurn5 = new PVector(0, 1.5);
  PVector movePerTurn6 = new PVector(0, -1.5);
  PVector movePerTurn7 = new PVector(1.5, 0);
  PVector movePerTurn8 = new PVector(-1.5, 0);
  
  int timer = 0;
  boolean alive = true;
  int colorAlpha = 255;
  int myColor = 0;
  int color1 = 255;
  
  ParticleSpread(float posX, float posY, int tempColor)
  {
    color1 = tempColor;
    startingPos = new PVector(posX, posY);
  }
  
  void Update()
  {
    
    PVector myLocation = new PVector(0, 0);
    for(int i = 0; i < 8; i++)
    {
      if(i == 0) myLocation = PVector.add(startingPos, PVector.mult(movePerTurn1, timer));
      else if(i == 1) myLocation = PVector.add(startingPos, PVector.mult(movePerTurn2, timer));
      else if(i == 2) myLocation = PVector.add(startingPos, PVector.mult(movePerTurn3, timer));
      else if(i == 3) myLocation = PVector.add(startingPos, PVector.mult(movePerTurn4, timer));
      else if(i == 4) myLocation = PVector.add(startingPos, PVector.mult(movePerTurn5, timer));
      else if(i == 5) myLocation = PVector.add(startingPos, PVector.mult(movePerTurn6, timer));
      else if(i == 6) myLocation = PVector.add(startingPos, PVector.mult(movePerTurn7, timer));
      else if(i == 7) myLocation = PVector.add(startingPos, PVector.mult(movePerTurn8, timer));
      fill(color1, myColor, 0, colorAlpha);
      ellipse(myLocation.x, myLocation.y, 3, 3);
    }
    colorAlpha -= 5;
    myColor += 10;
    
    timer++;
    if(timer > 60) alive = false;
  }
}

void DeleteDeadObjects()
{
  
  for(int i =0; i < particleSpreadList.size(); i++)
  {
    if(particleSpreadList.get(i).alive == false)
    {
      particleSpreadList.remove(i);
    }
  }
  
  for(int i =0; i < trailList.size(); i++)
  {
    if(trailList.get(i).alive == false)
    {
      trailList.remove(i);
    }
  }
  
}
