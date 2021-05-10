import de.bezier.guido.*;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
static int NUM_ROWS= 20;
static int NUM_COLS= 20;
private Life[][] buttons; //2d array of Life buttons each representing one cell
private boolean[][] buffer; //2d array of booleans to store state of buttons array
private boolean running = true; //used to start and stop program

public void setup () {
  size(400, 400);
  frameRate(6);
  // make the manager
  Interactive.make( this );

  //your code to initialize buttons goes here
  buttons= new Life [NUM_ROWS] [NUM_COLS];
  for (int NUM_ROWS= 0; NUM_ROWS< 20; NUM_ROWS++) {
    for (int NUM_COLS= 0; NUM_COLS< 20; NUM_COLS++) {
      buttons [NUM_ROWS] [NUM_COLS]= new Life(NUM_ROWS, NUM_COLS);
    }
  }

  //your code to initialize buffer goes here
  buffer= new boolean [NUM_ROWS] [NUM_COLS];
}

public void draw () {
  background( 0 );
  if (running == false) //pause the program
    return;
  copyFromButtonsToBuffer();

  //use nested loops to draw the buttons here
  for (int NUM_ROWS= 0; NUM_ROWS< 20; NUM_ROWS++) {
    for (int NUM_COLS= 0; NUM_COLS< 20; NUM_COLS++) {
      if (countNeighbors(NUM_ROWS, NUM_COLS)== 3) {
        buffer [NUM_ROWS] [NUM_COLS]= true;
      } else if (countNeighbors(NUM_ROWS, NUM_COLS)== 2 && buttons [NUM_ROWS] [NUM_COLS].getLife()== true) {
        buffer [NUM_ROWS] [NUM_COLS]= true;
      } else {
        buffer [NUM_ROWS] [NUM_COLS]= false;
      }
      buttons [NUM_ROWS] [NUM_COLS].draw();
    }
  }

  copyFromBufferToButtons();
}

public void keyPressed() {
  if (key == ' ') {
    running= !running;
  }
  if (key == 'g') {
    ++NUM_ROWS;
    ++NUM_COLS;
    setup();
    //this kinda works :) 
    //it gets funky at least
  }
  if (key == 's') {
    --NUM_ROWS;
    --NUM_COLS;
    setup();
    //this kinda works :) 
    //it gets funky at least
  }
  if (key == 'x') {
    for (int NUM_ROWS= 0; NUM_ROWS< 20; NUM_ROWS++) {
      for (int NUM_COLS= 0; NUM_COLS< 20; NUM_COLS++) {
        buttons [NUM_ROWS] [NUM_COLS].setLife(false);
      }
    }
  }
  if (key == 'p') {
    setup();
  }
}

public void copyFromBufferToButtons() {
  for (int NUM_ROWS= 0; NUM_ROWS< 20; NUM_ROWS++) {
    for (int NUM_COLS= 0; NUM_COLS< 20; NUM_COLS++) {
      if (buffer [NUM_ROWS] [NUM_COLS]== true) {
        buttons [NUM_ROWS] [NUM_COLS].setLife(true);
      } 
      if (buffer [NUM_ROWS] [NUM_COLS]== false) {
        buttons [NUM_ROWS] [NUM_COLS].setLife(false);
      }
    }
  }
}

public void copyFromButtonsToBuffer() {
  for (int NUM_ROWS= 0; NUM_ROWS< 20; NUM_ROWS++) {
    for (int NUM_COLS= 0; NUM_COLS< 20; NUM_COLS++) {
      if (buttons [NUM_ROWS] [NUM_COLS].getLife()== true) {
        buffer [NUM_ROWS] [NUM_COLS]= true;
      }
      if (buttons [NUM_ROWS] [NUM_COLS].getLife()== false) {
        buffer [NUM_ROWS] [NUM_COLS]= false;
      }
    }
  }
}

public boolean isValid(int r, int c) {
  //your code here
  if ((r>= 0 && r< 19) && (c >= 0 && c< 19)) {
    return true;
  } else {
    return false;
  }
}

public int countNeighbors(int row, int col) {
  int neighbors= 0;
  if (isValid(row-1, col-1)== true && buttons [row-1] [col-1].getLife() == true) {
    neighbors++;
  }
  if (isValid(row, col-1)== true && buttons [row] [col-1].getLife() == true) {
    neighbors++;
  }
  if (isValid(row+1, col-1)== true && buttons [row+1] [col-1].getLife() == true) {
    neighbors++;
  }
  if (isValid(row-1, col)== true && buttons [row-1] [col].getLife() == true) {
    neighbors++;
  }
  if (isValid(row+1, col)== true && buttons [row+1] [col].getLife() == true) {
    neighbors++;
  }
  if (isValid(row-1, col+1)== true && buttons [row-1] [col+1].getLife() == true) {
    neighbors++;
  }
  if (isValid(row, col+1)== true && buttons [row] [col+1].getLife() == true) {
    neighbors++;
  }
  if (isValid(row+1, col+1)== true && buttons [row+1] [col+1].getLife() == true) {
    neighbors++;
  }
  return neighbors;
}

public class Life {
  private int myRow, myCol;
  private float x, y, width, height;
  private boolean alive;

  public Life (int row, int col) {
    width = 400/NUM_COLS;
    height = 400/NUM_ROWS;
    myRow = row;
    myCol = col; 
    x = myCol*width;
    y = myRow*height;
    alive = Math.random() < .5; // 50/50 chance cell will be alive
    Interactive.add( this ); // register it with the manager
  }

  // called by manager
  public void mousePressed () {
    alive = !alive; //turn cell on and off with mouse press
  }
  public void draw () {    
    fill(alive ? 200 : 400);
    rect(x, y, width, height);
  }
  public boolean getLife() {
    if (alive== true) {
      return true;
    } else {
      return false;
    }
  }
  public void setLife(boolean living) {
    if (living== true) {
      alive= true;
    } else {
      alive= false;
    }
  }
}
