import processing.video.*;

Capture video;
float bright;

int increment = 5;
//Polygon size
int pSize = 3;
//color space
int cSpace = -1;


void setup() {
  size(1024, 768, P3D);
  //Prepare the camera with the image size
  video = new Capture(this, width, height);

  //Start capturing
  video.start();
}

void draw() {
  background(100);
  //Check the availability of camera
  if (video.available()) {
    //Get a frame
    video.read();
    //Load pixel data
    video.loadPixels();

    for (int j = 0; j < video.height; j += increment) {
      for (int i = 0; i < video.width; i += increment) {

        //Get a pixel color
        int pixelColor = video.pixels[j*video.width + i];

        int r = (pixelColor >> 16) & 0xff;
        int g = (pixelColor >> 8) & 0xff;
        int b = pixelColor & 0xff;

        //Calculate the brightness of a pixel
        bright = cSpace *sqrt(r*r + g*g + b*b);
        
        //Mouse Controls Eye Position
        float eyeX = width/2-map(mouseX, 0, width, -1600, 1600);
        float eyeY = height/2-map(mouseY, 0, height, -1600, 1600);
        
        camera(eyeX, eyeY, 700, width/2, height/2, 0, 0, 1, 0);

        //Draw a polygon
        beginShape(POLYGON);
        noStroke();
        fill(pixelColor);
        vertex(i, j, bright);
        vertex(i+pSize, j, bright);
        vertex(i+pSize, j+pSize, bright);
        vertex(i, j+pSize, bright);
        endShape();
      }
    }
  }
}

