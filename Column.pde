public class Column{
  String name; 
  int index; 
  int totalColumns; 
  int min = Number.MAX_VALUE;   
  int max = Number.MIN_VALUE; 
  boolean isClicked = false; 

  
 
  
  public Column(String name, int index, int totalColumns){
    this.name = name; 
    this.index = index; 
    this.totalColumns = totalColumns; 
  }
  
  public void checkAndUpdateMax(int toCheck){
    if (max < toCheck){
      max = toCheck; 
    }
  }
  public float findY(int data){
    if (max-min == 0){
      return height-60; 
    }
    return (60+(height-2*60)*(1-(parseFloat(data)-min)/(max-min))); 
  }
  
  public float getX(){
    int spacing = width/totalColumns; 
    return index*spacing; 
  }
  
  public void checkAndUpdateMin(int toCheck){
    if (min > toCheck){
      min = toCheck; 
    }
  }  
  
  public void drawColumn(int spacing, int index){
    fill(0);  
    int horizLoc = index*spacing; 
    text(this.name,horizLoc, 10, horizLoc + spacing,50); 
    text(this.max, horizLoc, 50); 
    text(this.min, horizLoc, height-40); 
    line(horizLoc, height-50, horizLoc, 60); 
  }
  
  public void switchOrientation(){
    int temp = max; 
    max = min; 
    min = temp; 
  }
}
