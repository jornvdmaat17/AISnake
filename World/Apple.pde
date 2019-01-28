public class Apple{
  
  Position p;
  
  public Apple(int x, int y){
    this.p = new Position(x, y); 
  }
  
  public void draw(){
    fill(255, 0, 0);  
    rect(p.x * 20, p.y * 20, 20, 20);
  } 
  
  public void change(){
    this.p.x = (int)random(1, width / 20 - 1);
    this.p.y = (int)random(1, height / 20 - 1);
  }
}
