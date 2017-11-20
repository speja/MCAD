use <../regular_shapes.scad>

$fa = 1.0;
$fs = 1.0;

module symmetric_difference() {
  // A\,\triangle \,B=(A\cup B)\smallsetminus (A\cap B)
  difference() {
    union() children();
    intersection_for(c = [0:$children-1]) {
      children(c);
    }
  }
}
symmetric_difference() {
  super_ellipse(10, 10);
  circle(r=10);
}

*translate([0,20]) symmetric_difference(){
  circle(10);
  circle(20);
}

translate([20, 0]) symmetric_difference() {
  super_ellipse(10,5);
  ellipse(2*10,2*5);
}
translate([0, 20])
  super_ellipse(10, 5, 1.6);

translate([20, 20])
  super_ellipse(10, 5, 0.5);