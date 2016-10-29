// Template for 2D projects
// Author: Jarek ROSSIGNAC
// FOR PART 3
import processing.pdf.*;    // to save screen shots as PDFs, does not always work: accuracy problems, stops drawing or messes up some curves !!!

//**************************** global variables ****************************
pts P = new pts(); // class containing array of points, used to standardize GUI
float t=0, f=0;
boolean animate=false, fill=false, timing=false;
boolean showLetters=true; // toggles to display vector interpoations
int ms=0, me=0; // milli seconds start and end for timing
int npts=20000; // number of points
float _hipAngle=-PI/12;
pt _H=P(), _K=P(), _A=P(), _E=P(), _B=P(), _T=P(); // centers of Hip, Knee, Ankle, hEel, Ball, Toe
float _rH=100, _rK=50, _rA=20, _rE=25, _rB=15, _rT=5; // radii of Hip, Knee, Ankle, hEel, Ball, Toe

// leg measures (to update press '/' and copy print here):
float _hk=319.979, _ka=266.46463, _ae=28.718777, _eb=117.23831, _ab=113.9619, _bt=44.75581;
//_eb=117.23831,_ae=28.718777
float _h=150; // height of _H
//_h=150
float hx = 200;
float bx = 200;
float hx2 = 580;
float floor = height-50;

boolean transfer = true;
boolean collect = false;
boolean rotate = false;
boolean aim = false;

boolean isLeft = true;

//**************************** initialization ****************************
void setup()               // executed once at the begining 
  {
  size(2000, 700);            // window size
  frameRate(40);             // render 30 frames per second
  smooth();                  // turn on antialiasing
 // myFace = loadImage("data/pic.jpg");  // load image from file pic.jpg in folder data *** replace that file with your pic of your own face
  P.declare(); // declares all points in P. MUST BE DONE BEFORE ADDING POINTS 
  //P.resetOnCircle(6); // sets P to have 4 points and places them in a circle on the canvas
  P.loadPts("data/pts");  // loads points form file saved with this program
  } // end of setup

//**************************** display current frame ****************************
void draw()      // executed at each frame
  {
    //_hipAngle++;
   // _H.x+=6;
   //_B.x+=3;
  if(recordingPDF) startRecordingPDF(); // starts recording graphics to make a PDF
  
    background(white); // clear screen and paints white background
    pen(grey,3); line(0,height-50,width,height-50);  // show ground line
    pt H=P.G[0], K=P.G[1], A=P.G[2], E=P.G[3], B=P.G[4], T=P.G[5]; // local copy of dancer points from points of Polyloop P
    // Hip       Knee      Ankle    hEel       Ball      Toe
 
    noFill(); pen(blue,4); 
    //P.drawCurve(); 
       //edge(_A,_B);  // add (foot top) edge from Ankle to Ball
    if(showLetters) 
      { 
      pen(black,2); 
      showId(_H,"H"); showId(_K,"K"); showId(_A,"A"); showId(_E,"E"); showId(_B,"B");showId(_T,"T");
      }
   // noStroke(); fill(yellow); student_displayDancer(H,K,A,E,B,T);
    //noStroke(); fill(green);  student_displayDancer(_H,_K,_A,_E,_B,_T);
    //student_computeDancerPoints(H,B,_hipAngle); // computes _H,_K,_A,_E,_B,_T  from measures and _hipAngle
    //noFill(); pen(red,2); 
    //student_displayDancer(_H,_K,_A,_E,_B,_T);
    //student_computeDancerPoints(_H, _B, _hipAngle);

    
    //CONSTRUCTING TEST LEG
    pt HTest = new pt(hx, height-floor-(height-_h));
    pt BTest = new pt(bx, height - floor - _rB);
    pt BTest2 = new pt(hx2, height - floor - _rB);
    noStroke();
    Leg testLeg = new Leg(HTest, BTest, _hipAngle);
    Leg testLeg2 = new Leg(HTest, BTest2, _hipAngle);
    
    //TESTING TRANSFER
    if (transfer){
      if (isLeft) {
        if(hx<hx2) { hx+=5;}
        else if (hx>=hx2) {transfer = false; collect = true;}
      }
      else {
        if(bx>hx) { hx+=5;}
        else if (bx<=hx) { transfer = false; collect = true;}
      }
    }
    
    //TESTING COLLECT
    if (collect) {
      if (isLeft) {
        if (bx<hx2){bx+=10;}
        else if(bx>=hx2) {collect = false; aim=true;}
      }
      else {
        if(hx2<hx) { hx2+=5;}
        else if (hx2>=hx) { collect = false; aim = true;}
      }
    }
    
    //TESTING AIM
    if (aim) {
      if (isLeft) {
        if (abs(hx2-bx)<380) {bx+=5;}
        else if (abs(hx2-bx)>=380) {
          aim = false; transfer = true;
          isLeft = false;
        }
      }
      else {
        if(abs(hx2-bx)<380) { hx2+=5;}
        else if (abs(hx2-bx)>=380) {
          aim = false; transfer = true;
          isLeft = true;
        }
      }
    }

    testLeg.student_computeDancerPoints(HTest, BTest, _hipAngle);
    testLeg2.student_computeDancerPoints(HTest, BTest2, _hipAngle);
    fill(green);
    testLeg.student_displayDancer();
    fill(red);
    testLeg2.student_displayDancer();
    
    
    noFill(); pen(black,4); 
    //P.drawCurve(); 
    //edge(_A,_B);   
    if(showLetters) 
      { 
      pen(red,2); 
      showId(_H,"H"); showId(_K,"K"); showId(_A,"A"); showId(_E,"E"); showId(_B,"B");showId(_T,"T");
      }
   
    

  if(recordingPDF) endRecordingPDF();  // end saving a .pdf file with the image of the canvas

  fill(black); displayHeader(); // displays header
  if(scribeText && !filming) displayFooter(); // shows title, menu, and my face & name 

  if(filming && (animating || change)) snapFrameToTIF(); // saves image on canvas as movie frame 
  if(snapTIF) snapPictureToTIF();   
  if(snapJPG) snapPictureToJPG();   
  change=false; // to avoid capturing movie frames when nothing happens
  }  // end of draw
  