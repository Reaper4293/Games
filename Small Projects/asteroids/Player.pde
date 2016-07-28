class Player
{

  int posX;
  int posY;
  int mySize = 30;
  int frontSize = 11;
  float offsetX = 0;
  float offsetY = 0;
  float angle = PI/2;

  boolean boost = false;
  boolean reverse = false;
  float forceStrength = .1;
  float verticalForce = 0;
  float horizontalForce = 0;

  boolean rotateRight = false;
  boolean rotateLeft = false;
  float rotateSpeed = .04;


  Player()
  {

    posX = width/2;
    posY = height/2;
  }

  void Update()
  {

    fill(255);
    text(verticalForce, 15, 15);
    text(horizontalForce, 15, 30);

    posX += horizontalForce;
    posY -= verticalForce;

    //Rotation of ship
    if (rotateRight)
    {
      angle += rotateSpeed;
    } else if (rotateLeft)
    {
      angle -= rotateSpeed;
    }

    //Angle simplification
    if (angle > 6.28)
    {
      angle = 0;
    } else if (angle < 0)
    {
      angle = 6.28;
    }

    //Go forwards
    if (boost)
    {
      verticalForce += cos(angle) * forceStrength;
      horizontalForce += sin(angle) * forceStrength;
    }

    //Go backwards
    if (reverse)
    {
      verticalForce -= cos(angle) * forceStrength;
      horizontalForce -= sin(angle) * forceStrength;
    }

    fill(255);
    noStroke();
    offsetX = sin(angle) * frontSize;
    offsetY = cos(angle) * frontSize;
    ellipse(posX, posY, mySize, mySize);

    //fill(255, 0, 0);
    rectMode(CENTER);
    translate(posX + offsetX, posY - offsetY);
    rotate(angle+PI/4);
    rect(0, 0, mySize/2, mySize/2);
  }

  void Boundaries()
  {
    //Stay in the X axis
    if (posX< 0 - mySize/2)
    {
      posX = width + mySize/2;
    }

    if (posX > width + mySize/2)
    {
      posX = 0 - mySize/2;
    }

    //Stay in the Y axis
    if (posY< 0 - mySize/2)
    {
      posY = height + mySize/2;
    }

    if (posY > height+ mySize/2)
    {
      posY = 0 - mySize/2;
    }
  }
}

