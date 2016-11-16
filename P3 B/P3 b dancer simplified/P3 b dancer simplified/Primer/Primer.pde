//  ******************* Tango dancer 3D 2016 ***********************
Boolean animating=true, PickedFocus=false, center=true, showViewer=false, showBalls=false, showCone=true, showCaplet=true, showImproved=true, solidBalls=false;
float t=0, s=0;

int index = 2;// int index2 = 2;

pt A, B, C;
//pt A2, B2, C2;
pt RightFoot, LeftFoot;// RightFoot2, LeftFoot2;
Leg person1;
//Leg person2;

vec Forward = U(1,0,0);// vec Forward2 = U(1,0,0);
float a;
boolean obtuseA = false; //boolean obtuseA2 = false;

//  ****************** dancer phase ***********************
boolean transfer = true;
boolean collect = false;
boolean rotate = false;
boolean aim = false;

boolean isLeft = true;

// ******************* initialization *********************
void setup() {
  //myFace = loadImage("data/pic.jpg");  // load image from file pic.jpg in folder data *** replace that file with your pic of your own face
  textureMode(NORMAL);          
  size(800, 700, P3D); // P3D means that we will do 3D graphics
  P.declare(); Q.declare(); PtQ.declare(); // P is a polyloop in 3D: declared in pts
  // P.resetOnCircle(3,100); Q.copyFrom(P); // use this to get started if no model exists on file: move points, save to file, comment this line
  P.loadPts("data/pts");  Q.loadPts("data/pts2"); // loads saved models from file (comment out if they do not exist yet)
  noSmooth();
  frameRate(10);
  
    // Footprints shown as reg, green, blue disks on the floor 
  A = P.Pt(0); B = P.Pt(1); C = P.Pt(2); //pt D = P.Pt(3); pt E = P.Pt(4);
  //A2 =P.Pt(1); B2 =P.Pt(2); C2 =P.Pt(3);
  RightFoot = A; LeftFoot = B;
  //RightFoot2 = A2; LeftFoot2 = B2;
  }

void draw() {
  background(255);
  pushMatrix();   // to ensure that we can restore the standard view before writing on the canvas
  setView();  // see pick tab
  showFloor(); // draws dance floor as yellow mat
  doPick(); // sets point Of and picks closest vertex to it in P (see pick Tab)
   
  // Footprints shown as reg, green, blue disks on the floor 
  //pt A = P.Pt(0), B = P.Pt(1), C = P.Pt(2); pt D = P.Pt(3); pt E = P.Pt(4);
  P.drawCurve();
  noStroke();
  
  // Footprints shown as reg, green, blue disks on the floor 
  //showNaiveDancer(A, s, B, ForwardDirection);  // THIS CALLS YOUR CODE IN TAB "Dancer"
  //showDancer(A, s, B, ForwardDirection);  // THIS CALLS YOUR CODE IN TAB "Dancer"
  if (isLeft) {
    person1 = new Leg(LeftFoot, s, RightFoot, Forward);
   // person2 = new Leg(LeftFoot2, s, RightFoot2, Forward2);
  } else {
    person1 = new Leg(LeftFoot, s, RightFoot, Forward);
    //person2 = new Leg(LeftFoot2, s, RightFoot2, Forward2);
  }
  
   

 

 //if(viewpoint) {Viewer = viewPoint(); viewpoint=false; showViewer=true;} // remember current viewpoint to shows viewer/floor frustum as part of the scene
     
 //if(showViewer) // shows viewer/floor frustum (toggled with ',')
 //    {
 //    noFill(); stroke(red); show(Viewer,P(200,200,0)); show(Viewer,P(200,-200,0)); show(Viewer,P(-200,200,0)); show(Viewer,P(-200,-200,0));
 //    noStroke(); fill(red,100); 
 //    show(Viewer,5); noFill();
 //    }
 
 
 if (transfer) {
     if (s<1) {
       s+=.1;
     } 
     //else if 
     else {
       //s = 0;
       transfer = false;
       collect = true;
     }
   //} 
 }// end transfer
 //------------------------------------------------------------- 
 
 if (collect) {
 if (t<1) {
     if (isLeft) {
      float ang = acos(24/d(A,B));
      //float ang2 = acos(24/d(A2,B2));
      //24 is the radius of the circle
      pt start = P(B, 24, U(B,A));
      //pt start2 = P(B2, 24, U(B2, A2));
      fill(red); show(start, 5); 
      pt initialB = R(start, -ang, B); //pt initialB2 = R(start2, -ang2, B2);
      
      RightFoot = L(A, t, initialB); //RightFoot2 = L(A2, t, initialB2);
      fill(red); show(initialB, 5);
      t+=0.1;
     } else if (!isLeft) {
       float ang = acos(24/d(B,A)); //float ang2 = acos(24/d(B2,A2));
       pt start = P(B, 24, U(B,A));// pt start2 = P(B2, 24, U(B2, A2));
       fill(red); show(start, 5);
       pt initialB = R(start, ang, B);// pt initialB2 = R(start2, ang2, B2);
       
       LeftFoot = L(A, t, initialB); //LeftFoot2 = L(A2, t, initialB2);
       t+=0.1;
     }
   } else {
    collect = false;                      
    rotate = true;
    t = 0;
   }
 }// end collect
 //------------------------------------------------------------
 
 if (rotate) {
     vec AB = U(A,B); //vec AB2 = U(A2, B2);
     vec BC = U(B,C); //vec BC2 = U(B2, C2);
     
     if (obtuseA) { a = -angle(AB, BC); obtuseA = false;}
     else {a = angle(AB, BC);}
     //println(a);
     
     //if (obtuseA2) { a2 = -angle(AB2, BC2); obtuseA2 = false;}
     //else {a2 = angle(AB2, BC2);}
     
     if (a >=1.58) { obtuseA = true;}
     println(obtuseA);
     //if (a2 >= 1.58) { obtuseA2 = true;}

  println(a);
     Forward = R(Forward, a, person1.Right, Forward);
     //Forward2 = R(Forward2, a2, person2.Right, Forward2);
     rotate = false;
     aim = true;
 }// end rotate
 //------------------------------------------------------------
 
 if (aim) {
     if (t<1) {
       if (isLeft) {
        float ang = acos(24/d(B,C)); //float ang2 = acos(24/d(B2,C2));
        //24 is the radius of the circle
        pt start = P(B, 24, U(B,C)); //pt start2 = P(B2, 24, U(B2,C2));
        fill(red); show(start, 5);
        pt initialB = R(start, ang, B); //pt initialB2 = R(start2, ang2, B2);
        
        RightFoot = L(initialB, t, C); //RightFoot2 = L(initialB2, t, C2);
        fill(red); show(initialB, 5);
        t+=0.1;
       } else if (!isLeft) {
        float ang = acos(24/d(B,C)); //float ang2 = acos(24/ d(B2,C2));
        //24 is the radius of the circle
        pt start = P(B, 24, U(B,C));// pt start2 = P(B2, 24, U(B2,C2));
        fill(red); show(start, 5);
        pt initialB = R(start, -ang, B); //pt initialB2 = R(start2, -ang2, B2);
        
        LeftFoot = L(initialB, t, C); //LeftFoot2 = L(initialB2, t, C2);
        fill(red); show(initialB, 5);
        t+=0.1;
       }
     } else {
       if (index < P.nv) index++; 
       else index = 1;

       
       
       A = B; B = C; C = P.Pt(index);
       //A2 = B2; B2 = C2; C = Q.Pt(index2);
       t = 0; s = 1;
       aim = false;
       transfer = true;
       if (isLeft) {isLeft = false;}
       else { isLeft = true;}
     }
 }// end aim
 
  popMatrix(); // done with 3D drawing. Restore front view for writing text on canvas

  // used for demos to show red circle when mouse/key is pressed and what key (disk may be hidden by the 3D model)
  if(keyPressed) {stroke(red); fill(white); ellipse(mouseX,mouseY,26,26); fill(red); text(key,mouseX-5,mouseY+4);}
     
  if(scribeText) {fill(black); displayHeader();} // dispalys header on canvas, including my face
  if(scribeText && !filming) displayFooter(); // shows menu at bottom, only if not filming
  //if (animating) { t+=PI/30; if(t>=TWO_PI) t=0; s=(cos(t)+1.)/2; } // periodic change of time 
  if(filming && (animating || change)) saveFrame("FRAMES/F"+nf(frameCounter++,4)+".tif");  // save next frame to make a movie
  change=false; // to avoid capturing frames when nothing happens (change is set uppn action)
  }
  