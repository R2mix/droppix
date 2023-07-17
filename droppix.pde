import drop.*;
SDrop drop;
PImage p;
PGraphics pg;
int pixel = 1;
int w = 800, h = 600;

void setup() {
  drop = new SDrop(this);
  surface.setResizable(true);
}

void settings() {
  size(w, h);
}

void draw() {
  background(100);
  if (p != null) {
    pg = createGraphics(w, h); // créer un graphique à la taille de l'image
    w = p.width;
    h = p.height;
    surface.setSize(w, h); // met à la taille de l'image
    pixelateImage(pixel);
    image(pg, 0, 0);
  }
}


void keyPressed() {
  if (keyCode == LEFT || keyCode == DOWN ) pixel --; // augmente pixel size
  if (keyCode == RIGHT || keyCode == UP ) pixel ++;  // diminue pixel size
  pixel = constrain(pixel, 1, 100);
  if (key == ' '){
    pg.save("pixel" + year() + month()+day()+hour()+minute()+second()+".png");
   fill(255);
   rect(0,0,width, height);
  }
}

void dropEvent(DropEvent theDropEvent) { // drop an image

    p = loadImage(theDropEvent.file().toString());
 
}


void pixelateImage(int pxSize) { // to pixel

  pg.beginDraw();
  pg.blendMode(BLEND);
  float ratio;
  if (p.width < height) {
    ratio = p.height/p.width;
  } else {
    ratio = p.width/p.height;
  }
  int pxH = int(pxSize * ratio);
  pg.noStroke();
  for (int x=0; x<p.width; x+=pxSize) {
    for (int y=0; y<p.height; y+=pxH) {
      if (p.get(x, y) != 0) {
        pg.fill(p.get(x, y));
        pg.rect(x, y, pxSize, pxH);
      }
    }
  }
  pg.endDraw();
}
