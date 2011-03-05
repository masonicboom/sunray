
// This class models a damped, harmonically oscillating particle.
class Spring {
  float ma, ad, hz, pl;
  float x0;
  float t0; // time offset
  
  Spring(float max_amplitude,
         float amplitude_decay,
         float hz,
         float phase_lag,
         float initial) {
    this.ma = max_amplitude;
    this.ad = amplitude_decay;
    this.hz = hz;
    this.pl = phase_lag;
    this.x0 = initial;
    this.t0 = 0;
  }
  
  float eval(float t) {
    return ma * exp(-1*ad*(t-t0)) * cos(hz*TWO_PI*t + pl) + x0;
  }
}
