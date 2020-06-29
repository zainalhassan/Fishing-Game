  //main costruction of the fishing game. Created by Zain Al-Hassan - 17106353
PFont font;  //custom font - SitkaBanner-40
PImage splashscreenBackground, instructions, title, background, backgroundFlipped, levelUp, fisherman, hook, predators, mantaTop, megaHook, lifeImage, finishBackground, winBackground;

//------------------------------------------------------------initalisation of variables---------------------------------------------------------------------------
int backgroundX = 0;
int boatX = 400;

int isPressed = 0;

int gameStartTime;
int gameTime = 70;  //length of the game
int time = gameTime;

int score;

int total;
int timeTotal;
int bestTotal;

boolean predatorTop;
boolean megaHookTop;

final int SPLASHSCREEN = -1;    //Gamemodes
final int INSTRUCTIONS = 0;
final int LEVEL1 = 1;
final int LEVEL2 = 2;
final int LEVEL3 = 3;
final int LEVEL1COMPLETE = 4;
final int LEVEL2COMPLETE = 5;
final int GAMEOVER = 6;
final int GAMEWON = 7;

int gameMode = SPLASHSCREEN;

int col = 5;
int row = 3;
fish[][] fishArray = new fish[col][row]; //2D array of fish

int numLives = 3;  //number of lives in the game
lives[] lifeArray = new lives[numLives];

int randomHint;  //random hint will be displayed when gameMode is gameover
String[] hints = { "Try dropping hook ahead of fish", "Better luck next time", ":(", "you can do it", "beware of the toxic predator" };

predator predator1;  //Predator 1
predator predator2;  //Predator 2
predator predator3;  //Predator 2

megaHook mega1;  //megaHook 1

Fisherman man1;  //boat
hook fishhook;   //hook
//-----------------------------------------------------------------------------------------------------------------------------------------------------------------

void setup()
{
  size(1000, 1200);  //canvas size
  font = loadFont("Sitka40.vlw");  //loads font into program
  textFont(font);    ///assigning font to program text
//------------------------------------------------------------Loading of backgrounds-------------------------------------------------------------------------------
  splashscreenBackground = loadImage("splashscreenBackground.jpg");
  splashscreenBackground.resize(width, height);

  instructions = loadImage("instructions.png");
  instructions. resize(width, height);

  background = loadImage("background.JPG");
  background.resize(width, height);
  
  backgroundFlipped = loadImage("backgroundflipped.jpg");
  backgroundFlipped.resize(width, height);
  
  levelUp = loadImage("LevelUP.png");
  levelUp.resize(width, height/2);

  finishBackground = loadImage("finished.png");
  finishBackground.resize(width, height);

  winBackground = loadImage("winBackground.jpg");
  winBackground.resize(width, int(height*0.6));
//-----------------------------------------------------------------------------------------------------------------------------------------------------------------
  initialiseGame(); //calls on initialiseGame
}

void initialiseGame()
{
//------------------------------------------------------------initialising the game elements-----------------------------------------------------------------------
  man1 = new Fisherman(boatX, 125, 200, 150);     //Boat
  
  fishhook = new hook(boatX + 109, 265, 25, 50, boatX + 132);  //Hook - these values need to be changed to use variables instead
  
  predator1 = new predator(int(random(0,width)), height + 125);            //Predator 1
  predator2 = new predator(int(random(0,width)), height + 125);            //Predator 2
  predator3 = new predator(int(random(0,width)), height + 125);            //Predator 2
  
  mega1 = new megaHook(int(random(0,width)), height + 300);                //megaHook 1
  
  int x = 200;  //variable for the fish
  int y = 900;  //variable for the fish

  for (int i = 0; i < fishArray.length; i++)
  {
    for (int j = 0; j < fishArray[i].length; j++)
    {
      fishArray[i][j] = new fish(x, y);           //fishes
      y = y + 100;
    }
    x = x + 120;
    y = 900;
  }

  int lifeX = 100;  //where the the first life image is

  for (int i = 0; i < lifeArray.length; i++)
  {
    lifeArray[i] = new lives(lifeX, 75, 40);           //lives
    lifeX = lifeX + 40;
  }
}
//-----------------------------------------------------------------------------------------------------------------------------------------------------------------

void reset()
{
//------------------------------------------------------------Reset game statistics--------------------------------------------------------------------------------
  initialiseGame();
  gameStartTime = millis();
  gameTime = 70;
  time = gameTime;
  score = 0;
  numLives = 3;
}
//-----------------------------------------------------------------------------------------------------------------------------------------------------------------

void play()
{
    image(background, backgroundX, 0);
    image(backgroundFlipped, backgroundX+background.width, 0);
    image(background, backgroundX+(background.width * 2), 0);  //3 backgrounds drawn adjacent to each other
    backgroundX = backgroundX - 1;    //makes background scroll left
    if (backgroundX <= (-backgroundFlipped.width * 2))
    {
      backgroundX = 0; //wrap background
    }
      
    man1.draw();
    fishhook.draw();

    if (isPressed == 1)
    {
      fishhook.drop(5);  //takes hook down
    }
    else if (isPressed == 2)
    {
      fishhook.drop(-5);  //takes hook up
    }

    for (int i = 0; i < fishArray.length; i++)
    {
      for (int j = 0; j < fishArray[i].length; j++)  //fish
      {
        fishArray[i][j].draw();
        fishArray[i][j].move();
        fishArray[i][j].collideScreen();
        fishArray[i][j].fishCollideBoat();
        fishArray[i][j].fishCollideHook();
      }
    }

    fishhook.collidescreen();

    predator1.draw();  //Predator 1
    predator1.ascend();
    predator1.predatorCollideBoat();
    
    
      if (gameMode == LEVEL2)
    {
      predator2.draw();   //Predator 2
      predator2.ascend();
      predator2.predatorCollideBoat();
    }
    
    if (gameMode == LEVEL3)
    {
      predator2.draw();   //Predator 2
      predator2.ascend();
      predator2.predatorCollideBoat();
      
      predator3.draw();   //Predator 2
      predator3.ascend();
      predator3.predatorCollideBoat();
    }

    if (predatorTop == true)  //When predator reaches top, make them go to the bottom and go back up again
    {
      predator1.reAscend();
      predator2.reAscend();
      predator3.reAscend();
    }
    
    mega1.draw();
    mega1.ascend();
    mega1.caughtMega();
    
    if (megaHookTop == true)  //When megaHook reach top, make it go to the bottom and go back up again
    {
      mega1.reAscend();
    }

    fill(40, 99, 193);          //dark blue
    rect(5, 5, 220, 110, 10);  //Rectangle for main game statistics
    
    fill(40, 99, 193);        //dark blue
    rect(width -225, 5, 220, 110, 10);  //Rectangle for time reminders, level and number of fish left
    
    fill(255);
    textSize(28);
    text("Time: ", 10, 40);
    
    time = gameTime - (millis() - gameStartTime)/1000;
    
    if (time > 0)
    {
      if (time < 11)
      {
        fill(255, 0, 0);                           //red
        text(time, 100, 40);                       //displays the countdown in the left box
        text("Hurry up!", width - 220, 40);        //displays motivational phrase in the right box
      }
      else if (time < 20 && time > 10)
      {
        fill(255, 191, 0);                        //amber
        text(time, 100, 40);                      //displays the countdown in the left box
        text("You got this", width - 220, 40);    //displays motivational phrase in the right box
      }
      else
      {
        fill(0, 255, 0);                          //green
        text(time, 100, 40);                      //displays the countdown in the left box
        text("Plenty of time", width - 220, 40);  //displays motivational phrase in the right box
      }
    }
    else
    {
      gameMode = GAMEOVER; // lose game when time = 0
    }
    
    fill(255);
    text("Score: ", 10, 70);
    text(score, 100, 70);    //calculates score and displays it in the left box
    
    text("Lives: ", 10, 100);
   
    for (int i = 0; i < numLives; i++) //changed lifeArray.length to numlives and it worked
    {
      lifeArray[i].draw();   //draws number of lives
    }
    
    fill(255);
    textSize(30);
    text("Level:", width - 220,70);
    text(gameMode, width - 50,70);  //displays the level in right box
    text("/3", width - 35,70);
    
    text("Fish left:", width - 220,100);
    if (gameMode == LEVEL1)
    {
      text(((row*col) - score), width - 50,100);  //calculates remaining fish and displays number in right box if its level 1
    }
    else if (gameMode == LEVEL2)
    {
      text((((row*col) * 2) - score), width - 50,100);  //calculates remaining fish and displays number in right box if its level 2
    }
    else if (gameMode == LEVEL3)
    {
      text((((row*col) * 3) - score), width - 50,100);  //calculates remaining fish and displays number in right box if its level 3
    }
}

void draw()
{
//------------------------------------------------------------Drawing the game-------------------------------------------------------------------------------------
  if (gameMode == SPLASHSCREEN)
  {
    image(splashscreenBackground, 0, 0);
    title = loadImage("title.png");
    image(title, 150, 200);
    image(predators, width*0.1, height/3, 150,150);
    image(predators, width*0.9 - 150, height/3,150, 150);
    
    textSize(32);
    text("PRESS I FOR INSTRUCTIONS", width * 0.3, height * 0.5);
    
    textSize(50);
    text("PRESS SPACE TO START GAME", width * 0.15, height * 0.6);
    
  }
  
  else if (gameMode == INSTRUCTIONS)
  {
    image(instructions, 0, 0);
    
    fill(40, 99, 193);   //dark blue
    rect(25, 800, width - 50, 375, 10);  //rectangle covering the bottom half of the screen
    
    textSize(50);
    fill(0);
    text("PRESS SPACE TO START GAME", width * 0.15, height * 0.9);
    
    textSize(40);
    text("The aim of the game is to complete all 3 levels by catching all the fish without losing all your lives as well as doing this in time. Make sure you catch all the fish before they reach the boat otherwise you'll die!", width*0.05, 820, width - 50,400);
  }
  
  else if (gameMode == LEVEL1)
  {
    play();
  }
  
  else if (gameMode == LEVEL1COMPLETE)
  {
    background(0);
    image(levelUp, 0,0);
    
    fill(255);
    textSize(40);    
    text(time, width * 0.05, height * 0.4);
    text("Seconds to spare",width * 0.1, height * 0.4);
    
    text("Can you do it with less time and more predators?",width * 0.1, height * 0.6, width, height/2);
    
    text("PRESS SPACE TO PLAY NEXT LEVEL", width * 0.18, height * 0.9);
  }
  
  else if (gameMode == LEVEL2)
  {
    play();
  }
  
  else if (gameMode == LEVEL2COMPLETE)
  {
    background(255);
    image(levelUp, 0,0);
    
    fill(0);
    textSize(40);  
    text(time, width * 0.05, height * 0.4);
    text("Seconds to spare",width * 0.1, height * 0.4);
    
    text("Can you do it with less time and more predators?",width * 0.1, height * 0.6, width, height/2);
    
    text("PRESS SPACE TO PLAY NEXT LEVEL", width * 0.18, height * 0.9);
  }
  
  else if (gameMode == LEVEL3)
  {
    play();
  }
  
  else if (gameMode == GAMEWON)
  {
    image(splashscreenBackground, 0, 0);
    image(winBackground, 0, 0);
    
    fill(40, 99, 193);  //dark blue
    rect(25, 800, width - 50, 375, 10);  //rectangle covering the bottom half of the screen
    
    fill(255);
    textSize(50);
    text("YOU WIN!", width * 0.38, 850);
    
    textSize(32);
    text("YOUR TIME REMAINING WAS: ", width * 0.1, 900);
    text(time, width*0.9, 900);
    
    text("YOUR SCORE WAS: ", width * 0.1, 950);
    text(score, width*0.9, 950);
    
    total = (score * (timeTotal + time)); // total is calculated by adding up all time remaining and * by score
    
    text("YOUR TOTAL WAS: ", width * 0.1, 1000);
    text(total, width*0.9, 1000);
    
    if(total > bestTotal)
    {
      bestTotal = total;
    }
    
    text("YOUR BEST TOTAL: ", width * 0.1, 1050);
    text(bestTotal, width*0.9, 1050);

    text("PRESS SPACE TO PLAY GAME AGAIN", width * 0.3, height * 0.95);
    
    if(total == bestTotal)  //display high score greeting if new highscore is beaten
    {
      fill(0);
      textSize(60);
      text("New High Score",width * 0.05, height * 0.05);
    }
  }
  
  else if (gameMode == GAMEOVER)
  {
    image(finishBackground, 0, 0);
    
    fill(40, 99, 193);  //dark blue
    rect(25, 800, width - 50, 375, 10);  //rectangle covering the bottom half of the screen
    
    fill(255);
    textSize(50);
    text("GAME OVER", width * 0.36, 850);
    
    textSize(32);
    text("YOUR SCORE WAS: ", width * 0.1, height * 0.75);
    text(score, width * 0.9, height * 0.75);
    
    text(hints[randomHint], width * 0.1, height * 0.8);
    
    text("PRESS SPACE TO PLAY GAME AGAIN", width * 0.2, height * 0.9);
  }
}
//-----------------------------------------------------------------------------------------------------------------------------------------------------------------

void keyPressed()
{
//------------------------------------------------------------Actions of different keyPressed buttons--------------------------------------------------------------
  if (gameMode == SPLASHSCREEN)
  {
    if (key == ' ')  //start game if splashscreen and space pressed
    { 
      gameMode = LEVEL1;
      gameStartTime = millis();
    }

    if (key == 'I' || key == 'i')
    {
      gameMode = INSTRUCTIONS;
    }
  }

  if (gameMode == INSTRUCTIONS)
  {
    if (key == ' ')  //start game if instructions screen and space pressed
    {
      gameMode = LEVEL1;
      gameStartTime = millis();
    }
  }
  
  if (gameMode == LEVEL1 || gameMode == LEVEL2 || gameMode == LEVEL3)
  {
    if (key == CODED)
    {
      if (keyCode == RIGHT)  //move boat and hook right
      {
        if (man1.x < width - man1.sizeX - 10)  //ensures boat and hook stays within right of screen 
        {
          man1.move(6);
          fishhook.move(6);
        }
      }

      if (keyCode == LEFT)  //move boat and hook left
      {
        if (man1.x > 0)  //ensures boat and hook stays within left of screen
        {
          man1.move(-6); 
          fishhook.move(-6);
        }
      }
      
      if (keyCode == DOWN && isPressed == 0)
      {
        isPressed = 1;  // drops hook
      }
    }
  }
  
   if (gameMode == LEVEL1COMPLETE)
   {
     if (key == ' ')  //start level 2 if level 1 completed and space pressed
    {
      timeTotal = timeTotal + time;
      gameMode = LEVEL2;  //move to next level
      reset();
      gameTime = gameTime -10;
      score = row * col;
      
    }
   }
   
    if (gameMode == LEVEL2COMPLETE)
   {
     if (key == ' ')  //start level 3 if level 2 completed and space pressed
    {
      timeTotal = timeTotal + time;
      gameMode = LEVEL3;  //move to next level
      reset();
      gameTime = gameTime - 20;
      score = (row * col) * 2;
    }
   }

  if (gameMode == GAMEWON)
  {
    if (key == ' ')  //restart game if game won and spacekey pressed
    {
      gameMode = LEVEL1;  
      reset();
      total = 0;
      timeTotal = 0;
    }
  }
  
  if (gameMode == GAMEOVER)
  {
    if (key == ' ')  //restart game if game lost and spacekey pressed
    {
      gameMode = LEVEL1;
      reset();
      total = 0;
      timeTotal = 0;
    }
  }
}
//-----------------------------------------------------------------------------------------------------------------------------------------------------------------