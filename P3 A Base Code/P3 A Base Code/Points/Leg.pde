class Leg {
  pt H, K, A, E, B, T;
  float hipAngle;
  boolean left = false;
  boolean Support = false; //Right foot starts out as support foot
  
  Leg(pt H, pt B, float hipAngle) {
    this.H = H;
    this.B = B;
    this.hipAngle = hipAngle;
    
    //this.H = 
    this.A = ankle();
    this.E = heel();
  }
  
  //calling helper functions for other points
  void knee() {
    //vec HB = 
    // _K = P(_H, _hk, HB);
  }

  //computes ankle
  pt ankle() {
    return A = TriangleTip(_K, _ka, _ab, _B); //compute by triangulation from knee and ball
  }

  //computes heel
  pt heel() {
    return E = TriangleTip(_A, _ae, _eb, _B);
  }

  //Returns tip C from base AB with |AC|=a and |BC|=b
  pt TriangleTip(pt A, float a, float b, pt B) {
    float c = d(A,B);
  
    //use the law of cosines
    float angC = acos((sq(b) + sq(a) - sq(c))/(2*b*a));
    float angA = ((b * sin(angC))/ c); 

    vec AB = U(A,B);
  
    pt C = P(A, a, R(AB, angA));
 
    return P(A, a, R(AB, angA)); //return C
  }
  
  //hip position, wrt  P0, P1, P2, P3, detect which phase you are in: 
  //Transfer, Collect, (no Rotation here), Aim, Transfer, 
  //and print it on the screen in realtime
  
  
  

}