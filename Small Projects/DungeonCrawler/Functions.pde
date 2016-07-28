
boolean AreWeColliding(float c1px, float c1py, float c1s, float c2px, float c2py, float c2s)
{

  float distanceBetweenCircles = dist(c1px, c1py, c2px, c2py);
  float halfOfCircleSizes = (c1s + c2s) / 2;

  if (distanceBetweenCircles < halfOfCircleSizes)
  {
    return true;
  } else {
    return false;
  }
}

boolean IsMouseTouchingRect (int rx, int ry, int rWidth, int rHeight)
{
  //if a point is within the bounds of the rect
  if (mouseX > rx && mouseX < rx + rWidth && mouseY > ry && mouseY < ry + rHeight) 
  {
    return true;
  } else {
    return false;
  }
}

void deleteDeadObjects()
{
  
  
  
}
