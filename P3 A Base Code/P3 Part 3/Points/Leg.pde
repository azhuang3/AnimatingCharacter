class Leg {
  pt H, K, A, E, B, T;
  float hipAngle;
  boolean left = false;
  boolean isSupport = true; //Right foot starts out as support foot
  
  Leg(pt H, pt B, float hipAngle) {
   //H.setTo(H);   
   //B.setTo(B); 
   this.H = H;
   this.B = B;
   this.hipAngle = hipAngle;
   K=P.G[1]; 
   A=P.G[2];
   E=P.G[3]; 
   T=P.G[5]; 
   
   B.y = height - floor - _rB;
   H.y = height-floor-(height-150);
   vec BT = U(B, T);
   T = P(B, _bt, BT);
   T.x = B.x +40;
   T.y = height-floor;
   //_T = P(B, _bt, BT);
   
   
   knee();
   ankle();
   heel();
  }
  
  void changeSupport() {
    if (isSupport) { isSupport = false;}
    else if (!isSupport) { isSupport = true;}
  }
  
  boolean isSupportLeg() {
    if (isSupport) {return true;}
    else {return false;}
  }
  
  
  //calling helper functions for other points
  void knee() {
    vec HB = U(H, B);
    K = P(H, _hk, R(HB,hipAngle));
  }

  //computes ankle
  pt ankle() {
    return A = TriangleTip(K, _ka, _ab, B); //compute by triangulation from knee and ball
  }

  //computes heel
  pt heel() {
    return E = TriangleTip(A, _ae, _eb, B);
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
  
  void student_computeDancerPoints
    (
    pt H,     // hip center
    pt B,     // ball center 
    float a   // angle between HB and HK
    )
  {
   H.setTo(H);   
   B.setTo(B); 
   K=P.G[1]; 
   A=P.G[2];
   E=P.G[3]; 
   T=P.G[5]; 
   
   B.y = height - floor - _rB;
   H.y = height-floor-(height-150);
   vec BT = U(B, T);
   T = P(B, _bt, BT);
   T.y = height-floor;
   //_T = P(B, _bt, BT);
   
   
   //knee();
   ankle();
   heel();
   }
  
  
void student_displayDancer() // displays dancer using dimensions
  {
  caplet(H,_rH,K,_rK);
  caplet(K,_rK,A,_rA);
  caplet(A,_rA,E,_rE);
  caplet(E,_rE,B,_rB);
  caplet(B,_rB,T,_rT);
  caplet(A,_rA,B,_rB);
  noFill(); pen(magenta,2); edge(H,P(H,R(V(0,100),hipAngle)));
  }

//TRANSFER
void transfer(Leg otherLeg) {
  while(H.x != otherLeg.B.x) {
    H.x++;
    //otherLeg.H.x++;
  }
  this.changeSupport();
  otherLeg.changeSupport();
}// end of transfer

//COLLECT
void collect(Leg otherLeg) {
  while (B.x != otherLeg.B.x) {
    otherLeg.B.x++;
  }
  this.changeSupport();
  otherLeg.changeSupport();
}// end of collect

//ROTATE

//AIM
void aim(Leg otherLeg) {
  //hard-coded counter
  int counter = 0;
  while (counter < 200) {
    otherLeg.B.x++;
    counter++;
  }
}// end of aim

}