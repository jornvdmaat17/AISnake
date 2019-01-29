class Snake{
   
  int l;
  int direction;
  SnakePart head;
  
  public Snake(){
     l = 5;
     direction = -1;
     head = new SnakePart(10, 10);
  }
  
  //Draw the snake
  public void draw(){
    SnakePart current = head;
    while(current != null){
       current.draw();
       current = current.next;
    }
    this.move();
  }
  
  //Change the direction of the snake
  public void changeDirection(int direction){
     this.direction = direction;
  }
  
  //Move the snake 
  private void move(){    
    SnakePart newH;
    switch(direction){
      case Direction.NORTH:
        newH = new SnakePart(head.p.x, head.p.y - 1, head);
        head = newH;   
        break;
      case Direction.EAST:
        newH = new SnakePart(head.p.x + 1, head.p.y, head);
        head = newH; 
        break;
      case Direction.SOUTH:
        newH = new SnakePart(head.p.x, head.p.y + 1, head);
        head = newH; 
        break;
      case Direction.WEST:
        newH = new SnakePart(head.p.x - 1, head.p.y, head);
        head = newH; 
        break;
    }
    this.checkLength();
    this.isDead();
  }
  
  //Check the length of the linked list
  private void checkLength(){
    SnakePart current = head;
    for(int i = 1; i < l; i++){
      if(current != null){
        current = current.next;      
      }else{
        return;
      }
    }
    if(current != null){
      current.next = null;
    }
  }
  
  //Check if the snake is dead
  private void isDead(){
    if(head.p.x == 0 || head.p.y == 0 || head.p.x == width / 20 - 1 || head.p.y == height / 20 - 1){
      reset();
      return;
    }
    //SnakePart current = head.next;
    //while(current != null){
    //  if(current.p.equals(head.p)){
    //    reset();
    //    return;
    //  }
    //  current = current.next;
    //}
  }
  
  //Reset the variables
  private void reset(){
    l = 5;
    direction = -1;
    head = new SnakePart(10, 10);
  }
  
  //Detect if the snake hit the apple
  public boolean hitApple(Apple a){
    return head.p.equals(a.p);
  }
  
  //Increases the snake by 1
  public void makeLonger(){
    l++; 
  } 
  
  //SnakePart class
  private class SnakePart{      
    
    Position p;
    SnakePart next; 
    
    public SnakePart(int x, int y){
      p = new Position(x, y);
      next = null;
    }
    
    public SnakePart(int x, int y, SnakePart next){
      p = new Position(x, y);
      this.next = next;
    }
    
    public void draw(){
       fill(0, 255, 0);  
       rect(p.x * 20, p.y * 20, 20, 20);
    }  
  }
}
