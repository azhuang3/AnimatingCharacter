//  ******************* Tango dancer 3D 2016 ***********************
Boolean animating=true, PickedFocus=false, center=true, showViewer=false, showBalls=false, showCone=true, showCaplet=true, showImproved=true, solidBalls=false;
float t=0, s=0;
float sCounter = 0;

int index = 2;

pt A, B, C;
pt RightFoot, LeftFoot;
Leg person1;

vec Forward = V(1,0,0);

//  ****************** dancer phase ***********************
boolean transfer = true;
boolean collect = false;
boolean rotate = false;
boolean aim = false;

boolean isLeft = true;

// ******************* initialization *********************
void setup() {
  myFace = loadImage("data/pic.jpg");  // load image from file pic.jpg in folder data *** replace that file with your pic of your own face
  textureMode(NORMAL);          
  size(800, 700, P3D); // P3D means that we will do 3D graphics
  P.declare(); Q.declare(); PtQ.declare(); // P is a polyloop in 3D: declared in pts
  // P.resetOnCircle(3,100); Q.copyFrom(P); // use this to get started if no model exists on file: move points, save to file, comment this line
  P.loadPts("data/pts");  Q.loadPts("data/pts2"); // loads saved models from file (comment out if they do not exist yet)
  noSmooth();
  frameRate(10);
  
    // Footprints shown as reg, green, blue disks on the floor 
  A = P.Pt(0); B = P.Pt(1); C = P.Pt(2); //pt D = P.Pt(3); pt E = P.Pt(4);
  RightFoot = A; LeftFoot = B;
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
  if (isLeft) {person1 = new Leg(LeftFoot, s, RightFoot, Forward);}
  else {person1 = new Leg(LeftFoot, s, RightFoot, Forward);}
   

 

 //if(viewpoint) {Viewer = viewPoint(); viewpoint=false; showViewer=true;} // remember current viewpoint to shows viewer/floor frustum as part of the scene
     
 //if(showViewer) // shows viewer/floor frustum (toggled with ',')
 //    {
 //    noFill(); stroke(red); show(Viewer,P(200,200,0)); show(Viewer,P(200,-200,0)); show(Viewer,P(-200,200,0)); show(Viewer,P(-200,-200,0));
 //    noStroke(); fill(red,100); 
 //    show(Viewer,5); noFill();
 //    }
 
 
 if (transfer) {
   //if (isLeft) {
     if (s<1) {
       s+=.1;
     } else {
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
      //24 is the radius of the circle
      pt start = P(B, 24, U(B,A));
      fill(red); show(start, 5);
      pt initialB = R(start, -ang, B);
      
      RightFoot = L(A, t, initialB);
      fill(red); show(initialB, 5);
      t+=0.1;
     } else if (!isLeft) {
       float ang = acos(24/d(B,A));
       pt start = P(B, 24, U(B,A));
       fill(red); show(start, 5);
       pt initialB = R(start, ang, B);
       
       LeftFoot = L(A, t, initialB);
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
   
   vec AB = U(A,B); arrow(person1.getBodyCenter(),AB,5);
   vec BC = U(B,C);
   float a = angle(AB, BC);
   println("angle a: "+a);
   //for (float i=0; i<=a; i+=0.1) {
   //  println("i: "+i);
     Forward = R(Forward, a, person1.Right, Forward);
   //}
   rotate = false;
   aim = true;
 }// end rotate
 //------------------------------------------------------------
 
 if (aim) {
     if (t<1) {
       if (isLeft) {
        float ang = acos(24/d(B,C));
        //24 is the radius of the circle
        pt start = P(B, 24, U(B,C));
        fill(red); show(start, 5);
        pt initialB = R(start, ang, B);
        
        RightFoot = L(initialB, t, C);
        fill(red); show(initialB, 5);
        t+=0.1;
       } else if (!isLeft) {
        float ang = acos(24/d(B,C));
        //24 is the radius of the circle
        pt start = P(B, 24, U(B,C));
        fill(red); show(start, 5);
        pt initialB = R(start, -ang, B);
        
        LeftFoot = L(initialB, t, C);
        fill(red); show(initialB, 5);
        t+=0.1;
       }
     } else {
       if (index < P.nv) index++; 
       else index = 1;
       A = B; B = C; C = P.Pt(index);
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
  