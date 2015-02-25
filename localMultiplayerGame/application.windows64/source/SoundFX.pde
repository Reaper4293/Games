import ddf.minim.*;

AudioPlayer powerUpSound;
AudioPlayer shoot;
AudioPlayer hit;
AudioPlayer music;
AudioPlayer win;
AudioPlayer menu;
Minim minim;

void soundSetup()
{
  
  minim = new Minim(this);
  powerUpSound = minim.loadFile("powerUp.wav");
  shoot = minim.loadFile("shoot.wav");
  hit = minim.loadFile("hit.aiff");
  music = minim.loadFile("music.wav");
  win = minim.loadFile("win.wav");
  menu = minim.loadFile("menu.wav");
  
  
}
