public static final int mul = 20;

Snake s;
Apple a;
AI brain;
AI xor;

int loop = 0;

boolean start;

void setup(){
  s = new Snake();
  a = new Apple(14, 14);
  start = false;
  //brain = new AI(1, 4, 1, s);
  xor = new AI(2, 1, 1);
}


void draw(){  
  for(int i = 0; i < 1000; i++){
    if(loop == 0){
      xor.train(new float[]{0, 0}, new float[]{0});
    }
    if(loop == 1){
      xor.train(new float[]{1, 1}, new float[]{1});
    }
    if(loop == 2){
      xor.train(new float[]{1, 0}, new float[]{0});
    }
    if(loop == 3){
      xor.train(new float[]{0, 1}, new float[]{0});
    }
    loop = loop % 4;
  }  
  System.out.println(xor.feedforward(new float[]{0, 1})[0]);
  delay(1000);
  
  
}


/*
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
  
  float distance = (float)Math.sqrt((a.p.x - s.head.p.x)*(a.p.x - s.head.p.x) + (a.p.y - s.head.p.y)*(a.p.y - s.head.p.y));
  
  delay(1000/1500);
  s.draw();
  float res = brain.feedforward(new float[]{distance})[0];
  
  
  if(res < 1){
    
    s.changeDirection(Direction.NORTH);
  }else if(res < 2){
    s.changeDirection(Direction.EAST); 
  }else if(res < 3){
    s.changeDirection(Direction.SOUTH);
  }else{
    s.changeDirection(Direction.WEST); 
  }
  System.out.println("Res: "+ res);
  
  
  brain.train(new float[]{distance}, new float[]{getClosestDirection(a)});
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

public float getClosestDirection(Apple a){
  Position p1 = a.p;
  Position p2 = s.head.p;
  
  int xDiff = p2.x - p1.x;
  int yDiff = p2.y - p2.y;    

  if(xDiff < yDiff){
    if(p1.x > p2.x){
      return Direction.EASTAVERAGE;
    }else{
      return Direction.WESTAVERAGE;
    }
  }else{
    if(p1.y > p2.y){
      return Direction.SOUTHAVERAGE;
    }else{
      return Direction.NORTHAVERAGE;
    }
  }
}

*/
