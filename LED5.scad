/*
* Model of a 5 mm LED
*  Author: Peter Janhäll
*/

LED_FWHM = 30; // Full Width Half Maximum beam angle, degrees
module ESL_R5044WWCE070() {
  // ESL-R5044WWCE070
  // If = 30 mA, Averga forward current
  // Vf = 3.2 V, Forward voltage, If=20 mA
  // Iv = Luminous intensity 13 cd, If=20 mA

  d = 4.9; // +/-0.15
  h1 = 8.7; // +/-0.25
  // Flange
  d2 = 5.8; // +/-0.25
  h2 = 1.0;

  hull() {
    cylinder(d=d, h=1);
    translate([0, 0, h1-d/2])
      sphere(d=d);
  };
  difference() {
    cylinder(d=d2, h= h2);
    translate([d/2, -2, -1]) cube([1, 4, 3]);
  }
  // The conductors
  for( x = [-2.54/2, 2.54/2])
    translate([x-0.5/2, -0.5/2, -20]) cube([0.5, 0.5, 21]);
  // The beam
  bl = 20; // beam length
  %translate([0, 0, h1-d/2]) cylinder(d1=0.1, d2=2*sin(LED_FWHM/2)*bl, h=bl);
}
