public class Position{

  int x;
  int y;
  
  public Position(int x, int y){
    this.x = x;
    this.y = y;
  }
  
  public void changePos(int x, int y){
    this.x = x;
    this.y = y;
  }
  
  public boolean equals(Position p){
    return (this.x == p.x && this.y == p.y);
  }
}
