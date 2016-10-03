// Rotate an image about a point using the mouse scroll wheel
// This version takes an animaged GIF as input and indexes the GIF to fully
//   cycle in one revolution of the image about the rotation point.


//  Take a look at PShape as another method that can be textured
//    https://processing.org/tutorials/pshape/

//  10/1/2016, David Kent
//     Working.  Just need to do initial rotation on the image so legs point to center
//       of rotation.

import gifAnimation.*;

PImage[] animation;
Gif loopingGif;

int encoderResolution = 180;
float imageScale = 0.75;
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

  // Stuff for animated GIF images
  println("gifAnimation " + Gif.version());
  animation = Gif.getPImages(this, "Muybridge_race_horse_animated.gif");
  //println("animation length", animation.length);
    
    
  img = loadImage("Muybridge_race_horse_animated.gif");
  imageHeight = img.height;
  imageWidth = img.width;
  println("image height = ", imageHeight, ",  image width = ", imageWidth);

  size(1000,700, P2D);
  rotationCenterX = width/2;
  rotationCenterY = height/2;

  //imageStartX = rotationCenterX + 0;
  //imageStartY = (int)((float)(((float)rotationCenterY-(float)imageHeight/imageScale)*imageScale));
  imageStartX = 200;
  imageStartY = (int)(-1.0*(float)imageHeight/2.0);
  
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
  //scale(0.25);
  //rotate(radians(20.0));
  //image(animation[(int) (animation.length / (float) (width) * mouseX)], width - 10 - animation[0].width, height / 2 - animation[0].height / 2);
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  //println(e);
  
  scale(imageScale,imageScale);
  //translate(rotationCenterX/imageScale+400, rotationCenterY/imageScale-imageHeight/2.0);
  translate(rotationCenterX/imageScale, rotationCenterY/imageScale);

  if (e > 0) {
    rotationAngle += 360.0/(float)encoderResolution;
  } else {
    rotationAngle -= 360.0/(float)encoderResolution;
  }
  rotate(radians(rotationAngle));
  if ( (rotationAngle > 360) || (rotationAngle < -360) ) rotationAngle = 0.0;
  //println(rotationAngle);
  
  background(0);
  
  image(animation[(int) ( (animation.length-1) / 360.0 * abs(rotationAngle) )], imageStartX, imageStartY);
/*
  beginShape();
  texture(img);
  vertex(imageStartX,imageStartY,0,0);
  vertex(imageStartX+imageWidth,imageStartY,imageWidth,0);
  vertex(imageStartX+imageWidth,imageStartY+imageHeight,imageWidth,imageHeight);
  vertex(imageStartX,imageStartY+imageHeight,0,imageHeight);
  endShape();
*/

  //println("rotation angle ", rotationAngle);

  
}