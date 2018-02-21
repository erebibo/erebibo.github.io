public class Box{
  float x1; 
  float y1; 
  float x2; 
  float y2; 
  boolean shouldDraw = false; 
  
  public void drawBox(){
    noFill(); 
    rectMode(CORNERS);
    stroke(0); 
    strokeWeight(2); 
    rect(x1, y1, x2, y2); 
  }
  
  public void finalizeBoxDimensions(){
    
    x2 = mouseX; 
    y2 = mouseY; 
    if (x1 > x2){
      float tmp = x1; 
      x1 = x2; 
      x2 = tmp; 
    }
    if (y1 > y2){
      float tmp2 = y1; 
      y1 = y2; 
      y2 = tmp2; 
    }
  }
  //adapted from http://www.jeffreythompson.org/collision-detection/line-line.php and studio 3 solution posted on piazza
  public boolean doesIntersectLine(Row row){
    for (int i = 0; i < row.dataPoints.length-1; i++){
      DataPoint d1 = row.dataPoints[i]; 
      DataPoint d2 = row.dataPoints[i+1]; 
      float rx1 = d1.getX();
      float ry1 = d1.column.findY(d1.value); 
      float rx2 = d2.getX(); 
      float ry2 = d2.column.findY(d2.value); 
      boolean doesIntersectTop = (orient(rx1, ry1, rx2, ry2, x1, y1) * orient(rx1, ry1, rx2, ry2, x2, y1) < 0) 
      && (orient(x1, y1, x2, y1, rx1, ry1)* orient(x1, y1, x2, y1, rx2, ry2) < 0);
      boolean doesIntersectBottom = (orient(rx1, ry1, rx2, ry2, x1, y2) * orient(rx1, ry1, rx2, ry2, x2, y2) < 0) 
      && (orient(x1, y2, x2, y2, rx1, ry1)* orient(x1, y2, x2, y2, rx2, ry2) < 0);
      boolean doesIntersectLeft = (orient(rx1, ry1, rx2, ry2, x1, y1) * orient(rx1, ry1, rx2, ry2, x1, y2) < 0) 
      && (orient(x1, y1, x1, y2, rx1, ry1)* orient(x1, y1, x1, y2, rx2, ry2) < 0);
      boolean doesIntersectRight = (orient(rx1, ry1, rx2, ry2, x2, y1) * orient(rx1, ry1, rx2, ry2, x2, y2) < 0) 
      && (orient(x2, y1, x2, y2, rx1, ry1)* orient(x2, y1, x2, y2, rx2, ry2) < 0);
      if (doesIntersectTop || doesIntersectBottom || doesIntersectLeft || doesIntersectRight){return true; }
    }
    
   return false; 
  }
  
  private float orient(float x1, float y1, float x2, float y2, float x3, float y3) {
  return (x2 - x1)*(y3 - y1) - (y2 - y1)*(x3 - x1);
}
}
