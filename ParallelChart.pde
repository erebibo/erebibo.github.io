public class ParallelChart{
  Row[]rows; 
  Column[] columns;
  Box box = new Box(); 
  
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
    for (int i = 0; i<rows.length; i++){
      rows[i].drawLines(); 
    }
  }
 
  public void drawColumnLabels(){
    int spacing = width/(columns.length); 
    for (int i = 0; i <columns.length; i++){
      columns[i].drawColumn(spacing, i); 
    }
  }
  
  public void checkColumnClicked(){
    clearClickedColumn(); 
    int spacing = width/(columns.length); 
    for (int i = 0; i<columns.length; i++){
        Column col = columns[i]; 
        float columnX = i*spacing; 
        if (mouseX <= columnX+5 && mouseX >= columnX-5){
          col.isClicked = true; 
        }
    }
     for(Row r : rows){
          r.setColorBasedOnCol();
    }
  }
  
  public void clearClickedColumn(){
    for(Column col : columns){
        col.isClicked = false; 
    }
  }
  
  public void checkFlipOrientation(){
    int spacing = width/(columns.length); 
    for (int i = 0; i<columns.length; i++){
        Column col = columns[i]; 
        float columnX = i*spacing; 
        if (mouseX <= columnX+spacing && mouseX >= columnX && mouseY <= 40){
           col.switchOrientation();  
        }
    }
  }
  
  public void checkHoverOverLines(){
    int spacing = width/(columns.length); 
    ArrayList<String> fullText = new ArrayList<String>(); 
    for(int i = 0; i <columns.length-1; i++){
      float colX = i*spacing; 
      //find column where mouse is between
      if (mouseX >= colX && mouseX <= colX+spacing){
        for (Row row: rows){
          if (row.doesMouseIntersect(i, i+1)){
            fullText.add(row.toString()); 
          }
        }
      }
     
      float X = mouseX; 
      float Y = mouseY; 
      for (String t : fullText){
        fill(0,0,0); 
        textSize(12); 
        text(t, X, Y, textWidth(t)/2, 50); 
        Y+= 50; 
      }
    }
    
  }
  public void drawBox(){
    box.drawBox();
    int spacing = width/(columns.length); 
    int colStartIndex = -1; 
    int colEndIndex = -1; 
    for(int i = 0; i <columns.length-1; i++){
      float colX = i*spacing; 
      //find column where mouse is between
      if (box.x1 >= colX && box.x1 <= colX+spacing){
        colStartIndex = i; 
       }
       if (box.x2 >= colX && box.x2 <= colX+spacing){
        colEndIndex = i; 
       }
    }
    if (colStartIndex != -1){
    for (Row row: rows){
          row.doesIntersectBox(box, colStartIndex, colEndIndex); 
        }
    }
  }
  public void startBox(){
    box.x1 =  mouseX; 
    box.y1 = mouseY;  
    box.x2 =  mouseX; 
    box.y2 = mouseY; 
  }
  
  public void updateBox(){
    box.x2 = mouseX; 
    box.y2 = mouseY;
  }
  
}
