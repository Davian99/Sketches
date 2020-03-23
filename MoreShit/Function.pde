public class Function { 
  ArrayList<Double> terms;
  
  Function(ArrayList<Double> in_terms) {
    this.terms = in_terms;
  }
  
  public Double evaluate(Double x){
    Double y = new Double(0.0);
    Double x2 = new Double(1.0);
    
    for(Double d : terms){
      y += d * x2;
      x2 *= x;
    }
    
    return y;
  }
  
}
