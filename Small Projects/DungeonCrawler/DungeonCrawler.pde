Room room02;
Room room11;
Room room12;
Room room13;
Room room21;
Room room22;
Room room23;
Room room31;
Room room32;
Room room33;
Room room42;

Player player1;

PFont myFont;

ArrayList<Trail> trailList = new ArrayList<Trail>();

int randomDoor1 = (int)random(1, 4); //for room32
int randomDoor2 = (int)random(1, 3); //for room21
int randomDoor3 = (int)random(1, 3); //for room23

float enemySpeed = 1;

void setup()
{

  size(1000, 800);
  smooth();
  
  loadImages();
  
  
  //0 = closed  1 = open   2 = no door
  //                #   U  R  D  L
  room02 = new Room(02, 1, 2, 2, 2);
  room11 = new Room(11, 0, 0, 2, 2);
  room12 = new Room(12, 0, 0, 2, 0);
  room13 = new Room(13, 0, 2, 2, 0);
  room21 = new Room(21, 0, 0, 0, 2);
  room22 = new Room(22, 0, 0, 0, 0);
  room23 = new Room(23, 0, 2, 0, 0);
  room31 = new Room(31, 2, 0, 0, 2);
  room32 = new Room(32, 0, 0, 0, 0);
  room33 = new Room(33, 2, 2, 0, 0);
  room42 = new Room(42, 2, 2, 0, 2);
  
  myFont = loadFont("Arial.vlw");
  
  player1 = new Player(width/2, height*3/4);
  
  
  

}

void draw()
{
  
  background(0);
  
  player1.Update();
  
  Key();
  
  
  
}
