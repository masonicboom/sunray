import processing.opengl.*;
import javax.media.opengl.*;


float THICKNESS = 11.0;

float t = 0.0;           // time
float dt = 1.0;          // change in time per frame
float da = TWO_PI/1200.0; // change in angle with respect to time

Sun[] suns = new Sun[1];


void setup() {
  size(400, 400);
  frameRate(60.0);
  smooth();
  
  for (int i = 0; i < suns.length; i++) {
    int num_rays = round(random(40, 60));
    float scale_factor = random(1, 1);
    float xo = random(width*0.5, width*0.5);
    float yo = random(height*0.5, height*0.5);
    suns[i] = new Sun(num_rays, scale_factor, xo, yo);
  }
  
  stroke(0);
}


void draw() {  
  background(230, 100, 140); // hot pink, in case you don't see in (R,G,B) tuples.
  
  for (int i = 0; i < suns.length; i++) {
    suns[i].draw(t);
  }
  
  t += dt;
}


float RAY_MAX_AMP = 3.0; // how much bounce is in that shit?
float RAY_HZ = 1/100.0;  // ouch! it hz
class Sun {
  Ray[] rays;
  float scale_factor;
  float xo, yo;
 
  Sun(int num_rays, float scale_factor, float xo, float yo) {
    this.scale_factor = scale_factor;
    this.xo = xo;
    this.yo = yo;
    
    this.rays = new Ray[num_rays];
    for (int i = 0; i < rays.length; i++) {
      float angle = i*TWO_PI/rays.length;
      float r0 = random(50.0, 60.0);
      float l = random(50.0, 100.0);
      rays[i] = new Ray(angle, r0, l);
    }
  }
  
  void draw(float t) {
    pushMatrix();
    translate(xo, yo);
    scale(scale_factor);
    rotate(t * da);
    
    for (int i = 0; i < rays.length; i++) {
      rays[i].draw(t);
    }
    
    popMatrix();
  }
}

class Ray {
  float angle, l;
  Spring r0;
  
  Ray (float angle, float radius_offset, float l) {
    // angle is an angle from 0 to TWO_PI
    // r0 is the radius at which the ray starts
    // l is the length of the ray
    
    this.angle = angle;
    this.l = l;
    
    this.r0 = new Spring(RAY_MAX_AMP, 0, RAY_HZ, random(0, TWO_PI), radius_offset);
  }
  
  void draw(float t) {
    float r = r0.eval(t);
    
    float x1 = r * cos(angle);
    float y1 = r * sin(angle);
    float x2 = (r + l) * cos(angle);
    float y2 = (r + l) * sin(angle);
    
    strokeWeight(THICKNESS);
    strokeCap(ROUND);
    line(x1, y1, x2, y2);
  }
}
