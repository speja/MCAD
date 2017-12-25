
include <../math.scad>

O = [0, 0, 0];
Px = [10,  0,  0];
Py = [ 0, 10,  0];
Pz = [ 0,  0, 10];

//echo(angles(Px, Py)); // -> [0, 0, -90]
//echo(angles(Py, Pz)); //.-> [90, 0, 0]
//echo(angles(Pz, Px)); // -> [0, -90, 0]]


translate(Px) cube(0.1, center=true);

*#translate(Py) cube(0.1, center=true);
*rotate(angles(O, Py)) translate(Px) cube(0.1, center=true);

*translate(Pz) cube(0.1, center=true);
*#rotate(angles(O, Pz)) translate(Px) cube(1, center=true);

// Draw a beam from p1 to p2

#translate(Px) cube(0.5, center=true);
#translate(Pz) cube(0.5, center=true);
#translate(Py) cube(0.5, center=true);

girder(Px, Py) square([0.2, 1.0]);
girder(Py, Px) square([0.2, 1.0]);
*girder(Px, Pz) square(0.5);
*girder(Pz, Px) square(0.5);
*girder(Py, Pz) square(0.5);
*girder(Pz, Py) square(0.5);
