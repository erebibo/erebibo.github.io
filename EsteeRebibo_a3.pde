ParallelChart p; 

void setup(){
 
  loadData(); 
  p.drawColumnLabels(); 
  p.drawCurves(); 
}

void draw(){
  background(255,255,255); 
  p.drawColumnLabels(); 
  p.drawCurves(); 
}

void loadData(){
  String[] loadedData = loadStrings("data.csv");
   p = new ParallelChart(loadedData);  
}

void mouseClicked(){
 p.deleteBox(); 
 if (!p.checkFlipOrientation()){
  p.checkColumnClicked(); 
 }
}

void mouseMoved(){
  p.checkHoverOverLines(); 
}
void mousePressed(){
  p.deleteBox();
   p.startBox(); 
}
void mouseDragged(){
  p.outlineBox(); 
}
void mouseReleased(){
  p.updateBox(); 
}
