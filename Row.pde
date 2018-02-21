public class Row{
  DataPoint[] dataPoints;
  color c; 
  color original = color(0,0,0); 
  color hovering = color(0,0,255);
  color notHovering = color (220,220,220); 
  color boxIntersect = color (0,255,0); 
  
  
  public Row(int length){
    dataPoints = new DataPoint[length]; 
    this.c = color(0,0,0); 
  }
  
    public void addData(int index, int value, Column column){
      dataPoints[index] = new DataPoint(value, column); 
    }
   public void drawLines(){
     for (int i = 0; i< dataPoints.length-1; i++){
       float horizLoc1 = dataPoints[i].column.getX(); 
       float horizLoc2 = dataPoints[i+1].column.getX(); 
       float vert1 = dataPoints[i].column.findY(dataPoints[i].value); 
       float vert2 = dataPoints[i+1].column.findY(dataPoints[i+1].value); 
       stroke(c); 
       strokeWeight(1); 
       line(horizLoc1, vert1, horizLoc2, vert2); 
     }
     
  }
  public void resetColor(){
    this.c = original; 
  }
  public void setColorNotHovering(){
    this.c = notHovering;  
  }
  public void setColorHovering(){
    this.c = hovering; 
  }
   public void setColorBoxIntersect(){
    this.c = boxIntersect; 
  }
  public void setColorBasedOnCol(Column col){
      DataPoint d = dataPoints[col.index]; 
      float y = height - col.findY(d.value); 
      float red = 255*(y/height); 
      this.c = color(red, 0,0); 
  }
  
  public boolean doesMouseIntersect(int colOneIndex, int colTwoIndex){
    DataPoint one = dataPoints[colOneIndex]; 
    DataPoint two = dataPoints[colTwoIndex]; 
    //adapted from http://www.jeffreythompson.org/collision-detection/line-point.php
    float oneDist = dist(mouseX,mouseY, one.getX(),one.getY());
    float twoDist = dist(mouseX,mouseY, two.getX(),two.getY());
    float oneToTwo = dist(one.getX(),one.getY(), two.getX(),two.getY());
    if (oneDist+twoDist >= oneToTwo-0.2 && oneDist+twoDist <= oneToTwo+0.2){
      return true; 
    }
    else{
      return false; 
    }
    
  }
  public String toString(){
    for (int i = 0; i <dataPoints.length; i++){
      DataPoint d1 = dataPoints[i]; 
      DataPoint d2 = dataPoints[i+1]; 
      if (d1.getX()<= mouseX && d2.getX() >=mouseX) {
      return "(" +d1.value + " ; "+ d2.value+")"; 
      }
    }
  return ""; 
  }
  
}
