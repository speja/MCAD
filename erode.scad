/*
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU Lesser General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
   GNU Lesser General Public License for more details.

   You should have received a copy of the GNU Lesser General Public License
   along with this program. If not, see <http://www.gnu.org/licenses/>.
*/

/**
 * Erosion function
 *
 * Authors:
 *   - Peter Janhäll, 2017
 *
 * License: LGPL 2.1
 */


/*
 * Erosion function:
 * - first erodes r1 from each surface
 * - then add r2 of cladding.
*/

module erode(r1=0.5, r2=0.5) {
  minkowski() {
    difference() {
      children();
      minkowski() {
        difference() {
          minkowski() {
            children();
            sphere(r1);
          }
          children();
        }
        sphere(r1);
      }
    }
    sphere(r2);
  }
}


