int support=0; // ID of vertex where support foot is located
boolean WeightOnRight = true;
float time = 0;
float r=100;


//shows vector direction of forward in respect to dancer.
void showDirectionVec(pt A, pt B) {
  //A would typically represent X
  vec AB = U(A,B);
  //pt midpoint = P(A, d(A,B), AB);
  vec midNorm = R(AB, -90);
  pen(blue, 2); arrow(A, 40, midNorm);
}

void showDancerOnRight(pt A, char b, pt B, pt newB, char c, pt C, float t)  // R=B L moves from A to C
  {
  scribeHeader("Dancer on RIGHT",3);

  pt R=B; 
  pt L = N(0,A,.5,newB,1,C,t);
  //body
  //float counter = 2./3;
  //for (float i=0; i < counter; i+=.1) {
  //    pt X = L(L,R, i);
  //}
  pt X = L(L,R,2./3);
  //pt X = N(0,A, 2./3, B, t);
 
  noStroke();
  
  vec XL = U(X,L);
  vec AB = U(A,B);
  vec BA = U(B,A);
  vec XLnegate = U(L,X);
  pt leftStart = P(X, 50, R(AB));
  pt rightStart = P(X, 50, R(BA));
  fill(lime); cone(leftStart,16,L,8); show(L,8); 
  fill(pink); cone(rightStart,16,R,8); show(R,8); 
  fill(blue); show(X,16); 
  pen(blue,2); arrow(X,40,AB);
  
  showDirectionVec(X, rightStart);
  }

void showDancerOnLeft(pt A, char b, pt B, pt newB, char c, pt C, float t)  // R=B L moves from A to C
  {
  scribeHeader("Dancer on Left",3);
  pt L=B; 
  pt R = N(0,A,.5,newB,1,C,t);
  //body
  pt X = L(R,L,2./3);

  noStroke();
  
  vec XL = U(X,L);
  vec XLnegate = U(L,X);
    vec AB = U(A,B);
  vec BA = U(B,A);
  
  pt leftStart = P(X, 50, R(AB));
  pt rightStart = P(X, 50, R(BA));
  
  fill(lime); cone(leftStart,16,L,8); show(L,8); 
  fill(pink); cone(rightStart,16,R,8); show(R,8); 
  fill(blue); show(X,16); 
  pen(blue,2); arrow(X,40,AB);
  
  showDirectionVec(X, leftStart);
  }

void cone(pt A, float rA, pt B, float rB) // displays Isosceles Trapezoid of axis(A,B) and half lengths rA and rB
  {
  vec T = U(A,B);
  vec N = R(T);
  pt LA = P(A,-rA,N);
  pt LB = P(B,-rB,N);
  pt RA = P(A,rA,N);
  pt RB = P(B,rB,N);
  beginShape(); v(LB); v(RB); v(RA); v(LA); endShape(CLOSE);
  }