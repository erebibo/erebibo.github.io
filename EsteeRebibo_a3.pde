ParallelChart p; 

void setup(){
  size(600,600); 
  surface.setResizable(true);
  loadData(); 
  p.drawColumnLabels(); 
  p.drawCurves(); 
}

void draw(){
  background(255,255,255); 
  p.drawColumnLabels(); 
  p.drawCurves(); 
   //p.drawBox();
  p.checkHoverOverLines(); 
   
}

void loadData(){
  String[] loadedData = loadStrings("data.csv");
   p = new ParallelChart(loadedData);
}

void mouseClicked(){
  p.checkFlipOrientation();
  p.checkColumnClicked();  
}
void mousePressed(){
   p.startBox(); 
}
void mouseDragged(){
  p.updateBox(); 
}

void mouseReleased(){
  
}
