include <_constants.scad>
use <_ittybox.scad>;

translate([-panel_width/4, 0, 0])
difference() {
  front_panel();
  translate([joint_offset, 0, 0]) panel_joint();
}