class Fisherman
{
  int x; 
  int y; 
  int sizeX;    //width of image
  int sizeY;    //height of image
  int changeX;  //movement of boat 

  Fisherman(int x, int y, int sizeX, int sizeY)
  {
    this.x = x;
    this.y = y;
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    
    fisherman = loadImage("man2.png");
  }
  
  void draw()
  {
    image(fisherman, x, y, sizeX, sizeY);
  }

  void move(int changeX)
  {
    man1.x = man1.x +  changeX;  //move boat left or right
  }
}