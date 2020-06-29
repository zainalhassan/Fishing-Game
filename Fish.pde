class fish
{
  int x;
  int y;
  int dy;
  int size;
  int speed = 4;
  int counter;
  int fishX = 100;
  int fishY = 75;
  
  boolean fishCaught;
  boolean fishCollidedHook;
  
  PImage img1,img2,img3,img4, img5, img6, img7, img8, img9, img10,img11, img12;

  fish(int x, int y)
  {
    this.x = x;
    this.y = y;
    
    img1 = loadImage("p1right.png");  //img1-img6 are fish facing right
    img2 = loadImage("p2right.png");
    img3 = loadImage("p3right.png");
    img4 = loadImage("p4right.png");
    img5 = loadImage("p5right.png");
    img6 = loadImage("p6right.png");
    
    img7 = loadImage("p1left.png");  //img7-img12 are fish facing left
    img8 = loadImage("p2left.png");
    img9 = loadImage("p3left.png");
    img10 = loadImage("p4left.png");
    img11 = loadImage("p5left.png");
    img12 = loadImage("p6left.png");
  }
  
  void draw()
  {
    counter = counter+1;
                                            //animation of fish going right
    if(speed < 0 && counter < 20)
    {
      image(img1,x,y,fishX,fishY);
    }
    else if (speed < 0 && counter < 40)
    {
      image(img2,x,y,fishX,fishY);
    }
    else if (speed < 0 && counter < 60)
    {
      image(img3,x,y,fishX,fishY);
    }
    else if (speed < 0 && counter < 80)
    {
      image(img4,x,y,fishX,fishY);
    }
    else if (speed < 0 && counter < 100)
    {
      image(img5,x,y,fishX,fishY);
    }
    else if (speed < 0 && counter < 120)
    {
      image(img6,x,y,fishX,fishY);
    }
                                            //animation of fish going left
    else if(speed > 0 && counter < 140)
    {
     image(img7,x,y,fishX,fishY);
    }
    else if(speed > 0 && counter < 160)
    {
      image(img8,x,y,fishX,fishY);
    }
    else if(speed > 0 && counter < 180)
    {
     image(img9,x,y,fishX,fishY);
    }
    else if(speed > 0 && counter < 200)
    {
     image(img10,x,y,fishX,fishY);
    }
    else if(speed > 0 && counter < 220)
    {
     image(img11,x,y,fishX,fishY);
    }
    else if(speed > 0 && counter < 240)
    {
     image(img12,x,y,fishX,fishY);
    }
    else
    {
      counter = 0;
    }
  }

  void move ()
  {
    x = x - speed;
    y = y + int(random(-4,4));
  }

  void collideScreen()
  {
    if (x < 0 || x > width - fishX)
    {
      speed = - speed;    //flip the direction of the fish
      x = x - speed;
      y = y - 40;    //take fish up if they collide with screen
    }
  }
  
  void fishCollideHook()
  {
    if(isPressed != 0)
      {
        if(fishCollidedHook == false)
        {
          if(this.y > fishhook.y + fishhook.sizeY || this.x > fishhook.x + fishhook.sizeX || this.x + this.size < fishhook.x || this.y + this.size > fishhook.y + fishhook.sizeY)
          {
            fishCollidedHook = false;
          }
          else
          {
            fishCollidedHook = true;
          }
        }
        
        if(fishCollidedHook == true)
        {
          isPressed = 2;  //take fish back up
          
          this.x = fishhook.x; 
          this.y = fishhook.y;  //take fish up with the hook
          
          if (this.y <= 275)  //if fish reach top of boat
          {
            this.x = width;  //remove fish off screen
            this.speed = 0;  //stop moving fish so they stop drawing
            score = score + 1;
            this.fishCollidedHook = false;
          }
          
          if (gameMode == LEVEL1)
          {
            if (score >= (row*col))  //all fish caught in level 1
            {
              gameMode = LEVEL1COMPLETE;
            }
          }
          else if (gameMode == LEVEL2)
          {
            if (score >= ((row*col) * 2))  //all fish caught in level 1 + all fish caught in level 2
            {
              gameMode = LEVEL2COMPLETE;
            }
          }
          else if (gameMode == LEVEL3)
          {
            if (score >= ((row*col) * 3))  ////all fish caught in level 1 + all fish caught in level 2 + all fish caught in level 3
            {
              gameMode = GAMEWON;
            }
          }
        }
      }
  }
  
  void fishCollideBoat()
  {
    boolean boatCrashed;
        
    if(this.y > man1.y + man1.sizeY || this.x + this.size < man1.x || this.y + this.fishY < man1.y || this.x > man1.x + man1.sizeX)
    {
      boatCrashed = false;
    }
    else
    {
      boatCrashed = true;
    } 
        
    if(boatCrashed == true)
    {
      gameMode = GAMEOVER;
    }
  }
}