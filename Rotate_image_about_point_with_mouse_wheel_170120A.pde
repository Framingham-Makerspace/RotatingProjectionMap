// Rotate an image about a point using the mouse scrool wheel


//  Take a look at PShape as another method that can be textured
//    https://processing.org/tutorials/pshape/

//  1/20/2017, David Kent
//    fixed some issues with smooth rotation by moving most of code out of mouse event

//  10/1/2016, David Kent
//     Working!

  int encoderResolution = 180;
  float imageScale = 0.25;
  int imageHeight;
  int imageWidth;
  int rotationCenterX;
  int rotationCenterY;
  float rotationAngle;  //in degrees
  PImage img;
  int imageStartX;
  int imageStartY;

  
void setup()
{
  frameRate(100);
  background(0);

  img = loadImage("green bug icon.jpg");
  imageHeight = img.height;
  imageWidth = img.width;
  //println("image height = ", imageHeight, ",  image width = ", imageWidth);

  size(1000,700, P2D);
  rotationCenterX = width/2;
  rotationCenterY = height/2;

  imageStartX = rotationCenterX + 300;
  imageStartY = (int)((float)(rotationCenterY-imageHeight)/imageScale);
  
  rotationAngle = 0;
  
  scale(imageScale,imageScale);
  //translate(rotationCenterX/imageScale+400, rotationCenterY/imageScale-imageHeight/2.0);
  translate(rotationCenterX/imageScale, rotationCenterY/imageScale);

  beginShape();
  texture(img);
  vertex(imageStartX,imageStartY,0,0);
  vertex(imageStartX+imageWidth,imageStartY,imageWidth,0);
  vertex(imageStartX+imageWidth,imageStartY+imageHeight,imageWidth,imageHeight);
  vertex(imageStartX,imageStartY+imageHeight,0,imageHeight);
  endShape();

}

void draw() {  
  //nothing here since all is event driven by mouse scroll wheel
  scale(imageScale,imageScale);
  //translate(rotationCenterX/imageScale+400, rotationCenterY/imageScale-imageHeight/2.0);
  translate(rotationCenterX/imageScale, rotationCenterY/imageScale);

  rotate(radians(rotationAngle));
  if ( (rotationAngle > 360) || (rotationAngle < -360) ) rotationAngle = 0.0;
  println(rotationAngle);
  
  background(0);
  
  beginShape();
  texture(img);
  vertex(imageStartX,imageStartY,0,0);
  vertex(imageStartX+imageWidth,imageStartY,imageWidth,0);
  vertex(imageStartX+imageWidth,imageStartY+imageHeight,imageWidth,imageHeight);
  vertex(imageStartX,imageStartY+imageHeight,0,imageHeight);
  endShape();
  
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  //println(e);
  
  if (e > 0) {
    rotationAngle += 360.0/(float)encoderResolution;
  } else {
    rotationAngle -= 360.0/(float)encoderResolution;
  }

  //println("rotation angle ", rotationAngle);

  
}