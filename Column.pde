public class Column{
  String name; 
  int index; 
  int totalColumns; 
  int min = Number.MAX_VALUE;   
  int max = Number.MIN_VALUE; 
  
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
    return 20+index*spacing; 
  }
  
  public void checkAndUpdateMin(int toCheck){
    if (min > toCheck){
      min = toCheck; 
    }
  }  
  
  public void drawColumn(){
    int spacing = width/totalColumns; 
     float horizLoc = getX(); 
     //label
    fill(125,125,125);  
    text(this.name,horizLoc, 10, horizLoc + spacing,50); 
    stroke(0,0,0); 
    strokeWeight(2); 
    line(horizLoc, 30, horizLoc+textWidth(this.name), 30); 
    //max and min
    fill(0,0,0); 
    text(this.max, horizLoc, 50); 
    text(this.min, horizLoc, height-40); 
    //axis
    stroke(220,220,220); 
    strokeWeight(4); 
    line(horizLoc, height-50, horizLoc, 60); 
  }
  
  public void switchOrientation(){
    int temp = max; 
    max = min; 
    min = temp; 
  }
  
  public boolean isColumnClicked(){
    float columnX = getX(); 
    return (mouseX <= columnX+5 && mouseX >= columnX-5); 
  }
}
