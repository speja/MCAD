// MIT license

include <constants.scad>

function deg(angle) = 360*angle/TAU;

// symmetric difference(A, B)=union(A, B)-intersection(A, B)
module symmetric_difference() {
  if ($children == 1)
      children();
  else if ($children == 2)
     difference() {
      union() children([0:1]);
      intersection() {
        children(0);
        children(1);
      }
    }
  else
    symmetric_difference() {
      symmetric_difference() {
        children(0);
        children(1);
      }
      symmetric_difference() {
        children([2:1:$children-1]);
      }
    }
}

module girder(p1, p2) {
  d = p2-p1;
  h = norm(d);  // radial distance
  b = acos(d[2]/h); // inclination angle
  c = atan2(d[1], d[0]);     // azimuthal angle

  translate(p1) rotate([0, b, c]) linear_extrude(height=h) children();
}