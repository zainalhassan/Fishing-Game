//predators
//lives
//megaHook

class predator
{
//------------------------------------------------------------initalisation of variables---------------------------------------------------------------------------
  int x;
  int y;
  int sizeX = 85;
  int sizeY = 75;
  int changeX;  //small random sideways movements of predators
  int changeY = int(random(1, 5));// change speed everytime it is reAscending;
  int textCounter;
  
  int randomHurt  = int(random(0, 4));
  String[] hurt = {"OUCH", "WOWZA", ":(", "BEWARE OF PREDATORS", "AHH"};

  boolean boatCrashed;
//-----------------------------------------------------------------------------------------------------------------------------------------------------------------

  predator(int x, int y)  //constructor
  {
    this.x = x;
    this.y = y;

    predators = loadImage("stingray.png");
    mantaTop = loadImage("bubbles.png");
  }

  void draw()
  {
    changeX = int(random(-3, 3));  //constantly changing value of changeX
    image(predators, x, y, sizeX, sizeY);
    
    textCounter = textCounter - 1;
    
    if(textCounter > 0)
    {
      textSize(40);
      fill(0);
      text(hurt[randomHurt], man1.x + man1.sizeX, man1.sizeY);    //hurt message displayed next to the boat
    }
  }

  void ascend()
  {
    if (y > man1.y + man1. sizeY)
    {
      predatorTop = false;
      y = y - changeY;  //take predator up whilst predator hasnt reached the top
      x = x - changeX;
    }
    else
    {
      predatorTop = true;
      image(mantaTop, x, y, sizeX, sizeY); //predator at top and pops
    }
  }

  void reAscend()
  {
    int random = int(random(-50, 100));
    sizeX = sizeX + random;  //different sized predator each time
    sizeY = sizeY + random;  //different sized predator each time
    x = int(random(0, width - sizeX));  //ensures predatorare kept on the screen
    changeY = int(random(1, 5));  //speed is changed each time a predator reascends
    y = height;  //resets y value
    
    ascend();  //after the above values have been changed, predators ascend again
  }

  void predatorCollideBoat()
  {
    if (this.y > man1.y + man1.sizeY || this.x + this.sizeX < man1.x || this.y + this.sizeY < man1.y || this.x > man1.x + man1.sizeX)
    {
      boatCrashed = false;
    }
    else
    {
      boatCrashed = true;
    } 

    if (boatCrashed == true)
    {
      numLives = numLives - 1;
      reAscend(); // ensures the predator does not keep killing the boat
      
      randomHurt  = int(random(0, 4));  //diffeent message displayed each time a life is lost
      textCounter = 100;  //length the hurt message will appear for
      
      if (numLives <= 0)
      {
        gameMode = GAMEOVER;
        randomHint = int(random(0, 4));  //different message displayed each time the user loses
        isPressed = 0;
      }
    }
  }
}



class lives
{
  int x;
  int y;
  int size;

  lives(int x, int y, int size)  //constructor
  {
    this.x = x;
    this.y = y;
    this.size = size;

    lifeImage = loadImage("lives.png");
  }

  void draw()
  {
    image(lifeImage, x, y, size, size);
  }
}



class megaHook 
{
  int x;
  int y;
  int changeY = 2;
  int sizeX = 150;
  int sizeY = 75;
  int textCounter;
  
  boolean caughtMegaHook;
  
  megaHook(int x, int y)
  {
    this.x = x;
    this.y = y;
    
    megaHook = loadImage("cloud.png");
  }
  
  void draw()
  {
    image(megaHook, x, y, sizeX, sizeY);
    
    textCounter = textCounter - 1;
    
    if(textCounter > 0)
    {                                //make hook biger
       fishhook.lineOffset = 15;
       fishhook.sizeX = 100;
       fishhook.sizeY = 100;
       fishhook.changeY = 6;
    }
    else
    {                              //revert back to original size and speed
      caughtMegaHook = false;
      
      fishhook.lineOffset = 5;
      fishhook.sizeX = 25;
      fishhook.sizeY = 50;
      fishhook.changeY = 3;
    }
  }
  
  void ascend()
  {
    if (y > man1.y + man1. sizeY)
    {
      megaHookTop = false;
      y = y - changeY;  //take predator up whilst predator hasnt reached the top
    }
    else
    {
      megaHookTop = true;
    }
  }

  void reAscend()
  {
    x = int(random(0, width - sizeX));  //ensures mega hook kept on the screen
    y = height;  //resets y value
    ascend();
  }
  
  void caughtMega()
  {
    if(this.y > fishhook.y + fishhook.sizeY || this.x > fishhook.x + fishhook.sizeX || this.x + this.sizeX < fishhook.x || this.y + this.sizeY > fishhook.y + fishhook.sizeY)
    {
      caughtMegaHook = false;
    }
    else
    {
      caughtMegaHook = true;
    }
        
    if(caughtMegaHook == true)
    {
      this.y = height;
      this.changeY = 0;   //ensures megahook can only be claimed once per level
      textCounter = 600;  //length of time the hook stays as a mega hook
    }
  }
}