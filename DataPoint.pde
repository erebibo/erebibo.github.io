public class DataPoint{
  int value; 
  Column column; 
  
  public DataPoint(int value, Column column){
    this.value = value; 
    this.column = column; 
  }

  public float getX(){
    return column.getX(); 
  }
  public float getY(){
    return column.findY(value); 
  }
}
