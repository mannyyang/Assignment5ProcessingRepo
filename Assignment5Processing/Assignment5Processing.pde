import traer.physics.*;

Particle mouse;
Particle[] others;
ParticleSystem physics;

PImage img;
PImage bgImg;
Cell[][] grid;
int cols = 24;
int rows = 40;

void setup()
{
  size(480, 800);
  frameRate(24);
  
  //Image loads and manipulations
  bgImg = loadImage("YellowGradient.png");
  img = loadImage("fade.png");
  imageMode(CORNER);
  tint(0, 32);
  
  //Grid's square height, width, & stroke weight
  grid = new Cell[cols][rows];
  for (int i = 0; i < cols; i++) 
  {
    for (int j = 0; j < rows; j++) 
    {
      // Initialize each object
      grid[i][j] = new Cell(i*20,j*20,20,20,i+j);
    }
  }
  
  //Physics 
  physics = new ParticleSystem(0, 0.1);
  mouse = physics.makeParticle();
  mouse.makeFixed();
  
  others = new Particle[1000];
  for (int i = 0; i < others.length; i++)
  {
    others[i] = physics.makeParticle(1.0, random(0, width), random(0, height), 0);
    physics.makeAttraction(mouse, others[i], 5000, 50); 
  }
}

void draw()
{
  background(bgImg);
  mouse.position().set(mouseX, mouseY, 0);
  
  //Grid production
  for (int i = 0; i < cols; i++) 
  {
    for (int j = 0; j < rows; j++) 
    {
      // display each object
      grid[i][j].displayGrid();
      //grid[i][j].mouseOver(i, j);
    }
  }
  
  if ()
  {
    
  }

  //Particale production
  for (int i = 0; i < others.length; i++)
  {
     Particle p = others[i];
     image(img,p.position().x()-img.width/2,p.position().y()-img.height/2);
  }
  physics.tick();
  
}

// A Cell object
class Cell 
{
  // A cell object knows about its location in the grid as well as its size with the variables x,y,w,h.
  float x,y;   // x,y location
  float w,h;   // width and height
  float angle; // angle for oscillating brightness

  // Cell Constructor
  Cell(float tempX, float tempY, float tempW, float tempH, float tempAngle) 
  {
    x = tempX;
    y = tempY;
    w = tempW;
    h = tempH;
    angle = tempAngle;
  } 
  
  void displayGrid() 
  {
    stroke(0);
    fill(255, 0);
    rect(x,y,w,h); 
  }
  
  void mouseOver(int i, int j)
  {
    fill(0);
    rect(x, y, w, h);
  }
  
}


