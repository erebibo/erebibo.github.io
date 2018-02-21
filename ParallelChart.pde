public class ParallelChart{
  Row[]rows; 
  Column[] columns;
  Box box = null; 
  Column clickedColumn = null; 
  ArrayList<Row> hoveredRows = new ArrayList<Row>(); 
  ArrayList<Row> intersectingRows = new ArrayList<Row>(); 
  
  public ParallelChart(String[]data){
    String[]cols = split(data[0], ','); 
    this.columns = new Column[cols.length-1]; 
    this.rows = new Row[data.length-1]; 
    
    //initialize columns, ignoring first column
    for (int i = 1; i<cols.length; i++){ 
        this.columns[i-1] = new Column(cols[i], i-1, columns.length); 
    }
    //initialize rows starting with second row
    for (int i = 1; i <data.length; i++){
      String[] rowData = split(data[i], ','); 
      rows[i-1] = new Row(rowData.length-1); 
      //ignore first column when finding column max and min
      for (int j = 1; j<rowData.length; j++){
          columns[j-1].checkAndUpdateMax(parseInt(rowData[j])); 
          columns[j-1].checkAndUpdateMin(parseInt(rowData[j])); 
          rows[i-1].addData(j-1, parseInt(rowData[j]), columns[j-1]); 
      }  
    }
      
  }
  public void drawCurves(){
   
   if (box != null && box.shouldDraw) { 
     implementBoxDrawn(); 
   }
   else if (hoveredRows.size() != 0){
       implementHovering(); 
   }
   else if (clickedColumn != null){
    implementColumnClicked(); 
   }
   else {
      implementNoEffect();  
    }
    for (int i = 0; i<rows.length; i++){
      rows[i].drawLines(); 
    }
    if (box != null && box.shouldDraw){
      box.drawBox(); 
      for (Row rb : intersectingRows){
        rb.drawLines(); 
      }
    }
    else if (hoveredRows.size() != 0){
       for (Row hr : hoveredRows){
        hr.drawLines(); 
      }
       implementHoverToolTip(); 
    }
  }
 
  public void drawColumnLabels(){
    for (int i = 0; i <columns.length; i++){
      columns[i].drawColumn(); 
    }
  }
  
  public boolean checkColumnClicked(){
   
    for (int i = 0; i<columns.length; i++){
        Column col = columns[i]; 
        if (col.isColumnClicked()){
          clickedColumn = col; 
          return true; 
        }
       }
       return false; 
    }
  
  public boolean checkFlipOrientation(){
    int spacing = width/(columns.length); 
    for (int i = 0; i<columns.length; i++){
        Column col = columns[i]; 
        float columnX = col.getX(); 
        if (mouseX <= columnX+spacing && mouseX >= columnX && mouseY <= 40){
           col.switchOrientation();  
           return true; 
        }
    }
    return false; 
  }
  
  public boolean checkHoverOverLines(){ 
   
    ArrayList<Row> foundRows = new ArrayList<Row>(); 
    for(int i = 0; i <columns.length-1; i++){
      float colX = columns[i].getX(); 
      if (mouseX >= colX && mouseX <= columns[i+1].getX()){
        for (Row row: rows){
          if (row.doesMouseIntersect(i, i+1)){
            foundRows.add(row); 
          }
        }
      }
    }
    hoveredRows = foundRows; 
    return hoveredRows.size() > 0 ; 
  }
  
  public void implementNoEffect(){
    for (Row r: rows){
      r.resetColor(); 
    }
  }
  public void implementColumnClicked(){
    for (Row r: rows){
      r.setColorBasedOnCol(clickedColumn); 
    }
  }
   public void implementHovering(){
    for (Row r: rows){
      r.setColorNotHovering(); 
    }
    for (Row rh: hoveredRows){
      rh.setColorHovering(); 
    }
  }
  public void implementBoxDrawn(){
    for (Row r: rows){
      r.setColorNotHovering(); 
    }
    for (Row ri: intersectingRows){
      ri.setColorBoxIntersect(); 
    }
  }
  public void implementHoverToolTip(){
    float X = mouseX+15; 
      float Y = mouseY+15; 
      for (Row r : hoveredRows){
        String t = r.toString(); 
        fill(0,0,0); 
        textSize(14); 
        text(t, X, Y); 
        Y+= 20; 
    }
  }
  
  public void startBox(){
     box = new Box(); 
    box.x1 = mouseX; 
    box.y1 = mouseY; 
  }
  public void outlineBox(){
    box.shouldDraw = true; 
     box.x2 = mouseX; 
    box.y2 = mouseY; 
  }
  public void updateBox(){
    box.finalizeBoxDimensions(); 
    for (Row r: rows){
      if (box.doesIntersectLine(r)){
        intersectingRows.add(r); 
      }
    }
  }
  
  public void deleteBox(){
    box = null; 
    intersectingRows = new ArrayList<Row>(); 
  }
  
}
