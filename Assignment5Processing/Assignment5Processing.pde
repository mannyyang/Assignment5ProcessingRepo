import traer.physics.*;

Particle mouse;
Particle[] others;
ParticleSystem physics;

PImage img;
Cell[][] grid;
int cols = 24;
int rows = 40;

void setup()
{
  size(480, 800);
  frameRate(24);
  
  //Image loads and manipulations
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
  background(255);
  mouse.position().set(mouseX, mouseY, 0);
  
  //Grid production
  for (int i = 0; i < cols; i++) 
  {
    for (int j = 0; j < rows; j++) 
    {
      // display each object
      grid[i][j].displayGrid();
      grid[i][j].gradient(i, j);
      grid[i][j].mouseOver(i,j);
    }
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
  int x,y;   // x,y location
  int w,h;   // width and height
  float angle; // angle for oscillating brightness

  // Cell Constructor
  Cell(int tempX, int tempY, int tempW, int tempH, float tempAngle) 
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
    strokeWeight(1.5);
    rect(x,y,w,h); 
  }
  
  void gradient(int i, int j)
  {
    fill(255, 255, (i*j)/2, 1000);
    rect(x,y,w,h);
  }
  
  void mouseOver(int i, int j)
  {
    stroke(0);
    strokeWeight(3);
    fill((i*j)/3, (i*j)/3, (i*j)/3);
    rect(mouseX/20*20, y, w, h);
    stroke(0);
    strokeWeight(3);
    fill((i*j)/3, (i*j)/3, (i*j)/3);
    rect(x, mouseY/20*20, w, h);
  }
}



