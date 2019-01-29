public static final int mul = 20;

Snake s;
Apple a;
AI brain;

boolean start;

void setup(){
  size(420, 420);
  s = new Snake();
  a = new Apple(5, 5);
  start = false;
  brain = new AI(2, 4, 1, s);
}

void draw(){
  background(0);
  
  fill(0,0,255);
  for(int i = 0; i < height; i++){
    rect(i * mul,0,mul,mul);
    rect(i * mul, height - mul, mul, mul);
  }
  for(int j = 0; j < width; j++){
    rect(0, j * mul, mul, mul);
    rect(width - mul, j * mul, mul, mul);
  }  
  a.draw();
  if(s.hitApple(a)){
    s.makeLonger();
    a.change();
  }
  //if(start){
  //  s.draw();
  //  delay(1000/15);
  //}else{
  //  fill(0, 255, 0);  
  //  rect( 10 * 20, 10 * 20, 20, 20);
  //}  
  
  delay(1000/15);
  s.draw();
  float res = brain.feedforward(new float[]{a.p.x, a.p.y})[0];
  if(res < 0.25){
    s.changeDirection(Direction.NORTH);
  }else if(res < 0.50){
    s.changeDirection(Direction.EAST); 
  }else if(res < 0.75){
    s.changeDirection(Direction.SOUTH);
  }else{
    s.changeDirection(Direction.WEST); 
  }
  //System.out.println(res);
  brain.train(new float[]{a.p.x, a.p.y}, new float[]{1});
}

void keyPressed(){
  if(key == CODED){
    start = true;
    if(keyCode == UP && s.direction != Direction.SOUTH){
      s.changeDirection(Direction.NORTH);
    }
    if(keyCode == DOWN && s.direction != Direction.NORTH){
      s.changeDirection(Direction.SOUTH);
    }
    if(keyCode == LEFT && s.direction != Direction.EAST){
      s.changeDirection(Direction.WEST);
    }
    if(keyCode == RIGHT && s.direction != Direction.WEST){
      s.changeDirection(Direction.EAST);
    }
  }
}
