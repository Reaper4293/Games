import ddf.minim.*;

AudioPlayer menuMusic;
AudioPlayer mainMusic;
AudioPlayer shoot;
AudioPlayer reload;
AudioPlayer emptyShot;
AudioPlayer menu;
AudioPlayer error;
AudioPlayer hit;
AudioPlayer hurt;
AudioPlayer kill;
AudioPlayer upgrade;
AudioPlayer dying;
AudioPlayer waveClear;
AudioPlayer music1;
AudioPlayer music2;

Minim minim;

void soundSetup()
{

  minim = new Minim(this);

  mainMusic = minim.loadFile("mainMusic.mp3");
  menuMusic = minim.loadFile("menuMusic.mp3");
  music1 = minim.loadFile("music1.mp3");
  music2 = minim.loadFile("music2.mp3");
  
  shoot = minim.loadFile("shoot.wav");
  waveClear = minim.loadFile("waveClear.wav");
  reload = minim.loadFile("reload.wav");
  emptyShot = minim.loadFile("emptyShot.wav");
  menu = minim.loadFile("menu.wav");
  error = minim.loadFile("error.wav");
  hit = minim.loadFile("hit.wav");
  hurt = minim.loadFile("hurt.wav");
  kill = minim.loadFile("kill.wav");
  upgrade = minim.loadFile("upgrade.wav");
  dying = minim.loadFile("dying.wav");
  
  menuMusic.setGain(-5);
  mainMusic.setGain(-5);
  music1.setGain(-5);
  music2.setGain(-5);
  shoot.setGain(-10);
  error.setGain(14);
}

