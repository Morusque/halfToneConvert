
void setup() {
  size(300, 300);
  PImage im = loadImage("img.jpg");
  PGraphics gr = createGraphics(im.width, im.height, JAVA2D);
  gr.beginDraw();
  gr.background(0xFF);
  gr.noStroke();
  gr.blendMode(MULTIPLY);
  for (int c=0; c<4; c++) {
    if (c==0) gr.fill(0);
    if (c==1) gr.fill(0, 0xFF, 0xFF);
    if (c==2) gr.fill(0xFF, 0, 0xFF);
    if (c==3) gr.fill(0xFF, 0xFF, 0);
    float gap=(5.0+(float)c/2);
    for (int x=-gr.width; x<gr.width*2; x+=gap) {
      for (int y=-gr.height; y<gr.height*2; y+=gap) {
        float tX=x;
        float tY=y;
        if (y%2==0) tX += gap/2;
        tY += ((float)x-(float)gr.width/2)*(((float)c+1)/gap);
        color thisPixel = im.get(floor(tX), floor(tY));
        int[] thisColor = rgbToKcmy((int)red(thisPixel), (int)green(thisPixel), (int)blue(thisPixel));
        float cSize = pow((float)thisColor[c]/100.0,0.75)*gap*1.3;
        gr.circle(tX, tY, cSize);
      }
    }
  }
  gr.endDraw();
  gr.save("result.png");
  exit();
}

private static int[] rgbToKcmy(int r, int g, int b) {
  double percentageR = r / 255.0 * 100;
  double percentageG = g / 255.0 * 100;
  double percentageB = b / 255.0 * 100;
  double k = 100 - Math.max(Math.max(percentageR, percentageG), percentageB);
  if (k == 100) return new int[]{ 0, 0, 0, 100 };
  int c = (int)((100 - percentageR - k) / (100 - k) * 100);
  int m = (int)((100 - percentageG - k) / (100 - k) * 100);
  int y = (int)((100 - percentageB - k) / (100 - k) * 100);
  return new int[]{(int)k, c, m, y, };
}
