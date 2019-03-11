hook_x = 100;
hook_y = 50;
hook_z = 100;
hook_shelf_z = 70;
hook_hole_diam = 25;
hook_hole_depth = 80;


translate([hook_x, 0, 0])
rotate([0, -90, 0])
wall_hook(hook_x, hook_y, hook_z, hook_shelf_z, hook_hole_diam, hook_hole_depth);


module wall_hook(x, y, z, shelf_z, hole_diam, hole_depth) {
  arm_thickness = 10;
  back_thickness = 10;
  translate([back_thickness, 0, shelf_z-arm_thickness]) fork(x, y, arm_thickness, hole_diam, hole_depth);
  
  minkowski() {
    rotate([0, 90, 0]) cylinder(r=5, h=0.1);
    cube([arm_thickness, y, x]);
  }
}

module fork (x, y, z, fork_width, fork_depth) {
  difference() {
    arm(x, y, z);
    translate([x+1, (y/2 + fork_width/2), -1]) rotate([0, 0, 180]) hole(fork_depth, fork_width, z*2+2);
  }

  support_y = (y-fork_width)/2;
  support_x = x/2;

  mirror([0, 0, 1]) support(support_x, support_y);
  translate([0, y-support_y, 0]) mirror([0, 0, 1]) support(support_x, support_y);
}

module support(x, y) {
  difference() {
    cube([x/2, y, x/2]);
    translate([x/2, -1, x/2]) rotate([-90, 0, 0]) cylinder(r=x/2, h=y+2);
  }
}

module arm (length, width, thickness) {
  knob_radius = thickness * 0.7;

  cube([length-knob_radius, width, thickness]);
  translate([length-knob_radius, 0, knob_radius]) rotate([-90, 0, 0]) cylinder(h=width, r=knob_radius);
}

module hole (x, y, z) {
  hole_radius = y/2;

  hole_center_x = x-hole_radius;

  cube([hole_center_x, y, z]);
  translate([hole_center_x, hole_radius, 0]) cylinder(r=hole_radius, h=z);
}
