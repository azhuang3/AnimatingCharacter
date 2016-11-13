class Leg {
  pt LeftFoot, RightFoot;
  float transfer;
  vec Forward;
  
  float footRadius=3, kneeRadius = 6,  hipRadius=12 ; // radius of foot, knee, hip
  float hipSpread = hipRadius; // half-displacement between hips
  float bodyHeight = 100; // height of body center B
  float ankleBackward=10, ankleInward=4, ankleUp=6, ankleRadius=4; // ankle position with respect to footFront and size
  float pelvisHeight=10, pelvisForward=hipRadius/2, pelvisRadius=hipRadius*1.3; // vertical distance form BodyCenter to Pelvis 
  float LeftKneeForward = 20; // arbitrary knee offset for mid (B,H)
  
  vec Up = V(0,0,1); // up vector
  //vec Right = N(Up,Forward); // side vector pointing towards the right
  vec Right = V(1,0,0);
  
 // Leg(){
  Leg(pt LeftFoot, float transfer, pt RightFoot, vec Forward) {
    this.LeftFoot = LeftFoot;
    this.RightFoot = RightFoot;
    this.transfer = transfer;
    this.Forward = Forward;
    Right = N(Up,Forward); // side vector pointing towards the right
    
    body(); ankle(); feet(); hip(); knee(); pelvis(); torso();
    showCircle(B, hipSpread*2);
  }
  // Student's should use this to render their model

 
  //bodyProjection - floor projection of B
  //looks like transfer is the key to .... transfer!!
  pt getBodyProjection() { return  L(RightFoot,transfer,LeftFoot);}
  
  //bodyCenter
  pt getBodyCenter() {
    pt BodyProjection = getBodyProjection();
    return P(BodyProjection,bodyHeight,Up);
  }
  
  pt getBodyTorso() { return  P(getBodyProjection(), bodyHeight+20, Up);}
  pt getChest() { return P(getBodyProjection(), bodyHeight+40, Up);}
  
  // BODY
  void body() {
    //pt BodyProjection = L(LeftFoot,1./3+transfer/3,RightFoot); // floor projection of B
    pt BodyCenter = getBodyCenter();

    //Centr of BodyTorso?
    //pt BodyTorso = getBodyTorso();
    //pt BodyTorso2 = P(getBodyProjection(), bodyHeight+10, Up);
    fill(blue); showShadow(BodyCenter,5); // sphere(BodyCenter,hipRadius);
    fill(blue); arrow(BodyCenter,V(100,Forward),5); // forward arrow 
    arrow(BodyCenter, V(100,Up),5);
    arrow(BodyCenter, V(100,Right),5);
  }
 
  //get right ankle
  pt getRightAnkle() { return P(RightFoot, -ankleBackward,Forward, -ankleInward,Right, ankleUp,Up);}
  pt getLeftAnkle() { return P(LeftFoot, -ankleBackward,Forward, ankleInward,Right, ankleUp,Up);}
 
 // ANKLES
 void ankle() {
    pt RightAnkle =  getRightAnkle();
    fill(red);  
    capletSection(RightFoot,footRadius,RightAnkle,ankleRadius);  
    pt LeftAnkle =  getLeftAnkle();
    fill(green);  
    capletSection(LeftFoot,footRadius,LeftAnkle,ankleRadius);  
    fill(blue);  
    sphere(RightAnkle,ankleRadius);
    sphere(LeftAnkle,ankleRadius);
 }
 
 
  // FEET (CENTERS OF THE BALLS OF THE FEET)
  void feet() {
    fill(blue);  
    sphere(RightFoot,footRadius);
    pt RightToe =   P(RightFoot,5,Forward);
    capletSection(RightFoot,footRadius,RightToe,1);
    sphere(LeftFoot,footRadius);
    pt LeftToe =   P(LeftFoot,5,Forward);
    capletSection(LeftFoot,footRadius,LeftToe,1);
  }

  pt getRightHip() { return P(getBodyCenter(),hipSpread,Right);}
  pt getLeftHip() { return P(getBodyCenter(),-hipSpread,Right);}
  
  // HIPS
  void hip() {
    pt RightHip =  getRightHip();
    fill(red);  sphere(RightHip,hipRadius);
    pt LeftHip =  getLeftHip();
    fill(green);  sphere(LeftHip,hipRadius);
  }

  // KNEES AND LEGs
  void knee() {
    float RightKneeForward = 20;
    pt RightMidleg = P(getRightHip(),getRightAnkle());
    pt RightKnee =  P(RightMidleg, RightKneeForward,Forward);
    fill(red);  
    sphere(RightKnee,kneeRadius);
    capletSection(getRightHip(),hipRadius,RightKnee,kneeRadius);  
    capletSection(RightKnee,kneeRadius,getRightAnkle(),ankleRadius);  
     
    pt LeftMidleg = P(getLeftHip(), getLeftAnkle());
    pt LeftKnee =  P(LeftMidleg, LeftKneeForward,Forward);
    fill(green);  
    sphere(LeftKnee,kneeRadius);
    capletSection(getLeftHip(),hipRadius,LeftKnee,kneeRadius);  
    capletSection(LeftKnee,kneeRadius,getLeftAnkle(),ankleRadius);  
  }

  pt getPelvis() { return  P(getBodyCenter(),pelvisHeight,Up, pelvisForward,Forward);}
  
  // PELVIS
  void pelvis() {
    pt Pelvis = getPelvis(); 
    fill(blue); sphere(Pelvis,pelvisRadius);
    capletSection(getLeftHip(),hipRadius,Pelvis,pelvisRadius);  
    capletSection(getRightHip(),hipRadius,Pelvis,pelvisRadius);  
  }
  
    
  //TORSO Testing
  void torso() {
    pt torsoCenter = P(getBodyTorso(), hipSpread, Up);
    pt chest = P(getChest(), hipSpread, Up);
    fill(blue); sphere(torsoCenter, hipRadius);
    fill(blue); sphere(chest, hipRadius);
    capletSection(torsoCenter, hipRadius, getPelvis(), pelvisRadius);
    capletSection(chest, hipRadius, torsoCenter, hipRadius);
  }

  
void capletSection(pt A, float a, pt B, float b) { // cone section surface that is tangent to Sphere(A,a) and to Sphere(B,b)
  coneSection(A,B,a,b);
  } 

}//END OF LEG CLASS