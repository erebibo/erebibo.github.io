public class Row{
  DataPoint[] dataPoints;
  color c; 
  color original = color(0,0,0); 
  color hover = color(0,0,255); 
  
  
  public Row(int length){
    dataPoints = new DataPoint[length]; 
    this.c = color(0,0,0); 
  }
  
    public void addData(int index, int value, Column column){
      dataPoints[index] = new DataPoint(value, column); 
    }
   public void drawLines(){
     int spacing = width/(dataPoints.length);
     
     for (int i = 0; i< dataPoints.length-1; i++){
       int horizLoc1 = i*spacing; 
       int horizLoc2 = (i+1)*spacing; 
       float vert1 = dataPoints[i].column.findY(dataPoints[i].value); 
       float vert2 = dataPoints[i+1].column.findY(dataPoints[i+1].value); 
       stroke(c); 
       line(horizLoc1, vert1, horizLoc2, vert2); 
     }
     
  }
  public void resetColor(){
    this.c = color(0,0,0); 
  }
  public void setColorBasedOnCol(){
    for (DataPoint d: dataPoints){
      if (d.column.isClicked == true){ 
        float y = height - d.column.findY(d.value); 
        float red = 255*(y/height); 
        this.c = color(red, 0,0); 
      }
    }
  }
  
  public boolean doesMouseIntersect(int colOneIndex, int colTwoIndex){
    DataPoint one = dataPoints[colOneIndex]; 
    DataPoint two = dataPoints[colTwoIndex]; 
    float oneDist = dist(mouseX,mouseY, one.getX(),one.getY());
    float twoDist = dist(mouseX,mouseY, two.getX(),two.getY());
    float oneToTwo = dist(one.getX(),one.getY(), two.getX(),two.getY());
    if (oneDist+twoDist >= oneToTwo-0.5 && oneDist+twoDist <= oneToTwo+0.5){
      c =hover; 
      return true; 
    }
    else{
      if (c == original || c == hover) {
      c =  color(220,220,220); 
      }
      return false; 
    }
    
  }
  
  public boolean doesIntersectBox(Box box, int columnIndex, int endIndex){
     float bx1 = box.x1;
    float bx2 = box.x2;
    float by1 = box.y1; 
    float by2 = box.y2; 
    
    if (bx1 > bx2) {
        bx2 =box.x2;  
        bx1 = box.x1;
        by2 = box.y1; 
        by1 = box.y2;
        
    }
    for (int i = columnIndex; i<=endIndex; i++){
    DataPoint v1 = dataPoints[i];
    DataPoint v2= dataPoints[i+1];
    float x1 = v1.getX();
    float y1 = v1.getY(); 
    float x2 = v2.getX();
    float y2 = v2.getY(); 
    float m = (y2-y1)/(x2-x1); 
    float b = y1-(m*x1); 
    float XlocAtY1 = (by1-b)/m;  
    float XlocAtY2 = (by2-b)/m;  
    float YlocAtX1 = m*bx1+b; 
    float YlocAtX2 = m*bx2+b; 
    if (i == columnIndex){
      if (isBetween(XlocAtY1, bx1, bx2) || isBetween(XlocAtY2, bx1, bx2)  || isBetween(YlocAtX1, by2, by1)){
        c = hover; 
        return true; 
      }
    }
  //  else if (isBetween(XlocAtY1, box.x1, v2.column.getX()) || isBetween(XlocAtY2, v1.column.getX(), v2.column.getX())){
    //  c = hover; 
     // return true; 
   // }
   
    }
    c = color(0,0,0); 
    return false; 
    
  }
  public String toString(){
    String s = "["; 
    for (DataPoint d : dataPoints){
      s+= d.column.name + ": "+d.value+","; 
    }
    s+="]"; 
    return s; 
  }
  
  boolean isBetween(float val, float smallNum, float largeNum) {
    if ((val < largeNum) && (val > smallNum)) {
        return true;
    }
    return false;
}
  
}

