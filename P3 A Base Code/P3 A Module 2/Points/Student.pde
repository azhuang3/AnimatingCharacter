// STUDENT'S NAME
// PLEASE PLACE YOUR CODE IN THIS TAB

void student_displayDancer(pt H, pt K, pt A, pt E, pt B, pt T) // displays dancer using dimensions
  {
  caplet(H,_rH,K,_rK);
  caplet(K,_rK,A,_rA);
  caplet(A,_rA,E,_rE);
  caplet(E,_rE,B,_rB);
  caplet(B,_rB,T,_rT);
  caplet(A,_rA,B,_rB);
  noFill(); pen(magenta,2); edge(H,P(H,R(V(0,100),_hipAngle)));
  }

// Recompute global dancer points (_H,..._T) from Hip center, Ball center, leg dimensions, and angle a btweeen HB and HK
void student_computeDancerPoints
    (
    pt H,     // hip center
    pt B,     // ball center 
    float a   // angle between HB and HK
    )
  {
   //_H.setTo(H);   
   //_B.setTo(B);
   //added
   _H=P.G[0];
   _K=P.G[1]; 
   _A=P.G[2]; 
   _E=P.G[3]; 
   _T=P.G[5];
   //added
   _B=P.G[4];
   
   
   _B.y = height - floor - _rB;
   _H.y = height-floor-(height-150);
   vec BT = U(_B, _T);
   //if (_B.x > _T.x) {
     _T = P(_B, _bt, BT);
     _T.x = _B.x +40;
   //} else {_T = P(B, _bt, BT);}
   _T.y = height-floor;

   
   
   knee();
   ankle();
   heel();
   }
   
   
void knee() {
  vec HB = U(_H, _B);
  _K = P(_H, _hk, R(HB,_hipAngle));
  //if (angle(U(_H,_K), HB)%2*PI ==0) {
  //  _hipAngle = -PI/6;
  //  println("made it in function");
  //}
  edge(_H, _K);
}

//computes ankle
void ankle() {
  _A = TriangleTip(_K, _ka, _ab, _B); //compute by triangulation from knee and ball
}

//computes heel
void heel() {
  _E = TriangleTip(_A, _ae, _eb, _B);
  if (_E.y > height-floor - _rE) {
    println("yes");
    _E.y = height-floor - _rE;
  }else{println("no");}
  
}

//Returns tip C from base AB with |AC|=a and |BC|=b
pt TriangleTip(pt A, float a, float b, pt B) {
  float c = d(A,B);
  
  //use the law of cosines
  float angC = acos((sq(b) + sq(a) - sq(c))/(2*b*a));
  float angA = asin(((b * sin(angC))/ c)); 

  vec AB = U(A,B);
  
  pt C = P(A, a, R(AB, angA));
  println("anga: "+ angA);
 
  return P(A, a, R(AB, angA)); //return C
}
   
void caplet(pt A, float rA, pt B, float rB) // displays Isosceles Trapezoid of axis(A,B) and half lengths rA and rB
  {
  show(A,rA);
  show(B,rB);
  // replace the line blow by your code to draw the proper caplet (cone) that the function displays th ecnvex hull of the two disks
  //cone(A,rA,B,rB); 
  myCone(A, rA, B, rB);
  }
  
void cone(pt A, float rA, pt B, float rB) // displays Isosceles Trapezoid of axis(A,B) and half lengths rA and rB
  {
  vec T = U(A,B); //Unit vector of A and B
  vec N = R(T); //Norm of unit vector
  pt LA = P(A,-rA,N); //P + sV
  pt LB = P(B,-rB,N);
  pt RA = P(A,rA,N);
  pt RB = P(B,rB,N);
  
  //LA.show();

  beginShape(); v(LB); v(LA); endShape(CLOSE);

  }
  
  void myCone(pt A, float rA, pt B, float rB) {
    float diff = 0;
    float dist = d(A, B);
    float l = 0;
    float littleA = 0;
    float bigA = 0;
    vec AB = U(A,B);
    vec BA = U(B,A);
    
    if (rA>rB) { 
      diff = rA - rB;
      l = sqrt(sq(dist) - sq(diff));   
    } else { 
      diff = rB = rA;
      l = sqrt(sq(dist) - sq(diff));
    }
    
    littleA = asin(diff/dist);
    bigA = radians(90 - degrees(littleA));
    
    vec LrotatedA = R(AB, bigA);
    vec LrotatedB = R(BA, -(littleA + PI/2));
    vec RrotatedA = R(AB, -bigA);
    vec RrotatedB = R(BA, (littleA + PI/2));
    
    pt LA = P(A, rA, LrotatedA);
    pt LB = P(B, rB, LrotatedB);
    pt RA = P(A, rA, RrotatedA);
    pt RB = P(B, rB, RrotatedB);
    
    //LA.show();
    //LB.show();
    //RA.show();
    //RB.show();
    
    
    beginShape(); v(LB); v(RB); v(RA); v(LA); endShape(CLOSE);
    
  }

    //(
    //pt H,     // hip center
    //float hk, // distance from to 
    //pt K,     // knee center 
    //float ka, // distance from to 
    //pt A,     // ankle center 
    //float ae, // distance from to 
    //pt E,     // heel center
    //float eb, // distance from to 
    //float ab, // distance from to 
    //pt B,     // ball center 
    //float bt, // distance from to 
    //pt T,     // toe center
    //float a   // angle between HB and HK
    //)