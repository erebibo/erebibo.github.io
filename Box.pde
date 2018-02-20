public class Box{
  int x1; 
  int y1; 
  int x2; 
  int y2;
  
  
  public void drawBox(){
    noFill(); 
    rectMode(CORNERS);
    rect(x1, y1, x2, y2); 
  }

}
