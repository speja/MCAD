use <../regular_shapes.scad>
use <../math.scad>

$fa = 1.0;
$fs = 1.0;

// Test symmetric_difference
translate ([-30 , 0]) symmetric_difference() {
  translate([0, 5*sqrt(3)]) circle(10);
  translate([5, 0]) circle(10);
  translate([-5, 0]) circle(10);
}

symmetric_difference() {
  super_ellipse(10, 10);
  circle(r=10);
}

translate([20, 0]) symmetric_difference() {
  super_ellipse(10,5);
  ellipse(2*10,2*5);
}
translate([0, 20])
  super_ellipse(10, 5, 1.6);

translate([20, 20])
  super_ellipse(10, 5, 0.5);