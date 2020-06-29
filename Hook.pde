class hook
{
  int x;
  int y;
  int sizeX;
  int sizeY;
  int changeY = 3;
  int lineX;
  int lineOffset;

  hook(int x, int y, int sizeX, int sizeY, int lineX)
  {
    this.x = x;
    this.y = y;
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    this.lineX = lineX;
    
    hook = loadImage("hook.png");
  }
  
  void draw()
  {
    line(lineX, 240, ((x + sizeX) - lineOffset), y);  //ensures line begins in same y position and then ends where the hook is.
    image(hook, x, y, sizeX, sizeY);
  }
  
  void move(int changeX)
  {
    x = x + changeX;          //move hook x
    lineX = lineX + changeX;  //move line x
  }
  
  void drop(int changeY)
   {
     y = y + changeY;   //drop hook
   }
   
   void collidescreen()
   {
     if(y > height - sizeY)
     {
       isPressed = 2;  //take hoop up
     }
     if (y < 265)
     {
       isPressed = 0;  //once hook is in originasl position, make hook stationary
     }
   }
}