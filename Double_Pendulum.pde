float r1 = 200; //rod length
float r2 = 200;
float m1 = 20; //mass                       //20 //50
float m2 = 20;                              //20 //1
float theta1 = -PI/2; //initial angle
float theta2 = -PI/2;
float theta1_v = 0; // initial velocity     //0  //1
float theta2_v = 0;
float g = 1; //gravity strength
float air_resistance = 0; //1-multiplier
//keep air resistance = 0, otherwise its boring

float cx,cy;
float prev_x2 = 0;
float prev_y2 = 0;

PGraphics canvas;

void setup(){
  size(1000,1000);
  cx = width/2;
  cy = height/2;
  canvas = createGraphics(width,height);
  canvas.beginDraw();
  canvas.background(0);
  canvas.endDraw();  
}

void draw(){
 
  float theta1_a = ((-g*(2*m1+m2)*sin(theta1))+(-m2*g*sin(theta1-2*theta2))+(-2*sin(theta1-theta2)*m2)*(theta2_v*theta2_v*r2+theta1_v*theta1_v*r1*cos(theta1-theta2)))/(r1*(2*m1+m2-m2*cos(2*theta1-2*theta2)));
  float theta2_a = ((2*sin(theta1-theta2))*((theta1_v*theta1_v*r1*(m1+m2))+(g*(m1+m2)*cos(theta1))+(theta2_v*theta2_v*r2*m2*cos(theta1-theta2))))/(r2*(2*m1+m2-m2*cos(2*theta1-2*theta2)));
  
  image(canvas,0,0);
  stroke(255);
  strokeWeight(5);
  
  translate(cx,cy);
  
  float x1 = r1*sin(theta1);
  float y1 = r1*cos(theta1);
  
  float x2 = x1 + r2*sin(theta2);
  float y2 = y1 + r2*cos(theta2);
  
  line(0,0,x1,y1);
  fill(255);
  ellipse(x1,y1,m1,m1);
  
  line(x1,y1,x2,y2);
  fill(255);
  ellipse(x2,y2,m2,m2);

  theta1_v += theta1_a;
  theta2_v += theta2_a;
  theta1 += theta1_v;
  theta2 += theta2_v;
  
  theta1_v *= (1-air_resistance);
  theta2_v *= (1-air_resistance);

  canvas.beginDraw();
  canvas.translate(cx,cy);
  canvas.strokeWeight(2);
  canvas.stroke(255,255,255,150);
  if (frameCount > 1){  //do not draw from 0,0 to start position
    canvas.line(prev_x2,prev_y2,x2,y2);
  }
  
  //every 1000 frames flip grvity
  //if (frameCount % 1000 == 0){
  //  g = -g; 
  //}

  canvas.endDraw();
  
  prev_x2 = x2;
  prev_y2 = y2;

}
