use <../erode.scad>

$fa = 1.0;
$fs = 1.0;
module object() {
  difference() {
    union() {
      cube([6, 8, 2]);
      cube([2, 8, 8]);
      translate ([2+2, 2+2, 2+2+1]) sphere(3, center=true);
    }
    #translate([2+2, 4, 2+2+1]) cube([1, 1, 12], center=true);
  }
}


// Erode nothing
erode() object();

// Erode 1, build 1
translate([0, 0, 15]) erode(1, 1) object();

// Just build one
translate([15, 0, 0]) erode(0, 1) object();

// Erode 1
translate([15, 0, 15]) erode(1, 0) object();
